#!/bin/bash



current_path=`echo $(cd "$(dirname "$0")"; pwd)`
flutter_app_path=$current_path/..
flutter_android_path=${flutter_app_path}/android/
android_app_name=flutter_android
android_app_path=${flutter_app_path}/host/android/${android_app_name}
flutter_android_gradle_build=${flutter_app_path}/android/app/build.gradle
flutter_aar_path=${flutter_app_path}/build/app/outputs/aar/app-release.aar

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

function cp_aar_to_android_lib() {
    if [ -e ${flutter_aar_path} ]; then
       cp -pv ${flutter_aar_path} ${android_app_path}/app/libs/flutter_sdk.aar
    else
       echo  ${flutter_aar_path} is not exist
    fi
}

function cp_icudtl_to_android_assets() {
    assets_path=${android_app_path}/app/src/main/assets/flutter_shared

    if [ -e ${assets_path} ]; then
        echo "icudtl.dat is exists"
    else
        mkdir -pv ${assets_path}
        cp -pv ${current_path}/icudtl.dat $assets_path
    fi

}
function main() {
    build_aar
    cp_aar_to_android_lib
    cp_icudtl_to_android_assets
}

main