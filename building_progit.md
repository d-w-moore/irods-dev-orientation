# Building the 'git' online book


First make sure you have installed `git` itself:  
```
sudo apt-get install git
```
For the following work, you may be `cd`'d anywhere you like; a good choice might be a subdirectory of your `$HOME` folder called `github`.  

```
mkdir -p ~/github ; cd ~/github
```

## Before doing the work of downloading and "building" the e-book in its various formats (PDF, HTML, asc, etc.), we need to:
-  Grab a recent [Ruby](https://www.ruby-lang.org/en/) tarball from the internet and install it locally, e.g.:  
`wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.3.tar.gz
`
- Explode the tarball and build:
` tar zxf ruby-2.4.3.tar.gz `  
` INSTALLDIR=$(pwd)/rubylocal_2.4.3 ; mkdir "$INSTALLDIR"`  
` cd ruby-2.4.3`  
` ./configure --prefix="$INSTALLDIR"`  
` make`  
` make install`  
` export PATH="$INSTALLDIR/bin:$PATH"`



- Import the bundler software into the local Ruby installation:
` gem install bundler`  
` hash -r`  
*Note the last command assumes bash; for **csh** dialects use 'rehash' to force your shell to find the 'bundle' binary*
## Now, download the repository for "Pro Git 2" from GitHub:  
```
git clone http://github.com/progit/progit2
```

Descend into the local repo and check out the `master` branch:  
`cd progit2`  
`git checkout`  
