class LinkedArray
	def initialize(previous_array, data)
		@previous_array = previous_array
		if data.is_a?(Array)
			@data = data
		else
			@data = []
			@data << data
		end
	end
	def to_s
		string = "("
		string << @data[0]
		@data[1..(@data.length - 1)].each do |x|
			if x.is_a?(LinkedArray)
				string << " " << x.to_s
			else
				string << " " << x
			end
		end
		string << ")"
	end
	def add_data(data)
		@data << data
	end
	def get_previous
		@previous_array
	end
	def get_array
		@data
	end
	def length
		@data.length
	end
	def count
		@data.length - 1
	end
	def maximum
		max = 0
		max_s = ""
		@data[1..(@data.length - 1)].each do |t|
			if t.length > max
				max_s = t.to_s
				max = t.length
			end
		end
		max_s
	end
	def remove(x, y)
		string = "("
		string << @data[0]
		@data[1...x].each do |t|
			if t.is_a?(LinkedArray)
				string << " " << t.to_s
			else
				string << " " << t
			end
		end
		@data[(y+1)..(@data.length - 1)].each do |t|
			if t.is_a?(LinkedArray)
				string << " " << t.to_s
			else
				string << " " << t
			end
		end
		string << ")"
	end
	def reverse(x, y)
		string = "("
		string << @data[0]
		@data[1...x].each do |t|
			if t.is_a?(LinkedArray)
				string << " " << t.to_s
			else
				string << " " << t
			end
		end
		@data[x..y].reverse.each do |t|
			if t.is_a?(LinkedArray)
				string << " " << t.to_s
			else
				string << " " << t
			end
		end
		@data[(y+1)..(@data.length - 1)].each do |t|
			if t.is_a?(LinkedArray)
				string << " " << t.to_s
			else
				string << " " << t
			end
		end
		string << ")"
	end
	def sort(x, y)
		string = "("
		string << @data[0]
		@data[1...x].each do |t|
			if t.is_a?(LinkedArray)
				string << " " << t.to_s
			else
				string << " " << t
			end
		end
		previous_heighest = ""
		heighest = ""
		biggest = nil
		(y - x + 1).times do
			i = 0
			loop do
				if (@data[x].get_array <=> previous_heighest) != -1
					previous_heighest = heighest
					heighest = @data[x + i].get_array[0]
					biggest = @data[x]
				end
				i += 1
				break if x + i >= y
				break unless (@data[x].get_array <=> previous_heighest) != -1
			end

			@data[x..y].each do |t|
				t.inspect
				if (t.get_array[0] <=> heighest) == 1
					heighest = t.get_array[0]
					biggest = t
				end
			end
			string << biggest.to_s
		end
		@data[(y+1)..(@data.length - 1)].each do |t|
			if t.is_a?(LinkedArray)
				string << " " << t.to_s
			else
				string << " " << t
			end
		end
		string << ")"
	end
end

puts "1."
lisps_s = gets.chomp
lisps_a = lisps_s.split
list = nil
lisps_a.each do |x|
	if  x[0] == "("
		list = LinkedArray.new(list, x.delete("("))
		if list.get_previous != nil
			list.get_previous.add_data(list)
		end
	elsif x[x.length - 1] == ")"
		list.add_data(x.delete(")"))
		i = 1
		while x[x.length - i] == ")"
			if list.get_previous != nil
				list = list.get_previous
			end
			i += 1
		end
	else
		list.add_data(x)
	end
end

puts list.to_s

5.times do |x|
	print (x + 2)
	puts "."
	s = gets.chomp
	if s[0..6] == "REVERSE"
		puts list.reverse((s.split)[1].to_i, (s.split)[2].to_i)
	elsif s[0..4] == "COUNT"
		puts list.count
	elsif s[0..5] == "REMOVE"
		puts list.remove((s.split)[1].to_i, (s.split)[2].to_i)
	elsif s[0..6] == "MAXIMUM"
		puts list.maximum
	elsif s[0..3] == "SORT"
		puts list.sort((s.split)[1].to_i, (s.split)[2].to_i)
	else
		puts "Sorry I can't do that kind sir. :("
	end

end
