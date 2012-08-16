require "digest/sha1"
class Admin < ActiveRecord::Base
  before_save :create_hashed_password
  after_save :clear_password
  attr_accessor :password
  
  attr_accessible :password, :nickname
  
  validates :nickname, :presence => true, uniqueness: true
  validates :password, :presence => true, length: {minimum: 6}
  
  def self.hash_with_password(password="",salt="")
    Digest::SHA1.hexdigest("doraismyman123123#{password}isnthebaro?#{salt}")
  end
  
  def self.make_salt
    Digest::SHA1.hexdigest("BABACKOLAR!BABACKOLAR!#{Time.now}CUMAYAGITTIM")
  end
  
  def self.authenticate(nickname="",password="")
    admin = Admin.find_by_nickname(nickname)
    if admin && admin.password_match?(password)
      return admin
    else
      return false
    end
  end
  
  def password_match?(password)
    self.hashed_password == Admin.hash_with_password(password,salt)
  end
  
  protected
  
  def create_hashed_password
    self.salt = Admin.make_salt if salt.blank?
    self.hashed_password = Admin.hash_with_password(password,salt)
  end
  
  def clear_password
    self.password = ""
  end
end
