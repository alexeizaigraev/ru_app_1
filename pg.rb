#!/usr/bin/ruby

require 'pg'
require 'colorize'

require_relative 'modules'

module Pg

include Modules


#clear_______________________________

def clear_table table_name
  con = PG::Connection.new(:host => 'localhost', :user => 'postgres', :dbname => 'postgres', :port => '5432', :password => 'postgres')
  con.exec "DELETE FROM #{table_name}"
  con.close
end

def clear_otbor = clear_table 'otbor'
def clear_departments = clear_table 'departments'
def clear_terminals = clear_tadle 'terminats'

#show_________________________________

def show_table table_name
  con = PG::Connection.new(:host => 'localhost', :user => 'postgres', :dbname => 'postgres', :port => '5432', :password => 'postgres')
  arr = con.query("SELECT * FROM #{table_name}")
  count = 0
  arr.each do |line|
    count += 1
    puts " #{count} #{line}".green
    end
end

def show_otbor = show_table 'otbor'
def show_departments = show_table 'departments'
def show_terminals = show_table 'terminals'



def table_from_file table_name, file_name, header=true, clear_flag=false
  clear_otbor in clear_flag
  arr = file_to_arr(data_in_path + file_name)
  arr = arr[1..] if header
  begin
      con = PG::Connection.new(:host => 'localhost', :user => 'postgres', :dbname => 'postgres', :port => '5432', :password => 'postgres')
      arr.each do |line|
        next if line.nil? || line[0].nil?
        puts line
        if table_name == 'otbor'
          q = "INSERT INTO otbor VALUES($1, $2)"
        elsif table_name == 'departments'
          q = "INSERT INTO departments VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)"
        elsif table_name == 'terminals'
          q = "INSERT INTO terminals VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22)"
        end
        line = good_vec line
        con.exec_params(q, line)
        #puts line[0].green
      end
  rescue PG::Error => e
      puts e.message
  ensure
      con.close if con
  end
end

def refresh_otbor
  table_from_file 'otbor', 'otbor.csv', true, true
end
def refresh_terminals
  table_from_file 'terminals', 'terminals.csv', true, true
end
def refresh_departments
  table_from_file 'departments', 'departments.csv', true, true
end


def insert_record table_name , key, val, vec
  if vec.nil? || vec[0].nil?
    puts 'empty record'.magenta
    return
  end
  con = PG::Connection.new(:host => 'localhost', :user => 'postgres', :dbname => 'postgres', :port => '5432', :password => 'postgres')
  begin
    q = "DELETE FROM #{table_name} WHERE #{key} = '#{val}'"
    con.exec q
  rescue => err
    puts err.message.madenta
  end

  begin
      if table_name == 'otbor'
          q = "INSERT INTO otbor VALUES($1, $2)"
        elsif table_name == 'departments'
          q = "INSERT INTO departments VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)"
        elsif table_name == 'terminals'
          q = "INSERT INTO terminals VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22)"
        end
        vec = good_vec vec
        con.exec_params(q, vec)
        puts q.green
  rescue PG::Error => e
      puts e.message
  ensure
      con.close if con
  end
end

def insert_one_otbor vec
  insert_record 'otbor' , 'term', vec[0], vec
end

def insert_one_dep vec
  insert_record 'departments' , 'department', vec[0], vec
end

def insert_one_term vec
  insert_record 'terminals' , 'termial', vec[1], vec
end

def delete_record table_name, key, val
  con = PG::Connection.new(:host => 'localhost', :user => 'postgres', :dbname => 'postgres', :port => '5432', :password => 'postgres')
  begin
    q = "DELETE FROM #{table_name} WHERE #{key} = '#{val}'"
    con.exec q
  rescue => err
    puts err.message.madenta
  ensure
    con.close if con
  end
end

end

include Pg

a = ['10101101', '1010110']
insert_one_otbor a
show_otbor
