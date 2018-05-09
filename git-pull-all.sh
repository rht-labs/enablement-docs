#!/bin/bash
# util function for pulling all repo branches
echo ""
echo "    PULLING ALL BRANCHES"
echo ""
echo "##################################################"
echo ""
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch#remotes/origin/} $branch
done
echo ""
echo "##################################################"
echo ""