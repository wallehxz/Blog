#encoding=utf-8
class Note < ActiveRecord::Base

  belongs_to :user, :foreign_key => 'user_id'

  attr_accessible :note_content, :note_date, :note_tag, :note_title, :note_weather, :user_id

  def self.word_count(user_id)
    if Note.where(:user_id => user_id).count > 0
      count_word = 0
      Note.where(:user_id => user_id).each do |item|
        count_word += item.note_content.length
      end
    else
      count_word = 0
    end
    return count_word
  end
end
