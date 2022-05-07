require 'colorize'

def ask h
    data = h
    #system('cls')
    puts "\n\n"
    if h.class == Hash
        keys = h.keys
        i = 0
        keys.each do
            i += 1
            puts "\t#{i} #{keys[ i-1 ]}".blue
        end
        print "\n\n -> ".green
        choise = gets.chomp
        return if choise == ''
        choise = choise.to_i - 1
        if ( -1 < choise ) && ( choise < keys.size + 1 )
            mykey = keys[ choise ]
            #puts mykey.yellow
            #h2 = h[ mykey ]
            color_flag = !color_flag
            ask h[ mykey ]
        elsif choise == -1
            puts '\n\n\t*** GOOD BY ***'.blue
            exit
        else
            myloop
        end
    elsif h.class == String
        system('cls')
        puts "\n\n"
        system("ruby", h + '.rb')#process
        puts "\n\n"
    end
end


def myloop

    data = {
         'people' => 
             {            
                'Priem' => 'people/priem',
                'Otpusk' => 'people/otpusk',
                'Perevod' => 'people/perevod',
                'PostAll' => 'people/postall',
             },
        'some'  => 
             {            
                'Term' => 'some/term',
                'Site' => 'some/site',
                'Hr_Otbor' => 'some/hr_otbor',
                'Hr_Partner' => 'some/hr_partner',
                'Hr_Ab' => 'some/hr_ab',
                'Natasha' => 'some/natasha',
                'Active_term' => 'some/activ_term',
                #'ulya_adresa' => 'some/ulya',
             },
        'monitor'  => 
             {            
                #'Pg_BackUp' => 'doc/doc_pg_back',
                'Walker' => 'monitor/walker',
                'Monitor' => 'monitor/monitor',
                'Accback' => 'monitor/accback',
                'Get_RP_Fast' => 'monitor/get_rp_fast',
                'Get_rp_all' => 'monitor/get_rp_all',
                'gnetz' => 'monitor/gnetz',
                'gdrive_copy' => 'monitor/gdrive_copy',
                'gdrive_comon' => 'monitor/gdrive_comon',
             },
        'kabinet'  => 
             {            
                'Rro' => 'kabinet/rro',
                'Pereezd' => 'kabinet/pereezd',
                'Otmena' => 'kabinet/otmena',
                'Prro' => 'kabinet/prro',
                'Knigi' => 'kabinet/knigi',
             },
        'other'  => 
             {            
                'Kvadratiki' => 'other/kvadratiki'
             },
        'doc'  => 
             {            
                #'Pg_BackUp' => 'doc/doc_pg_back',
                'Activaciya' => 'doc/activaciya',
                'Act_Peredachi' => 'doc/act_peredachi',
                'Dep_To_File' => 'doc/dep_to_file',
                'Term_To_File' => 'doc/term_to_file',
                'VsyoZapros' => 'doc/vsyo_zapros',
             },
        'otbor'  => 
             {            
                'Otbor_From_To_Dep' => 'otbor/otbor',
                'Otbor_List_Dep' => 'otbor/otbor_hard_dep',
                'Otbor_Hard_Term' => 'otbor/otbor_hard',
                'Otbor_Serial' => 'otbor/otbor_serial',
                'Otbor_Serial_Hvost' => 'otbor/otbor_serial_hvost',
                'Otbor_From_File_Term' => 'otbor/otbor_from_file_term',
                'Otbor_From_File' => 'otbor/otbor_from_file',
                'show_otbor' => 'otbor/show_otbor',
             },
        'db'  => 
             {  #'refresh_db' => 'db/runsharp',
                #'all_to_actual' => 'db/actual_refresh_all',
                #'otbor_to_actual' => 'db/actual_refresh_otbor',
                #'del_otbor_actual' => 'db/del_actual_otbor',
                #'del_all_actual' => 'db/del_actual_all',
                'del_otbor_dep' => 'db/del_otbor_dep',
                'del_otbor_term' => 'db/del_otbor_term',
                'show' => 'db/show',
                #'analis_dep' => 'db/analis_dep',
                'analis_term' => 'db/analis_term',     
                'dep_from_file' => 'edit/dep_from_file',
                'term_from_file' => 'edit/term_from_file',
             },
                
    }

    loop do
    hello
        ask data
    end

end

def hello
    print "\n\t\t -^-\t".blue
    print " r".red
    print "u".yellow
    print "b".cyan
    print "y".green
    puts "\t-^-\n".magenta
  end

myloop
