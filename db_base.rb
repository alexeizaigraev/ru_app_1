require 'colorize'
require_relative 'modules'

module Db

    include Modules

  def f_to_h(fname, main_key)
    clear_file fname
    out = Hash.new
    base_name = fname.split('/')[-1].split('.')[0][0...3]
    arr = file_to_arr(fname)
    head = arr[0]
    arr = arr[1..]
    arr.each do |line|
      begin
        h = Hash.new
        0.upto(line.size) do |i|
            next if head[i].nil?
            line[i] = '' if line [i].nil?
            key = "#{base_name}_#{head[i]}"
            h[key] = line[i]
        end
        out[ h[main_key] ] = h
      rescue => err
        puts err.red
      end
    end
    out
  end


    def dep_to_h = f_to_h(data_in_path + 'departments.csv', 'dep_department')
    def ter_to_h = f_to_h(data_in_path + 'terminals.csv', 'ter_termial')
    def otb_to_h = f_to_h(data_in_path + 'otbor.csv', 'otb_term')

    def vsyo_arr
        out = []
        deps = dep_to_h
        terms = ter_to_h
        otbs = otb_to_h
        deps.each do |dep|
            terms.each do |term|
            next if dep[ 'dep_department' ] != term[ 'ter_department']
                line = term.merge(dep)
                out.append(line)
                #puts line['dep_department']
            end
        end
      out
    end

    def vsyo
        out = []
        deps = dep_to_h
        terms = ter_to_h
        #otbs = otb_to_h
        terms.each_value do |term|
            begin
                my_key = term[ 'ter_department' ]
                out.append( term.merge(deps[ my_key ]) ) if deps.has_key? my_key
            rescue => err
                z = nil
                #puts "#{err}".red
            end
        end
        out
    end


    def vsyo_otbor
        out = []

        all = vsyo
        otbs = otb_to_h
        otbs.each_value do |otb|
            all.each do |line|
                #puts line.class
                #puts line
                next unless line['ter_termial'] == otb['otb_term']
                begin
                    out.append( line )
                rescue => err
                    z = nil
                    #puts "#{err}".red
                end
            end
        end
        out
    end


    def vsyo_table_otbor all_h
        out = []
        otbs = otb_to_h
        otbs.each_value do |otb|
            all_h.each_value do |line|
                if line.has_key? 'dep_department'
                    next unless ( line['dep_department'] == otb['otb_dep'] )
                elsif line.has_key? 'ter_termial'
                    next unless ( line['ter_termial'] == otb['otb_term'] )
                end
                begin
                    out.append( line )
                rescue => err
                    z = nil
                end
            end
        end
        out
    end


  def vsyo_table all_h
        out = []
        all_h.each_value do |line|
                begin
                    out.append( line )
                rescue => err
                    z = nil
                end
            end
        out
    end


    def vsyo_dep = vsyo_table dep_to_h

    def vsyo_ter = vsyo_table ter_to_h




    def vsyo_dep_otbor = vsyo_table_otbor dep_to_h

    def vsyo_ter_otbor = vsyo_table_otbor ter_to_h


    def select_all table_name=''
        reurn vsyo_otbor if table_name == ''
        reurn vsyo if table_name == ''
        reurn vsyo if table_name == ''
    end


end

include Db
include Modules

#puts vsyo
#puts vsyo_otbor.size

# vsyo_otbor.each do |line|
#     puts line
#     puts '__________'
# end
#
# puts "\n\twell".yellow
