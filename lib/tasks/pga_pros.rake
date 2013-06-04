desc "PGA Pro Rake"
task :fetch_pros => :environment do
  require 'nokogiri'
  require 'open-uri'
  
	url = "http://www.pga.com/golf-instruction/instructors/"
	doc = Nokogiri::HTML(open(url))
	# country level
	doc.css("#content-area a").each do |item|
		url2 = item['href']
		doc2 = Nokogiri::HTML(open("http://www.pga.com#{url2}"))
		# state level
		doc2.css("#content-area a").each do |item2|
			url3 = item2['href']
			doc3 = Nokogiri::HTML(open("http://www.pga.com#{url3}"))
			# page of pros - region level
			doc3.css(".views-row").each do |item3|
				doc4 = Nokogiri::HTML(item3.text)
				url4 = item3.at_css(".imagecache-pgapro_medium")['href']
				if !url4.include? 'http'
					url4 = "http://www.pga.com" << url4
				end
				doc5 = Nokogiri::HTML(open(url4))
				# single pro page
				name = doc5.at_css('.title').text
				phone = doc5.at_css('.contact-field').text
				if phone.include? 'Phone'
					phone = phone[5,phone.length]
				end
				course_address = doc5.at_css('.pga-professional-course:nth-child(3)').text
				course_name = doc5.at_css('.field-field-course-name:nth-child(1) a').text
				description = doc5.at_css('.field-wrap').text
				image = doc5.at_css('.imagecache')['src']
				puts "Name: #{name}"
				puts "Description: #{description}"
				puts "Course Name: #{course_name}"
				puts "Course Address: #{course_address}"
				puts "Phone: #{phone}"
				puts "Image: #{image}"
				puts "---------------------"
				p = Pro.new
				p.name = name
				p.description = description
				p.course_name = course_name
				p.course_address = course_address
				p.phone = phone
				p.image_url = image
				p.save
			end
		end
	end
end