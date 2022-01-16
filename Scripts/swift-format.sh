#!/usr/bin/env sh

if [ $ENABLE_PREVIEWS == "NO" ]
then
  $SRCROOT/Tools/.build/release/swift-format -r $SRCROOT/PCSwiftUI $SRCROOT/Presentation $SRCROOT/Application $SRCROOT/Domain $SRCROOT/Infrastructure -i || true
  $SRCROOT/Tools/.build/release/swift-format -r $SRCROOT/PCSwiftUI $SRCROOT/Presentation $SRCROOT/Application $SRCROOT/Domain $SRCROOT/Infrastructure -m lint || true
else
  echo "Skipping the script because of preview mode"
fi
