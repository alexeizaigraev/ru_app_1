require_relative 'people_papa'
require_relative 'otpusk_module'
require 'colorize'

class Otpusk < PeoplePapa
  include OtpuskModule

  def OtpuskProcess
    @colFioOne = 0
    @colFioTwo = 1
    @colLoginTwo = 0
    @colDepTwo = -2
    @colDepOne = 3
    out_text = ''
    @kass_all = mk_kass_all

    unfind = ''

    data = file_to_arr(data_in_dir + 'otpusk_uvol.csv')
    data.each do |vec|
      @vec = vec
      my_login = search_login
      unless @login_ok
        unfind += vec[0] + "\t" + ';' + dates + "\n"
        next
      else
        my_login.each do |unit|
          out_text += unit + ';' + dates + "\n"
      end
    end
  end

    if out_text != ''
      out_text = unfind + "\n\n\n" + out_text if unfind != ''

      #save_and_show(out_text, data_out_dir + 'OutOtpuskUvol.csv')
      text_to_file( out_text, data_out_dir + 'OutOtpuskUvol.csv' )

      puts "\n\twell".yellow if '' == unfind
    else
      puts '>> Вобще никто не найден ! '.red if '' == out_text
    end

    if '' != unfind
      puts "\tЕсть ненайденные логины\n".yellow
      puts unfind.green
    end

  end


  def mk_good_arr( data )
    b = []
    data.each do |line|
      #b.append( clear_line( line ) ) if line.join( '' ).include? '№'
      b.append( line ) if line.join( '' ).include? '№'
    end
    otpusk = b
  end

  def clear_line( line )
    ind_date = -1
    ind_fio = -1
    ind_dep = -1

    for el in line
      ind_date += 1
      break if( ( el.include? '.' ) && ( el.include? '0' ) )
    end

    ind_fio = -1
    for el in line
      ind_fio += 1
      break if( el.split(' ').size > 2 )
    end

    ind_dep = -1
    for el in line
      ind_dep += 1
      break if( el.include? '№' )
    end

    return line[ind_fio...ind_fio + 1] + line[ind_date...ind_date + 2] + line[ind_dep...ind_dep + 1]
  end


end

x = Otpusk.new
x.OtpuskProcess
