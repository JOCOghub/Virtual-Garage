class User < ActiveRecord::Base
    belongs_to :admin
    has_secure_password
    validates_uniqueness_of :username
end