class Cafe

  #HTML entity codes for emojis
  HOT_BEVERAGE_CODE = 9749
  FEARFUL_FACE = 128552
  CRYING_FACE = 128546
  PERSON_WITH_FOLDED_HANDS = 128591

  def handle(action)
    send(action)
  end

  def emoji(n)
  	return [n].pack('U*')
  end

  def fiz
    @cabou_em = nil
    @feito_em = Time.now

    "Opa, café tá pronto! #{emoji(HOT_BEVERAGE_CODE)}"
  end

  def tem?; tem; end
  def tem
    if @feito_em
      "Tem :) Feito as #{@feito_em.strftime("%H:%M")} #{emoji(HOT_BEVERAGE_CODE)}"
    elsif @cabou_em
      "Não #{emoji(CRYING_FACE)} Cabou as #{@cabou_em.strftime("%H:%M")}"
    else
      "Ixi, nem sei. Veja e me diga #{emoji(PERSON_WITH_FOLDED_HANDS)}"
    end
  end

  def cabou; cabo; end
  def cabo
    @feito_em = nil
    @cabou_em = Time.now

    "Ih, cabou café #{emoji(CRYING_FACE)}"
  end

  def comofaz
    <<-RECEITA
Pra um cafézinho forte estilo huebr, 1 colher bem cheia pra cada 3 xícaras.
Pra um café mais fraco estilo 'murica, 1 colher bem cheia pra cada 5 xícaras.
Se vai botar açucar então foda-se faz aí de qualquer jeito mesmo.
    RECEITA
  end

  define_method(':middle_finger:') do 🖕 end
  def 🖕
    [
      "é o teu",
      "sai daí porra",
      "vai tu",
      "__|__",
      "👉👌"
    ].sample
  end
end
