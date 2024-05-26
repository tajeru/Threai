class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :destroy
    has_many :replies, dependent: :destroy

   

    
    
    validates :name, presence: true,uniqueness: true

end
