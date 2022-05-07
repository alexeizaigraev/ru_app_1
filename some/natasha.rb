require 'colorize'

require_relative '../modules'
#require_relative '../db_base'

class NatashaBig
  include Modules

  @natasha = nil
  @deps = nil
  @hash_line = nil
  @partner = nil
  @comon = nil
  @edrpou = nil
  @pnfp = nil
  @hash_line = nil

  def natashaBigProcess

    @natasha = mk_natasha
    @deps = file_to_arr( data_in_path + 'departments.csv' )
    @head = @deps[ 0 ]
    @deps = @deps[ 1... @deps.size ]


    partner_hash = Hash.new
    for line in @deps
      hash_line = vec_to_hash( @head, line )
      next if( ( !hash_line[ 'partner' ] ) || ( !hash_line[ 'department' ] ) )
      partner_hash[ hash_line[ 'partner' ] ] = hash_line[ 'department' ][0...4]
    end

    partner_list = partner_hash.keys.sort
    header = 'Партнёр; Отделения с ЕДРПОУ;ПНФП;Всего'
    out_text = header + "\n"
    summ_comon = 0
    summ_edrpou = 0
    summ_pnfp = 0
    for partner in partner_list
      @partner = partner
      if( @partner && ( @partner != '' ) && ( @partner != 'intime' ) and count_comon > 0 )

        out_line = "#{partner};#{count_edrpou};#{count_pnfp};#{count_comon}"
        out_text += out_line + "\n"
        summ_comon += count_comon
        summ_edrpou += count_edrpou
        summ_pnfp += count_pnfp
      end
    end

    out_text += "\nВсего с ЕДРПОУ #{summ_edrpou}\n"
    out_text += "Всего ПНФП #{summ_pnfp}\n"
    out_text += "Всего #{summ_comon}\n"
    puts out_text.green

    ofname = data_path + "STATISTICA/#{now_date_line}.csv"
    puts "\n\t Отчёт?\t\t Да [Enter] ->".yellow
    choise = gets.chomp
    if( "" == choise )
      #text_to_file(out_text, ofname)
      save_and_show(out_text, ofname)
    else
      puts "\tDu-Du :)".blue
    end



  end


  def count_edrpou0
    count = 0
    for line in @deps
      hash_line = vec_to_hash( @head, line )
      next if( ( !hash_line[ 'partner' ] ) || ( !hash_line[ 'department' ] ) )
        if( ( hash_line[ 'partner' ].include? @partner ) && \
          ( hash_line[ 'edrpou' ] && ( hash_line[ 'edrpou' ] != '' ) ) && \
          ( @natasha.include? hash_line[ 'department' ] ) )
          count += 1
        end
      end
    count
  end

  def my_count
    @count = 0
    for line in @deps
      @hash_line = vec_to_hash( @head, line )
      next if( ( !@hash_line[ 'partner' ] ) || ( !@hash_line[ 'department' ] ) )
      yield
    end
  end

  def count_comon
    res = my_count do
      if( ( @hash_line[ 'partner' ].include? @partner ) && \
          ( @natasha.include? @hash_line[ 'department' ] ) )
          @count += 1
      end
    end
    res = @count
  end

  def count_edrpou
    res = my_count do
      if( ( @hash_line[ 'partner' ].include? @partner ) && \
          ( @hash_line[ 'edrpou' ] && ( @hash_line[ 'edrpou' ] != '' ) ) && \
          ( @natasha.include? @hash_line[ 'department' ] ) )
        @count += 1
      end
    end
    res = @count
  end

  def count_pnfp
    res = my_count do
      if( ( @hash_line[ 'partner' ].include? @partner ) && \
          ( @hash_line[ 'edrpou' ] == '' ) && \
          ( @natasha.include? @hash_line[ 'department' ] ) )
        @count += 1
      end
    end
    res = @count
  end

end

x = NatashaBig.new
x.natashaBigProcess
