#encoding=utf-8
require 'rack/auth/digest/md5'

class Embarrass < ActiveRecord::Base

  has_many :embarrass_comments, :foreign_key => 'embarrass_id', :dependent => :destroy

  attr_accessible :chan_count, :picture, :process, :user_id

  def self.word_count(user_id)
    if Embarrass.where(:user_id => user_id).count > 0
      count_word = 0
      Embarrass.where(:user_id => user_id).each do |item|
        count_word += item.process.length
      end
    else
      count_word = 0
    end
    return count_word
  end

  def self.chan_count
    if Embarrass.all.count > 0
      count = 0
      Embarrass.all.each do |item|
        count += item.chan_count
      end
    else
      count = 0
    end
    return count
  end

  def Embarrass.picture_upload(file)

    dir_path = "#{Rails.root}/public/images/embarrass/#{Time.now.strftime('%Y%m')}"
    if !File.exist?(dir_path)
      FileUtils.makedirs(dir_path)
    end
    file_rename = "#{Digest::MD5.hexdigest(Time.now.to_s)}#{File.extname(file.original_filename)}"
    file_path = "#{dir_path}/#{file_rename}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end
    store_path = "/images/embarrass/#{Time.now.strftime('%Y%m')}/#{file_rename}"
    return store_path
  end

  def Embarrass.delete_picture(picture_path)

    file_path = "#{Rails.root}/public/#{picture_path}"
    if File.exist?(file_path)
      File.delete(file_path)
    end
  end

end