#encoding=utf-8
class ApplicationController < ActionController::Base
  before_filter :current_admin, :current_user
  helper_method :current_user, :current_admin
  protect_from_forgery

  def authenticate_admin!

    if @current_admin.nil?
      flash[:notice] ='您还没有管理员账户,请联系meteor21475@126.com'
      redirect_to admin_sign_in_path
    end
  end

  def authenticate_user!

    if @current_user.nil?
      flash[:notice] ='请登录您的账户'
      redirect_to '/account/user_sign_in'
    end
  end

  def has_been_login?
    if @current_user.present?
      flash[:success] ="#{@current_user.nickname},您已经登录，如需更换账号，请先登出账号信息！"
      redirect_to root_path
    end
  end

  def current_admin

   if session[:admin_id].present?
     @current_admin = Admin.find_by_id(session[:admin_id])
   end
  end

  def current_user

    if session[:user_id].present?
      @current_user = User.find_by_id(session[:user_id])
    end
  end



  # def save_referer  #保存上一次链接 用户登录跳转
  #   if @current_user.nil?
  #     session[:back_url] = request.env['HTTP_REFERER']
  #   else
  #     session[:back_url] = nil
  #   end
  # end


end
