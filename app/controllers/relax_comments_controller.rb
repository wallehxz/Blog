#encoding=utf-8
class RelaxCommentsController < ApplicationController

  def create

    @relax_comment = RelaxComment.new(params[:relax_comment])
    if @relax_comment.save
      stat = 200
    end
    render :json => {:status=> stat}
  end

  def destroy

    @relax_comment = RelaxComment.find(params[:id])
    @relax_comment.destroy
    respond_to do |format|
      format.html { redirect_to topic_comments_url }
      format.json { head :no_content }
    end
  end
end
