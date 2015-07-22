#encoding=utf-8
class GameLive < ActiveRecord::Base

  has_many :game_comments, :foreign_key => 'game_id', :dependent => :destroy
  attr_accessible :live_interval, :live_title, :live_type, :live_url,
                  :person_name, :person_resume, :person_cover, :attention

  def self.picture_upload(file)

    dir_path = "#{Rails.root}/public/images/game_lives"
    if !File.exist?(dir_path)
      FileUtils.makedirs(dir_path)
    end
    file_rename = "#{Digest::MD5.hexdigest(Time.now.to_s)}#{File.extname(file.original_filename)}"
    file_path = "#{dir_path}/#{file_rename}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end
    store_path = "/images/game_lives/#{file_rename}"
    return store_path
  end

  def self.delete_picture(picture_path)
    file_path = "#{Rails.root}/public/#{picture_path}"
    if File.exist?(file_path)
      File.delete(file_path)
    end
  end
end
