class Friend < ActiveRecord::Base
  validates_presence_of :email

  has_one :video
end
