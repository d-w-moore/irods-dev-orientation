# Python and iRODS - setup & familiarization

# First stop

These commands set up some prerequisites for working under the Python language with iRODS and the Python iRODS Client library (PRC):

```
sudo apt-get upgrade
sudo apt-get install python-dev python3-dev python-pip 
sudo -H apt-get install python-pip
sudo -H pip install --upgrade pip ; hash -r
```
At the time of writing, pip was current at version **9.0.1** ; you can verify that on your system by typing `pip --version`.

# Further pointers:

The official repo for python iRODS client (aka the PRC) is at:

https://github.com/irods/python-irodsclient

You can follow the inline example(s) to become a bit more familiar with how the library works.

