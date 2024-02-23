#!/bin/zsh

if [ "$CI_WORKFLOW" = "Canary Deploy" ]; then
    NEW_TEXT="Canary"
elif [ "$CI_WORKFLOW" = "Dev Deploy" ]; then
    NEW_TEXT="Dev"
elif [ "$CI_WORKFLOW" = "Public Release" ]; then
    NEW_TEXT="Stable"
else
    # 默认值，如果 CI_WORKFLOW 不匹配上述条件
    NEW_TEXT="Unknown"
fi

sed -i '' "s|.*|${NEW_TEXT}|" ../CurrentChannel.drkdatac

brew install swiftlint
