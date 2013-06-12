class Video < ActiveRecord::Base
  belongs_to :entry

  attr_accessible :attachment

  has_attached_file :attachment
  # ,
  #               :url => "#{Rails.root}/app/assets/images/:basename.:extension",
  #               :path => "#{Rails.root}/app/assets/images/products/:id/:style/:basename.:extension"
end