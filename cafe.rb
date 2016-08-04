class Cafe
  DEMORA_MAIS_OU_MENOS = 4
  QUATRO_HORAS = 3_600 * 4

  def fiz
    @cabou_em = nil
    @feito_em = Time.now

    [
      "Opa, café tá fazendo!",
      "papai gosta, papai"
    ].sample
  end

  def tem?; tem; end
  def tem
    if @feito_em && !feito_hoje?
      cabou
      "Não, já era boy :( Alguém tem que fazer o de hoje"
    elsif @feito_em && fazendo?
      "Fazendo..."
    elsif @feito_em && !velho?
      "Tem :) Feito as #{@feito_em.strftime("%H:%M")}"
    elsif @feito_em && velho?
      "Tem mas tá velho, feito em #{@feito_em.strftime("%H:%M")} :( Vai lá e faz teu nome"
    elsif @cabou_em
      "Não :( Cabou as #{@cabou_em.strftime("%H:%M")}"
    else
      "Ixi, nem sei. Veja e me diga"
    end
  end

  private def feito_hoje?
    Time.now.to_a.slice(4, 3) == @feito_em.to_a.slice(4, 3)
  end

  private def velho?
    (Time.now - @feito_em) >= QUATRO_HORAS
  end

  def cabou; cabo; end
  def cabo
    @feito_em = nil
    @cabou_em = Time.now

    "Ih, cabou café :("
  end

  def caboquejo
    ["CARACA :O", "alguém levou pra casa só pode"].sample
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

  private

  def feito_a_quanto_tempo
    ((Time.now - @feito_em) / 60).to_i
  end

  def fazendo?
    feito_a_quanto_tempo < DEMORA_MAIS_OU_MENOS
  end
end
