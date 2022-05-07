require_relative 'papa2'
#require_relative 'priem_module'
require 'colorize'
class RunSharp < Papa2
  def runsharp_main
    begin
      exec('C:/Users/a.zaigraev/source/repos/alexeizaigraev/SharpForPy/bin/Release/SharpForPy.exe')
    rescue
      exec('C:/Users/user/source/repos/SharpForPy/bin/Release/SharpForPy.exe')
    end
  end
end

u = RunSharp.new
u.runsharp_main
puts 'ok'
