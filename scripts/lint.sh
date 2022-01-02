#!/usr/bin/env sh

$SRCROOT/Tools/MainTools/.build/release/swift-format -r ./PCSwiftUI ./DataStore ./Domain ./Presentation -m lint || true
