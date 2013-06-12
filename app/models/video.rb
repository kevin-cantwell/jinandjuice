class Video < ActiveRecord::Base
  belongs_to :entry

  attr_accessible :attachment

  has_attached_file :attachment
end