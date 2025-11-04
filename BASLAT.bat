@echo off
cls
echo ================================
echo   MAYA KATALOG
echo   Yeni PC Kurulum
echo ================================
echo.
echo Bu dosya sadece YENİ PC'de BİR KEZ calistirilir!
echo.
pause

REM ============================================
REM SSH Key'leri Kopyala
REM ============================================
echo.
echo [1/2] SSH key'leri yerlestirilyor...
echo.

if not exist "%USERPROFILE%\.ssh" (
    mkdir "%USERPROFILE%\.ssh"
    echo .ssh klasoru olusturuldu
)

if exist "_ssh_backup" (
    echo SSH key dosyalari kopyalaniyor...
    xcopy "_ssh_backup\*" "%USERPROFILE%\.ssh\" /E /Y >nul

    if %errorlevel% equ 0 (
        echo [OK] SSH key yerlestirildi!
        echo Konum: %USERPROFILE%\.ssh\
        echo.
        echo ARTIK TOKEN GEREKMEYECEK!
        echo.
    ) else (
        echo [X] SSH key kopyalama hatasi!
        pause
        exit /b 1
    )
) else (
    echo [!] UYARI: _ssh_backup klasoru bulunamadi!
    echo.
    echo Bu klasor:
    echo - MAYA_KATALOG_PORTABLE icinde olmali
    echo - SSH key dosyalarini icermeli (id_ed25519_maya, config)
    echo.
    pause
    exit /b 1
)

REM ============================================
REM Test SSH Baglanti
REM ============================================
echo [2/2] GitHub baglantisi test ediliyor...
echo.
ssh -T git@github.com-maya 2>&1 | findstr "successfully" >nul

if %errorlevel% equ 0 (
    echo [OK] SSH baglanti basarili!
    echo [OK] GitHub ile baglanti kuruldu
) else (
    echo [!] SSH baglanti test ediliyor...
    echo Not: "Permission denied" veya "successfully authenticated" NORMAL
    echo.
)

echo.
echo ================================
echo   KURULUM TAMAMLANDI!
echo ================================
echo.
echo Artik yapilacaklar:
echo.
echo 1. urunler.xlsx ac -^> Duzenle -^> Kaydet
echo 2. guncelle.bat cift tikla
echo 3. Bitti!
echo.
echo NOT: Bu dosyayi (BASLAT.bat) artik calistirmaya gerek yok.
echo Sadece yeni PC'de ilk kurulum icindi.
echo.
pause
