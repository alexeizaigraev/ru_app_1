require_relative 'people_papa'
require 'colorize'

class Perevod < PeoplePapa
  @line =''

  def perevodProcess
    @fOutName = data_out_dir + 'OutPerevod.csv'

    @colFioOne = 0
    @colFioTwo = 2
    @colLoginTwo = 0
    @colDepTwo = -2
    @colDepOne = 1

    out_text = ''
    @kass_all = mk_kass_all

    perevod = file_to_arr(data_in_dir + 'perevod.csv')
    unfind = ''
    perevod.each do |vec|
      @vec = vec
      @surname, @firstname, @lastname = mk_fio_split
      my_login = search_login

      unless @login_ok
        unfind += vec.join(";") + "\n"
        next
      else
        my_login.each do |unit|
          out_text += unit + ";" + vec[1] + ';' + vec[2] + "\n"
        end
      end

    end

    puts "\n\n"
    puts out_text.blue
    puts
    puts unfind.green
    out_text = unfind + "\n\n\n" + out_text if unfind != ''

    #text_to_file( out_text, @fOutName )
    save_and_show( out_text, @fOutName )

    if '' == unfind
      puts "\n\twell".yellow
    else
      puts "/n/tunfind".red if '' == out_text
    end

  end

end

x = Perevod.new
x.perevodProcess
