
# ios package script
# author: bobwong

# ---------- 参数配置 ----------

project_name="BWiOSJenkinsCI"
date_current=`date +"%Y%m%d_%H%M%S"`
ipa_name=${project_name}_${date_current}
ios_package="iOSPackages/${project_name}/${ipa_name}"
tool_plist="/usr/libexec/PlistBuddy"  # plist工具

path_project=`pwd`  # 工程路径
path_info_plist=${path_project}/${project_name}/Info.plist  # Info.plist路径
path_build=${path_project}/build  # build文件夹路径
path_package=${HOME}/Desktop/${ios_package}

echo "================工程路径:$path_project================"
echo "================工程build文件夹路径:$path_build================"

# ---------- build and package ----------

xcodebuild clean  # clean
rm -r $path_build

xcodebuild  # build

mkdir -p ${path_package}

mv $path_build ${path_package}

cd ${path_package}
mv build/Release-iphoneos/${project_name}.app ./${project_name}.app
mv build/Release-iphoneos/${project_name}.app.dSYM ./${project_name}.app.dSYM
rm -r build

mkdir Payload
mv ${project_name}.app Payload/${project_name}.app
zip -r ${ipa_name}.ipa Payload
rm -r Payload

open ${path_package}

echo "======= 打包完成 ======="
