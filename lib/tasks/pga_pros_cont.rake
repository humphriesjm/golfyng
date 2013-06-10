desc "PGA Pro Rake Continued"
task :fetch_cont => :environment do
  require 'nokogiri'
  require 'open-uri'

  	# Pro.destroy_all
	url = "http://www.pga.com/golf-instruction/instructors/"
	doc = Nokogiri::HTML(open(url))
	# country level
	# doc.css("#content-area a").each do |item|
	# doc.css('li:nth-child(22) , .last .last a, .last li:nth-child(24) a, .last li:nth-child(23) a, .last li:nth-child(22) a, .last li:nth-child(21) a, .last li:nth-child(19) a, .last li:nth-child(20) a, .last li:nth-child(18) a, .last li:nth-child(17) a, .last li:nth-child(16) a').each do |item|

		# url2 = item['href']
		state_urls = []
		# state_urls << "http://www.pga.com/golf-instruction/instructors/al"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ak"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/az"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ar"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ca"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/co"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ct"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/de"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/fl"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ga"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/hi"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/id"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/il"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/in"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ia"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ks"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ky"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/la"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/me"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/md"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ma"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/mi"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/mn"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ms"
		state_urls << "http://www.pga.com/golf-instruction/instructors/mo"
		state_urls << "http://www.pga.com/golf-instruction/instructors/mt"
		state_urls << "http://www.pga.com/golf-instruction/instructors/ne"
		state_urls << "http://www.pga.com/golf-instruction/instructors/nv"
		state_urls << "http://www.pga.com/golf-instruction/instructors/nh"
		state_urls << "http://www.pga.com/golf-instruction/instructors/nj"
		state_urls << "http://www.pga.com/golf-instruction/instructors/nm"
		state_urls << "http://www.pga.com/golf-instruction/instructors/ny"
		state_urls << "http://www.pga.com/golf-instruction/instructors/nc"
		state_urls << "http://www.pga.com/golf-instruction/instructors/nd"
		state_urls << "http://www.pga.com/golf-instruction/instructors/oh"
		state_urls << "http://www.pga.com/golf-instruction/instructors/ok"
		state_urls << "http://www.pga.com/golf-instruction/instructors/or"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/pa"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/pr"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ri"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/sc"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/sd"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/tn"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/tx"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/ut"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/vt"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/va"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/wa"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/wv"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/wi"
		# state_urls << "http://www.pga.com/golf-instruction/instructors/wy"
		state_urls.each do |state_url|
			doc2 = Nokogiri::HTML(open(state_url))
			# state level
			doc2.css("#content-area a").each do |item2|
				url3 = item2['href']
				doc3 = Nokogiri::HTML(open("http://www.pga.com#{url3}"))
				# page of pros - region level
				doc3.css(".views-row").each do |item3|
					doc4 = Nokogiri::HTML(item3.text)
					if !item3.at_css(".imagecache-pgapro_medium").nil?
						url4 = item3.at_css(".imagecache-pgapro_medium")['href']
						if !url4.include? 'http'
							url4 = "http://www.pga.com" << url4
						end
						doc5 = Nokogiri::HTML(open(url4))
						# single pro page
						name = ""
						if !doc5.at_css('.title').nil?
							name = doc5.at_css('.title').text
						end
						phone = ""
						if !doc5.at_css('.contact-field').nil?
							phone = doc5.at_css('.contact-field').text
						end
						if phone.include? 'Phone'
							phone = phone[5,phone.length]
						end
						course_address = ""
						course_street = ""
						if !doc5.at_css('.pga-professional-course:nth-child(3)').nil?
							course_address = doc5.at_css('.pga-professional-course:nth-child(3)')
							# get zip
							# regex_zip = /(\d{5}+)(?!.*\d{5})/
							# m = regex_zip.match pro.course_address
							# pro.course_zip = ""
							# if !m.nil?
							# 	puts m[0][0..4]
							# 	pro.course_zip = m[0]
							# end
							course_address.search('br').each do |n|
	  							n.replace(" | ")
							end
							course_address = course_address.text
							course = course_address.split(' | ')
							course_street = course[1]
							course_city = course[2]
							course_address = "#{course_street} #{course_city}"
							# puts "->course:#{course_street} #{course_city}"
							# puts "course street:#{course[1]}"
							# puts "course city:#{course[2]}"
							# puts "course phone:#{course[3]}"
						end
						course_name = ""
						if !doc5.at_css('.field-field-course-name:nth-child(1) a').nil?
							course_name = doc5.at_css('.field-field-course-name:nth-child(1) a').text
						end
						description = ""
						if !doc5.at_css('.field-wrap').nil?
							description = doc5.at_css('.field-wrap').text
						end
						image = ""
						if !doc5.at_css('.imagecache').nil?
							image = doc5.at_css('.imagecache')['src']
						puts "Name: #{name}"
						# puts "Description: #{description}"
						# puts "Course Name: #{course_name}"
						puts "Address: #{course_address}"
						# puts "Phone: #{phone}"
						# puts "Image: #{image}"
						puts "---------------------"
						p = Pro.new
						p.name = name
						p.description = description
						p.course_name = course_name
						p.course_address = course_address
						p.address = course_address
						p.course_street = course_street
						p.phone = phone
						p.image_url = image
						p.save
					end
				end
			end
		end
	# end
end
end

