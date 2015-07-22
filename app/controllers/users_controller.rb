#encoding=utf-8
require 'rack/auth/digest/md5'
class UsersController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:user_create, :password_reset, :update_info]
  before_filter :authenticate_user!, :only => [:my_info, :info_edit, :info_center]
  layout 'account'
  def user_sign_up

  end

  def user_create

    a = params[:phone]
    b = params[:nickname]
    c = params[:account]
    if params[:nickname].blank? && params[:account].blank? && params[:password].blank?
      flash[:error] = '注册信息不能为空'
      redirect_to action: 'user_sign_up'
    elsif params[:account].length < 6
      flash[:error] = '账号长度为6-20字符'
      redirect_to action: 'user_sign_up', :phone=> a, :nickname=> b
    elsif params[:phone].size < 10
      flash[:error] = '手机号格式为11位数字'
      redirect_to action: 'user_sign_up', :nickname=> b, :account=> c
    elsif params[:nickname].size < 2
      flash[:error] = '昵称长度推荐3-8个汉字'
      redirect_to action: 'user_sign_up', :phone=> a, :account=> c
    elsif User.find_by_account(params[:account])
      flash[:error] = '账号已经存在，请更换'
      redirect_to action: 'user_sign_up', :phone=> a, :nickname=> b
    elsif User.find_by_account(params[:phone])
      flash[:error] = '手机号已经存在，请更换'
      redirect_to action: 'user_sign_up', :nickname=> b, :account=> c
    elsif params[:password].size < 6
      flash[:error] = '密码强度弱爆了，容易被盗'
      redirect_to action: 'user_sign_up', :phone=> a, :nickname=> b, :account=> c
    else
      new_account = User.new
      new_account.nickname = params[:nickname]
      new_account.phone = params[:phone]
      new_account.account = params[:account]
      new_account.password = Digest::MD5.hexdigest(params[:password])
      new_account.login_ip = request.remote_ip
      new_account.login_times = 1
      new_account.integration = 10
      new_account.save
      session[:user_id] = new_account.id
      text ="◆#{params[:nickname]}欢迎您加入豆芽小站,账户:#{params[:account]},密码:#{params[:password]};为了您的账号安全,请勿泄露账号相关信息"
      User.send_msg(params[:phone],text)
      flash[:success] = "感谢对本站的支持❤#{new_account.nickname}❤，请记得完善自己的信息哦"
      redirect_to root_path
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  #密码管理---------------------------------------------------------------
  def forget_password

  end

  def get_code

    if User.find_by_phone(params[:phone])
      code = User.six_number
      user = User.find_by_phone(params[:phone])
      if user.verify_time.present? && user.verify_time > Time.now
        @stat= 666
        @msg = '验证码有效时间未过期
请查看手机短信内容'
      else
        user.verify_code = code
        user.verify_time = 1.days.from_now
        user.save
        text = "◆验证码[#{code}],#{user.nickname},您正在使用修改密码功能,验证有效时间为一天,请尽快验证"
        User.send_msg(params[:phone], text)
        @stat= 666
        @msg = '手机验证短信已经发送,请耐心等待!'
      end
    else
      @stat= 777
      @msg = '手机号不存在,验证失败,请重新输入!'
    end
    render :json => {:status=> @stat, :msg=> @msg}
  end

  def verify_password_code

    if params[:phone].blank? || params[:code].blank?
      flash[:error] = '手机号验证码不能为空'
      redirect_to action: 'forget_password'
    else
      if User.find_by_phone(params[:phone])
        user = User.find_by_phone(params[:phone])
        if user.verify_code == params[:code]
          if user.verify_time > Time.now
            redirect_to action: 'reset_password', :user=> user.id, :verify=> user.password
          else
            flash[:error] = '验证码已过期,请重新获取'
            redirect_to action: 'forget_password', :phone=> params[:phone]
          end
        else
          flash[:error] = '验证码不对,请重新输入'
          redirect_to action: 'forget_password', :phone=> params[:phone]
        end
      else
        flash[:error] = '手机号不存在,请重新输入'
        redirect_to action: 'forget_password'
      end
    end
  end

  def reset_password  #重置密码 页面

    if User.find_by_id(params[:user])
      user = User.find_by_id(params[:user])
      if user.password != params[:verify]
        flash[:error] = '验证信息有误,无法进行操作'
        redirect_to action: 'forget_password'
      end
    else
      flash[:error] = '账户信息有误,无法进行操作'
      redirect_to action: 'forget_password'
    end
  end

  def password_reset  #密码重置   方法

      user = User.find_by_id(params[:user_id])
      user.password = Digest::MD5.hexdigest(params[:password])
      user.verify_code = nil
      user.verify_time = nil
      user.login_times = user.login_times + 1
      user.login_ip = request.remote_ip
      user.save
      text = "◆#{user.nickname}、您账号#{user.account}的登录密码已经修改为#{params[:password]},请保留该信息，方便您登录"
      User.send_msg(user.phone, text)
      session[:user_id] = user.id
      flash[:success] ="密码修改成功 ❤【#{user.nickname}】"
      redirect_to  '/info_center'
  end

  def my_info   #我的名片
    render layout: 'userinfo'
  end

  def info_edit #完善用户信息
      render layout: 'teemo'
  end

  def constellation_date #根据选择的生日，自动生成相应的星座

    date = params[:select_date]
    number = User.constellation_picture(date.to_datetime.strftime('%m%d').to_i)
    constellation = User::CONSTELLATION[number]
    render :json => {:msg=> constellation}
  end

  def update_info  #更新信息  post
    if session[:user_id].present?
      my_info = User.find_by_id(session[:user_id])
      if params[:user][:avatar].present?
        if my_info.avatar.present?
            User.delete_picture(my_info.avatar)  #删除旧照片文件
        end
        params[:user][:avatar] = User.avatar_upload(params[:user][:avatar])
      end
      my_info.update_attributes(params[:user])
      flash[:success] = '个人信息更新成功！'
      redirect_to '/info_center'
    else
      flash[:notice] = '您的操作没有权限，请登录后完善'
      redirect_to root_path
    end

  end

  def info_center
    render layout: 'teemo'
  end

end
