#!/bin/bash

if [ "$CI_WORKFLOW" = "Public Release" ]; then
    NEW_TEXT="Darock"
elif [ "$CI_WORKFLOW" = "Alternative" ]; then
    NEW_TEXT="785"
elif [ "$CI_WORKFLOW" = "KentYe Alternative" ]; then
    NEW_TEXT="Kent Ye"
else
    # 默认值，如果 CI_WORKFLOW 不匹配上述条件
    NEW_TEXT="Unknown"
fi

sed -i '' "s|.*|${NEW_TEXT}|" ../CurrentChannel.drkdatac

if [ -n $CI_TAG ]; then
    sed -i '' "s|.*|${CI_TAG}|" ../SemanticVersion.drkdatas
fi

brew install swiftlint
