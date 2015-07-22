#encoding=utf-8
class TopicCommentsController < ApplicationController

  def create
    @topic_comment = TopicComment.new(params[:topic_comment])
    if @topic_comment.save
      stat = 200
    end
    render :json => {:status=> stat}
  end

  def destroy
    @topic_comment = TopicComment.find(params[:id])
    @topic_comment.destroy

    respond_to do |format|
      format.html { redirect_to topic_comments_url }
      format.json { head :no_content }
    end
  end
end
