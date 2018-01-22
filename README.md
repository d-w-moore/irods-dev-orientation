# irods-dev-beginner

Chapter 0. A guide for developers who want to work with/on iRODS source
=======================================================================

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

First, the general setup by way of installing some necessary prerequisite machinations including the installing of support packages for the building of iRODS code later on...
First, a `sudo apt-get update` will spill a lot of  verbiage but essentially make sure Ubuntu is updated on package lists and dependencies. Then follow this up with the necessary package installs:
```
sudo apt-get -y install git g++ make python-dev help2man unixodbc libfuse-dev libcurl4-gnutls-dev \
libbz2-dev zlib1g-dev libpam0g-dev libssl-dev libxml2-dev libkrb5-dev unixodbc-dev libjson-perl \
python-psutil python-jsonschema super python-exif odbc-postgresql
```

Second, the database setup. (To be able to run iRODS, let alone build in your edits!)

Issue the commands:
```
sudo apt-get install -y postgresql
```
And before we forget to do it (the ICAT database and an admin role (user, if you like) 'irods' are required to run or build iRODS):

Now become the postgres user :
```
sudo su - postgres
```
and while you're there, invoke ```psql``` and do these SQL commands:
```
CREATE DATABASE "ICAT";
CREATE USER irods WITH PASSWORD 'testpassword';
GRANT ALL PRIVILEGES ON DATABASE "ICAT" to irods;
\q
```
Now, *_exit the bash shell of the postgres user_*  (using `exit` or by  issuing  **Control-D**)
With that we're ready now to install the binary packages that will get the iRODS server going:

* fetch the public key for the repository and add it to the system:
    - ``` KEY=$(wget -qO - https://packages.irods.org/irods-signing-key.asc) ```  
    - ``` sudo apt-key add - <<<"$KEY"```
* add the repository so subsequent `apt` commands will see it:
    - ``` echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" |  \```  
      ``` sudo tee /etc/apt/sources.list.d/renci-irods.list```
    - `sudo apt-get update`

[Next chapter](./one.md)
