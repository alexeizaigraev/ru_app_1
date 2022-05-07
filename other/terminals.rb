require 'colorize'

require_relative 'papa2'
require_relative 'modules'

class Terminals < Papa2
  include Modules

  def terminalsProcess
    
    fname_out = 'OutSite.csv'
    line = ''
    ag_cog = ''
    @ColDataShablon1 = 5
    @ColDataShablon2 = 6
    @ColDataSoft = 7
    @ColDataLimit = 8

    @ColTermTerm = 0
    @ColTermId = 1
    @ColTermSity = 2
    @ColTermRegion = 3
    @ColTermStreet = 4
    @ColTermHouse = 5
    @ColTermSerial = 6


    fname_in = 'vsyo_zapros_vnesh_otbor.csv'
    fname_out = 'OutTerminals.csv'
    out_text = ''
    vsyo_zapros = file_to_arr( data_in_dir + fname_in )
    head = vsyo_zapros[0]
    data = vsyo_zapros[1...vsyo_zapros.size]
    data.each do |line|
      insert_data = vec_to_hash(head, line)
      
      terminal = insert_data['termial']
      
      idd = insert_data['id_terminal']
      if '' == idd
        idd = terminal
      end
      
      sity = insert_data[ 'city' ]
      
      region = insert_data['region']
      if '' == region
        region = sity
      end

      street_type = insert_data['street_type']
      street = insert_data['street']
      
      house = insert_data['hous']
      
      serial = insert_data['serial_number']
      fiscal = insert_data['fiscal_number']
      if ( ( serial != '' ) && ( serial.include? '0' ) )
        split_serial = serial.split( '0' )
        serial = ( split_serial[ 1...split_serial.size ] ).join('')
      end
      if serial == ''
        serial = fiscal
      end
      if serial == ''
        serial = '333'
      end

      @ag_cod = terminal[ 0..2 ]
      out = [ '','','','','','','','','', ]

      out[ 0 ] = terminal
      out[ 1 ] = idd
      out[ 2 ] = def_agent[ :shablon1 ]
      out[ 3 ] = sity + ', ' + region
      out[ 4 ] = street_type + ' ' + street + ', ' + house
      out[ 5 ] = def_agent[ :shablon2 ]
      out[ 6 ] = def_agent[ :soft ]
      out[ 7 ] = def_agent[ :limit ]
      out[ 8 ] = serial

      out_line = out.join( ';' )
      out_text += out_line + "\n"
      #puts out_line.blue
    end
    full_out_fname = data_out_dir + fname_out
    #save_and_show(full_out_fname, out_text)
    puts out_text.green
    text_to_file(out_text, full_out_fname)

  end

  def def_agent

    h = Hash.new
    h = {
      shablon: '',
      shablon2: '',
      soft: '',
      limit: '',
    }

    a = file_to_arr(data_config_dir + 'comon_data.csv')
    a.each do |vec|
      if vec[0].include? @ag_cod
        h[:shablon1] = vec[@ColDataShablon1]
        h[:shablon2] = vec[@ColDataShablon2]
        h[:soft] = vec[@ColDataSoft]
        h[:limit] = vec[@ColDataLimit]
        break
      end
    end
    if  h[:shablon1].include? 'shablon1'
        sos('Нет данных агента', @ag_cod)
    end

    if  h[:shablon1] == ''
        sos('Незнакомый агент', @ag_cod)
    end

    return h
  end

end

x = Terminals.new
x.terminalsProcess
