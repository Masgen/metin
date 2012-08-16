class Visual < ActiveRecord::Base
  attr_accessible :story_id, :picture
  belongs_to :story
  has_attached_file :picture, styles: {normal: ["1024x768>",:png], thumbnail: ["170x170>",:png]}
  
  validates_attachment :picture, size: { less_than: 3.megabytes}
end
