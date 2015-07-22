#encoding=utf-8
require 'will_paginate'
class TopicsController < ApplicationController
  layout 'butterfly'
  before_filter :authenticate_admin!
  def index

    @topics = Topic.order('updated_at desc').paginate(:page=> params[:page],:per_page=> 6)

  end

  def show

    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.where(:topic_id => @topic.id)
  end

  def new

    @topic = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create

    @topic = Topic.new(params[:topic])
    @topic.save
  end

  def update_topic

    @topic = Topic.find(params[:topic][:id])
    @topic.update_attributes(params[:topic])
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      flash[:success] ='帖子删除成功！'
      format.html { redirect_to topics_path }
    end
  end
end
