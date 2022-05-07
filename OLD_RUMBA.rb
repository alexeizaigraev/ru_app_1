require 'colorize'

#require_relative 'kvadratiki'
require_relative 'modules'

#require_relative 'tech'

class MainMenu
  include Modules

  def hello
    print "\n\t\t -^-\t".blue
    print " r".red
    print "u".yellow
    print "b".cyan
    print "y".green
    puts "\t-^-\n".magenta
  end

  def mainMenuProcess
    system('cls')
    menu_body = """

\t1 People
\t2 Some
\t3 Monitor
\t4 Kabinet"""

    menu_body2 = "\t5 Base\n\n"

  loop do
    system('cls')
    hello
    puts ( '_' * 50 ).blue
    puts menu_body.cyan
    puts menu_body2.green

    print ' -> '.green
    input = gets.chomp
    case input
      when '0'
        puts "\n\t*** GOOD BY ***".yellow
        exit
      when ''
        puts 'Тра - ля - ля :)'.red
      when '1'
        menuPeople
      when '2'
        menuSome
      when '3'
        menuMonitor
      when '4'
        menuKabinet
      when '5'
        menuBase
      #when '6'
        #system('ruby', 'runsharp.rb')

      else
      puts 'Wrong Number'.red
    end
  end
  end
#--------------------------------------------------


def menuSome
  h = Hash.new
  h = { 'Term' => 'some/term',
    'Site' => 'some/site',
    'Hr_Otbor' => 'some/hr_otbor',
    'Hr_Partner' => 'some/hr_partner',
    'Hr_Ab' => 'some/hr_ab',
    'Natasha' => 'some/natasha',
    'Active_term' => 'some/activ_term', }
  mk_menu(h, 'Some')
end
#--------------------------------------------------


  def menuPeople
    h = Hash.new
    h = { 'priem' => 'people/priem',
          'otpusk' => 'people/otpusk',
          'perevod' => 'people/perevod',
          'rasklad' => 'people/rasklad'}
    mk_menu(h, 'People')
  end
#--------------------------------------------------

  def menuKabinet
    h = Hash.new
    h = { 'knigi' => 'knigi',
          'rro' => 'rro',
          'pereezd' => 'pereezd',
          'otmena' => 'otmena',
          'otmena_knigi' => 'otmena_knigi',
          'partiya_zakr_it' => 'partiya_zakr_it',}
    mk_menu(h, 'Kabinet')
  end

def menuMonitor
  h = Hash.new
  h = { 'monitor' => 'monitor',
        'walker' => 'walker',
        'backup_access' => 'backup_access', }
  mk_menu(h, 'Monitor')
end

def menuBase
  h = Hash.new
  h = { 'runsharp' => 'runsharp',
        'otbor' => 'add_otbor',
        'otbor_hard' => 'add_otbor_hard', }
  mk_menu(h, 'Base')
end

end

z = MainMenu.new()
z.mainMenuProcess
