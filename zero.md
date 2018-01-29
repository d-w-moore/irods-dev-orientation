# Chapter 0 - Set-up for iRODS Development Environment 

Prerequisites
-------------

We need only :

* a familiarity with basic Linux commands and the ability to launch a terminal window. (Ok, we'd like you to be able to install Ubuntu Linux as well)
* an open (aka open-source-friendly) and all-absorbing mind. 
* some solid programming experience in C++  and/or Python
* an Intel-based machine constructed in the 21st century 
* an internet connection
 
Contents and Purpose of This Documentation
----------
The aim and narrative of this guide are from the standpoint of a new software support/development professional on Renci's (Renaissance Computing Institute's) iRODS Consortium development team.  Yours truly, that same employee and the author of this guide, is still getting up to speed at the time of this writing , a month into the orientation process, and would like to be a help to others finding themselves in the same lucky position. Of course, the open-source way of doing things will be new to many developers, even some who've been working in the software industry for years.

Even if you're not working directly on the iRODS core team, you might still find these to be valuable instructions if you're looking to develop on / improve / play with / "bang on" some iRODS .... good luck!

Quick Start Guide
-----------------
Get the help of someone who's already initiated if you can. That person can set you up with Ubuntu 14 Linux on your PC - probably best done by burning a flash drive with the boot image. He/she will be using either "Rufus" (an MS Windows tool) or "etcher-electron" - which should work on any Linux platform - to give you the boot image on a USB-insertable flash drive.

In the case of etcher, that good person who's undertaken to help in getting your workstation set up can do the following:
* make sure an .ISO image of **Ubuntu14.04.5 LTS** (from `ubuntu.com` )is on the machine doing the 'burning'
    - `wget  http://releases.ubuntu.com/14.04/ubuntu-14.04.5-desktop-amd64.iso `
* navigate in a browser to `https://github.com/resin-io/etcher`
* click on the `README.md` and follow the instructions there, to burn the Ubuntu 14 image to the flash drive

The flash drive can then be used to install Ubuntu Linux on your workstation. Select mostly defaults when the install program asks, except as your common sense might urge you to stray. For example, large `/var` partitions may be needed, if they're made separate from `/`, particularly if you later want to create virtual machines via KVM, QEMU and **virt-manager**. Also:  select updates to be downloaded during the install.  Ubuntu 14 has been around a few years.

When you're done with the install and log in as your new user, you'll have `sudo` (administrative) access on your machine, so begin by installing some general prerequisites for work in the iRODS development environment:
```
 sudo apt-get update
 sudo apt-get install -y git make ninja-build python-pip libssl-dev zlib1g-dev apt-transport-https
```

At the time of iRODS release **4.2.2** , these are the most commonly used packages to facilitate our software work and in open-source methodologies in general. Later we'll install more packages as necessary.

As an exercise, go ahead and navigate in your browser to `http://slides.com/irods` and find the *UGM 2017 - Getting Started* slides from June of 2017. Follow the directions there in the first few pages, to install the PostgreSQL database and the iRODS server. We'll pick up there in the next chapter.
