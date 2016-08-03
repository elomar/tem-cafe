require 'minitest/autorun'
require './cafe'

class CafeTest < Minitest::Test
  def setup
    @cafe = Cafe.new
  end

  def test_quando_fizer_ta_pronto
    time = nil

    Time.stub :now, Time.at(0) do 
      time = Time.now.strftime("%H:%M")
      respostas = [
        "Opa, café tá fazendo!",
        "papai gosta, papai"
      ]

      assert respostas.include? @cafe.handle(:fiz)
    end

    assert @cafe.handle(:tem).include? time
    assert @cafe.handle(:tem?).include? time
  end

  def test_quando_fiz_ta_fazendo
    respostas = [
      "Opa, café tá fazendo!",
      "papai gosta, papai"
    ]

    assert respostas.include? @cafe.handle(:fiz)
    assert_equal "Fazendo...", @cafe.handle(:tem)
  end

  def test_quando_cabou_nao_tem
    time = Time.now.strftime("%H:%M")

    assert_equal "Ih, cabou café :(", @cafe.handle(:cabou)
    assert_equal "Ih, cabou café :(", @cafe.handle(:cabo)
    assert @cafe.handle(:tem).include? time
  end

  def test_quando_nao_sabe_nao_sabe
    assert_equal "Ixi, nem sei. Veja e me diga", @cafe.handle(:tem)
  end

  def test_comofaz
    receita = <<-RECEITA
Pra um cafézinho forte estilo huebr, 1 colher bem cheia pra cada 3 xícaras.
Pra um café mais fraco estilo 'murica, 1 colher bem cheia pra cada 5 xícaras.
Se vai botar açucar então foda-se faz aí de qualquer jeito mesmo.
    RECEITA

    assert_equal receita, @cafe.handle(:comofaz)
  end

  def test_🖕
    # sim, tô ligado que isso não é como se testa algo random
    xingamentos = [
      "é o teu",
      "sai daí porra",
      "vai tu",
      "__|__",
      "👉👌"
    ]
    assert xingamentos.include? @cafe.handle("🖕")
    assert xingamentos.include? @cafe.handle(":middle_finger:")
  end

  def test_whitelist
    assert_raises(ArgumentError) { @cafe.handle('object_id') }
  end
end
