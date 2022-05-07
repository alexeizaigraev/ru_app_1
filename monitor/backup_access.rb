require "fileutils"
require 'colorize'
require_relative 'modules'

include Modules

def data_dir = file_to_vec('Config/ConfigDataPath.txt')[0]
def data_config_dir_list = data_dir + 'ConfigDir/'
def data_config_dir_out = data_dir + 'ConfigDir/'

def mkBack(dir, backDir)
  path = dir + '*.accdb'
  oldNames = Dir[path]
  oldNames.each do |oldName|
    puts oldName.blue
		shortName = oldName.split('/')[-1]
		newName = backDir + shortName
		FileUtils.copy(oldName, newName)
		puts " Скопировано: #{newName}".blue
	end
end

in_dir_list = file_to_vec( data_config_dir_list + 'PathBackUpAccessDirList.txt' )
out_dirs = file_to_vec(data_config_dir_list + 'PathBackUpAccessOut.txt')

out_dirs.each do |out_dir|
  in_dir_list.each do |dir|
    begin
      mkBack(dir, out_dir)  
    rescue => exception
      puts exception.to_s.red
    end
  end
end
