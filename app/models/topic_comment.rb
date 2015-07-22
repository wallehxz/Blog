#encoding=utf-8
class TopicComment < ActiveRecord::Base
  belongs_to :topic, :foreign_key=>'topic_id'

  attr_accessible :comment, :topic_id, :user_id

  validates_uniqueness_of :comment, scope: [:topic_id, :user_id]
end
