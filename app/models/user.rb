class User < ActiveRecord::Base
    has_many :entries
    has_secure_password
    validates_uniqueness_of :email
end