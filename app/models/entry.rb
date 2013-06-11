class Entry < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :name

  has_one :video
  has_one :photo
  has_one :message
end
