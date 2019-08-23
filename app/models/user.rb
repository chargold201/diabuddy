class User < ActiveRecord::Base
    has_many :entries
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, length: {in: 6..20}, unless: ->(u){ u.password.blank? }
end