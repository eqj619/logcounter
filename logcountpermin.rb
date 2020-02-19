#
# logcountpermin <input> <pattern>
#


begin
	input = open(ARGV[0])
	log_filter = Regexp.new(ARGV[1])

	log_count = Hash.new(0)

	while log = input.gets
		# store time stamp in hask key if it is not exist
		ts = log.split(/[\s:]/)
		if ts[1].length == 1; ts[1] = "0" + ts[1]; end;
		if ts[0].length == 9; ts[0] = "0" + ts[0]; end;
		timestamp = ts[0] + " " + ts[1] + ":" + ts[2]

		if log_count.has_key?(timestamp) == false
			log_count.store(timestamp, 0)
		end

		# count pattern matched log
		if log_filter =~ log
			# p (log_filter =~ log)
			log_count[timestamp] += 1
		end
	end

	logreport = log_count.keys.sort

	logreport.each do |t|
		printf("%s, %d\n", t, log_count[t]) 
	end

rescue => ex
	print ex.message, "\n"
	print "usage: logcountpermin <input> <pattern>\n"
ensure
	input.close
end
