#encoding=utf-8
class EmbarrassComment < ActiveRecord::Base

  belongs_to :embarrass, :foreign_key => 'embarrass_id'

  attr_accessible :comment, :embarrass_id, :user_id

  validates_uniqueness_of :comment, scope: [:embarrass_id, :user_id]
end
