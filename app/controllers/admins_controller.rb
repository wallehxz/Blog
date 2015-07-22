#encoding=utf-8
require 'rack/auth/digest/md5'
class AdminsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def sign_up

  end

  def create
    a = params[:invitation]
    b = params[:nickname]
    c = params[:account]
    if params[:invitation] == '18211109527'
      if params[:nickname].blank? && params[:account].blank? && params[:password].blank?
        flash[:notice] = '注册信息不能为空'
        redirect_to action: 'sign_up', :code=> a, :name=> b, :account=> c
      elsif params[:nickname].size < 2
        flash[:notice] = '昵称长度好像太短了'
        redirect_to action: 'sign_up', :code=> a, :account=> c
      elsif Admin.find_by_account(params[:account])
        flash[:notice] = '账号已经存在，请更换'
        redirect_to action: 'sign_up', :code=> a, :name=> b
      elsif params[:password].size < 4
        flash[:notice] = '密码强度弱爆了，容易被盗'
        redirect_to action: 'sign_up', :code=> a, :name=> b, :account=> c
      else
        @admin = Admin.new
        @admin.nickname = params[:nickname]
        @admin.account = params[:account]
        @admin.password = Digest::MD5.hexdigest(params[:password])
        @admin.login_ip = request.remote_ip
        @admin.login_count = 1
        @admin.save
        flash[:success] ="恭喜您成功获得管理员权限❤#{@admin.nickname}❤"
        redirect_to admin_sign_in_path
      end
    else
      flash[:alert] = '您还没有获得邀请资格'
      redirect_to admin_sign_up_path
    end

  end


  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { head :no_content }
    end
  end

end
