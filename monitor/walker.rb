require "fileutils"
require_relative'modules.rb'
require 'colorize'

include Modules

def data_dir = file_to_vec('Config/ConfigDataPath.txt')[0]
def data_config_dir = data_dir + 'Config/'

def defAgent(ag_sign)
  a = file_to_arr( data_config_dir + 'comon_data.csv' )
  a.each do |vec|
     if vec[ 0 ].include? ag_sign
      return vec[3]
    end
  end
  sos('Незнакомый агент', ag_sign)
end

pathInDir = file_to_vec(data_config_dir + 'ConfigRaskladPath.txt')[0]

pathOutDir = file_to_vec(data_config_dir + 'ConfigGdrivePath.txt')[0]

files = Dir[ file_to_vec(data_config_dir + 'ConfigRaskladPath.txt')[0] + '*.pdf']
files.each do |fullOldFName|
  shortFname = fullOldFName.split('/')[-1]
  ag_sign = fullOldFName.split('/')[-1][0..2]
  folder = fullOldFName.split('/')[-1][0..6]
  newPath = pathOutDir + defAgent(ag_sign) + '/' + folder
  
  begin
    unless Dir.exist?(newPath)
      Dir.mkdir(newPath)
      puts " mkDir #{newPath}".green
    end
  rescue
    puts "err mkDir".red
  end

  begin
    if shortFname.include? '_RP_'
      backup_fname = 'R:/DRM/ЗАИГРАЕВ ОБМЕН АРХИВ/Архив/' + shortFname
	    FileUtils.copy(fullOldFName, backup_fname)
      puts "arhiv #{backup_fname}".blue
    end
  rescue
    uuu = nil
  end
      
  begin
	  fullNewName = newPath + '/' + shortFname
    FileUtils.move(fullOldFName, fullNewName)
    puts " #{fullNewName}".cyan
  rescue => err
    puts " #{err}".red
  end
end

files = Dir[pathInDir + '*.*']
puts "\n\n\tleft #{pathInDir} :\n".green
puts "___".green

files.each do |file|
  puts file.red
end
puts "___\n\n".green
puts "\n\tSuccess\n\n".yellow
