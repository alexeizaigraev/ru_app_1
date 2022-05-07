# coding: UTF-8
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

    deps = vsyo_dep
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
            dep = line['dep_department']
            next if dep == ""
            if line['dep_partner'].include? partner
                count += 1
                out_line = count.to_s + ';' + line['dep_department']  + ';' \
                        + line['dep_region'] + ';' \
                        + line['dep_district_region'] + ';' \
                        + line['dep_post_index'] + ';' \
                        + line['dep_city_type'] + ';' \
                        + line['dep_city'] + ';' \
                        + line['dep_district_city'] + ';' \
                        + line['dep_street_type'] + ';' \
                        + line['dep_street'] + ';' \
                        + line['dep_hous'] + ';' \
                        + '' + ';' \
                        + '' + ';' \
                        + '' + ';' \
                        + line['dep_address'] + ';' \
                        + line['dep_koatu'] + ';' \
                        + mk_koatu2(line['dep_koatu'], line['dep_city'], line['dep_district_city'], line['address'])
            out_text += out_line + "\n"
            end
        rescue => err
            puts err
        end
    end

  #text_to_file(out_text, fname_out)
  save_and_show( out_text, fname_out )
  end

  def niseStr(str) = return str.gsub('`', '').gsub("’", '').gsub("'", '').downcase

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

  #out
  end


end

x = Summury.new
x.summuryProcess
