#!/bin/bash

if [[ "$CI_WORKFLOW" == "Canary Deploy" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo "CI 自动生成信息，24小时内的main分支的提交：\n" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
  git fetch -a --deepen 40 && git log --since="24 hours ago" main --pretty=format:"%s" >> $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
elif [[ "$CI_WORKFLOW" == "Public Release" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo "当前语义化版本：${{ CI_TAG }}\n\nRelease Notes: https://github.com/Darock-Studio/Darock-Bili/releases/tag/${{ CI_TAG }}\n\n若要使用watchOS App，请打开“在Apple Watch上显示App”开关" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
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
        /repos/${{ CI_PULL_REQUEST_SOURCE_REPO }}/statuses/${{ CI_COMMIT }} \
        -f state='$NEW_STATUS' \
        -f target_url='${{ CI_BUILD_URL }}' \
        -f context='API Status Checker'
fi
