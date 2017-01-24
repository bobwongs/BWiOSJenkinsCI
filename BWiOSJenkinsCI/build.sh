
# ios package script
# author: bobwong

# ---------- 参数配置 ----------

project_name="BWiOSJenkinsCI"
date_current=`date +"%Y%m%d_%H%M%S"`
ipa_name=${project_name}_${date_current}
#ipa_name=${project_name}
ios_package="iOSPackages/${project_name}"
tool_plist="/usr/libexec/PlistBuddy"  # plist工具

path_project=`pwd`  # 工程路径
path_info_plist=${path_project}/${project_name}/Info.plist  # Info.plist路径
path_build=${path_project}/build  # build文件夹路径
path_package=${HOME}/Desktop/${ios_package}
path_package_history=${path_package}/History

echo "================ 工程路径:$path_project ================"
echo "================ 打包文件目录:$path_package ================"

if [ ! -d $path_package_history ]; then
    mkdir -p $path_package_history
fi

# ---------- build and package ----------

xcodebuild clean  # clean
rm -r $path_build

xcodebuild  # build

if [ ! -d $path_package_history ]; then
　　mkdir -p $path_package_history
fi

cd ${path_package}

mv ./*.ipa $path_package_history/
mv ./*.dSYM $path_package_history/

mv $path_build ${path_package}
mv build/Release-iphoneos/${project_name}.app ./${ipa_name}.app
mv build/Release-iphoneos/${project_name}.app.dSYM ./${ipa_name}.app.dSYM
rm -r build

mkdir Payload
mv ${ipa_name}.app Payload/${ipa_name}.app
zip -r ${ipa_name}.ipa Payload
rm -r Payload

open ${path_package}

echo "======= 打包完成 ======="
