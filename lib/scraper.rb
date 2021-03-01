require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses")) #the page
    #binding.pry
    # doc.css(".post").each do |post| #each offering had a class of post, so we iterate on it
    #     course = Course.new #create instances
    #     course.title = post.css("h2").text # we analyzed each element of nokogiri's array
    #     course.schedule = post.css(".date").text
    #     course.description = post.css("p").text
    # end
    #### all the above was refactored into two other methods, get_courses and make_courses
  end
  
  def get_courses
    self.get_page.css(".post") #use each preceding function inside the new one
  end

  def make_courses
    self.get_courses.each do |post| #use each preceding function inside the new one
        course = Course.new #create instances
        course.title = post.css("h2").text # we analyzed each element of nokogiri's array
        course.schedule = post.css(".date").text
        course.description = post.css("p").text
    end
  end

end

Scraper.new.print_courses

