ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'dalli'

require './tem_cafe'

class TemCafeTest < Minitest::Test

  include Rack::Test::Methods

  def setup
    TemCafe.settings.token = 'my_token'
  end

  def teardown
    TemCafe.settings.token = nil
  end

  def app
    TemCafe
  end

  def test_nao_permite_acesso_sem_token_configurado
    TemCafe.settings.token = nil

    post '/', channel_id: "channel-id", text: "tem"
    assert last_response.status == 401
  end

  def test_nao_permite_acesso_com_token_errado
    TemCafe.settings.token = 'my_token'

    post '/', channel_id: "channel-id", text: "tem", token: "errado"
    assert last_response.status == 401
  end

  def test_permite_acesso_com_token_correto_e_retorna_corretamente
    post '/', channel_id: "channel-id", text: "tem", token: "my_token"

    assert last_response.status == 200
    response = JSON.parse(last_response.body)
    assert_equal 'in_channel', response['response_type']
    refute response['text'].nil?
  end

  def test_integracao
    post '/', channel_id: "channel-id", text: "fiz", token: "my_token"
    response = JSON.parse(last_response.body)

    assert_equal 'Opa, café tá pronto!', response['text']

    post '/', channel_id: "channel-id", text: "tem?", token: "my_token"
    response = JSON.parse(last_response.body)

    assert_match /\ATem :\)/, response['text']
  end

  def test_nao_permite_metodos_fora_da_whitelist
    post '/', channel_id: "channel-id", text: "object_id", token: "my_token"
    assert last_response.status == 500
  end
end
