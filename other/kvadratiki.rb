require_relative 'papa'
require_relative 'modules'

class Kvadratiki < Papa
	include Modules

	def kvadratikiProcess
		@fOutName = 'OutKvadratiki.csv'

		a = @arrOne
		a.each do |aa|
			aa.each do |x|
				if x == ""
					x = " "
				end
			end
		end

		hor_size_a = a[0].size
		header = ""
		mmax = [7, 8, 5, 1, 36, 1, 35, 1, 1, 1, 28, 32, 7, 1, 27, 1, 1, 1, 7, 10, 6]
		head = []
		count_word = -1
		content = []
		a[0].each do |word|
			content_line = []
    	count_word += 1
    	#1.upto(mmax[count_word] + 1) do |i|
    	1.upto(mmax[count_word]) do |i|
    		name_col = word + i.to_s
        head.append(name_col)
        content_line.append("")

    	end
		end

		b = a[1..-1]
		outline = head.join(";") + "\n"
		lines = head

		b.each do |b_line|
			start = 0
    	count_leter = -1
    	line = []
    	count_word = -1

    	b_line.each do |word|
    		count_word += 1
        start += mmax[count_word]
        word.each_char do |leter|
    			begin
    				leter = leter.upcase
    				#puts leter
    			rescue
    				#puts " #{leter} Not a Leter"
    			end

    			count_leter += 1
          line.append(leter)
    		end

    		if line.size < start
    			0.upto((start - line.size) -1) do |n|
    				line << " "
    			end
    		end

    		count_leter = line.size
    	end
    	outline += line.join(";") + "\n"
    	lines.append(line)
    	#puts line
		end

		@outText = outline
		myOut
	end

end

x = Kvadratiki.new('kvadratiki.csv')
x.kvadratikiProcess
