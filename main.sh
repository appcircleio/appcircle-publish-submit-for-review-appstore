#!/bin/bash
 
      export LC_ALL=en_US.UTF-8
      export LANG=en_US.UTF-8
      export LANGUAGE=en_US.UTF-8

      echo "IPAFileName:$IPAFileName"
      echo "IPAFileUrl:$IPAFileUrl"
      echo "AppleId:$AppleId"
      echo "BundleId:$BundleId"
      echo "AppleUserName:$AppleUserName"
      echo "ApplicationSpecificPassword:$ApplicationSpecificPassword"
      echo "AppStoreConnectApiKey:$AppStoreConnectApiKey"
      echo "AppStoreConnectApiKeyFileName:$AppStoreConnectApiKeyFileName"
      echo "appleStoreSubmitApiType:$appleStoreSubmitApiType"
      
      locale
      curl -o "./$IPAFileName" -k $IPAFileUrl

        bundle init
        echo "gem \"fastlane\"">>Gemfile
        bundle install
        mkdir fastlane
        touch fastlane/Appfile
        touch fastlane/Fastfile
        mv $FastFileConfig "fastlane/Fastfile"

        mv "$AppStoreConnectApiKey" "$AppStoreConnectApiKeyFileName"
        bundle exec fastlane doSubmitForReview --verbose
        
        if [ $? -eq 0 ] 
        then
          echo "Submit for review progress succeeded"
          exit 0
        else
          echo "Submit for review progress failed :" >&2
          exit 1
        fi
