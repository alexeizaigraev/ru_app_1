require 'colorize'
require 'fileutils'

require_relative '../modules'

class Site
  include Modules

  def siteProcess

    fname_out = 'OutSite.csv'
    fname_out_php = 'page-departments.php'

    text1 = '<?php
get_header();
?>
<div class="container">
    <div class="row">
      <h1 class="title-normal"><strong>Відділення</strong></h1>
       <h5>Керівник відділень - начальник відділень Кульчицький Андрій Олегович, тел. +380 (44) 300 00 01 (137)</h5>
        <div class="form-group" style="margin-top:10px;">
            <input type="text" class="search-depart form-control" placeholder="Пошук">
        </div>
        <span class="counter"></span>
        <table class="table table-hover table-bordered results">
          <thead>
            <tr>
              <th class="col-md-1"><div style="text-align: center;">Найменування відокремленного підрозділу та ПНФП</div></th>
              <th class="col-md-4"><div style="text-align: center;">Адреса</div></th>
              <th><div style="text-align: center;">Дата та номер рішення про створення</div></th>
              <th class="col-md-1"><div style="text-align: center;">ЄДРПОУ</div></th>
              <th class="col-md-2"><div style="text-align: center;">Режим роботи</div></th>
              <th class="col-md-2"><div style="text-align: center;">Платежі приймаються в Платіжній системі</div></th>
              <th class="col-md-2"><div style="text-align: center;">Платежі виплачуються  в Платіжній системі</div></th>
            </tr>
            <tr class="warning no-result">
              <td colspan="7"><i class="fa fa-warning"></i> No result</td>
            </tr>
          </thead>
          <tbody>
'

    text2 = '</tbody>
        </table>
        <div class="gap-20"></div>
        <ul class="list-arrow">
            <li><a href="<?php echo $www?>/departments.pdf" target="_blank">Список усіх відділень</a></li>
        </ul>
        <div class="gap-20"></div>
    </div>

</div>

<?php
get_footer();
?> '

    regimes = mk_regimes()
    regimes_group = mk_regimes_group
    natasha = mk_natasha

    #access = file_to_arr(data_in_dir + 'access.csv')
    deps = file_to_arr( data_in_path + 'departments.csv' )
    deps_head = deps[0]
    deps = deps[1..]
    header = ['Найменування відокремленного підрозділу та ПНФП;Адреса;Дата та номер рішення про створення;ЄДРПОУ;Режим роботи;Платежі приймаються в Платіжній системі;Платежі виплачуються  в Платіжній системі\n']


    out_text_php = ''
    out_text_clear = header.join(';') + "\n"

    deps.each do |line|
            dep_hash = vec_to_hash(deps_head, line)
            dep = dep_hash[ 'department' ]
            partner = dep_hash[ 'partner' ]

            address = dep_hash[ 'address' ]
            edrpou = dep_hash[ 'edrpou' ]
            register = dep_hash[ 'register' ]
      regim_insert = 'не працює'
      ag_sign = dep[0...3]
      if ( (regimes_group.has_key? dep) && (natasha.include? dep) )
        regim_insert = regimes_group[dep]
      end
      if ( (regim_insert == 'не працює') && (regimes.has_key? ag_sign) && (natasha.include? dep) )
        regim_insert = regimes[ag_sign]
      elsif '1' == dep
        regim_insert = 'ПН-ПТ 09:00-18:00'
      end

      if edrpou != ''
        out_text_php += "<tr><td>ВІДДІЛЕННЯ №#{dep}</td><td>#{address}</td><td>#{register}</td><td>#{edrpou}</td><td>#{regim_insert}</td><td>ВПС ЕЛЕКТРУМ, ВПС FLASHPAY</td><td>ВПС ЕЛЕКТРУМ</td></tr>\n"
        out_text_clear += "ВІДДІЛЕННЯ №#{dep};#{address};#{register};#{edrpou};#{regim_insert};ВПС ЕЛЕКТРУМ, ВПС FLASHPAY;ВПС ЕЛЕКТРУМ\n"
      else
        out_text_php += "<tr><td>ПНФП ВІДДІЛЕННЯ №#{dep}</td><td>#{address}</td><td>#{register}</td><td>#{edrpou}</td><td>#{regim_insert}</td><td>ВПС ЕЛЕКТРУМ, ВПС FLASHPAY</td><td>ВПС ЕЛЕКТРУМ</td></tr>\n"
        out_text_clear += "ПНФП ВІДДІЛЕННЯ №#{dep};#{address};#{register};#{edrpou};#{regim_insert};ВПС ЕЛЕКТРУМ, ВПС FLASHPAY;ВПС ЕЛЕКТРУМ\n"
      end
    end

    full_out_fname = data_out_path + fname_out
    text_to_file(out_text_clear, full_out_fname)

    out_text_php = text1 + out_text_php + text2
    full_out_fname_php = data_out_path + fname_out_php
    text_to_file(out_text_php, full_out_fname_php)

  end


  def mk_regimes()
    h = Hash.new
    a = file_to_arr( data_config_path + 'comon_data.csv' )
    a.each do |vec|
       h[vec[0]] = vec[4]
    end
    h
  end

  def mk_regimes_group
    d = Hash.new
    root = data_path + 'Regimes'
    files = Dir.chdir(root) { Dir.glob("**/*").map {|path| File.expand_path(path) } }
    files.each do |fname|
      data = file_to_arr(fname)
      next if data.nil? || data.size < 2
      data.each do |line|
        begin
          dep, reg = line
          d[dep] = reg
        rescue
          z = nil
        end
      end
    end
    return d
end

end

x = Site.new
x.siteProcess
