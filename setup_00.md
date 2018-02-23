# Setting up to install an iRODS Development Environment

Prerequisites
-------------

We need only :

* a familiarity with basic Linux commands and the ability to launch a terminal window.
* an ready and open (aka open-source-friendly) mind.
* some solid programming experience in C++ and/or Python
* an Intel-based machine constructed in the 21st century
* an internet connection

Contents and Purpose of This Documentation
----------
The general aim of this guide is to give some cues and clues for learning the fundamentals of "how software is done" at [RENCI](http://renci.org)'s [iRODS Consortium](http://irods.org), where the core development and engineering work on **iRODS** (the *integrated Rule-Oriented Data System*) takes place.  The author of this guide started not very long ago on the iRODS team and, in the inevitable process of learning and adaptation, has relied pretty heavily on the time and attention of his more experienced teammates.  Therefore, it seemed expeditious to write down some tips, procedures, and lessons learned -- for others down-the-line  who find themselves in the same lucky position of becoming part of the effort to further iRODS!  

If you're reading this because you have joined the core iRODS dev team; or, if you're finding it has potential applications for you; or if you simply enjoy some educational playing-around with open source software, you still might find it helpful to peruse or work through some of the instructions included here.

Whatever the case, dear reader, the author hopes you find your first experiences with development in the iRODS environment to be edifying, joyful, and successful!


Quick Start Guide : Installing Ubuntu
-----------------
Get the help of someone who's already initiated if you can. That person can set you up with Ubuntu 14 Linux on your PC - probably best done by burning a flash drive with the boot image. He/she will probably be using either "Rufus" (an MS Windows tool) or "etcher-electron" - which should work on any Linux platform - to give you the boot image on a USB-insertable flash drive.

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

At the time of iRODS **4.2.X** releases  , these are the most commonly used packages to facilitate our software work and in open-source methodologies in general. Later we'll install more packages as necessary.

For the steps essential to setting up the iRODS server and icommands packages, go to the  [*UGM 2017 - Getting Started*](http://slides.com/irods/ugm2017-getting-started) and follow the instructions in the first few pages, to install prerequisites as well as iRODS and the PostgreSQL enabled ICAT database. We'll pick up from there in the next chapter.
