# Use uma imagem base de servidor nginx
FROM nginx:alpine

# Copie os arquivos compilados do Flutter Web para a pasta html do nginx
COPY build/web/ /usr/share/nginx/html

# Exponha a porta 80
EXPOSE 80

# Inicie o nginx
CMD ["nginx", "-g", "daemon off;"]
