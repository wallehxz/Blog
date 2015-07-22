#encoding=utf-8
require 'will_paginate'
class RelaxMomentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :update_relax]
  before_filter :authenticate_admin!
  layout 'blade'
  def index

    @relax_moments = RelaxMoment.order('chan_count DESC').order('relax_time desc').paginate(:page=>params[:page], :per_page=>6)
  end

  def show

    @relax_moment = RelaxMoment.find(params[:id])
    @relax_comment = RelaxComment.where(:relax_id => @relax_moment.id)
  end

  def new

    @relax_moment = RelaxMoment.new
  end

  def edit
    @relax_moment = RelaxMoment.find(params[:id])
  end

  def create

    @relax_moment = RelaxMoment.new(params[:relax_moment])
    @relax_moment.save
  end

  def update_relax

    @relax_moment = RelaxMoment.find(params[:relax_moment][:id])
    @relax_moment.update_attributes(params[:relax_moment])
  end

  def destroy
    @relax_moment = RelaxMoment.find(params[:id])
    @relax_moment.destroy

    respond_to do |format|
      format.html { redirect_to relax_moments_path }
    end
  end
end
