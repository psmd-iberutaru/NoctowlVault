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

I describe these steps in more detail below, though, they are specific to the
[[NOCTOWL]] server and are a way I can recreate the production environment if need be.

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