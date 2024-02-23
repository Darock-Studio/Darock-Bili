#!/bin/zsh
#  ci_post_xcodebuild.sh

if [[ "$CI_WORKFLOW" == "Canary Deploy" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo "CI 自动生成信息，24小时内的main分支diff：\n" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-CN.txt
  git fetch && git log --since="24 hours ago" -p main >> $TESTFLIGHT_DIR_PATH/WhatToTest.zh-CN.txt
fi
