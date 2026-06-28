---
date: 2026-06-27
author: Sparrow
tags:
  - StarLiner
  - Blog
  - Tutorial
---

Welcome aboard the [[STAR Liner/STAR Liner - Welcome Briefing|Sparrow STAR Liner]]! A blog where we take a trackless voyage across Space, Technology, Aviation, and other Randomness. Stops are scattered, and we do not have many stations, but we hope you enjoy where you disembark.

___
# Creating a Obsidian-Quartz Website

This website is made by turning Obsidian-based Markdown notes to a static website. Although it is common to use Obsidian Publish for this, I find that the subscription cost to be unnecessary. In that regard, I have utilized [Quartz](https://quartz.jzhao.xyz/), to generate this static website. Although there are many tutorials online which already have similar information, I find this way the best working system for me so I thought to write it down.

## Overview

My current system generally follows the following steps:
1. Pull any changes from the GitHub repository where the Markdown files are stored: [NoctowlVault](https://github.com/psmd-iberutaru/NoctowlVault)
2. Transfer these files to a Quartz install, under the content directory. The public HTML files are stored with the NoctowlVault Markdown files so I clear the public HTML files within the content directory.
3. Build the website using Quartz.
4. Transfer the new public HTML files to the local GitHub repository and push it to the remote repository. Other static files which are not built but still need to be added may be done so as well. (Though as these files do not change, the previous Git history should have them.)
5. A GitHub action is automatically triggered to create a [GitHub Pages site](https://docs.github.com/en/pages) using the new uploaded public HTML files.

I describe these steps in more detail below, though, they are specific to the [[NOCTOWL]] server and are a way I can recreate the production environment if need be. These steps are all contained in a single script, which has some extra house-keeping commands not otherwise described here.

## Pull GitHub Repository

Simply put, I have a local clone of the NoctowlVault in `/home/sparrow/NoctowlVault/`. I pull the GitHub repository via Git and SSH-keys due to they being better for scripts, and more secure. I do not really care about any old files in the repository when I am pulling the canonical version from GitHub:

```shell
git fetch --all
git reset --hard origin/main
git clean -fd
```

## Transfer to a Quartz Install

First, in order to transfer to a Quartz Install, we need to have one. I have found that it is not that harmful to have a "reinstallation of" Quartz in the script that I use. In order to install Quartz, we need to install its [Node.js](https://nodejs.org/en/download) dependency. 

I just follow the Node instructions to install Node.js: (Note, the URL will likely need to change depending on the Node version.)
```shell
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash

# ...in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 26
```

We then also get Quartz, if needed:
```shell
git clone https://github.com/jackyzha0/quartz.git Quartz
cd Quartz

# Get deps
npm install

# Init, though add the flags to make it non-interactive.
npx quartz create --template obsidian --strategy new --baseUrl wiki.sparrow-orcinus.space

# Get the needed plugins
npx quartz plugin install
npx quartz plugin install --latest
npx quartz plugin install --from-config
```

Now, we can move all of the content files from the NoctowlVault to the new Quartz project, and remove all of the unneeded public HTML files:
```shell
rsync -rlvhzc --mkpath --open-noatime --info=progress2 /home/sparrow/NoctowlVault/ /home/sparrow/Quartz/content/
rm -rf /home/sparrow/Quartz/content/_html/
```

## Build Using Quartz

The NoctowlVault does have the configuration file which we are going to use for building the website. It is pertinent to copy it over.
```shell
cp /home/sparrow/NoctowlVault/quartz.config.yaml /home/sparrow/Quartz/quartz.config.yaml
```

We can finally build the project, generating the website from our Markdown files. Because I build the website on a virtual machine which is generally underpowered, I impose some limits on the building. It is okay if it takes a little longer.
```shell
npx quartz build --concurrency 2
```

## Transfer Updated Website Files

We then copy the generated HTML files into the public facing directory of the NoctowlVault.
```shell
rsync -avhzP /home/sparrow/Quartz/public/ /home/sparrow/NoctowlVault/_html/
```

Once transferred, we can push all of the relevant files to the GitHub repository as the new updated HTML files.
```shell
git push
```






___
Created: 2026-06-27
Last Updated: 2026-06-27