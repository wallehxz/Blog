#encoding=utf-8
class RelaxComment < ActiveRecord::Base

  belongs_to :relax_moment, :foreign_key=>'relax_id'
  attr_accessible :comment, :relax_id, :user_id
  validates_uniqueness_of :comment, scope: [:relax_id, :user_id]
end
