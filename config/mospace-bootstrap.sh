#!/bin/bash

# local-bootstrap.sh is a hacky little solution to customizing your own DSpace clone from github. You can use it to do such things as set an upstream remote, configure fetching of pull requests from upstream, and much more

# it is also a handy stop-gap measure for providing needed functionality for Vagrant DSpace (such as AIP auto-loading) without having to do a lot of puppet scripting. This works.


# WORD of WARNING: don't forget this script will run as root, so be careful about files you create. Git config lines will need to be run either as the vagrant user.

HOME="/home/vagrant"
DSPACE_HOME="$HOME/dspace"
DSPACECMD="$DSPACE_HOME/bin/dspace"
DSPACESRC="$DSPACE_HOME-src"

## START OFF BY CUSTOMIZING THE GIT CLONE ##
echo "Setting up my preferences for Git... oooh, shiny shiny new Git installation..." 

cd $DSPACESRC

# set git to allways rebase when we pull
sudo -i -u vagrant git config --global --bool pull.rebase true

# set git to always use pretty colors
sudo -i -u vagrant git config --global color.ui always

# and don't even try to get smart about converting line endings, that just pisses me off
sudo -i -u vagrant git config --global core.autocrlf input

# and I don't need merge backups, really, I don't
sudo -i -u vagrant git config --global --bool merge.keepbackups false

# use the simple push, which means you have to be explicit about the branch you're pushing, which is a good thing, stop with all the smarts
sudo -i -u vagrant git config --global push.default simple


echo "and now setting up our preferences for working copy... adding an upstream remote, PR refs..." 

# add the mospace upstream remote
git remote add mospace-upstream git@github.com:umlso/MOspace.git

# enable fetching of pull requests from upstream (this is a little edgy, but I like it)
git config --add remote.mospace-upstream.fetch +refs/pull/*/head:refs/remotes/mospace-upstream/pr/*



# add the official dspace upstream remote
git remote add dspace-upstream git@github.com:DSpace/DSpace.git

# enable fetching of pull requests from upstream (this is a little edgy, but I like it)
git config --add remote.dspace-upstream.fetch +refs/pull/*/head:refs/remotes/dspace-upstream/pr/*

