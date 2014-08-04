class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :omniauthable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable, :confirmable
  
  include RoleModel
  roles_attribute :roles_mask
  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :moderator
end
