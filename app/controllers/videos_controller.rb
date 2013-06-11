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
    email = params[:video].delete(:email).downcase
    @video = Video.create!(params[:video])
    friend = Friend.where(email: email).first || Friend.create(email: email)
    friend.video_id = @video.id
    friend.save
    redirect_to :action => :show, :id => @video.id 
  end
end