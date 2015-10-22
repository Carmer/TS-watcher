class Payload < ActiveRecord::Base
  belongs_to :source

  validates :sha, uniqueness: true
  validates :url, presence: true
end
