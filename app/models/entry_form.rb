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
    @video.present?
  end

  def video_url
    ""
  end

  def video_url=(url)
    if url.present?
      video = Panda::Video.create(:source_url => url)
      self.panda_video_id = video.id
    end
  end

  def panda_video_id
    @video.andand.panda_video_id
  end

  def panda_video_id=(panda_video_id)
    (@video ||= Video.new(entry_id: @entry.id)).panda_video_id = panda_video_id unless panda_video_id.blank?
  end

  def video_poster
    if @video
      video_h264e.screenshots.first
    elsif @photo
      photo_url
    else
      "http://img0099.popscreencdn.com/110387874_amazoncom-happy-birthday-present-girl-laser-die-cut-arts.jpg"
    end
  end

  def video_ready?
    video_h264e.status == "success" && video_ogg.status == "success"
  end

  def video_percent_complete
    ((video_h264e.encoding_progress.to_i / 2) + (video_ogg.encoding_progress.to_i / 2)).to_i
  end

  def video_h264e
    panda_video.encodings["h264"]
  end

  def video_ogg
    panda_video.encodings["ogg"]
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