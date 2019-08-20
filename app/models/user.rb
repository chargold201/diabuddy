class User < ActiveRecord::Base
    has_many :entries
    has_secure_password
    validates :email, presence: true, uniqueness: true
end