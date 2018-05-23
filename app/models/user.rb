

class User < ApplicationRecord
  #may 20 2018
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  #ke ahun wedya zim bilo account mekfet yelem..be email actvation nw
  before_create :create_activation_digest
  
  #attr_accessor :remember_token
  #added may 18 2018
  #before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },
  uniqueness:  { case_sensitive: false } 

  has_secure_password
  #validates :password, presence: true, length: { minimum: 6 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


  #ted may 23 2018
 #Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
#ted may 23 2018

#ted may 23 2018  replaced by above
 # def authenticated?(remember_token)
      #may 19 2018 nypl chrome and firefox bug
     # return false if remember_digest.nil?

    #BCrypt::Password.new(remember_digest).is_password?(remember_token)
 # end

   # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  

 #ted may 23 2018 
  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
    ##may 23 2018
    #update_attribute(:activated,    true)
   # update_attribute(:activated_at, Time.zone.now)
  end
#ted may 23 2018
  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end









#private added may 20 2018---
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  




 
end
