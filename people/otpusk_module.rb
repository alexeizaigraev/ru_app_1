module OtpuskModule

  def status
    return :uvolnenie if @vec[2] == ''
    return :otpusk
  end


def dates
"""
  sos('Ошибка даты', @vec[0]) if ( ( @vec[1].size != 10 ) \
    ||  ( @vec[1].count( '.' ) != 2 ) ) \
    || ( ( @vec[2] != '' ) && ( @vec[2].size != 10) \
    && ( @vec[2].count( '.' ) != 2 ) )
"""
  # Отпуск
  if status == :otpusk

    date_start_otpusk = ( @vec[1].split('.').reverse! ).join('-') + ' ' + '00:00:01'
    date_finish_otpusk = ( @vec[2].split('.').reverse! ).join('-') + ' ' + '23:59:59'

    date_active_start = '2020-02-02 00:00:01'
    date_active_finish = '2050-02-02 00:00:01'

    dates_out = date_start_otpusk + ';' + \
      date_finish_otpusk + ';' + \
      + '' + ';' + \
      date_active_start + ';' + \
      date_active_finish

  end

    # Увольнение
  if status == :uvolnenie

    date_start_otpusk = ''
    date_finish_otpusk = ''

    date_uvol = ( @vec[1].split('.').reverse! ).join('-') + ' ' + '23:59:59'

    date_active_start = '2020-02-02 00:00:01'
    date_active_finish = date_uvol

    dates_out = date_start_otpusk + ';' + \
          date_finish_otpusk + ';' + \
          date_uvol + ';' + \
          date_active_start + ';' + \
          date_active_finish
    #  return @dates
    end
    return dates_out
  end

end
