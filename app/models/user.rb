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
  attr_accessible :name, :email

  #validate usernames
  validates :name, :presence => true, 
  		   :length => {:maximum => 50,
		   	       :minimum => 5 }

  #validate emails
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	   
  validates :email, :presence => true,
  		    :format => {:with => email_regex},
		    :uniqueness => {:case_sensitive => false}

end
