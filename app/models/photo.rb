class Photo < ActiveRecord::Base
  belongs_to :entry

  has_attached_file :attachment, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
end
