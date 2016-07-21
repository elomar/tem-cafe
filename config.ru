require 'sinatra'
require 'dalli'
require 'json'
require './cafe'

set :cache, Dalli::Client.new(ENV["MEMCACHIER_SERVERS"],
                  {:username => ENV["MEMCACHIER_USERNAME"],
                   :password => ENV["MEMCACHIER_PASSWORD"]})

set :token, 'hYbvkWsx1UOj2mx7HoOApCks'
set :show_exceptions, false

before do
  halt 401, "Opa, também não é assim" unless params['token'] == settings.token
end

error do
  halt 500, "Ih, deu ruim"
end

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

