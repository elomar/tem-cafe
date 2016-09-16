require 'minitest/autorun'
require 'timecop'
require './cafe'

class CafeTest < Minitest::Test
  def setup
    @cafe = Cafe.new
  end

  def test_quando_fiz_ta_fazendo_e_demora_4_minutos
    agora = Time.now

    Timecop.freeze agora do
      respostas = [
        "Opa, café tá fazendo!",
        "papai gosta, papai"
      ]

      assert respostas.include? @cafe.fiz
    end

    tres_minutos_no_futuro = agora + (3 * 60)

    Timecop.freeze tres_minutos_no_futuro do
      assert_equal "Fazendo...", @cafe.tem
    end
  end

  def test_quando_fiz_ta_pronto_depois_de_4_minutos
    agora = Time.now

    Timecop.freeze(agora) { @cafe.fiz }

    quatro_minutos_no_futuro = agora + (4 * 60)

    Timecop.freeze quatro_minutos_no_futuro do
      assert @cafe.tem.include? agora.strftime('%H:%M')
      assert @cafe.tem?.include? agora.strftime('%H:%M')
    end
  end

  def test_quando_fiz_tem_se_for_no_mesmo_dia
    agora = Time.new(2016, 8, 1)

    Timecop.freeze(agora) { @cafe.fiz }

    fim_do_dia = Time.new(2016, 8, 1, 3, 59, 59)

    Timecop.freeze fim_do_dia do
      assert @cafe.tem.include? agora.strftime('%H:%M')
      assert @cafe.tem?.include? agora.strftime('%H:%M')
      refute_includes(@cafe.tem?, 'velho')
    end
  end

  def test_tem_mas_ta_velho_depois_de_4_horas
    agora = Time.new(2016, 8, 1)

    Timecop.freeze(agora) { @cafe.fiz }

    quatro_horas_depois = Time.new(2016, 8, 1, 4, 1, 0)

    Timecop.freeze quatro_horas_depois do
      assert_includes(@cafe.tem?, 'velho')
    end
  end

  def test_quando_cabou_nao_tem
    time = Time.now.strftime("%H:%M")

    assert_equal "Ih, cabou café :(", @cafe.cabou
    assert_equal "Ih, cabou café :(", @cafe.cabo
    assert @cafe.tem.include? time
  end

  def test_quando_fez_ontem_nao_tem
    ontem = Time.new(2016, 8, 1)

    Timecop.freeze(ontem) { @cafe.fiz }

    hoje = Time.new(2016, 8, 2)

    Timecop.freeze hoje do
      assert_match(/Não :\(/, @cafe.tem?)
    end
  end

  def test_quando_cabou_ontem_alguem_tem_que_fazer_o_de_hoje
    ontem = Time.new(2016, 9, 9)

    Timecop.freeze(ontem) do
      @cafe.fiz
      @cafe.cabou
    end

    hoje = Time.new(2016, 9, 10)

    Timecop.freeze hoje do
      assert_match(/Não :\(/, @cafe.tem?)
    end
  end

  def test_quando_fez_mes_passado_no_mesmo_dia_nao_tem
    mes_passado = Time.new(2016, 7, 1)

    Timecop.freeze(mes_passado) { @cafe.fiz }

    esse_mes_no_mesmo_dia = Time.new(2016, 8, 1)

    Timecop.freeze esse_mes_no_mesmo_dia do
      assert_match(/Não :\(/, @cafe.tem?)
    end
  end

  def test_quando_fez_ano_passado_no_mesmo_mes_e_dia_nao_tem
    ano_passado = Time.new(2015, 8, 1)

    Timecop.freeze(ano_passado) { @cafe.fiz }

    esse_ano_no_mesmo_dia_e_mes = Time.new(2016, 8, 1)

    Timecop.freeze esse_ano_no_mesmo_dia_e_mes do
      assert_match(/Não :\(/, @cafe.tem?)
    end
  end

  def test_quando_nao_sabe_nao_sabe
    assert_equal "Ixi, nem sei. Veja e me diga", @cafe.tem
  end

  def test_comofaz
    receita = <<-RECEITA
Pra um cafézinho forte estilo huebr, 1 colher bem cheia pra cada 3 xícaras.
Pra um café mais fraco estilo 'murica, 1 colher bem cheia pra cada 5 xícaras.
Se vai botar açucar então foda-se faz aí de qualquer jeito mesmo.
    RECEITA

    assert_equal receita, @cafe.comofaz
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
    assert xingamentos.include? @cafe.public_send("🖕")
    assert xingamentos.include? @cafe.public_send(":middle_finger:")
  end
end
