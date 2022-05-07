require_relative '../modules'
require 'colorize'

class Postall

  include Modules

  #@dir_out_post = post_path

  def post_all(ag, fout)
      out_text = "login;status;fio;terminal;agent\n"
      @all_kass.each do |line|
        if (line.size > 3) && (line[-1].include? ag) && (line[1].include? 'tru')
          rez = "#{line[0]};#{line[1]};#{line[2]};#{line[-2]};#{line[-1]}".chomp + "\n"
          out_text += rez
        end
      end
      text_to_file(out_text, fout)
      #ssay(fout)
  end



  def mk_fierd()
    vec = []
      all_otpuska = file_to_arr(data_in_path + 'all_otpuska.csv')
      all_otpuska.each do |line|
        vec.append( line[ 0 ] ) if line && ( !line[ 3 ].include? 'nul' )
      end
    vec
end

  def mk_all_kass()
      all = []
      a = file_to_arr(data_in_path + 'kass_all.csv')
      a.each do |line|
        if ( line.size > 4 ) && ( line[ 1 ].include? 'tru' ) && ( !@fierd.include? line[ 0 ] )
          all.append( line )
        end
      end
      all
end


  def mk_all_otpuska()
    arr = []
    otpuska = file_to_arr( data_in_path + 'all_otpuska.csv' )
    otpuska.each do |line|
      arr.append( line ) if !@fierd.include? line[ 0 ]
    end
    arr
  end

  def kass(ag)
    vec = []
    @all_kass.each do |line|
      if ( line.size > 3 ) && ( line[ -1 ].include? ag ) && ( line[ 1 ].include? 'tru' )
        vec.append( line[ 1 ] )
      end
    end
    vec
  end


  def post_otpuska(ag, fout)
      logins = kass(ag)
      out_text = "login;otpusk_start;otpusk_finish;data_uvolneniya\n"
      @otp_arr.each do |line|
        if line && ( logins.include? line[ 0 ] )
          rez = line[0...4].join( ';' ).gsub('null', '')
          out_text += rez + "\n"
        end
      end
      text_to_file(out_text, fout)
  end

def postallProcess

    #post_path = GDRIVE_PATH

    @dir_out_post = post_path

    @fierd = mk_fierd()
    @all_kass = mk_all_kass()

    @all_otpuska = mk_all_otpuska()

    @otp_arr = file_to_arr(data_in_path + 'all_otpuska.csv')

    post_all('justin', post_path + 'justin/OutPostAll.csv')
    post_otpuska('justin', post_path + 'justin/OutPostOtpuskaJust.csv')

    post_all('allo', post_path + 'allo/OutPostAllAllo.csv')

    post_all('satua', post_path + 'sat/OutPostAllSat.csv')
    post_otpuska('satua', post_path + 'sat/OutPostOtpuskaSat.csv')

    post_path = data_out_path + 'DOC/'
    post_all('justin', post_path + 'justin/OutPostAll.csv')
    post_otpuska('justin', post_path + 'justin/OutPostOtpuskaJust.csv')
end

end

x = Postall.new
x.postallProcess
