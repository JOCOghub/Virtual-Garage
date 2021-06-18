class User < ActiveRecord::Base
    belongs_to :admin
    validates_uniqueness_of :name
    has_secure_password
end