# tem café?

bot pra slack que avisa se tem café.

## como usa?

no canal do teu escritório, manda

/cafe tem
pra saber se tem café

/cafe fiz
pra avisar que você fez café

/cafe cabou
pra avisar que acabou o café

## como instala?

1. faz deploy no heroku
2. instala addon memcachier
3. configura no [slack](http://my.slack.com/services/new/slash-commands)
4. configura variável SLACK_TOKEN pro token que o slack te teu
5. parte pro abraço

## como ajuda?

manda pr aí. tá faltando:

- testes
- ~~fazendo (ideia: diz 'fazendo' por x minutos depois do /cafe fiz)~~ valeu [@andrezacm](http://github.com/andrezacm)
- botão ~deploy no heroku~
- um deploy funcionar pra vários times
- dar um jeito no heroku botando pra dormir (acorda a cada hora durante expediente?)
- ~~um whitelist de métodos no lugar de send (/cafe object_id funciona)~~ valeu [@thiagoa](http://github.com/thiagoa) e [@iagomoreira](http://github.com/iagomoreira)
- e mais e mais coisa.
