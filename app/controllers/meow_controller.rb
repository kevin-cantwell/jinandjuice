class MeowController < ApplicationController
  def index
    @meowsers = EntryForm::SAMPLE_GIFS.uniq
    @meowsers += [
      "http://1-ps.googleusercontent.com/h/www.catgifpage.com/gifs/184.gif.pagespeed.ce.IMf9conBRY.gif",
      "http://1-ps.googleusercontent.com/h/www.catgifpage.com/gifs/185.gif.pagespeed.ce.yvDfYyj82d.gif",
      "http://1-ps.googleusercontent.com/h/www.catgifpage.com/gifs/183.gif.pagespeed.ce.wMj9LVJr1q.gif",
      "http://1-ps.googleusercontent.com/h/www.catgifpage.com/gifs/182.gif.pagespeed.ce.S3pBqCa_-u.gif",
      "http://1-ps.googleusercontent.com/h/www.catgifpage.com/gifs/178.gif.pagespeed.ce.cQ9KdTJ9uZ.gif",
      "https://lh5.googleusercontent.com/-Yewx1iYeRJM/UXO4hVWwSwI/AAAAAAAAG1o/tZsKzfU7wEQ/s500/168.gif",
      "https://lh4.googleusercontent.com/-_AJ_FcGXwC4/UXO4gLCsExI/AAAAAAAAG1Q/eFw4P0Sj7h4/s400/164.gif"
    ]
    @meowsers = @meowsers.shuffle
  end
end
