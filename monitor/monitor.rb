require "fileutils"
require_relative 'papa2'
require_relative 'modules'
require 'colorize'

class Monitor
  include Modules

  # перемещает в rasklad/ файл
  def mower(oldFullName)
    shortName = oldFullName.split('/')[-1]
    newName = 'R:/DRM/Access/Data/rasklad/' + shortName
    begin
      FileUtils.move(oldFullName, newName)
      if newName.include? '.pdf'
        puts " #{newName}".green
      else
        puts " #{newName}".blue
      end
    rescue
      puts " >> Не могу переместить: #{oldFullName}".red
    end
  end

  def mkNames(myDir)
    a = Dir[myDir]
    a.each do |fName|
      mower(fName)
    end
  end

  def show(myDir)
    a = Dir['R:/DRM/Access/Data/rasklad/*.*']
    a.each do |fName|
      puts fName.blue
    end
  end

  def monitorProcess
    dirs = [
      "R:/Obmen/alex_obmen/*.pdf",
      "R:/DRM/ЗАИГРАЕВ ОБМЕН/*.pdf",
      ]
    dirs.each do |myDir|
      mkNames(myDir)
    end
    
    puts "\n\n\trasklad/ :\n".green
    puts "___\n".green
    show('R:/DRM/Access/Data/rasklad/')
    puts "\n___\n\n".green

  end

end

x = Monitor.new()
x.monitorProcess
