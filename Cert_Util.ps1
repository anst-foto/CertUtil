Clear-Host

Write-Host -ForegroundColor Yellow "*******************************************************"
""
Write-Host -ForegroundColor Yellow "Установка и удаление сертификатов (PowerShell)"
Write-Host -ForegroundColor Yellow "(c) AnSt. Август 2017"
Write-Host -ForegroundColor Yellow "© Автономное учреждение Воронежской области 'Многофункциональный центр предоставления государственных и муниципальных услуг', 2017"
Write-Host -ForegroundColor Yellow "Версия: 0.4 (февраль 2019)"
""
Write-Host -ForegroundColor Yellow "*******************************************************"
""
#*******************************************************

#########################
# Функции #
#########################

#Установка сертификата из URL
Function CertInstall1 {
    # $URL - URL необходимого сертификата
    # $CertName - временное имя сертификата
    # $StoreName, $StoreScope - Определение места хранения сертификата

    $URL = "http://uc.govvrn.ru/content/catalog_image/doc/8CAE88BBFD404A7A53630864F9033606E1DC45E2.cer"
    $CertName = “8CAE88BBFD404A7A53630864F9033606E1DC45E2.cer”
    [String]$StoreScope = “LocalMachine”
    [String]$StoreName = “Root”

    #Определение места хранения файла сертификата
    $СertFile = “$env:TEMP/$CertName”
    
    #Подключение к URL и скачивание файла сертификата
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFileAsync($URL, $СertFile)

    #Пауза
    Start-Sleep -s 5

    #Импортирование сертификата из файла
    $Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2    
    $Cert.Import($СertFile)
   

    #Открытие доступа к хранилищу сертификатов в режиме "чтение-запись"    
    $Store = New-Object System.Security.Cryptography.X509Certificates.X509Store($StoreName,$StoreScope)
    $Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    
    #Добавление сертификата в хранилище
    $Store.Add($Cert)

    #Закрытие хранилища
    $Store.Close()    
}
###

Function CertInstall2 {
    # $URL - URL необходимого сертификата
    # $CertName - временное имя сертификата
    # $StoreName, $StoreScope - Определение места хранения сертификата

    $URL = "http://uc.govvrn.ru/content/catalog_image/doc/72F43FDF2C5BC93297F18E43A392D48683DBBA0E.cer"
    $CertName = “72F43FDF2C5BC93297F18E43A392D48683DBBA0E.cer”
    [String]$StoreScope = “LocalMachine”
    [String]$StoreName = “CA”

    #Определение места хранения файла сертификата
    $СertFile = “$env:TEMP/$CertName”
    
    #Подключение к URL и скачивание файла сертификата
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFileAsync($URL, $СertFile)

    #Пауза
    Start-Sleep -s 5

    #Импортирование сертификата из файла
    $Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2    
    $Cert.Import($СertFile)
   

    #Открытие доступа к хранилищу сертификатов в режиме "чтение-запись"
    $Store = New-Object System.Security.Cryptography.X509Certificates.X509Store($StoreName,$StoreScope)
    $Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    
    #Добавление сертификата в хранилище
    $Store.Add($Cert)

    #Закрытие хранилища
    $Store.Close()    
}
###
Function CertInstall3 {
    # $URL - URL необходимого сертификата
    # $CertName - временное имя сертификата
    # $StoreName, $StoreScope - Определение места хранения сертификата

    $URL = "http://uc.govvrn.ru/content/catalog_image/doc/auitcvo.cer"
    $CertName = “auitcvo.cer”
    [String]$StoreScope = “LocalMachine”
    [String]$StoreName = “CA”

    #Определение места хранения файла сертификата
    $СertFile = “$env:TEMP/$CertName”
    
    #Подключение к URL и скачивание файла сертификата
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFileAsync($URL, $СertFile)

    #Пауза
    Start-Sleep -s 5

    #Импортирование сертификата из файла
    $Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2    
    $Cert.Import($СertFile)
   

    #Открытие доступа к хранилищу сертификатов в режиме "чтение-запись"
    $Store = New-Object System.Security.Cryptography.X509Certificates.X509Store($StoreName,$StoreScope)
    $Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    
    #Добавление сертификата в хранилище
    $Store.Add($Cert)

    #Закрытие хранилища
    $Store.Close()    
}
###

#*******************************************************

### Добавление сертификата ГУЦ
Write-Host -ForegroundColor Green "Раздел 1: Добавление сертификата ГУЦ"
Write-Host -ForegroundColor Green "---------------------------------------"

""
Write-Host -ForegroundColor Magenta "Скрипт выполняется..."
Try {
    CertInstall1
}
Catch {
    Write-Host -ForegroundColor Magenta "Сертификат не импортирован!"
}
Finally {
    Write-Host -ForegroundColor Magenta "Сертификат успешно импортирован!"
}

""
#*******************************************************

### Добавление сертификата УЦ 1 ИС ГУЦ
Write-Host -ForegroundColor Green "Раздел 2: Добавление сертификата УЦ АУ ИТЦ ВО"
Write-Host -ForegroundColor Green "---------------------------------------"

""
Write-Host -ForegroundColor Magenta "Скрипт выполняется..."
Try {
    CertInstall2
}
Catch {
    Write-Host -ForegroundColor Magenta "Сертификат не импортирован!"
}
Finally {
    Write-Host -ForegroundColor Magenta "Сертификат успешно импортирован!"
}
""
#*******************************************************

### Добавление сертификата УЦ АУ ИТЦ ВО
Write-Host -ForegroundColor Green "Раздел 3: Добавление сертификата АУ ИТЦ ВО"
Write-Host -ForegroundColor Green "---------------------------------------"

""
Write-Host -ForegroundColor Magenta "Скрипт выполняется..."
Try {
    CertInstall3
}
Catch {
    Write-Host -ForegroundColor Magenta "Сертификат не импортирован!"
}
Finally {
    Write-Host -ForegroundColor Magenta "Сертификат успешно импортирован!"
}
""
#*******************************************************

""
Write-Host -ForegroundColor Red "*******************************************************"
""
Write-Host -ForegroundColor Red "Все задачи выполнены!"
""
Write-Host -ForegroundColor Red "*******************************************************"
""

Read-Host "Для выхода нажмите Enter"
