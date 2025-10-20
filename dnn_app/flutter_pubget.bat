@echo off
SETLOCAL

:: Salva o diretório atual para voltar a ele depois
for /f %%i in ("%CD%") do set "current_dir=%%i"

:: Executa o comando fvm global 3.10.2
::fvm global 3.10.2

:: Defina a variável "project_dirs" com os diretórios dos seus projetos, separados por ponto e vírgula
set "project_dirs=../dnn_dependencies;../dnn_core;../dnn_shared;../dnn_app;."

:: Percorre os diretórios de projetos e executa "flutter pub get"
for %%G in (%project_dirs%) do (
  echo Atualizando projeto: %%G
  cd /D "%current_dir%\%%G" && flutter clean && flutter pub get
)

:: Retorna ao diretório original (dnn_app)
cd /D "%current_dir%"

echo Todos os projetos foram atualizados com sucesso.
ENDLOCAL
