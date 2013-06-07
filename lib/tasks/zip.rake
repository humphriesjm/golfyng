desc "PGA Pro Zip Rake"
task :zip_rake => :environment do
	Pro.all.each do |pro|
		if !pro.course_address.empty?
			# regex_zip = /\d{5}/
			regex_zip = /(\d{5}+)(?!.*\d{5})/
			m = regex_zip.match pro.course_address
			pro.course_zip = ''
			if !m.nil?
				puts m[0]
				pro.course_zip = m[0]
			end
			pro.save
		end
	end
end

