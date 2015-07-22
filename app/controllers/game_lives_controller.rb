#encoding=utf-8
class GameLivesController < ApplicationController
  layout 'butterfly'
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_admin!
  def index

    @game_lives = GameLive.order('attention desc').paginate(:page=> params[:page],:per_page=> 3)
  end

  def show

    @game_life = GameLive.find(params[:id])
  end

  def new_cover

    if GameLive.find_by_id(params[:live_id]).nil?
      redirect_to game_lives_path
    else
      @game_life = GameLive.find(params[:live_id])
    end
  end

  def create_cover

    @game_life = GameLive.find_by_id(params[:id])
    if params[:person_cover].present?
      store_path = GameLive.picture_upload(params[:person_cover])
      @game_life.person_cover = store_path
      @game_life.save
      flash[:success] = "#{@game_life.person_name}封面上传成功能"
      redirect_to game_lives_path
    else
      flash[:error] = '图片信息不完整，图片上传失败'
      redirect_to action: 'new_cover', :live_id=> params[:id]
    end

  end

  def new

    @game_life = GameLive.new
  end

  def edit

    @game_life = GameLive.find(params[:id])
  end

  def create

    @game_life = GameLive.new(params[:game_live])
    @game_life.save
  end

  def update_live

    @game_life = GameLive.find(params[:game_live][:id])
    @game_life.update_attributes(params[:game_live])
  end

  def destroy

    @game_life = GameLive.find(params[:id])
    if @game_life.person_cover.present?
      GameLive.delete_picture @game_life.person_cover
    end
    @game_life.destroy
    respond_to do |format|
      format.html { redirect_to game_lives_path }
    end
  end

end
