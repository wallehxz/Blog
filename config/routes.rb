#encoding=utf-8
Meteor::Application.routes.draw do

  root :to => 'site#index' #网站主页

  controller :home do
  	get 'admin_index' => :index #管理员主页
    get '/game_lives/delete/:id' => :delete_game  #删除主播
    get '/embarrasses/delete/:id' => :delete_embarrass #删除糗事
    get '/relax_moments/delete/:id' => :delete_relax #删除轻松一刻
    get '/topics/delete/:id' => :delete_topic #删除帖子
  end

  controller :site do

    get 'index'=> :index  #网站首页
    get 'rubyonrails' => :rubyonrails
    get '/rubyonrails/:id' => :rorshow
    get 'qingsongyike' => :qingsongyike
    get '/qingsongyike/:id' => :qsykshow
    get 'qiushibaike' => :qiushibaike
    get '/qiushibaike/:id' => :qsbkshow
    get 'youxizhibo' => :youxizhibo
    get 'wuziqi' => :wuziqi
    get '/youxizhibo/:id' => :yxzbshow
    get '/user' => :account
  end

  controller :sessions do

    get 'admin_sign_in'=> :admin_sign_in  #管理员登陆
    get '/admin_logout/:id'=> :admin_logout  #退出管理员账号
    post '/session/login'=> :admin_login  #管理员账户判断
    get '/sign_up' => :user_sign_in   #用户登录
    post '/account/user_login' => :user_login #用户账户判断
    get  '/account/user_logout/:id' => :user_logout  #用户登出
  end

  controller :admins  do

    get 'admin_sign_up'=> :sign_up   #注册管理员账户
    post '/admin/create' => :create
    get '/my_detail/:id' => :detail  #获取管理员账户信息
    get '/edit_detail/:id' => :edit
    post '/admin/update' => :update
    get '/admin/destroy/:id' => :destroy  #删除管理员账户
  end

  controller :users do

    get '/sign_in' => :user_sign_up
    post '/account/user_create' => :user_create

    post '/account/verify_password_code' => :verify_password_code
    get '/account/user_forget_password' => :forget_password
    get '/account/get_phone_code' => :get_code
    get '/account/reset_password' => :reset_password
    post '/account/password_reset' => :password_reset

    get '/my_card' => :my_info
    get 'my_info/completion' => :info_edit
    get '/constellation_date' => :constellation_date
    post '/my_info/update' => :update_info
    get  '/info_center' => :info_center

  end

  controller :user_sets do

    get '/new_topic' => :new_topic  #添加
    post '/create_topic' => :create_topic  #生成
    get '/edit_topic/:id' => :edit_topic #编辑
    post '/update_topic' => :update_user_topic #更新

    get '/new_embarrass' => :new_embarrass
    post '/create_embarrass' => :create_embarrass

    get '/new_note' => :new_note
    post '/create_note' => :create_note
    get '/edit_note/:id' => :edit_note
    post '/update_note' => :update_note

    get '/my_topic' => :my_topic
    get '/topic/delete/:id' => :delete_topic
    get '/my_embarrass' => :my_embarrass
    get '/my_note' => :my_note

  end

  resources :topics do
    post 'update_topic', :on => :collection

  end

  resources :topic_comments

  resources :embarrasses do
    collection do
      get 'applaud'
    end
  end

  resources :embarrass_comments

  resources :relax_moments do

    post 'update_relax', :on=> :collection
  end

  resources :relax_comments


  resources :game_lives do

    post 'update_live', :on=> :collection
    post 'create_cover', :on=> :collection
    get 'new_cover', :on=> :collection
  end

  resources :game_comments

end
