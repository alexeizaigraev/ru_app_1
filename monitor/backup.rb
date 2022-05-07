require "fileutils"
require 'colorize'


def mkBack(oldNames, backDir)
	now = Time.new
	
	if now.month.to_s.size < 2
		myMonth = '0' + now.month.to_s
	else
		myMonth = now.month.to_s
	end

	if now.day.to_s.size < 2
		myDay = '0' + now.day.to_s
	else
		myDay = now.day.to_s
	end

	data = now.year.to_s + '-' + myMonth + '-' + myDay
	
	oldNames.each do |oldName|
		shortName = oldName.split('/')[-1]
		newName = backDir + data + '_' + shortName

		FileUtils.copy(oldName, newName)

		puts newName.green
	end
end

#puts "#{now.year} #{now.month} #{now.day}"

access = [
	"R:/Obmen/ЖУРНАЛЫ_РЕГИСТРАЦИИ/ЖУРНАЛЫ_РЕГИСТРАЦИИ.accdb",
	"R:/Obmen/ЖУРНАЛЫ_РЕГИСТРАЦИИ/ЖУРНАЛЫ_РЕГИСТРАЦИИ_be.accdb",

	"R:/DRM/Access/db2_be.accdb",
	"R:/DRM/Access/db2.accdb",
	]

	appRuby = Dir["C:/Users/a.zaigraev/Desktop/AVARU/*.*"]
	appSharp = Dir["C:/Users/a.zaigraev/Desktop/CSHARP/MainConsoleApp2/*.*"]
	appD = Dir["//eps.ua/ho/Users/a.zaigraev/Desktop/БЛАГОДАТЬ/СКЛАД/D_PROG/appone/*.*"]

	
	backDir = "G:/Мой диск/БЕКАПЫ/access/"
	mkBack(access, backDir)

	backDir = "R:/DRM/BackupAccess/"
	mkBack(access, backDir)

	

	backDir = "G:/Мой диск/БЕКАПЫ/ruby/"
	mkBack(appRuby, backDir)

	#backDir = "G:/Мой диск/БЕКАПЫ/csharp/"
	#mkBack(appSharp, backDir)

	#backDir = "G:/Мой диск/БЕКАПЫ/dd/"
	#mkBack(appD, backDir)

