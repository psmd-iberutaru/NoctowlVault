#!/usr/bin/env bash

# This script is the main script which is used to build the NoctowlVault
# Obsidian-Quartz website.
# See URL for more information.



# START!

# We need to be in the correct directory first off.
cd /home/sparrow/

# And, installing dependencies.
sudo dnf update
sudo dnf install rsync curl git libatomic


# Pulling and updating the GitHub repository.
git clone git@github.com:psmd-iberutaru/NoctowlVault.git /home/sparrow/NoctowlVault/
cd /home/sparrow/NoctowlVault/
git fetch --all
git reset --hard origin/main
git clean -fd

# We only care about publishing the pages on the publish branch.
git switch publish
git rebase main

# Install the correct Node.JS version.

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash

# ...in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 26


# Install the most recent Quartz version, removing any old version where 
# needed.
rm -rf /home/sparrow/Quartz
git clone https://github.com/jackyzha0/quartz.git /home/sparrow/Quartz
cd /home/sparrow/Quartz

# Install dependencies...
npm install

# Initialize the project...
npx quartz create --template obsidian --strategy new --baseUrl wiki.sparrow-orcinus.space

# Install/update needed plugins. This may take a while...
npx quartz plugin install
npx quartz plugin install --latest
npx quartz plugin install --from-config


# Back home...
cd 


# Move all Markdown content files from the vault to the new Quartz content folder.
rm -rf /home/sparrow/Quartz/content/
rsync -rlvhzc --mkpath --open-noatime --info=progress2 /home/sparrow/NoctowlVault/ /home/sparrow/Quartz/content/
# Removing any unneeded public HTML files which are copied over.
rm -rf /home/sparrow/Quartz/content/_html/


# Copying over the main Quartz build configurations.
cp /home/sparrow/NoctowlVault/quartz.config.yaml /home/sparrow/Quartz/quartz.config.yaml


# Building the Obsidian Quartz project. We limit the number of threads due to 
# the typical VM being we use is weak.
cd /home/sparrow/Quartz/
npx quartz build --concurrency 2


# Copy over the freshly generated public HTML files.
rsync -avhzP /home/sparrow/Quartz/public/ /home/sparrow/NoctowlVault/_html/


# Attempt to push the results to the GitHub.
cd /home/sparrow/NoctowlVault/
git push