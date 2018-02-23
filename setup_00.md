# Setting up Linux and getting familiar with iRODS

Prerequisites
-------------

We need only :

* a familiarity with basic Linux commands and the ability to launch a terminal window.
* an ready and open (aka open-source-friendly) mind.
* some solid programming experience in C++ and/or Python
* an Intel-based machine constructed in the 21st century
* an internet connection


Quick Start: Installing Ubuntu Linux and Getting Started with iRODS
-----------------

Get the help of someone who's already initiated as soon as you can. That person can set you up with Ubuntu 14 Linux on your PC - probably best done by burning a flash drive with the boot image. He/she will probably be using either [Rufus](https://rufus.akeo.ie/) (an MS Windows tool) or [etcher](https://www.techspot.com/downloads/6931-etcher.html) (which  works on Linux and MacOS X platforms) to give you the boot image on a USB-insertable flash drive.

If the above-mentioned `etcher` is the tool of choice, the good person who's undertaken to help in getting your workstation set up can do the following:
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
