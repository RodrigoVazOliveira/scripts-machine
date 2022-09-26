#!/bin/bash
rm ~/.ssh/know_hosts
ssh -i ~/.ssh/github git@github.com
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
