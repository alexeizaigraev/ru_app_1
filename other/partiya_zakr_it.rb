
require "fileutils"
require_relative'modules_zakr.rb'

include Modules_zakr



out_dir = 'R:/DRM/Access/ЗАКРЫТИЕ ИНТАЙМ ОКОНЧАТЕЛЬНОЕ/КАБИНЕТ/ПАРТИЯ_ЗАКРЫТИЕ_СЕГОДНЯ/'
a = Dir["R:/DRM/Access/ЗАКРЫТИЕ ИНТАЙМ ОКОНЧАТЕЛЬНОЕ/КАБИНЕТ/ОТМЕНА/*.xml"]

spr = file_to_vec('R:/DRM/Access/ЗАКРЫТИЕ ИНТАЙМ ОКОНЧАТЕЛЬНОЕ/КАБИНЕТ/ПАРТИЯ_ЗАКРЫТИЕ_СЕГОДНЯ/otbor.csv')

a.each do |aa|
	dep = aa.split('/')[-1].split('_')[0][0..-2]
	name = aa.split('/')[-1]
	
	if spr.include? dep
		puts dep 
		out_path = out_dir + name
		puts out_path
		FileUtils.copy(aa, out_path)
	end
end

puts "--------------------------------------"

out_dir = 'R:/DRM/Access/ЗАКРЫТИЕ ИНТАЙМ ОКОНЧАТЕЛЬНОЕ/КАБИНЕТ/ПАРТИЯ_ЗАКРЫТИЕ_СЕГОДНЯ/'
a = Dir["R:/DRM/Access/ЗАКРЫТИЕ ИНТАЙМ ОКОНЧАТЕЛЬНОЕ/СКАНЫ НОМЕРА ИНТАЙМ/*.pdf"]

a.each do |aa|
	dep = aa.split('/')[-1].split('_')[0]
	name = aa.split('/')[-1]
	
	if spr.include? dep
		puts dep 
		out_path = out_dir + name
		puts out_path
		FileUtils.copy(aa, out_path)
	end
end
