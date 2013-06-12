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
    "http://24.media.tumblr.com/tumblr_lvqom1E96A1qaeawvo1_500.png", # Tiny hat cat
    "http://25.media.tumblr.com/tumblr_ljrr75Aiiy1qj4o5ko1_500.jpg", # Sad ear cat
    "http://i735.photobucket.com/albums/ww352/miminachos/well%20then/birthday_cat.gif", # Birthdaycats
    "http://media0.giphy.com/media/achoDiZFxZvdm/original.gif", # Cats
    "http://media0.giphy.com/media/achoDiZFxZvdm/original.gif", # Cats
    "http://media0.giphy.com/media/achoDiZFxZvdm/original.gif", # Cats
    "http://media0.giphy.com/media/achoDiZFxZvdm/original.gif" # Cats
  ]

  def poster
    if photo?
      photo_url
    else
      SAMPLE_GIFS.sample
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