#encoding=utf-8
require 'will_paginate'
class UserSetsController < ApplicationController
  layout 'teemo'
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only =>[:create_embarrass,:create_topic, :create_note, :update_topic, :update_note]

  def new_topic  #get

  end

  def create_topic  #post
    params[:topic][:user_id] = session[:user_id]
    @topic = Topic.new(params[:topic])
    @topic.save
    @current_user.integration = @current_user.integration + 5
    @current_user.save
  end

  def edit_topic #get

    @topic = Topic.find(params[:id])
    if @topic.user_id != session[:user_id]
      flash[:error]='您没有权限编辑他人的帖子'
      redirect_to '/info_center'
    end
  end

  def update_user_topic  #post
    @topic = Topic.find(params[:topic][:id])
    @topic.update_attributes(params[:topic])
  end

  def new_embarrass  #get

  end

  def create_embarrass  #post
    params[:embarrass][:user_id] = session[:user_id]
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
      @current_user.integration = @current_user.integration + 2
      @current_user.save
      flash[:success] = '新的糗事已经成功发布！'
      redirect_to '/info_center'
    else
      flash[:error] = '分享的糗事内容太短了！'
      redirect_to action: 'new_embarrass'
    end
  end

  def new_note #get

  end

  def create_note #post
    params[:note][:user_id] = session[:user_id]
    @note = Note.new(params[:note])
    @note.save
    @current_user.integration = @current_user.integration + 3
    @current_user.save
  end

  def edit_note #get
    @note = Note.find(params[:id])
    if @note.user_id != session[:user_id]
      flash[:error]='您没有权限编辑他人的帖子'
      redirect_to '/info_center'
    end
  end

  def update_note  #post

    @note = Note.find(params[:note][:id])
    @note.update_attributes(params[:note])
  end

  def my_embarrass

    @embarrasses = Embarrass.where(:user_id => session[:user_id]).order('chan_count desc').paginate(:page=> params[:page],:per_page=> 2)
  end

  def my_note
    @note = Note.where(:user_id => session[:user_id]).order('note_date desc').paginate(:page=> params[:page],:per_page=> 14)
  end

  def my_topic

    @topics = Topic.where(:user_id => session[:user_id]).order('updated_at desc').paginate(:page=> params[:page],:per_page=> 2)
  end

  def delete_topic

    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:success] ='帖子删除成功!'
    redirect_to action: 'my_topic'
  end

end