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




======

Deps:
curl
git


Install Node:
```
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash

# in lieu of restarting the shell

\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 26

# Verify the Node.js version:
node -v   # Should print "v26.4.0".

# Verify npm version:
npm -v   # Should print "11.17.0".
```

Get Quartz
```
git clone https://github.com/jackyzha0/quartz.git
cd quartz

# Get deps
npm install

# Init, though add the flags to make it non-interactive.
npx quartz create

# Get the needed plugins
npx quartz plugin install
npx quartz plugin install --from-config
npx quartz plugin install --latest
```


___
Created: 2026-06-27
Last Updated: 2026-06-27