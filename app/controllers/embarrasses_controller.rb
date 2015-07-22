#encoding=utf-8
require 'will_paginate'
class EmbarrassesController < ApplicationController
  before_filter :authenticate_admin!, :except => :applaud
  skip_before_filter :verify_authenticity_token, :only => :create
  layout 'butterfly'
  def index
    @embarrasses = Embarrass.order('chan_count DESC').order('created_at desc').paginate(:page=>params[:page], :per_page=>6)
    render layout: 'league'
  end

  def show
    @embarrass = Embarrass.find(params[:id])
    @embarrass_comment = EmbarrassComment.where(:embarrass_id => @embarrass.id)

  end

  def new
    @embarrass = Embarrass.new
  end


#   original_filename	获得文件的名字
#   content_type	得到文件的类型
#   File.extname(file.original_filename) 	扩展名
#   read	读取文件中的数据(从硬盘上读取到内存中)
#   write	写文件(把内存中数据写到硬盘中)
#   size	获取文件长度

  def create
    @embarrass = Embarrass.new
    file = params[:embarrass][:picture]
    if file.present? && params[:embarrass][:process].present?
      store_path = Embarrass.picture_upload(file)
      @embarrass.picture = store_path
    end
    if params[:embarrass][:process].present? && params[:embarrass][:process].size > 5
      @embarrass.process = params[:embarrass][:process]
      @embarrass.user_id = params[:embarrass][:user_id]
      @embarrass.save
      flash[:success] = '新的糗事已经成功发布！'
      redirect_to action: 'index'
    else
      flash[:error] = '分享的糗事内容太短了！'
      redirect_to action: 'new'
    end

  end

  def destroy
    @embarrass = Embarrass.find(params[:id])
    @embarrass.destroy

    respond_to do |format|
      format.html { redirect_to embarrasses_url }
      format.json { head :no_content }
    end
  end

  def applaud

    if Embarrass.find_by_id(params[:id]).present?
      @embarrass = Embarrass.find_by_id(params[:id])
      @embarrass.chan_count = @embarrass.chan_count + 1
      @embarrass.save
      render :json => {status:200}
    end
  end

end
