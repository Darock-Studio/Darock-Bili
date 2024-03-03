#!/bin/bash

if [ "$CI_WORKFLOW" == "Dylib Release Update" ] || [ "$CI_WORKFLOW" == "Dylib Snapshot Update" ]; then
    if [[ "$CI_PRODUCT_PLATFORM" == "iOS" ]]; then
        codesign -fs "${EXPANDED_CODE_SIGN_IDENTITY_NAME}" "${BUILT_PRODUCTS_DIR}/DarockBili.dynamic.dylib"
    elif [[ "$CI_PRODUCT_PLATFORM" == "watchOS" ]]; then
        codesign -fs "${EXPANDED_CODE_SIGN_IDENTITY_NAME}" "${BUILT_PRODUCTS_DIR}/DarockBili.dynamic.watch.dylib"
    fi
fi

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
