class PandaController < ApplicationController
  def notifications
    if params['event'] == 'video-encoded'
        video = Video.find_by_panda_video_id(video_id)
        if video
            UpdateVideoState.perform_async(video.id)
        else
            # might have been deleted
        end
    end
  end
end

class UpdateVideoState
  include Sidekiq::Worker

  def perform(id)
    video = Video.find(id)
    if video.panda_video.status == 'fail'
        # video failed to be uploaded to your bucket
    else
        h264e = video.panda_video.encodings['h264']
        if h264e.status == 'success'
            # save h264e.url in your models to avoid querying panda each time
        else # handle a failed job
            # h264e.error_class; h264e.error_message
            # a log file has been dumped in your bucket
        end
    end
  end
end