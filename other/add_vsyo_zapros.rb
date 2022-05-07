require 'colorize'

require_relative 'papa2'
require_relative 'modules'

class AddVsyo < Papa2
    include Modules

    def AddVsyoProcess
      otbor = file_to_arr(data_in_dir + 'otbor.csv')
      otbor = otbor[1...otbor.size]
      otbor_objects = []
      for line in otbor
        otbor_objects.append(line[0])
      end
    
      otbor = otbor_objects
    
      vsyo = file_to_arr(data_in_dir + 'vsyo_zapros.csv')
      head = vsyo[0].join(';') + "\n"
      text = head
    
      for vsyo_line in vsyo
        if otbor.include? vsyo_line[1]
          text += vsyo_line.join(";") + "\n"
        end
      end
        
      text_to_file(text, data_in_dir + 'vsyo_zapros_vnesh_otbor.csv')

    end
end

x = AddVsyo.new
x.AddVsyoProcess
