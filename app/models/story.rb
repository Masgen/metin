class Story < ActiveRecord::Base
  has_many :visuals, dependent: :destroy
  attr_accessible :content, :event_date, :title, :video, :visuals_attributes, :cover, :video_source, :press_release
  
  default_scope -> {order('stories.event_date DESC')}
  
  validates :content, presence: true
  validates :title, length: {minimum: 3}
  validates_attachment :cover, size: { less_than: 3.megabytes}
  validate :neither_cover_nor_video
  
  def neither_cover_nor_video
    if self["video"].blank? && (cover =~ /\/covers\/original\/missing\.png/)
      errors.add :base, "Cover and Video cannot be blank simultaneously."
    end
  end
  
  has_attached_file :cover, styles: {normal: ["576x462>",:png], facebook: ["250x200>", :gif]}
  has_attached_file :press_release
  
  accepts_nested_attributes_for :visuals, allow_destroy: true, reject_if: lambda { |a| a[:picture].blank? }
  
  searchable do
    text :title, boost: 5
    text :content
    string :event_year
    string :event_month
    string :event_date
  end
  
  def event_month
    event_date.strftime("%B")
  end
  
  def event_year
    event_date.strftime("%Y")
  end
  
  def to_param
    "#{id} #{title}".parameterize
  end
end
