@echo off
echo Script App for web


docker build -t doutornanet/app-web:latest -f Dockerfile .
docker login --username=doutornanet --password=Celular3260
docker push doutornanet/app-web:latest 
