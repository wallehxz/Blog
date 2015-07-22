#encoding=utf-8
class RelaxMoment < ActiveRecord::Base

  has_many :relax_comments, :foreign_key => 'relax_id', :dependent => :destroy
  attr_accessible :chan_count, :relax_audio, :relax_content, :relax_time, :relax_title

  def self.chan_comment
    if RelaxMoment.all.count > 0
      count = 0
      RelaxMoment.all.each do |item|
        count += RelaxComment.where(:relax_id => item.id).count
      end
    else
      count = 0
    end
    return count
  end
end
