class Friend < ActiveRecord::Base
  def panda_video
    @panda_video ||= Panda::Video.find(video)
  end
end
