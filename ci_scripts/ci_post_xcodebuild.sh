#!/bin/zsh
#  ci_post_xcodebuild.sh

if [[ "$CI_WORKFLOW" == "Canary Deploy" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo "CI 自动生成信息，24小时内的main分支diff：\n" > $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
  git fetch && git log --since="24 hours ago" -p main --pretty=format:"%s" >> $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
  CHAR_COUNT=$(wc -c < $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt)
  if [ "$CHAR_COUNT" -gt 4000 ]; then
    # 截取文件内容，保留前4000个字符
    sed -i '' "1,3900d" $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt

    # 在文件末尾添加提示文本
    echo "\n由于超过字符限制，剩余内容被截断，完整diff请见喵哩喵哩GitHub页" >> $TESTFLIGHT_DIR_PATH/WhatToTest.zh-Hans.txt
  fi
fi
