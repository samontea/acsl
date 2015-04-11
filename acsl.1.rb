def get_distance (a, b)
	ll_distance = 0
	so_far = 0

	distances = {"ab"=>450,"bc"=>140,"cd"=>125, "de"=> 365, "ef"=>250, "fg"=>160, "gh"=>380, "hj"=>235,"jk"=>320}

	distances.each do |k, x|
		ll_distance += x;

		if(k[0] == a.downcase)
			ll_distance = ll_distance - so_far
		end

		so_far += x

		if(k[1] == b.downcase)
			break
		end
	end
	ll_distance
end

#get dat input
input = Array.new(5)

5.times do |x|
	input[x] = gets.chomp.split(/,/);
end

input.each do |x|
	#even out the times
	a_time = x[2].to_i
	b_time = x[4].to_i
	ttl_distance = get_distance(x[0], x[1])
	a_speed = x[6].to_i
	b_speed = x[7].to_i

	#correct for stupid am pm
	if (x[3] == "PM" || x[3] == "pm")
		a_time += 12
	end
	if (x[5] == "PM" || x[5] == "pm")
		b_time += 12
	end

	#evening out times
	if (a_time > b_time)
		total_time = (a_time - b_time).to_f
		ttl_distance = ttl_distance - (total_time * b_speed)
		if (ttl_distance < 0)
			ttl_distance = get_distance(x[0], x[1])
			total_time = ttl_distance / b_speed
			ttl_distance = 0
		end
	elsif (a_time < b_time)
		total_time = (b_time - a_time).to_f
		ttl_distance = ttl_distance - (total_time * a_speed)
		if (ttl_distance < 0)
			ttl_distance = get_distance(x[0], x[1])
			total_time = ttl_distance / a_speed
			ttl_distance = 0
		end
	else
		total_time = 0.0
    end

	#calculate the times
	if (ttl_distance > 0)
		total_time = total_time + (ttl_distance.to_f / (a_speed + b_speed).to_f)
	end

	hours = total_time.to_i
	minutes = ((total_time - hours.to_f) * 60.0).round
	puts "#{hours}:#{minutes}"
end
