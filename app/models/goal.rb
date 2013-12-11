class Goal < ActiveRecord::Base
  validates :calories, numericality: true
end
