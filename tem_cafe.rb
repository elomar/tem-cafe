require 'sinatra/base'
require 'dalli'
require 'json'
require_relative 'cafe'
require_relative 'cafe_dispatcher'
require_relative 'command_parser'

class TemCafe < Sinatra::Base
  COMMAND_PARSER = CommandParser.new(
    whitelist: %i(fiz tem? tem cabou cabo comofaz :middle_finger: 🖕)
  )

  set :cache, Dalli::Client.new(ENV["MEMCACHIER_SERVERS"],
                    {:username => ENV["MEMCACHIER_USERNAME"],
                     :password => ENV["MEMCACHIER_PASSWORD"]})

  set :token, ENV["SLACK_TOKEN"]
  set :show_exceptions, false

  before do
    token = settings.token
    halt 401, "Opa, também não é assim" if !token || params['token'] != settings.token
  end

  error CafeDispatcher::ActionNotFound do
    halt 500, "Ih, deu ruim"
  end

  post '/' do
    @cafe = settings.cache.get(params['channel_id']) || Cafe.new
    dispatcher = CafeDispatcher.new(@cafe, command_parser: COMMAND_PARSER)
    response = dispatcher.call(params['text'])

    settings.cache.set(params['channel_id'], @cafe)

    content_type "application/json"

    { "response_type": "in_channel", "text": response }.to_json
  end
end
