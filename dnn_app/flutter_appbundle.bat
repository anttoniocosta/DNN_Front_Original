@echo off
SETLOCAL

flutter clean | flutter pub get | flutter build appbundle

echo APK gerada com sucesso
ENDLOCAL
