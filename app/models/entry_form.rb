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

  SAMPLE_GIFS = [
    "http://media.tumblr.com/tumblr_mb68nnWV8P1rnxf9c.gif", # Grumpy cat
    "http://media.tumblr.com/862d32a9d39af33a6f044c348e0af0b3/tumblr_inline_mmx12uV2N91qz4rgp.gif", # Yellow guys
    "http://media.tumblr.com/691e21f0ea8bfdaef1dc02aba8d0aced/tumblr_inline_mkmomxJDtV1qz4rgp.gif", # Fresh prince
    "http://media0.giphy.com/media/achoDiZFxZvdm/original.gif", # Cats
    "http://images.wikia.com/glee/images/6/6c/Birthday.gif" # Princess
  ]

  def poster
    if photo?
      photo_url
    else
      SAMPLE_GIFS[@entry.id % SAMPLE_GIFS.length]
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