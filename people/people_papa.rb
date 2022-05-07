require_relative '../modules'
require 'colorize'
class PeoplePapa
  include Modules

  def sharp_path = file_to_vec('Config/SharpAppPath.txt')[0]

  def data_dir = file_to_vec('Config/ConfigDataPath.txt')[0]

  def data_in_dir = data_dir + 'InData/'

  def data_config_dir = data_dir + 'Config/'

  def data_out_dir = data_dir + 'OutData/'

  def post_dir = file_to_vec(data_config_dir + 'ConfigPostPath.txt')[0]

  def kabinet_out_dir = file_to_vec(data_config_dir + 'ConfigKabinetPath.txt')[0]

  def sos(textOne, textTwo)
    puts(">> #{textOne} : #{textTwo}".red)
    puts "- - - - - - "
    puts " Поправь и нажми [Enter] :)".green
    gets
    system('ruby', 'main_menu.rb')
  end
 
  def mk_fio_split
    fioSplit = @vec[ @colFioOne ].split( ' ' )
    if fioSplit.size < 3
      out = [fioSplit[ 0 ], fioSplit[ 1 ], fioSplit[ 1 ] ]
    else
      out = fioSplit
    end
    fioSplit
  end

  def fio_white(fff)
    fs = fff.split( ' ' )
    rez = fs[0]
    other = fs[1...fs.size].join('').gsub('.', '').gsub('`', '').gsub("'", '')
    other.each_char do |cha|
      if cha.upcase == cha
        rez += cha
      end
    end
    rez
  end

  
  def mk_initial_one_dot = "#{@firstname[ 0 ]}."

  def mk_initial_two_dot = "#{@lastname[ 0 ]}."

  def mk_name_for_login = "#{@firstname[ 0..1 ].downcase}#{@lastname[ 0..1 ].downcase}#{@surname.downcase}"
  

  # имя с инициалами для загрузки в систему
  def mk_shortname = "#{@surname} #{mk_initial_one_dot} #{mk_initial_two_dot}"


  # номер отделения из разных представлений
  def department
    dep = @vec[@colDepOne].gsub(' ', '')
    dep = dep.split('№')[1] if dep.include? '№'
    dep
  end
  
  def search_login_deep(par_dep, nama)
    logins = []
    count = 0
    for line in @kass_all
      if ( ( line[2][1..3].include? par_dep ) &&
      ( line[1].include? nama ) )
        count += 1
        if count > 1
          return nil
        end
        logins << line[0]
      end
    end
    @login_ok = true if( logins && ( 1 == logins.size ) )
    
    return logins
    end

  def search_login
    @login_ok = false
    rez = ''
    nama = fio_white(@vec[@colFioOne])
    dep = department
    logins = []
    
    for line in @kass_all
      if ( ( line[2].include? dep ) &&
      ( line[1].include? nama ) )
        logins << line[0]
        @login_ok = true
      end
    end

    if @login_ok
        return logins
    else
        search_login_deep(dep[0..2], nama)
    end
  end

  def mk_kass_all_0
    b = []
    a = file_to_arr(data_in_dir + 'kass_all.csv')
    for line in a
      if( ( line.size > 4 ) && ( line[1].include? 'tru' ) )
        b.append([line[0], fio_white(line[2]), line[3]])
      end
    end
    b
  end

  def mk_kass_all
    b = []
    a = file_to_arr(data_in_dir + 'kass_all.csv')
    a.reject! { |line| ( ( line.size < 5 ) && ( line[1][0].include? 'f' ) ) }
    a.each do |line|
      b.append([line[0], fio_white(line[2]), line[3]])
    end
    return b
  end


  def my_out(text, file) = text_to_file(text, file)

  def save_and_show(text, file)
    text_to_file(text, file)
    system("notepad", file)
  end

# cp1251 Запись в файл для кабинета
  def text_to_file_kabinet( text, fname)
    fo = File.open(fname, "w:cp1251")
    fo.write(text)
    fo.close
    puts fname.blue
  end

end
