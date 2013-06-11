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
    (@photo ||= Photo.new(entry_id: @entry.id)).attachment = attachment unless attachment.blank?
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

  def poster
    if @video
      original_video ||= @video.panda_video
      h264 = original_video.encodings["h264"]
      h264.screenshots.first
    elsif @photo
      photo_url
    else
      "http://img0099.popscreencdn.com/110387874_amazoncom-happy-birthday-present-girl-laser-die-cut-arts.jpg"
    end
  end

  def video_ogg
    if @video
      original_video ||= @video.panda_video
      @h264e = original_video.encodings["h264"]
      @ogg = original_video.encodings["ogg"]
    end
  end

  # Where the magic happens
  def attributes=(attributes)
    attributes.each { |k, v| self.send("#{k}=", v) }
  end

  def save!
    @entry.message = @message
    @entry.photo = @photo
    @entry.video = @video
    @entry.save!
  end
end