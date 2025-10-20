@echo off
SETLOCAL

flutter clean | flutter pub get | flutter build apk

echo APK gerada com sucesso
ENDLOCAL
