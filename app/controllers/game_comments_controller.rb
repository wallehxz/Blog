#encoding=utf-8
class GameCommentsController < ApplicationController

  def create
    @game_comment = GameComment.new(params[:game_comment])
    if @game_comment.save
      stat = 200
    end
    render :json => {:status=> stat}
  end

  def destroy
    @game_comment = GameComment.find(params[:id])
    @game_comment.destroy

    respond_to do |format|
      format.html { redirect_to game_comments_path }
      format.json { head :no_content }
    end
  end
end
