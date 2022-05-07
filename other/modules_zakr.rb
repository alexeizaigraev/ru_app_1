module Modules_zakr

#INDATA_PATH = 'data/indata/'
#OUTDATA_PATH = 'data/outdata/'

HOR_LINE_SIZE = 40

def testmodule(fname)
	"QQ"
end

def file_to_hash(fname)
	h = Hash.new
	f = File.open(fname, 'rt')
	f.each do |line|
		line = line.chomp!.split(';')
		key = line[0]
		h[key] = line
	end
	h
end

def file_to_arr(fname)
	arr = []
	f = File.open(fname, 'rt')
	f.each do |line|
		line = line.chomp!.split(';') if line.include?( ";" )
		arr << line
	end
	arr
end

def file_to_vec(fname)
	arr = []
	f = File.open(fname, 'rt')
	f.each do |line|
		arr << line.chomp
	end
	arr
end

def text_to_file(fname, mytext)

	f = File.open(fname, 'wt')
	f.write mytext
	f.close

	puts "Ok. -> #{fname}"
end

end
