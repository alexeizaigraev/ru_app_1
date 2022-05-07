require 'colorize'


require_relative '../modules'
require_relative '../db_base'

class Summury
  include Modules
  include Db

  def summuryProcess
    @koatuSpr = file_to_arr(data_in_path + 'koatuall.csv')

    fname_out = data_out_path + 'hr_new_deps.csv'

    head = '№ п/п;"№ Відділення ТОВ ""ЕПС""";Область;Район в обл.;Індекс;Тип населеного пункту;Населений пункт;Район в місті;Тип вулиці;Адреса;Номер будинку;Дата признчення керівника;модель РРО;Заводський № РРО;2;koatu1;koatu2'
    out_text = head + "\n"

    deps = vsyo_dep_otbor
    partners = []
    deps.each do |dep|
      partners <<  dep['dep_partner'] unless partners.include? dep['dep_partner']
    end

    partner = ask_menu partners
    puts "\n\t#{partner}\n".cyan

    my_deps = []
    count = 0
    deps.each do |line|
        begin
            line = hh[key]
            dep = line['dep_department']
            next if dep ==

            if ( ( line['partner'].include? partner ) && !( my_deps.include? dep ) )
              my_deps << dep
                count += 1
                out_line = (count.to_s + ';' + line['Терминалы.department']  + ';' \
                        + line['region'] + ';' \
                        + line['district_region'] + ';' \
                        + line['post_index'] + ';' \
                        + line['city_type'] + ';' \
                        + line['city'] + ';' \
                        + line['district_city'] + ';' \
                        + line['street_type'] + ';' \
                        + line['street'] + ';' \
                        + line['hous'] + ';' \
                        + '' + ';' \
                        + '' + ';' \
                        + '' + ';' \
                        + line['address'] + ';' \
                        + line['koatu'] + ';' \
                        + mk_koatu2(line['koatu'], line['city'], line['district_city'], line['address']))

            out_text += out_line + "\n"
            end
        rescue
            zzz = nil
        end

    end

  text_to_file(out_text, fname_out)
  end

  def niseStr(str) = str.gsub("’", '').gsub("'", '').downcase

  def mk_koatu2(koatu, city, district_city, address)
    out = ''
    @koatuSpr.each do |line|
        if ( (line[1].include? koatu) && ( (niseStr(line[2]).include? niseStr(city) ) || (niseStr(line[2]).include? niseStr(district_city)) ) )
            return line[0]
        end
    end

    @koatuSpr.each do |line|
        if ( (line[1].include? koatu) && ( (niseStr(address).include? niseStr(line[2]) ) ) )
            return line[0]
        end
    end

  out
  end


end

x = Summury.new
x.summuryProcess
