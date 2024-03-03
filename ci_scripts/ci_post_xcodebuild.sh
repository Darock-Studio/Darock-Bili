#!/bin/bash

if [[ -n $CI_PULL_REQUEST_NUMBER ]]; then
    if [[ "$CI_XCODEBUILD_EXIT_CODE" == "0" ]]; then
        NEW_STATUS=success
    else
        NEW_STATUS=failure
    fi
    
    gh api \
        --method POST \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        /repos/$CI_PULL_REQUEST_SOURCE_REPO/statuses/$CI_COMMIT \
        -f state=$NEW_STATUS \
        -f context='API Status Checker'
fi
