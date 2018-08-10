class User < ApplicationRecord
    before_save { email.downcase! }
    #VALID_NAME_REGEX = /\A[a-z]+\z/
    validates :name, presence: true, length: { maximum: 50 }#, format: { with: VALID_NAME_REGEX }
begin
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
                      format: { with: VALID_EMAIL_REGEX }, 
                      uniqueness: { case_sensitive: false }
end
    has_secure_password

    validates :password, presence: true, length: { minimum: 6 }
end
