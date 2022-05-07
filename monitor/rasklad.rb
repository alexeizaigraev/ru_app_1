require_relative 'papa2'

class Rasklad < Papa2

  def raskladProcess
    @kass_all = mk_kass_all_rasklad
    post_all('justin', post_dir + 'justin/OutPostAll.csv')
    post_otpuska('justin', post_dir + 'justin/OutPostOtpuskaJust.csv')

    post_all('allo', post_dir + 'allo/OutPostAllAllo.csv')
	
	post_all('satua', post_dir + 'sat/OutPostAllSat.csv')
    post_otpuska('satua', post_dir + 'sat/OutPostOtpuskaSat.csv')

  
  end

  def mk_kass_all_rasklad
    a = file_to_arr(data_in_dir + 'kass_all.csv')
    a.find_all{ |line| ( line.size > 4 ) && ( line[1][0].include? 't' ) }
    
  end

  def kass(ag)
    a = @kass_all.find_all{ |line| line[-1].include? ag}
    out = []
    a.each do |line|
      out << line[0]
    end
    out
  end

  def post_otpuska(ag, fout)
    logins = kass(ag)
    out_text = "Логин;Начало отпуска;Конец отпуска;Дата увольнения\n"
    a = file_to_arr( data_in_dir + 'all_otpuska.csv')
    a.each do |line|
      #if ( line.size > 5 && (logins.include? line[0]) )
      if logins.include? line[0]
        line_new = line[0..3]
        out_text += line_new.join(';').gsub('null', '') + "\n"
      end
    end
    text_to_file(out_text, fout)

  end

  def post_all(ag, fout)
    out_text = "Логин; ФИО; Терминал\n"
    a = @kass_all.find_all { |line| ( line[-1].include? ag ) }
    
    a.each do |line|
      out_text += "#{line[0]};#{line[2]};#{line[-2]}\n"
    end
    text_to_file(out_text, fout)
  end

end

x = Rasklad.new
x.raskladProcess
