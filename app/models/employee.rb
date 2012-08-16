class Employee < ActiveRecord::Base
  attr_accessible :photograph, :name, :job_title
  has_attached_file :photograph, styles: {normal: ["170x170#",:png]}
  
  default_scope order("employees.position ASC")
  
  validates_attachment :photograph, presence: true,size: {less_than: 3.megabytes}
  validates :name, presence: true
  validates :job_title, presence: true
  
  acts_as_list
end
