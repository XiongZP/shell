#app id
APPID=XXX
#app id 密码
APPPS=XXX
#fir token
#FIRTOKEM=XXX

#使用方法

if [ ! -d ./IPADir ];
then
mkdir -p IPADir;
fi

#工程绝对路径
project_path=$(cd `dirname $0`; pwd)
echo ""
echo "===================================================================="
echo "                      准备事项，已经准备请忽略                           "
echo ""
echo "请先安装 xcodebuild 和 Ruby"
echo "mac 电脑一台  xcode 开发工具"
echo "安装xcodebuild方法： https://github.com/CocoaPods/Xcodeproj"
echo "安装Ruby方法：       https://www.jianshu.com/p/6c0758430dc0"
echo "注意key证书权限开起始终信任"
echo "===================================================================="

#===================================== 选择打包方式 ==========================
echo ""
echo "请选择你需要的打包方式"
echo "1.选择配置打包"
echo "2.输入配置打包"
read numberType
while([[ $numberType != 1 ]] && [[ $numberType != 2 ]])
do
echo "请选择你需要的打包方式"
echo "1.输入配置打包"
echo "2.选择配置打包"
read numberType
done

#===================================== 默认配置 ==========================
app_name="TFInfo"
app_bundle_id="com.cjc.itfer"
app_bundle_Short_version="2.1.0"
app_bundle_version="1"

if [ $numberType == 1 ];then
#===================================== 自动配置 ==========================
echo "请选择您配置好的信息"
echo "1.App名称：TFIn 包名：com.cjc.it 版本：1.0.0  构建版本：1"
echo "2.App名称：TF1    包名：com.cjc.it1   版本：1.0.0  构建版本：2"
echo "3.App名称：TFA    包名：com.cjc.itA   版本：1.0.0  构建版本：3"
read numberType1
while([[ $numberType1 != 1 ]] && [[ $numberType1 != 2 ]] && [[ $numberType1 != 3 ]])
do
echo "请选择您配置好的信息"
echo "1.App名称：TFIn 包名：com.cjc.it 版本：1"
echo "2.App名称：TF1 包名：com.cjc.it1 版本：2"
echo "3.App名称：TFA 包名：com.cjc.itA 版本：3"
read numberType1
done

if [ $numberType1 == 1 ];then
app_name="TFIn"
app_bundle_id="com.cjc.it"
app_bundle_version="1"
app_bundle_Short_version="1.0.0"
elif [ $numberType1 == 2 ];then
app_name="TF1"
app_bundle_id="com.cjc.it1"
app_bundle_version="2"
app_bundle_Short_version="1.0.0"
else
app_name="TFA"
app_bundle_id="com.cjc.itA"
app_bundle_version="3"
app_bundle_Short_version="1.0.0"
fi
fi

if [ $numberType == 2 ];then
echo "======================================================================="
echo "                           修改程序配置部分                               "
echo "======================================================================="
app_name="appNameStr"
app_bundle_id="appBundleStr"
app_bundle_version="appVersionStr"
app_bundle_Short_version="ShortVersionString"
#===================================== 手动配置 (配置APP的基本信息 包名，APP名称等) ==========================
    echo ""
    echo "请输入您的App名称"
    read appNameStr
    if [ -n "$appNameStr" ]; then
        app_name=$appNameStr
    fi

    echo ""
    echo "请输入您的App包名 版本: com.cjc.xxx"
    read appBundleStr
    if [ -n "$appBundleStr" ]; then
        app_bundle_id=$appBundleStr
    fi
    echo ""
    echo "请输入您的App版本 版本: 1.0.0"
    read shortVersionStr
    if [ -n "$shortVersionStr" ]; then
        app_bundle_Short_version=$shortVersionStr
    fi

    echo ""
    echo "请输入您的App内部版本版本（用于上传使用） 版本: 1"
    read appVersionStr
    if [ -n "$appVersionStr" ]; then
        app_bundle_version=$appVersionStr
    fi
fi

#===================================== 替换文件 (配置APP Logo ，启动图，多媒体文件)==========================
#app logo资源路径
echo ""
echo "替换你APP的Logo资源 空则不替换"
echo "请输入您准备的文件路径"
read linkStr
link=$linkStr
#判断是否为空
if [ -n "$link" ]; then
# 替换自己的地址
superlink=${project_path}/image.xcassets
cp -a "$link" "$superlink"
fi

#app 启动图资源路径
echo ""
echo "替换你APP的启动图资源 空则不替换"
echo "请输入您准备的文件路径"
read linkStr
link=$linkStr
#判断是否为空
if [ -n "$link" ]; then
superlink=${project_path}/image.xcassets
cp -a "$link" "$superlink"
fi

#app icon资源路径
echo ""
echo "替换你APP的icon资源 空则不替换"
echo "请输入您准备的文件路径"
read linkStr
link=$linkStr
#判断是否为空
if [ -n "$link" ]; then
superlink=${project_path}/image.xcassets
cp -a "$link" "$superlink"
fi


#================================== 替换程内内容  修改代码（配置程序内数据，修改文件代码） ==========================
echo ""
echo "是否替换App内信息 （1：修改 / 2：不修改） 空则不改"
read editlinkStr

#判断是否为空
if [ -n "$editlinkStr" ]; then
    if [ $editlinkStr == 1 ];then
