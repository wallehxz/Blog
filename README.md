【使用说明】

 1   用 git 工具将代码 克隆

 2  安装 gemfile里的 gem
     bundle install 

  3  代码支持短信功能，所以需要联网，如果没有网络
      请注释掉 /config/initializers/initialize_config.rb 里面代码

  4 迁移数据，生成数据表 ，默认使用的是PostgreSQL数据
       rake db:migrate

  5 启动项目
      rails s