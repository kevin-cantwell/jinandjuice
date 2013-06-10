class HomeController < ApplicationController
  def show
    @friend = Friend.new
    @friends = Friend.all

    if params[:id].present?
      new_friend = Friend.find(params[:id])
      @original_video = new_friend.panda_video
      @h264e = @original_video.encodings["h264"]
    end
  end

  def create
    @friend = Friend.create!(params[:friend])
    redirect_to :action => :show, :id => @friend.id
  end
end
