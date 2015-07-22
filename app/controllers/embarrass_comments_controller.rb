#encoding=utf-8
class EmbarrassCommentsController < ApplicationController

  def create
    @embarrass_comment = EmbarrassComment.new(params[:embarrass_comment])
    if @embarrass_comment.save
      stat = 200
    end
    render :json => {:status=> stat}
  end

  def destroy
    @embarrass_comment = EmbarrassComment.find(params[:id])
    @embarrass_comment.destroy

    respond_to do |format|
      format.html { redirect_to embarrass_comments_url }
      format.json { head :no_content }
    end
  end

end
