#!/bin/bash

if [[ -n $CI_PULL_REQUEST_NUMBER ]];
then
    brew install gh
    
    gh api \
        --method POST \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        /repos/Darock-Studio/Darock-Bili/statuses/$CI_COMMIT \
        -f state='pending' \
        -f description='XCloud Building...' \
        -f context='API Status Checker'
fi
