#encoding=utf-8
class Topic < ActiveRecord::Base

  attr_accessible :topic_content, :topic_tag, :topic_title, :topic_type, :user_id

  has_many :topic_comments, :foreign_key=>'topic_id',:dependent=> :destroy

  def self.word_count(user_id)
    if Topic.where(:user_id => user_id).count > 0
      count_word = 0
      Topic.where(:user_id => user_id).each do |item|
        count_word += item.topic_content.length
      end
    else
      count_word = 0
    end
    return count_word
  end

  def self.word_total
    if Topic.all.count > 0
      count_word = 0
      Topic.all.each do |item|
        count_word += item.topic_content.length
      end
    else
      count_word = 0
    end
    return count_word
  end

end
