class EntriesController < ApplicationController

  def index
    @entry_forms = Entry.all.map do |entry|
      EntryForm.new(entry)
    end
  end

  def show
    entry = Entry.find(params[:id])
    @entry_form = EntryForm.new(entry)
  end

  def new
    @entry_form = EntryForm.new(Entry.new)
  end

  def edit
    entry = Entry.find(params[:id])
    @video = entry.video
    if @video
      original_video = @video.panda_video
      @h264e = original_video.encodings["h264"]
      @ogg = original_video.encodings["ogg"]
    end
    @entry_form = EntryForm.new(entry)
  end

  def update
    entry = Entry.find(params[:id])
    entry_form = EntryForm.new(entry)
    entry_form.email = params[:entry_form][:email]
    entry_form.name = params[:entry_form][:name]
    entry_form.photo_url = params[:entry_form][:photo_url]
    entry_form.photo_attachment = params[:entry_form][:photo_attachment]
    entry_form.message = params[:entry_form][:message]
    entry_form.video_title = params[:entry_form][:video_title]
    entry_form.panda_video_id = params[:entry_form][:panda_video_id]
    entry_form.save!
    redirect_to :action => :edit, :id => entry.id
  end

  def create
    entry_form = EntryForm.new(Entry.new)
    entry_form.email = params[:entry_form][:email]
    entry_form.name = params[:entry_form][:name]
    entry_form.photo_url = params[:entry_form][:photo_url]
    entry_form.photo_attachment = params[:entry_form][:photo_attachment]
    entry_form.message = params[:entry_form][:message]
    entry_form.video_title = params[:entry_form][:video_title]
    entry_form.panda_video_id = params[:entry_form][:panda_video_id]
    entry_form.save!
    redirect_to :action => :edit, :id => entry_form.id
  end
end
