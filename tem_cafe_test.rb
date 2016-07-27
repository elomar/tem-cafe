ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'dalli'

require './tem_cafe'

class TemCafeTest < Minitest::Test

  include Rack::Test::Methods

  def app
    TemCafe
  end

  def test_nao_permite_acesso_sem_token
    post '/', channel_id: "channel-id", text: "tem"
    assert last_response.status == 401
  end

  def test_permite_acesso_com_token_correto
    post '/', channel_id: "channel-id", text: "tem", token: ENV["SLACK_TOKEN"]
    assert last_response.status == 200
  end

  def test_nao_permite_metodos_fora_da_whitelist
    post '/', channel_id: "channel-id", text: "object_id", token: ENV["SLACK_TOKEN"]
    assert last_response.status == 500
  end
end
