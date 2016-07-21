class Cafe
  def handle(action)
    send(action)
  end

  def fiz
    @cabou_em = nil
    @feito_em = Time.now

    "Opa, café tá pronto!"
  end

  def tem?; tem; end
  def tem
    if @feito_em
      "Tem :) Feito as #{@feito_em.strftime("%H:%m")}"
    elsif @cabou_em
      "Não :( Cabou as #{@cabou_em.strftime("%H:%m")}"
    else
      "Ixi, nem sei. Veja e me diga"
    end
  end

  def cabou; cabo; end
  def cabo
    @feito_em = nil
    @cabou_em = Time.now

    "Ih, cabou café :("
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
