
class QMA_Term
	@array
	@number
	@uses
	@x_locs
	@@letter_hash = {0 => "a", 1 => "b", 2 => "c", 3 => "d"}

	# length = number of variables, number = the number, x_locs = the positions in the bitstring that don't matter
	def initialize(length, number, x_locs = [])
		@number = number

		@array = []
		(length - 1).downto (0) do |x|
			if (number - (2 ** x) >= 0)
				number -= (2 ** x)
				@array << 1
			else
				@array << 0
			end
		end

		x_locs.each do |x|
			@array[x] = 2
		end

		@uses = 0

		@x_locs = x_locs
	end

	# get the array
	def get_array
		@array
	end

	# see if the term and term differ by only one boolean
	def usable (term)
		differences = []
		@array.length.times do |x|
			if (@array[x] != term[x])
				differnces << x
			end
		end
		if differences.length > 1
			nil
		else
			uses += 1
			Term.new(@array.length, @number, differences + @x_locs)
		end
	end

	# get the index of the term
	def index
		i = 0
		@array.each do |x|
			if x == 1
				i += 1
			end
		end
	end

	# output the logical expression
	def print_logic
		out = ""
		@array.length.times do |x|
			case @array[x]
			when 0
				out << @@letter_hash[x].downcase
			when 1
				out << @@letter_hash[x].upcase
			end
		end
		out
	end

end

t = QMA_Term.new(3, 6, [0])

puts t.get_array

puts t.print_logic
