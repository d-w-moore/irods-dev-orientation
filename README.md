# irods-dev-beginner
A guide for beginners who want to develop on iRODS
==================================================

Requirements
------------

We need only :

* a familiarity with basic Linux commands and the ability to launch a terminal window. (Ok, we'd like you to be able to install Ubuntu Linux as well)
* beyond that, a willingness to dive into C++ and Python code; and an internet connection
 
So, to start:
1. go to ubuntu.com and download the 64-bit Ubuntu Desktop, version 16.04
1. either burn it to DVD, if you want it running on your bare metal, or download virtualbox for your host OS
(which we'll assume  is either Windows or MacOS >=10)
1. if you've chosen the virtualbox route, install that on your PC and start it up. create a VM with:
    * preferably 1024MB or more of RAM
    * preferably 16GB or more disk space (one disk is fine, as is dynamic allocation)
1. double-click on the new VM entry to start it, and point at the DVD '.iso' file you downloaded
1. let the install guide you through.  For security, choose 'yes' to download updates live from Ubuntu.

Now you've got Ubuntu, let's install the PostgreSQL database
------------------------------------------------------------

Once you've booted back up again after install , you can install some packages  that will be necessary 
for the compiling and running of the iRODS server.

First, the database.

Issue the commands:
```
sudo apt-get install -y postgresql
```
