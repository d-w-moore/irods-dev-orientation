# Chapter 0

Development set-up

Prerequisites
-------------

We need only :

* a familiarity with basic Linux commands and the ability to launch a terminal window. (Ok, we'd like you to be able to install Ubuntu Linux as well)
* an open (aka open-source-friendly) and all-absorbing mind. 
* some solid programming experience in C++  and/or Python
* an Intel-based machine constructed in this 21st century 
* an internet connection
 
Contents and Purpose of This Document
----------
This is all from the standpoing of a new employee at Renci (Renaissance Computing Institute)'s iRODS Consortium development team.  Yours truly, that same employee and the author of this guide, is still getting up to speed at the time of this writing , a month into the orientation process. The open source way of doing development will be new to many developers, even some who've been working in the software industry for years. Fortunately, a lot of the aka "climbing the learning curve" has been documented for your benefit!

Even if you're not working here at Renci, these may still be valuable instructions if you're looking to develop on / improve / play with / "bang on" some iRODS .... good luck!

Quick Start Guide
-----------------
Get the help of someone who's already initiated if you can. That person can set you up with Ubuntu 14 Linux on your PC - probably best done by burning a flash drive with the boot image. He/she will be using either "Rufus" ( a windows tool ) or "etcher-electron" (which works on any Linux platform ) to give you the boot image.

In the case of etcher, that good person who's undertaken the task of getting you started can do the following:
* make sure an .ISO image of **Ubuntu14.04.5 LTS** (from `ubuntu.com` )is on the machine doing the 'burning'
    - `wget  http://releases.ubuntu.com/14.04/ubuntu-14.04.5-desktop-amd64.iso `
* navigate in a browser to `https://github.com/resin-io/etcher`
* click on the `README.md` and follow the instructions
