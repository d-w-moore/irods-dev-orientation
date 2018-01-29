
These commands set up some prerequisites for working under the Python language with iRODS (and generally) :

```
sudo apt-get upgrade
sudo apt-get install python-dev python3-dev make git apt-transport-https
sudo -H apt-get install python-pip
sudo -H pip install --upgrade pip ; hash -r
```

At the time of writing, pip was current at version **9.0.1** ; you can verify that on your system by typing `pip --version`.