# 替换自己的地址
        editlink=${project_path}/shiku_im/Configurations/XAppConfiguration.m

        echo ""
        echo "请输入您App的颜色 格式（#0093dd）空则不替换"
        read editStr
        editS=$editStr
        #判断是否为空
        if [ -n "$editS" ]; then
        sed -i "" '20s?.*?NSString *AppColor = @"'${editS}'";?' $editlink
        fi

        echo ""
        echo "请输入您App 名字 格式（我是一只土豆）"
        read editStr
        editS=$editStr
        #判断是否为空
        if [ -n "$editS" ]; then
        sed -i "" '16s?.*?NSString *kText_000000 = @"'${editS}'";?' $editlink
        fi

        echo ""
        echo "请输入您App 主框架地址 格式（http://www.baidu.com/）"
        read editStr
        editS=$editStr
        if [ -n "$editS" ]; then
        sed -i "" '27s?.*?NSString *Api_HOST = @"'${editS}'";?' $editlink
        fi
    fi
fi

# 指定文字替换
#sed -i '' 's/第一/$(editS)/' $editlink
# 替换整行
#sed -i "" '1s?.*?abc79234723947239/' /Users/xzp/Desktop/ViewController.swift
# 替换文件
#cp -a "/Users/xzp/Desktop/代码管理/shiku_im/appIcons/app1/AppIcon.appiconset" "/Users/xzp/Desktop/代码管理/shiku_im/shiku_im/Assets.xcassets"


#===================================== 配置脚本 ==========================
#替换工程文件配置信息
ruby modifyProj.rb $app_name $app_bundle_id $app_bundle_Short_version $app_bundle_version

#工程名 将XXX替换成自己的工程名
project_name=XXX

#scheme名 将XXX替换成自己的sheme名
scheme_name=XXX

#打包模式 Debug/Release
development_mode=Release

#build文件夹路径
build_path=${project_path}/build

#plist文件所在路径
exportOptionsPlistPath=${project_path}/exportTest.plist

#导出.ipa文件所在路径
exportIpaPath=${project_path}/IPADir/${development_mode}

echo "======================================================================="
echo "                           开始打包部分                              "
echo "======================================================================="
#===================================== 开始打包 ==========================
echo ""
echo "请选择你的打包方式 ? [ 1:app-store(正式版) 2:ad-hoc（测试版）]"
echo "1 ：(正式版) 上传商城app Store  app-store"
echo "2 ：(测试版) 上传蒲公英测试      ad-hoc  "


##
read number
while([[ $number != 1 ]] && [[ $number != 2 ]] && [[ $number != 3 ]])
do
echo "请选择你的打包方式 ? [ 1:app-store(正式版) 2:ad-hoc（测试版）]"
echo "1 ：(正式版) 上传商城app Store  app-store"
echo "2 ：(测试版) 上传蒲公英测试      ad-hoc  "
read number
done

# 默认两种类型
if [ $number == 1 ];then
development_mode=Release
exportOptionsPlistPath=${project_path}/exportAppstore.plist
#exportOptionsPlistPath=${project_path}/exportTest.plist
else
development_mode=Debug
exportOptionsPlistPath=${project_path}/exportTest.plist
fi
# 自定义的
if [ $number == 3 ];then
development_mode=TRelease
#exportOptionsPlistPath=${project_path}/exportAppstore.plist
exportOptionsPlistPath=${project_path}/exportTest.plist
fi


echo '///-----------'
echo '/// 正在清理工程'
echo '///-----------'
xcodebuild \
clean -configuration ${development_mode} -quiet  || exit


echo '///--------'
echo '/// 清理完成'
echo '///--------'
echo ''

echo '///-----------'
echo '/// 正在编译工程:'${development_mode}
echo '///-----------'
xcodebuild \
archive -workspace ${project_path}/${project_name}.xcworkspace \
-scheme ${scheme_name} \
-configuration ${development_mode} \
-archivePath ${build_path}/${project_name}.xcarchive  -quiet  || exit

echo '///--------'
echo '/// 编译完成'
echo '///--------'
echo ''

echo '///----------'
echo '/// 开始ipa打包'
echo '///----------'
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportIpaPath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit

if [ -e $exportIpaPath/$scheme_name.ipa ]; then
echo '///----------'
echo '/// ipa包已导出'
echo '///----------'
open $exportIpaPath
else
echo '///-------------'
echo '/// ipa包导出失败 '
echo '///-------------'
fi
echo '///------------'
echo '/// 打包ipa完成  '
echo '///-----------='
echo ''

echo '///-------------'
echo '/// 开始发布ipa包 '
echo '///-------------'

if [ $number == 1 ];then
#验证并上传到App Store
# 将-u 后面的XXX替换成自己的AppleID的账号，-p后面的XXX替换成自己的密码
altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
"$altoolPath" --validate-app -f ${exportIpaPath}/${scheme_name}.ipa -u $APPID -p $APPPS -t ios --output-format xml
"$altoolPath" --upload-app -f ${exportIpaPath}/${scheme_name}.ipa -u  $APPID -p $APPPS -t ios --output-format xml
else

# 上传蒲公英
# XXXXX 替换自己的key
RESULT=$(curl -F "file=@$exportIpaPath/$scheme_name.ipa" -F "uKey=XXXXX" -F "_api_key=XXXXX" -F "publishRange=2" http://www.pgyer.com/apiv1/app/upload)

echo "完成上传"
echo "\n\n\n\n-------------------\n\n\n\n"
echo "\033[361m打包总用时: ${SECONDS}s \033[0m"


#上传到Fir
# 将XXX替换成自己的Fir平台的token
# fir login -T XXX
# fir publish $exportIpaPath/$scheme_name.ipa

fi

echo '///-------------'
echo '/// 邮件发送中。。。。。。。。 '
echo '///-------------'

#发送推送
#python3 myjpush.py  "${bundleShortVersion}(${bundleVersion})上传成功" "${project_name}"

exit

