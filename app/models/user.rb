# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :microposts, :dependent => :destroy
  #automatically create the virtual password_confirmation attribute
  validates :password, :presence => true,
                       :confirmation => true,
		       :length => { :within => 6..10}

  #create encrypted password before saving the user record
  before_save :encrypt_password

  #return true if the user's password is correct
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  #the class method for user authentication
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  #validate usernames
  validates :name, :presence => true, 
  		   :length => {:maximum => 50,
		   	       :minimum => 5 }

  #validate emails
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	   
  validates :email, :presence => true,
  		    :format => {:with => email_regex},
		    :uniqueness => {:case_sensitive => false}

  #private methods
  private
 
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end
