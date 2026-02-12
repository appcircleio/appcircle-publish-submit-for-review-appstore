#!/bin/bash
 
      export LC_ALL=en_US.UTF-8
      export LANG=en_US.UTF-8
      export LANGUAGE=en_US.UTF-8

      echo "IPAFileName:$AC_APP_FILE_NAME"
      echo "IPAFileUrl:$AC_APP_FILE_URL"
      echo "AppleId:$AC_APPLE_ID"
      echo "BundleId:$AC_BUNDLE_ID"
      echo "AppleUserName:$AC_APPLE_APP_SPECIFIC_USERNAME"
      echo "ApplicationSpecificPassword:$AC_APPLE_APP_SPECIFIC_PASSWORD"
      echo "AppStoreConnectApiKey:$AC_API_KEY"
      echo "AppStoreConnectApiKeyFileName:$AC_API_KEY_FILE_NAME"
      echo "appleStoreSubmitApiType:$AC_APPLE_STORE_SUBMIT_API_TYPE"
      echo "Fastlane Version: $AC_FASTLANE_VERSION"
      
      locale
      curl -o "./$AC_APP_FILE_NAME" -k "$AC_APP_FILE_URL"

        bundle init

if [ -z "$AC_FASTLANE_VERSION" ] || [ "$AC_FASTLANE_VERSION" = "latest" ]; then
    echo 'gem "fastlane"' >> Gemfile
    echo "Using latest fastlane version"
else
    echo "Using fastlane version: $AC_FASTLANE_VERSION"
    echo "gem \"fastlane\", \"$AC_FASTLANE_VERSION\"" >> Gemfile
fi
        
        bundle install
        mkdir fastlane
        touch fastlane/Appfile
        touch fastlane/Fastfile
        mv $AC_FASTFILE_CONFIG "fastlane/Fastfile"

        mv "$AC_API_KEY" "$AC_API_KEY_FILE_NAME"
        bundle exec fastlane doSubmitForReview --verbose
        
        if [ $? -eq 0 ] 
        then
          echo "Submit for review progress succeeded"
          exit 0
        else
          echo "Submit for review progress failed :" >&2
          exit 1
        fi
