---
title: Hosting Guide
description: Page description.
---

# Hosting Vontigo

A short guide to running Vontigo in a production environment and setting up an independent publication to serve traffic at scale.

<hr/>

Vontigo is open source software, and can be installed and maintained relatively easily on just about any VPS hosting provider.

## Self-hosting details & configuration

Vontigo has a small team, so we optimize the software for a single, narrow, well defined stack which is heavily tested. Vontigo can also run successfully with different operating systems, SQLite3 for now and other databases (comming soon) and web servers, but these are not officially supported or widely adopted, so your mileage may (will) vary.

Our officially supported and recommended stack is as follows:

- Ubuntu 16.04, 18.04, 20.04 or 22.04
- MySQL 8.0
- NGINX
- Systemd
- Recommended Node version installed via NodeSource
- A server with at least 1GB memory

### Server hardening

After setting up a fresh Ubuntu install in production, it’s worth considering the following steps to make your new environment extra secure and resilient:

- Use SSL - Vontigo should be configured to run over HTTPS.
- Secure MySQL (comming soon) - We strongly recommend running `mysql_secure_installation` after successful setup to significantly improve the security of your database.
- Set up a firewall - Ubuntu 18.04, 20.04 and 22.04 servers can use the UFW firewall to make sure only connections to certain services are allowed. We recommend setting up UFW rules for `ssh`, `nginx`, `http`, and `https`. If you do use UFW, make sure you don’t use any other firewalls.
- Disable SSH Root & password logins - It’s a very good idea to disable SSH password based login and only connect to your server via proper SSH keys. It’s also a good idea to disable the root user.
- Separate admin domain (comming soon) - Configuring a separate admin URL can help to guard against privilege escalation and reduces available attack vectors.

### Optimizing for scale

The correct way to scale Vontigo is by adding a CDN and/or caching layer in front of your Vontigo instance. Clustering or sharding is not supported in any way. Minimal, sensible caching is more than enough.

### Staying up to date

Whenever running a public-facing production web server it’s **critically important** to keep all software up to date. If you don’t keep everything up to date, you place your site and your server at risk of numerous potential exploits and hacks.

If you can’t manage these things yourself, ensure that a systems administrator on your team is able to keep everything updated on your behalf.
