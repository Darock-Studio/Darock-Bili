#!/bin/zsh
#  ci_post_xcodebuild.sh

if [[ "$CI_WORKFLOW" == "Canary Deploy" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo "CI 自动生成信息，24小时内的main分支的提交：\n" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
  git fetch -a && git log --since="24 hours ago" main --pretty=format:"%s" >! $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
fi
