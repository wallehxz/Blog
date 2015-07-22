#encoding=utf-8
require 'rack/auth/digest/md5'
class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:admin_login, :user_login]
  skip_before_filter :save_referer, :only => [:admin_sign_in, :user_sign_in, :admin_logout, :user_logout]
  before_filter :has_been_login?, :only =>  [:user_sign_in]
  #管理员---------------------------------------------
  def admin_sign_in

  end

  def admin_login #登录

    if params[:account].blank? && params[:password].blank?
      flash[:error] = '账号密码不能为空'
      redirect_to admin_sign_in_path
    elsif params[:account].blank?
      flash[:error] = '账号不能为空'
      redirect_to admin_sign_in_path
    elsif params[:password].blank?
      flash[:error] = '密码不能为空'
      redirect_to admin_sign_in_path
    elsif Admin.find_by_account(params[:account]).nil?
      flash[:error] = '账号不存在'
      redirect_to admin_sign_in_path
    else
      @current_admin = Admin.find_by_account(params[:account])
      if @current_admin.password == Digest::MD5.hexdigest(params[:password])
        @current_admin.login_count = @current_admin.login_count + 1
        @current_admin.login_ip = request.remote_ip
        @current_admin.save
        session[:admin_id] = @current_admin.id
        if session[:back_url].present?
          redirect_to session[:back_url].to_s
        else
          flash[:success] ="欢迎回来,管理员【#{@current_admin.nickname}】"
          redirect_to admin_index_path
        end
      else
        flash[:notice] = '密码不正确'
        redirect_to admin_sign_in_path
      end
    end

  end

  def admin_logout
    if session[:admin_id].present?
      if params[:id].to_i == session[:admin_id]
        session.delete :admin_id
        flash[:success] = '账户登出成功！'
        redirect_to admin_sign_in_path
      else
        flash[:notice] = '您没有权限登出其他管理人员'
        redirect_to '/admin_index'
      end
    else
      flash[:notice] = '您还没有登录，不能操作'
      redirect_to admin_sign_in_path
    end

  end

  #用户---------------------------------------------
  def user_sign_in
    session[:back_url] = params[:back_url]
    render layout: 'account'
  end

  def user_login

    if params[:account].blank? && params[:password].blank?
      flash[:error] = '账号密码不能为空'
      redirect_to action: 'user_sign_in'
    elsif params[:account].blank?
      flash[:error] = '账号不能为空'
      redirect_to action: 'user_sign_in'
    elsif params[:password].blank?
      flash[:error] = '密码不能为空'
      redirect_to action: 'user_sign_in', :account=>params[:account]
    elsif User.find_by_account(params[:account]).nil?
      flash[:error] = '账号不存在'
      redirect_to action: 'user_sign_in'
    else
      @current_user = User.find_by_account(params[:account])
      if @current_user.password == Digest::MD5.hexdigest(params[:password])
        @current_user.login_times = @current_user.login_times + 1
        @current_user.integration = @current_user.integration + 1  #登录一次积分加1
        @current_user.login_ip = request.remote_ip
        @current_user.save
        session[:user_id] = @current_user.id
        if session[:back_url].present?
          redirect_to session[:back_url]
          session[:back_url] = nil
        else
          flash[:success] ="欢迎回来【#{@current_user.nickname}】"
          redirect_to  '/info_center'
        end
      else
        flash[:error] = '密码不正确'
        redirect_to action: 'user_sign_in', :account=>params[:account]
      end
    end
  end

  def user_logout

    if session[:user_id].present?
      if params[:id].to_i == session[:user_id]
        session.delete :user_id
        if params[:back_url].present?
          redirect_to params[:back_url]
        else
          flash[:success] = '账户登出成功！'
          redirect_to root_path
        end
      else
        flash[:notice] = '不合法的操作，不予执行'
        redirect_to root_path
      end
    else
      flash[:notice] = '您还没有登录，不能操作'
      redirect_to action: 'user_sign_in'
    end

  end

end
