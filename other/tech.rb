require 'io/console'

loop do
	say = STDIN.noecho(&:gets).chomp
	break if say == 'az'
end