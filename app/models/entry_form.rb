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

  def photo?
    !photo_url.blank?
  end

  def photo_url
    if @photo.andand.url.blank?
      @photo.andand.attachment.andand.url
    else
      @photo.andand.url
    end
  end

  def photo_url=(url)
    (@photo ||= Photo.new(entry_id: @entry.id)).url = url unless url.blank?
  end

  def photo_attachment
    @photo.andand.attachment
  end

  def photo_attachment=(attachment)
    (@photo ||= Photo.new(entry_id: @entry.id)).attachment = attachment unless attachment.blank?
  end

  def message?
    !message.blank?
  end

  def message
    @message.andand.message
  end

  def message=(message)
    (@message ||= Message.new(entry_id: @entry.id)).message = message
  end

  def video?
    return true if @entry.id == 1
    @video.present?
  end

  def video_url
    if @video.andand.url.blank?
      @video.andand.attachment.andand.url
    else
      @video.andand.url
    end
  end

  def video_url=(url)
    (@video ||= Video.new(entry_id: @entry.id)).url = url unless url.blank?
  end

  def video_attachment
    @video.andand.attachment
  end

  def video_attachment=(attachment)
    (@Video ||= Video.new(entry_id: @entry.id)).attachment = attachment unless attachment.blank?
  end

  def video_poster
    return "https://s3.amazonaws.com/jinandjuice/jasonfeng.jpg" if @entry.id == 1
    if video?
      "https://s3.amazonaws.com/jinandjuice/jasonfeng.jpg"
    elsif photo?
      photo_url
    else
      "http://media.tumblr.com/tumblr_mb68nnWV8P1rnxf9c.gif"
    end
  end

  def video_ready?
    return true if @entry.id == 1
    video?
  end

  def video_percent_complete
    0
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

  private

  def panda_video
    @panda_video ||= @video.andand.panda_video
  end
end