# dnn_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Dentro da pasta android criar o arquivo key.properties e colocar o conteudo abaixo

storePassword=Celular3260
keyPassword=Celular3260
keyAlias=key_dnn_app
storeFile= ../../keystore/key_dnn_app.jks

keytool -genkey -v -keystore D:\Projetos\DNN\DnnAppFlutter\dnn_app_company\keystore\key_dnn_app_company.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key_dnn_app_company

keytool -genkey -v -keystore D:\Projetos\DNN\DnnAppFlutter\dnn_app_seller\keystore\key_dnn_app_seller.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key_dnn_app_seller

precisa instalar o firebase tools:

npm install -g firebase-tools


rodar o flutterfire cli:

firebase login

dart pub global activate flutterfire_cli
dart pub global activate flutterfire_cli


e dentro do projeto:
flutterfire configure


echo 'export PATH="$PATH:/caminho/para/flutter/bin"' >> ~/.zshrc
echo 'export PATH="$PATH:/caminho/para/flutter/bin/cache/dart-sdk/bin"' >> ~/.zshrc
source ~/.zshrc
