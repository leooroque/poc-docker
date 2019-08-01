# Informa qual a imagem que vamos utilizar e qual a versão respectivamente
FROM node:8-alpine

# Informar qual  será o diretório de trabalho, nesse cenário será criado o  /app
WORKDIR /app

# Copia o conteúdo do diretório ./app para a pasta /app
COPY ./app/ /app


# Instala as dependencia do nosso aplicativo
RUN  npm install

# Informa qual a porta que será disponibilizada.
EXPOSE 3000

# Rodar o comando em questão quando o container estiver criado
CMD ["node", "main.js"]