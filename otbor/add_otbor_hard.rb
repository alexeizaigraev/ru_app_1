require 'colorize'

require_relative 'papa2'
require_relative 'modules'

class OtborHard < Papa2
    include Modules

    def otborProcess
      out = "term;dep\n"  
      print "\n Dep: From To\n\n\t -> ".cyan
      choise = gets.chomp
      puts

      if choise.include? ' '
        deps = choise.split(' ')
        
      else
        deps = [choise]
      end
  
      deps.each do |dep|
        term = dep + '1'
        out += "#{term};#{dep}\n"
      end

      puts out.green
      text_to_file(out, data_in_dir + 'otbor.csv')

    end
    
end

x = OtborHard.new
x.otborProcess
system('ruby', 'add_vsyo_zapros.rb')
