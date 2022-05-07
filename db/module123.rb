require 'colorize'
module Modules


  def sos(textOne, textTwo)
    puts(">> #{textOne} : #{textTwo}".red)
    puts "- - - - - - "
    puts " Поправь и нажми [Enter] :)".green
    gets
    system('ruby', 'MENU.rb')
  end

def file_to_text(fname)
    file = File.new(fname,"r:UTF-8")
    text = file.read
    file.close
    text
  end


def file_to_arr0(fname)
    arr = []
    f = File.open(fname, 'rt')
    for line in f
        if line
            if line.include? ';'
                lineTwo = line.chomp!.split(';') if line.include?( ";" )
            else
                lineTwo = line.chomp!
            end
            arr.push lineTwo
        end
    end
    arr
end

def file_to_arr(fname)
    arr = []
    File.readlines(fname).each do |line|
        if line
            if line.include? ';'
                arr.push( line.chomp!.split(';') )
            else
                arr.push( line.chomp! )
            end
        end
    end
    arr
end


def file_to_vec(fname)
    arr = []
    File.readlines(fname).each do |line|
        if line
            arr.push line.chomp!
        end
    end
    arr
end

def text_to_file(mytext, fname)

    f = File.open(fname, 'wt')
    f.write mytext
    f.close

    puts "\n  ~ #{fname}\n".blue
end

def hash_to_text(a)
    x = a.keys[0]
    head = a[x].keys.join(';') + "\n"
    text = head
    a.each_key do |u|
        v = a[u]
        line = v.values.join(';') + "\n"
        text += line
    end
    text
end

def arr_to_text(arr)
  text = ''
  for vec in arr
    text += vec.join(';') + "\n"
  end
  return text
end

def arr_to_file(arr, fname)
  text_to_file(arr_to_text(arr), fname)
end


def hash_to_file(h, fname)
    text_to_file(hash_to_text(h), fname)
end


def file_to_hash(fname, key_main)
    a = file_to_arr(fname)
    head = a[0]
    a = a[1...a.size]
    h = Hash.new
    for line in a
        i = -1
        h_line = Hash.new
        for u in line
            i += 1
            key = head[i]
            h_line[key] = u
        end
        key_line = line[ key_main ]
        h[ key_line] = h_line
    end
    h
end

def vec_to_hash(head, vec)
    d = Hash.new
    0.upto(head.size) do |i|
        begin
            d[head[i]] = vec[i]
        rescue
            d[head[i]] = ''
        end
    end
   d
end

def mk_menu(h, header)
    system('cls')
    points = h.keys

    loop do
        puts ( "\n" + '_' * 50 + "\n\n").blue
        counts = 1
        for point in points
            if counts == h.size
              puts "\t#{counts} #{point}".green
            else
              puts "\t#{counts} #{point}".cyan
            end
            counts += 1
        end
        puts "\n\n\n"
        print " -> ".green
        choise = gets.chomp
        if choise == ''
            system('cls')
            break
        end
        if choise == '0'
            puts '*** GOOD BY ***'.blue
            exit
        end
        choise = choise.to_i
        return if choise < 1 || choise > h.size + 1
        comand = h[ points[ choise - 1] ] + '.rb'
        system('cls')
        #puts
        system("ruby", comand)
        #puts
    end
end

def now_date_kabinet
    ddd = Time.new
    d = ddd.day
    d = '0' + d if d.size == 1
    m = ddd.month
    #return ddd.strftime("%d-%m-%Y")
    return ddd.strftime("%d%m%Y")
end

def now_date_line
    ddd = Time.new
    return ddd.strftime("%Y-%m-%d")
end

def col_key(hh, mykey)
    system('cls')
    puts"\n\n"
    s = []
    hh.each_key do |key|
        begin
            line = hh[key]
            s << line[mykey]
        rescue
            #('>> no key', key)
            zzz = 0
        end
    end

    s.uniq!

    0.upto(s.size) do |i|
        puts "\t#{i} #{s[i]}".green if s[i] && ( '' != s[i] )
    end


    print "\n\n -> ".blue

    choise = gets.to_i
    system('cls')
    puts s[choise]
    s[choise]
end

def mk_natasha
    sign = 'Відділення № '
    b = []
    f = file_to_arr(data_in_dir + 'natasha.csv')
    f = f[6...f.size]
    f.each do |line|

        line = line.gsub('"', '').gsub('\\', '') if ( (line.include? '"') || (line.include? '\\') )
        next unless line.join('').include? sign

        #puts line
        line.each do |unit|
          if unit.include? sign
            el = unit.gsub(sign, '').gsub(' ', '')
            b.append(el)
            #puts el
          end
        end

    end
    #puts b
    return b.uniq
    end

    def mk_comon_hash(key_col_num)
        h = Hash.new()
        a = file_to_arr( data_config_path + 'comon_data.csv' )
        a.each do |vec|
            key = vec[0]
            h[key] = vec[key_col_num]
        end
        h
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

    def open_note fname
      system("ruby# {fname}")
    end


    def sharp_path = file_to_vec('Config/SharpAppPath.txt')[0]

    def data_path = file_to_vec('Config/ConfigDataPath.txt')[0]

    def data_in_path = data_path + 'InData/'

    def data_config_path = data_path + 'Config/'

    def data_out_path = data_path + 'OutData/'

    def post_path = file_to_vec(data_config_path + 'ConfigPostPath.txt')[0]

    def kabinet_out_dir = file_to_vec(data_config_path + 'ConfigKabinetPath.txt')[0]


end
