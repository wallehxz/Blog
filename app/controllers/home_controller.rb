# encoding=utf-8
class HomeController < ApplicationController
  before_filter :authenticate_admin!

    def index
      render layout: 'meteor'
    end

    def delete_game
      @game_life = GameLive.find(params[:id])
      if @game_life.person_cover.present?
        GameLive.delete_picture @game_life.person_cover
      end
      @game_life.destroy
      flash[:success] ='已删除主播信息'
      redirect_to game_lives_path
    end

    def delete_topic

      @topic = Topic.find(params[:id])
      @topic.destroy
      flash[:success] ='帖子内容删除成功！'
      redirect_to topics_path
    end

    def delete_relax
      @relax_moment = RelaxMoment.find(params[:id])
      @relax_moment.destroy
      flash[:success] ='轻松一刻内容删除成功！'
      redirect_to relax_moments_path
    end

    def delete_embarrass
      @embarrass = Embarrass.find(params[:id])
      @embarrass.destroy
      flash[:success] ='糗事内容删除成功！'
      redirect_to embarrasses_path
    end
end
