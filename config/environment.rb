# 加载文件
require File.expand_path('../application', __FILE__)

#解决 incompatible character encodings: UTF-8 and ASCII-8BIT
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# 初始化程序
Meteor::Application.initialize!