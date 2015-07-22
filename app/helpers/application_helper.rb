#encoding=utf-8
require 'fast-aes'
module ApplicationHelper

  def aes_encrypt(string)

    key = 'UITN25LMUQC436IM'
    aes = FastAES.new(key)
    return aes.encrypt(string)
  end


  def aes_decrypt(string)

    key = 'UITN25LMUQC436IM'
    aes = FastAES.new(key)
    aes.decrypt(string)
  end

end
