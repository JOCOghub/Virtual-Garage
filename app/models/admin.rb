class Admin < ActiveRecord::Base
    has_many :users
    has_secure_password
    validates_uniqueness_of :username
end