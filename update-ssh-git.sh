#!/bin/bash
echo '' >> ~/.ssh/known_hosts
eval "$(ssh-agent -s)"
ssh -i ~/.ssh/github git@github.com
ssh-add ~/.ssh/github
