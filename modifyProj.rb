# encoding: utf-8
#!/usr/bin/ruby

# XXXX 改为自己的工程名称
require 'xcodeproj'
project_path = './XXXX.xcodeproj'
project = Xcodeproj::Project.open(project_path) #打开工程文件

plist_path = './XXXX/Info.plist'
plistHash = Xcodeproj::Plist.read_from_path(plist_path) #读取工程plist配置文件

#传过来的参数 ARGV
if ARGV.size != 4
    puts "修改失败"
    else
        if ARGV[0] != "appNameStr"
            plistHash['CFBundleDisplayName'] = ARGV[0] #app显示名称
        end
        if ARGV[1] != "appBundleStr"
            plistHash['CFBundleIdentifier'] = ARGV[1] #bundle id
        end
        if ARGV[2] != "ShortVersionString"
            plistHash['CFBundleShortVersionString'] = ARGV[2] #bundle version
        end
        if ARGV[3] != "appVersionStr"
            plistHash['CFBundleVersion'] = ARGV[3] #内部版本号
        end

    
    
#    plistHash['CFBundleDisplayName'] = ARGV[0] #app显示名称
#    plistHash['CFBundleIdentifier'] = ARGV[1] #bundle id
#    plistHash['CFBundleVersion'] = ARGV[2] #bundle version

    Xcodeproj::Plist.write_to_path(plistHash, plist_path)  #覆盖修改工程plist配置文件
    puts "修改成功"
end
