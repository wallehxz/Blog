#encoding=utf-8
class GameComment < ActiveRecord::Base

  belongs_to :game_live, :foreign_key=>'game_id'
  attr_accessible :comment, :game_id, :user_id
  validates_uniqueness_of :comment, scope: [:game_id, :user_id]
end
