class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264e = @original_video.encodings["h264"]
    @ogg = @original_video.encodings["ogg"]
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create!(params[:video])
    redirect_to :action => :show, :id => @video.id 
  end
end