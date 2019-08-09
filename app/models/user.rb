class User < ActiveRecord::Base
    has_many :entries
    has_secure_password
end