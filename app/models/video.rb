class Video < ActiveRecord::Base
  belongs_to :entry

  attr_accessible :attachment

  has_attached_file :attachment, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
end