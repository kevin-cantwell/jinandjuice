class EntryForm < FormModel
  attr_reader :entry

  delegate :email, :email=, :name, :name=,
           :persisted?, :id, to: :entry,
           :prefix => false, :allow_nil => false

  def initialize(entry)
    @entry = entry
    @photo = entry.photo
    @message = entry.message
    @video = entry.video
  end

  def photo_url
    @photo.andand.url || @photo.andand.attachment.andand.url
  end

  def photo_url=(url)
    (@photo ||= Photo.new(entry_id: @entry.id)).url = url
  end

  def photo_attachment
    @photo.andand.attachment
  end

  def photo_attachment=(attachment)
    (@message ||= Photo.new(entry_id: @entry.id)).attachment = attachment unless attachment.blank?
  end

  def message
    @message.andand.message
  end

  def message=(message)
    (@message ||= Message.new(entry_id: @entry.id)).message = message
  end

  def panda_video_id
    @video.andand.panda_video_id
  end

  def panda_video_id=(panda_video_id)
    (@video ||= Video.new(entry_id: @entry.id)).panda_video_id = panda_video_id unless panda_video_id.blank?
  end

  # Where the magic happens
  def attributes=(attributes)
    attributes.each { |k, v| self.send("#{k}=", v) }
  end

  def save!
    Entry.transaction do
      @entry.message_id = @message.id if @message
      @entry.photo_id = @photo.id if @photo
      @entry.video_id = @video.id if @video
      @entry.save!
      @photo.andand.save!
      @message.andand.save!
      @video.andand.save!
    end
  end
end