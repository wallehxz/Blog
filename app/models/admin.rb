#encoding=utf-8
class Admin < ActiveRecord::Base
  validates_uniqueness_of :account

  AVATAR = ['/img/lol/CS.png','/img/lol/HL.png','/img/lol/HN.png','/img/lol/HZ.png',
         '/img/lol/JJ.png','/img/lol/MS.png','/img/lol/RW.png','/img/lol/STR.png',
         '/img/lol/TM.png','/img/lol/XXG.png','/img/lol/YR.png','/img/lol/ZX.png',
         "/img/lol/YR.png"]
         #随机从数组里去一个 Admin::AVATAR[rand(13)]

end
