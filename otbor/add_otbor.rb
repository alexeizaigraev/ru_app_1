require 'colorize'

require_relative 'papa2'
require_relative 'modules'

class Otbor < Papa2
    include Modules

    def otborProcess
      out = "term;dep\n"  
      print "\n Dep: From To\n\n\t -> ".cyan
      choise = gets.chomp
      puts

      if choise.include? ' '
        start, finish = choise.split(' ')
        start, finish = start.to_i, finish.to_i
      else
        start = choise.to_i
        finish = start
      end
  
      start.upto(finish) do |x|
        dep, term = x.to_s, ( x*10+1 ).to_s
        out += "#{term};#{dep}\n"
      end

      puts out.green
      text_to_file(out, data_in_dir + 'otbor.csv')
      
    end
    
end

x = Otbor.new
x.otborProcess
system('ruby', 'add_vsyo_zapros.rb')
