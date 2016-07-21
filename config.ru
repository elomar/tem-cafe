require 'sinatra'
require 'dalli'
require 'json'
require './cafe'

set :cache, Dalli::Client.new(ENV["MEMCACHIER_SERVERS"],
                  {:username => ENV["MEMCACHIER_USERNAME"],
                   :password => ENV["MEMCACHIER_PASSWORD"]})

post '/' do
	@cafe = settings.cache.get(params['channel_id']) || Cafe.new
	response = @cafe.handle(params['text'])
	settings.cache.set(params['team_id'], @cafe)

  content_type "application/json"
	{
			"response_type": "in_channel",
			"text": response
	}.to_json
end

run Sinatra::Application

