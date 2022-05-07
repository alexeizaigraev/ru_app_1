require_relative 'people_papa'
require_relative 'priem_module'
require 'colorize'


class Priem < PeoplePapa

  include PriemModule

  def main
    @info = ''
    @h_mail = Hash.new
    @h_shablon = Hash.new
    mk_agent_data
    fout_name = data_out_dir + 'OutPriem.csv'
    @ag_code = nil

    @colFioOne = 0
    @colDep = 1
    @colDepOne = @colDep
    @colPhone = 2
    @colMail = 3
    @colPaspSeria = 4
    @colPaspNum = 5
    @colPaspDate = 6
    @colPaspVydan = 7

    header = 'Логин;Пароль;ФИО;;;Агент;Терминал;;;;;'
    out_text = header + "\n"

    data = file_to_arr(data_in_dir + 'priem.csv')
    data.each do |vec|
      @vec = vec
      @surname, @firstname, @lastname = mk_fio_split
      term = department + '1'
      login = makeLogin
      @ag_code =department[ 0..2 ]
      sos('>> err agent', @ag_code) if !@h_shablon.include? @ag_code
      shablon = @h_shablon[ @ag_code ]

      login += mk_pasp_num[ mk_pasp_num.size - 4...mk_pasp_num.size ]
      # выходная строка
      out_line = login + ";" + login + ";" \
        + mk_shortname + ";" \
        + mk_mail + ";" \
        + mk_phone + ";" \
        + shablon + ";" \
        + term + ";" \
        + mk_pasp_seria + ";" \
        + mk_pasp_num + ";" \
        + mk_pasp_vydan + ";" \
        + mk_pasp_date
      # собираем выходной текст
      out_text += out_line + "\n"
    end

    #save_and_show( out_text, fout_name )
    @info += "#{out_text}\n\n#{text_to_file( out_text, fout_name )}"

#    puts "\twell\n".yellow
  end

end

#x = Priem.new()
#puts x.main
