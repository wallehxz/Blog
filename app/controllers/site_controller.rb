# encoding=utf-8
require 'will_paginate'
class SiteController < ApplicationController
  layout 'sprouts'
  def index

  end

  def rubyonrails

    @topics = Topic.order('updated_at desc').paginate(:page=> params[:page],:per_page=> 6)
    render layout: 'rubyonrails'
  end

  def rorshow
    if Topic.find_by_id(params[:id]).nil?
      flash[:error] = '该贴被城管打死或被作者删除！'
      redirect_to rubyonrails_path
    else
      @topic = Topic.find(params[:id])
      @topic_comment = TopicComment.where(:topic_id => params[:id])
      render layout: 'rubyonrails'
    end
  end

  def qingsongyike

    @relax_moments = RelaxMoment.order('chan_count DESC').order('relax_time desc').paginate(:page=>params[:page], :per_page=>6)
    render layout: 'qingsongyike'
  end

  def qsykshow

    if RelaxMoment.find_by_id(params[:id]).nil?
      flash[:alert] = '网易的编辑中了500万大奖而辞职不干了！'
      redirect_to qingsongyike_path
    else
      @relax_moment = RelaxMoment.find(params[:id])
      @relax_comment = RelaxComment.where(:relax_id => params[:id])
      render layout: 'qingsongyike'
    end
  end

  def qiushibaike

    @embarrasses = Embarrass.order('chan_count DESC').order('created_at desc').paginate(:page=>params[:page], :per_page=>6)
    render layout: 'qiushibaike'
  end

  def qsbkshow

    if Embarrass.find_by_id(params[:id]).nil?
      flash[:success] = '该糗事因为太搞笑被外星人抓走了！'
      redirect_to qiushibaike_path
    else
      @embarrass = Embarrass.find(params[:id])
      @embarrass_comment = EmbarrassComment.where(:embarrass_id => params[:id])
      render layout: 'qiushibaike'
    end
  end

  def youxizhibo

    @game_lives = GameLive.order('attention desc').paginate(:page=> params[:page],:per_page=> 4)
    render layout: 'youxizhibo'
  end

  def yxzbshow

    if GameLive.find_by_id(params[:id]).nil?
      flash[:notice] = '该主播因嫖娼被抓或被城管打断了小弟弟！'
      redirect_to youxizhibo_path
    else
      @game_life = GameLive.find(params[:id])
      @game_comment = GameComment.where(:game_id => params[:id])
      render layout: 'youxizhibo'
    end
  end

  def account  #用户名片

      if User.find_by_account(params[:account])
        @current_user = User.find_by_account(params[:account])
        render layout: 'userinfo'
      else
        flash[:error] = '该用户不存在，请检查'
        redirect_to root_path
      end
  end

  def wuziqi #休闲娱乐
    render layout: false
  end

end