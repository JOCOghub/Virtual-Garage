class User < ActiveRecord::Base
    belongs_to :admin
    validates_uniqueness_of :name
end