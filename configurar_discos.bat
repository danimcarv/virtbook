@echo off
title Rclone Config
setlocal

echo ==========================================
echo    CONFIGURACAO DOS DISCOS ADICIONAIS
echo ==========================================

echo Eh altamente recomendado que voce crie uma nova conta no Mega, e outra no Google Drive (segunda conta caso ja possua), para usar como discos adicionais.
echo Caso ja tenha criado, seguiremos com a configuracao.

:PERGUNTAMEGA
echo.
set /p "confirmarmega=Deseja seguir com a configuracao do Mega? Digite S para Sim, ou N para Nao:  "

if /i "%confirmarmega%"=="S" goto SEGUIRMEGA
if /i "%confirmarmega%"=="N" goto IGNORARMEGA

echo.
echo Opção inválida! Digite apenas S para Sim ou N para Não.
echo.
goto PERGUNTAMEGA

:SEGUIRMEGA
cls
echo ==========================================
echo    CONFIGURACAO DO MEGA
echo ==========================================

set /p user_mega="Digite seu e-mail do MEGA: "
set /p pass_mega="Digite sua senha do MEGA: "
echo.

echo Criando disco do Mega...
C:\rclone\rclone.exe config create mega mega user "%user_mega%" pass "%pass_mega%" hard_delete true -qq 2>nul

echo Montando MEGA no disco M:...

echo CreateObject("Wscript.Shell").Run "C:\rclone\rclone_mount_mega.bat", 0, False > "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\invisible_mega.vbs"
echo @echo off > "C:\rclone\rclone_mount_mega.bat"
echo start /b C:\rclone\rclone.exe mount mega: M: --vfs-cache-mode full --vfs-cache-max-size 10G --vfs-cache-max-age 1h --vfs-cache-poll-interval 1m --links >> "C:\rclone\rclone_mount_mega.bat"
"%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\invisible_mega.vbs"

goto PERGUNTAGDRIVE

:IGNORARMEGA
echo Mega ignorado. Caso queira configurar no futuro, clicar em configurar_discos na Area de Trabalho.
echo.

pause
goto PERGUNTAGDRIVE


:PERGUNTAGDRIVE
cls

echo.
set /p "confirmargdrive=Deseja seguir com a configuracao do Google Drive? Digite S para Sim, ou N para Nao:  "

if /i "%confirmargdrive%"=="S" goto SEGUIRGDRIVE
if /i "%confirmargdrive%"=="N" goto IGNORARGDRIVE

echo.
echo Opção inválida! Digite apenas S para Sim ou N para Não.
echo.
goto PERGUNTAGDRIVE

:SEGUIRGDRIVE
cls

echo ==========================================
echo    CONFIGURACAO DO GOOGLE DRIVE
echo ==========================================
echo Uma janela de navegador sera aberta para login.
pause

C:\rclone\rclone.exe config create gdrive drive scope drive auth_owner_only true use_trash false acknowledge_abuse true -qq 2>nul

echo Montando Google Drive no disco G:...

echo CreateObject("Wscript.Shell").Run "C:\rclone\rclone_mount_gdrive.bat", 0, False > "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\invisible_gdrive.vbs"
echo @echo off > "C:\rclone\rclone_mount_gdrive.bat"
echo start /b C:\rclone\rclone.exe mount gdrive: G: --vfs-cache-mode full --vfs-cache-max-size 10G --vfs-cache-max-age 1h --vfs-cache-poll-interval 1m --links >> "C:\rclone\rclone_mount_gdrive.bat"
"%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\invisible_gdrive.vbs"

echo.
cls
echo ==========================================
echo Configuracoes concluidas com sucesso. Verifique o "Meu Computador".
echo ==========================================
echo.
echo Priorize o uso desses discos para armazenar arquivos, documentos, downloads, trabalhos e projetos.
echo Para instalacao de programas, use o disco C: .
echo.

pause
exit

:IGNORARGDRIVE
echo Google Drive ignorado. Caso queira configurar no futuro, clicar em configurar_discos na Area de Trabalho.
echo.

pause
exit