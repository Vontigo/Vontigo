---
title: Installation
description: How to install Vontigo.
---

# How to install Vontigo locally.

Fast-track local install for getting Vontigo running on your computer or setup for doing theme development.

## Overview

Running Vontigo locally is the easiest way to get your own copy of the software running and be able to do some local development with it. By the end of this guide you will have completed a local Vontigo install that runs in development mode using SQLite3.

This install is not suitable for production use or contributing to core.

## Prerequisites

To install Vontigo locally you will need the following:

- A computer running MacOS, Windows or Linux
- A supported version of Node.js
- Either yarn or npm or pnpm to manage packages
- A clean, empty directory on your machine

## Install Vontigo

### Create GitHub fork

First you’ll need to make a fork of the Vontigo repository. Click on the fork button right at the top, wait for a copy to be created over on your personal GitHub account, and you should be all set!

### Configure repository

The main Ghost repository is a monorepo that using Turborepo containing the full Ghost code, including the Admin client and default theme which will also be automatically set up.

First clone Ghost with submodules and make it your working dir

```bash
git clone --recurse-submodules git@github.com:Vontigo/Vontigo && cd Vontigo
```

### Properly rename your references

Rename origin to upstream

```bash
git remote rename origin upstream
```

Add your fork as an origin, editing in \<YourUsername\>!

```bash
git remote add origin git@github.com:<YourUsername>/Vontigo.git
```

### Run setup & installation

#### Run with [Turborepo](https://turbo.build/).

Turbo is an incremental bundler and build system optimized for JavaScript and TypeScript, written in Rust.

> ⚠️ Rename `.env.example` to `.env`.

```bash
pnpm i turbo --global
pnpm i
pnpm dev
```

> 🌐 Vontigo website is now running at `https://localhost:5173/` -
> 📱 Vontigo mobile app is now running at `http://localhost:5174/`

#### Or, run as SvelteKit app.

```bash
cd .\apps\web\
pnpm i
pnpm dev -- --open
```

### Setup

Now you can see the `Setup` screen. Just fill in all of the required information then hit `Continue` button. That's it! : )

> ⚠️ Incase you are not able to see the `Setup` screen. Make sure you have deleted the `./apps/web/database/vontigo.db` file.
