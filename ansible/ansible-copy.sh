#!/bin/sh

# dry run
ansible -m copy -a "src=myconfig dest=~/.gitconfig2" --check localhost

# run
ansible -m copy -a "src=~/.gitconfig dest=files/.gitconfig.master" localhost
ansible -m copy -a "src=files/master.gitconfig dest=~/.gitconfig" localhost
