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
    entry_form.video_url = params[:entry_form][:video_url]
    entry_form.video_attachment = params[:entry_form][:video_attachment]
    entry_form.save!
    redirect_to :action => :show, :id => entry.id
  end

  def create
    entry_form = EntryForm.new(Entry.new)
    entry_form.email = params[:entry_form][:email]
    entry_form.name = params[:entry_form][:name]
    entry_form.photo_url = params[:entry_form][:photo_url]
    entry_form.photo_attachment = params[:entry_form][:photo_attachment]
    entry_form.message = params[:entry_form][:message]
    entry_form.video_url = params[:entry_form][:video_url]
    entry_form.video_attachment = params[:entry_form][:video_attachment]
    entry_form.save!
    redirect_to :action => :show, :id => entry_form.id
  end
end
