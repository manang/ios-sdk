#!/bin/bash

set -eo pipefail

cd hICNTools
pod install
xcodebuild -workspace hICNTools.xcworkspace \
            -scheme hICNTools
            -sdk iphoneos \
            -allowProvisioningUpdates \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/hICNTools.xcarchive -allowProvisioningUpdates \
            clean archive | xcpretty
