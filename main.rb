# General Assembly 
# Backend Web Development Course
# Kevin Liu 2014 Production
# Midterm Assignment: Twitter API

###############################################################################

# Introduction to project:
# 	- Using the Twitter API (twitter API 1.1), a user would be able to input their 
# 	  twitter user handle and manipulate it in two ways;
# 	  - (1) Access a twitter stream of the last 10 tweets 
# 	  - (2) Tweet from the terminal 

###############################################################################

require 'rubygems'
require 'oauth'
require 'json'

require_relative 'user'
# require 'pry'

# The consumer key identifies the application making the request.
# The access token identifies the user making the request.

# Key generated via api.twitter: The consumer key identifies the application making the request 
# and the access token identifies the user making the request.

# For this particular terminal app, all the Keys belong to the twitter account @ckevinliu 

# consumer_key = 'enI7iHxgUJeBxyyqq0cNl0SzV'
# consumer_secret = 'ZIH8iUzd2iFMoMlQB5hsBHPg26MjS26EaUUlPcRrRpzW5xv2sY'
# token = '317978047-WXZwlXoCEwtl3FsPfTibcRyRAHxuOUOXdi4OLfEz'
# token_secret = 'krzFliZDWiA71IqROMXZJg5ulCp86Twl4Xs3r8htEx49l'

consumer_key = OAuth::Consumer.new(
	"enI7iHxgUJeBxyyqq0cNl0SzV","ZIH8iUzd2iFMoMlQB5hsBHPg26MjS26EaUUlPcRrRpzW5xv2sY")
access_token = OAuth::Token.new(
	"317978047-WXZwlXoCEwtl3FsPfTibcRyRAHxuOUOXdi4OLfEz","krzFliZDWiA71IqROMXZJg5ulCp86Twl4Xs3r8htEx49l")

# puts "please enter screen name"
# screen = gets.chomp
# screen = screen_name

# After getting all the keys and authentications, we will now fetch a public twitter stream from
# /1.1/statuses/user_timeline.json and return the list of public Tweets from the specified account
puts
puts "******* Welcome to Twitter on Terminal! *******"
puts "This simple terminal app will let you input a twitter user handle fetch the last 10 tweets"
puts "from that account. This is a Kevin Liu 2014 Production."
puts
puts "Please enter your twitter handle (without the @): "
user_input = gets.chomp
puts

base = "https://api.twitter.com"
path    = "/1.1/statuses/user_timeline.json"
query   = URI.encode_www_form("screen_name" => "#{user_input}", "count" => 10,)
address = URI("#{base}#{path}?#{query}")
request = Net::HTTP::Get.new address.request_uri

# Print data about a list of Tweets. To do this, we use a small little if statement. 
#This will loop till we reach 10 tweets.

def print_timeline(tweets)
        tweets.each do |tweet|
        count = 0
        if count < 10
            puts tweet["text"]
            puts
            count += 1
        end
    end
end

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
# Standard response for successful HTTP requests. Definition below from Wikipedia:
# The actual response will depend on the request method used. 
# In a GET request, the response will contain an entity corresponding to the requested resource. 
# In a POST request the response will contain an entity describing or containing the 
# result of the action.

tweets = nil
if response.code == '200' then
  tweets = JSON.parse(response.body)
  print_timeline(tweets) 
end
nil
