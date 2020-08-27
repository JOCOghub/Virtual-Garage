class Tool < ActiveRecord::Base
    belongs_to :user
    validates :name, presence: true
    validates_presence_of :quantity
end