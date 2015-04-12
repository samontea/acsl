
class QMA_Term
	@array
	@number
	attr_accessor :uses
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
			if (@array[x] != term.get_array[x])
				differences << x
			end
		end
		if differences.length > 1
			nil
		else
			@uses += 1
			term.uses += 1
			QMA_Term.new(@array.length, @number, differences + @x_locs)
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

		i
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

5.times do |x|
	puts ((x + 1).to_s + ".\n-----")
	input = gets.chomp.split(',')
	input = input.take(input.length - 1)

	length = (x <= 2) ? 3 : 4

	input.each_index do |x|
		input[x] = QMA_Term.new(length, input[x].to_i, [])
	end

	input.sort! do |x, y|
		x.index <=> y.index
	end

	simplified = []

	(length + 1).times do
		simplified << Array.new()
	end

	input.each do |x|
		simplified[x.index] << x
	end

	extended_simplified = []

	(length).times do
		extended_simplified << Array.new()
	end

	(simplified.length - 1).times do |x|
		simplified[x].each do |y|
			simplified[x + 1].each do |z|
				zz = y.usable(z)
				if (zz)
					extended_simplified[zz.index] << zz
				end
			end
		end
	end

	final = []

	(extended_simplified.length).times do |x|
		extended_simplified[x].each do |y|
			if (x < extended_simplified.length - 1)
				extended_simplified[x + 1].each do |z|
					zz = y.usable(z)
					if (zz)
						final << zz
					end
				end
			end
			if(y.uses == 0)
				final << y
			end
		end
	end

	final.uniq! do |x|
		x.print_logic
	end

	puts ((x + 1).to_s + ".\n-----")
	final.each_index do |x|
		if (x > 0)
			print (" + ")
		end
		print final[x].print_logic
	end
	print ("\n")
end
