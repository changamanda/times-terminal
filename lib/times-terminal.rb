require 'nokogiri'
require 'open-uri'

class Headlines

	attr_accessor :doc, :list

	def initialize
		@doc = Nokogiri::HTML(open("http://www.nytimes.com/pages/todayspaper/index.html"))
		@list = @doc.css("div.first h3 a")
	end

	def headlines
		@list.each_with_index { |story, i| puts "#{i+1}. #{story.text.strip}" }
	end

	def open_story(index)
		if index.to_i > 0 && index.to_i <= list.length
			link = list[index.to_i-1].attribute("href").value
			system "open #{link}"
		end
	end

	def call
		puts "TODAY'S NEW YORK TIMES HEADLINES"
		headlines
		puts "\nWould you like to open a story? (Enter index)"
		i = gets.strip
		open_story(i)
	end

end

Headlines.new.call