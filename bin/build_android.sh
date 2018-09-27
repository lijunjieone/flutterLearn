#!/bin/bash



current_path=`echo $(cd "$(dirname "$0")"; pwd)`
flutter_app_path=$current_path/..
flutter_android_path=${flutter_app_path}/android/
android_app_name=flutter_android
android_app_path=${flutter_app_path}/host/android/${android_app_name}
flutter_android_gradle_build=${flutter_app_path}/android/app/build.gradle


#echo $flutter_app_path
#echo $android_app_name
#echo $android_app_path

#cd $flutter_app_path && ls -lh

function modify_build_gradle_for_aar() {
    cp $flutter_android_gradle_build ${flutter_android_gradle_build}.src
    sed -i.bak 's/com.android.application/com.android.library/g' $flutter_android_gradle_build
    sed -i.bak 's/applicationId/\/\/applicationId/g' $flutter_android_gradle_build
}

function modify_build_gradle_for_apk() {
   cp -pv ${flutter_android_gradle_build}.src $flutter_android_gradle_build
   rm -rf ${flutter_android_gradle_build}.bak
   rm -rf ${flutter_android_gradle_build}.src

}

function build_aar() {
#   cat $flutter_android_gradle_build
   modify_build_gradle_for_aar
#   echo ${flutter_android_path}
   cd ${flutter_android_path} && ./gradlew :app:asR
   modify_build_gradle_for_apk
}


function main() {
    build_aar
}

main