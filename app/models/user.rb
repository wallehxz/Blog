#encoding=utf-8
require 'faraday'
require 'fast-aes'
class User < ActiveRecord::Base

  # validates_uniqueness_of :account, :phone
  # validates_presence_of :nickname, :password

  attr_accessible :account, :avatar, :birthday, :constellation, :educational,
                  :full_name, :hobby, :nickname, :password, :phone, :signature,
                  :verify_code, :verify_time, :login_times, :login_ip, :qq, :yy, :weibo,
                  :weixin, :email, :company, :office, :inauguration_time, :colleges,
                  :discipline, :school_time, :integration, :project_name1,:project_url1,
                  :project_name2,:project_url2, :project_name3,:project_url3,
                  :project_name4,:project_url4

  has_many :embarrass_comments, :foreign_key => 'user_id', :dependent => :destroy
  has_many :game_comments, :foreign_key => 'user_id', :dependent => :destroy
  has_many :relax_comments, :foreign_key => 'user_id', :dependent => :destroy
  has_many :topic_comments, :foreign_key => 'user_id', :dependent => :destroy
  has_many :topics, :foreign_key => 'user_id', :dependent => :destroy
  has_many :embarrasses, :foreign_key => 'user_id' , :dependent => :destroy
  has_many :notes, :foreign_key => 'user_id' , :dependent => :destroy

  CONSTELLATION ={
      1 => '摩羯座',
      2 => '水瓶座',
      3 => '双鱼座',
      4 => '牡羊座',
      5 => '金牛座',
      6 => '双子座',
      7 => '巨蟹座',
      8 => '狮子座',
      9 => '处女座',
      10 => '天秤座',
      11 => '天蝎座',
      12 => '射手座'
  }

  def self.constellation_picture(date) #根据日期返回星座图片
    if date <= 119 || date >= 1221
      return 1
    elsif date >=120 && date <= 218
      return 2
    elsif date >=219 && date <= 320
      return 3
    elsif date >=321 && date <= 420
      return 4
    elsif date >=421 && date <= 520
      return 5
    elsif date >=521 && date <= 621
      return 6
    elsif date >=622 && date <= 722
      return 7
    elsif date >=723 && date <= 822
      return 8
    elsif date >=823 && date <= 921
      return 9
    elsif date >=922 && date <= 1022
      return 10
    elsif date >=1023 && date <= 1121
      return 11
    elsif date >=1122 && date <= 1220
      return 12
    end
  end

  def self.send_msg(mobile,text) #给手机用户发送信息
    Meteor::Application::SMS_DRIVER.sendSms(:mobile=>mobile,:text=>text,:username=>'cjzs',:password=>'201004191541')
  end

  def self.six_number  #随机生成六位数字
    return [*0..9].sample(6).join
  end

  def self.avatar_upload(file)

    dir_path = "#{Rails.root}/public/images/avatar"
    if !File.exist?(dir_path)
      FileUtils.makedirs(dir_path)
    end
    file_rename = "#{Digest::MD5.hexdigest(Time.now.to_s)}#{File.extname(file.original_filename)}"
    file_path = "#{dir_path}/#{file_rename}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end
    store_path = "/images/avatar/#{file_rename}"
    return store_path
  end

  def self.delete_picture(picture_path)

    file_path = "#{Rails.root}/public/#{picture_path}"
    if File.exist?(file_path)
      File.delete(file_path)
    end
  end

  def self.login_count
    if User.all.count > 0
      count = 0
      User.all.each do |item|
        count += item.login_times
      end
    else
      count = 0
    end
    return count
  end

  def self.aes_encrypt(string)  #对称加密

    key = '42#3b%c$dxyT,7a5=+5fUI3fa7352&^:'
    aes = FastAES.new(key)
    return aes.encrypt(string)
  end

  def self.aes_decrypt(string) #对称解密

    key = '42#3b%c$dxyT,7a5=+5fUI3fa7352&^:'
    aes = FastAES.new(key)
    return aes.decrypt(string)
  end

  def self.ip_to_city(ip)
    if ip != '127.0.0.1'
      # conn = Faraday.new(:url => 'http://ip.taobao.com') do |faraday|
      #   faraday.request  :url_encoded             # form-encode POST params
      #   faraday.response :logger                  # log requests to STDOUT
      #   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      # end
      # response = conn.get 'service/getIpInfo.php', {:ip => ip}
      response = Faraday.get "http://ip.taobao.com/service/getIpInfo.php?ip=#{ip}"
      return JSON.parse(response.body)['data']['region'] + "游客"
    else
      return '开发人员'
    end
  end

end
