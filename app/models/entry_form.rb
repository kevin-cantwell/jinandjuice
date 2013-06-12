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

  def message?
    !message.blank?
  end

  def message
    @message.andand.message
  end

  def message=(message)
    (@message ||= Message.new(entry_id: @entry.id)).message = message
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

  def video?
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
    (@video ||= Video.new(entry_id: @entry.id)).attachment = attachment unless attachment.blank?
  end

  def poster
    if photo?
      photo_url
    else
     ["http://media.tumblr.com/1a89348535faebbe182109ef87fcdbd0/tumblr_inline_mo8hclHwU71qz4rgp.gif",
      "http://media.tumblr.com/tumblr_mb68nnWV8P1rnxf9c.gif",
      "http://media.tumblr.com/1226824fa92f9c53d3c102d631d5bceb/tumblr_inline_mnpxzlhVHZ1qz4rgp.gif",
      "http://media.tumblr.com/2d63d8eebaa86c521b423318f2e9fe15/tumblr_inline_mns3oclGMC1qz4rgp.gif",
      "http://25.media.tumblr.com/dbc2db23f7791ef211daa36639bf3868/tumblr_mnpxd0BGB71sqfkdpo1_500.gif"].sample
    end
  end

  def video_ready?
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