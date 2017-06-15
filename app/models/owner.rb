class Owner

	def name
		name = 	'Benjamin Raspiel'
	end

	def birthdate
		birthdate = Date.new(1967, 1, 16)
	end

	def countdown
		today = Date.today
		birthday = Date.new(today.year, birthdate.month, birthdate.day)
		if birthday > today
			countdown = (birthday - today).to_i
		else
			countdown = (birthday.next_year - today).to_i
		end
	end

	def age
		today = Date.today
		currYear = today.year
		age = (currYear - birthdate.year).to_i
	end

end