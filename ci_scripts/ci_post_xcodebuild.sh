#!/bin/bash

if [[ "$CI_WORKFLOW" == "Public Release" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo -e "当前语义化版本：$CI_TAG\n\nRelease Notes: https://github.com/Darock-Studio/Darock-Bili/releases/tag/$CI_TAG\n\n若要使用 watchOS App，请打开“在 Apple Watch 上显示 App”开关" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
elif [[ "$CI_WORKFLOW" == "Alternative" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo -e "由 ThreeManager785 替代分发的喵哩喵哩\n\n当前语义化版本：$CI_TAG\n\nRelease Notes: https://github.com/Darock-Studio/Darock-Bili/releases/tag/$CI_TAG\n\n若要使用 watchOS App，请打开“在 Apple Watch 上显示 App”开关" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
elif [[ "$CI_WORKFLOW" == "KentYe Alternative" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo -e "由 Kent Ye 替代分发的喵哩喵哩\n\n当前语义化版本：$CI_TAG\n\nRelease Notes: https://github.com/Darock-Studio/Darock-Bili/releases/tag/$CI_TAG\n\n若要使用 watchOS App，请打开“在 Apple Watch 上显示 App”开关" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
elif [[ "$CI_WORKFLOW" == "Darock Alternative" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo -e "当前语义化版本：$CI_TAG\n\nRelease Notes: https://github.com/Darock-Studio/Darock-Bili/releases/tag/$CI_TAG\n\n若要使用 watchOS App，请打开“在 Apple Watch 上显示 App”开关" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
fi
