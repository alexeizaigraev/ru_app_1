require_relative '../modules'

include Modules

def ask_menu vec
    system('cls')
    puts "\n\n"
    i = 0
    vec.each do |point|
      i += 1
      puts "\t#{i} #{point}".cyan
    end
    print "\n\n -> ".green
    choise = gets.chomp
    return if choise == ''
    choise = choise.to_i - 1
    vec[choise]
end

a = ['a', 's', 'd']

puts ask_menu a
