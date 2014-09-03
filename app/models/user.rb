class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable,
    :validatable, :registerable, :confirmable,
    :omniauthable, :omniauth_providers => [:facebook]
  include RoleModel
  roles_attribute :roles_mask
  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :moderator

  def self.from_omniauth(auth)
    # Currently only for Facebook
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # basic information from the public_profile of Facebook Login
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,10]
      user.full_name = auth.info.name
      user.gender = auth.extra.raw_info.gender
      user.skip_confirmation!
      user.save!
    end
  end
end
