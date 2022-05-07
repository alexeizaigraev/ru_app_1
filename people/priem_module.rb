module PriemModule

  # Строим логин из имени для логина
  def makeLogin
    h = Hash.new()
    h = {
        'а' => 'a',
        'б' => 'b',
        'в' => 'v',
        'г' => 'g',
        'ґ' => 'gh',
        'д' => 'd',
        'е' => 'e',
        'є' => 'ye',
        'ж' => 'zh',
        'з' => 'z',
        'и' => 'y',
        'і' => 'i',
        'ї' => 'ji',
        'й' => 'j',
        'к' => 'k',
        'л' => 'l',
        'м' => 'm',
        'н' => 'n',
        'о' => 'o',
        'п' => 'p',
        'р' => 'r',
        'с' => 's',
        'т' => 't',
        'у' => 'u',
        'ф' => 'f',
        'х' => 'h',
        'ц' => 'tz',
        'ч' => 'ch',
        'ш' => 'sh',
        'щ' => 'sch',
        'ь' => 'j',
        'ю' => 'yu',
        'я' => 'ya',
        "'" => "y",
        '-' => '',
        }
    login = ''
    n = mk_name_for_login
    n.each_char do |bukva_ua|
      login += h[ bukva_ua ] if h.include? bukva_ua
    end
    login
  end


  # по коду агента ищем шаблон и почту по умолчанию
  def mk_agent_data
    a = file_to_arr( data_config_dir + 'comon_data.csv' )
    a.each do |vec|
        @h_shablon[ vec[ 0 ] ] = vec[ 1 ]
        @h_mail[ vec[ 0 ] ] = vec[ 2 ]
    end
  end

  def mk_mail
    # умолчание
    mail = @h_mail[ @ag_code ]
    mail2 = @vec[ @colMail ]
      if mail2 && ( mail2.include? '@' )
        mail = mail2
      end
    mail
  end

  def mk_phone
    phone = @vec[ @colPhone ]
    if phone && ( phone.gsub( "-","" ).size == 10 )
      return phone = "38" + phone.gsub( "-","" )
    end
    return '380999999999'
  end

  def mk_pasp_seria
    pasp_seria = @vec[ @colPaspSeria ]
    if ( pasp_seria ) \
      && ( pasp_seria.size > 1 )
      return pasp_seria
    end
    "id"
  end

  def mk_pasp_num
    pasp_number = @vec[ @colPaspNum ]
    if pasp_number && ( pasp_number.size > 3 )
      return pasp_number
    end
    "3333"
  end

  def mk_pasp_date
    pasp_date = @vec[ @colPaspDate ]
    if pasp_date \
      && ( pasp_date.size == 10 ) \
      && ( pasp_date.include? '.' )
      date = pasp_date.split(".")
      return date[ 2 ] + "-" + date[ 1 ] + "-" + date[ 0 ]
    end
    "2020-01-01"
  end

  def mk_pasp_vydan
    # умолчание
    pasp_get = @vec[ @colPaspVydan ]
    if ( pasp_get &&
      ( pasp_get.size > 3 ))
      return pasp_get
    end
    "3333"
  end

end
