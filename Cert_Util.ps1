Clear-Host
Write-Host -ForegroundColor Yellow "*******************************************************"
""
Write-Host -ForegroundColor Yellow "Установка и удаление сертификатов (PowerShell)"
Write-Host -ForegroundColor Yellow "(c) AnSt. Август 2017"
Write-Host -ForegroundColor Yellow "Версия: 0.1 (Август 2017)"
""
Write-Host -ForegroundColor Yellow "*******************************************************"
""
Write-Host -ForegroundColor Green "Изменения:
v0.1(Август 2017):   Создание скрипта"
""
Write-Host -ForegroundColor Yellow "*******************************************************"
""
#*******************************************************

#########################
# Функции #
#########################

# Открытие доступа к хранилищу сертификатов в режиме "чтение-запись"
Function OpenStore ($StoreName, $StoreScope) {

    # $StoreName, $StoreScope - Определение места хранения сертификата
    #[String]$StoreName = “My”
    #[String]$StoreScope = “CurrentUser”

    $Store = New-Object System.Security.Cryptography.X509Certificates.X509Store($StoreName,$StoreScope)
    $Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)

}

# Удаление сертификата
Function CertDelete ($SerialNumber, $StoreName, $StoreScope) {
    
    # $SerialNumber - Серийный номер сертификата    
    # $StoreName, $StoreScope - Определение места хранения сертификата

    #Открытие доступа к хранилищу сертификатов в режиме "чтение-запись"
    OpenStore ($StoreName, $StoreScope)
    #$Store = New-Object System.Security.Cryptography.X509Certificates.X509Store($StoreName,$StoreScope)
    #$Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)

    #Поиск сертификата по серийному номеру
    $Cert = $Store.Certificates.Find("FindBySerialNumber",$SerialNumber,$FALSE)[0]
    If ($Cert -ne $null) {
        #Удаление сертификата
        $Store.Remove($Cert)
        Write-Host -ForegroundColor Magenta "Сертификат с серийным номером" $SerialNumber "удалён!"
    } Else {
        Write-Host -ForegroundColor Red "Сертификат с серийным номером" $SerialNumber "не найден!"
    }

    #Закрытие хранилища
    $Store.Close()
}
###

#Установка сертификата из URL
Function CertInstall ($URL, $CertName, $StoreName, $StoreScope) {
    # $URL - URL необходимого сертификата
    # $CertName - временное имя сертификата
    # $StoreName, $StoreScope - Определение места хранения сертификата

    #Определение места хранения файла сертификата
    $СertFile = “$env:TEMP/$name”
    
    #Подключение к URL и скачивание файла сертификата
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFileAsync($URL, $СertFile)

    #Пауза
    Start-Sleep -s 5

    #Импортирование сертификата из файла
    $Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2    
    $Cert.Import($СertFile)
   

    #Открытие доступа к хранилищу сертификатов в режиме "чтение-запись"
    OpenStore ($StoreName, $StoreScope)
    #$Store = New-Object System.Security.Cryptography.X509Certificates.X509Store($StoreName,$StoreScope)
    #$Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    
    #Добавление сертификата в хранилище
    $Store.Add($Cert)

    #Закрытие хранилища
    $Store.Close()    
}
###

""
Write-Host -ForegroundColor Green "Раздел 1: Удаление сертификата"
Write-Host -ForegroundColor Green "---------------------------------------"

#Присвоение значений переменным
[String]$SerialNumber = '00000000000000000000'
[String]$StoreScope = “CurrentUser”
[String]$StoreName = “My”


Write-Host -ForegroundColor Magenta "Серийный номер сертификата - "$SerialNumber
Write-Host -ForegroundColor Magenta "Место хранения сертификата: Cert:\"$StoreName"\"$StoreScope

""
Write-Host -ForegroundColor Magenta "Скрипт выполняется..."
CertDelete ($SerialNumber, $StoreName, $StoreScope)
""

Write-Host -ForegroundColor Green "Раздел 2: Добавление сертификата"
Write-Host -ForegroundColor Green "---------------------------------------"

#Присвоение значений переменным
$URL = "https://examle.com"
$CertName = “cert.cer”
[String]$StoreScope = “LocalMachine”
[String]$StoreName = “Root”
Write-Host -ForegroundColor Magenta "URL: "$URL
Write-Host -ForegroundColor Magenta "Имя сертификата - "$CertName
Write-Host -ForegroundColor Magenta "Место хранения сертификата: Cert:\"$StoreName"\"$StoreScope

""
Write-Host -ForegroundColor Magenta "Скрипт выполняется..."
CertInstall ($URL, $CertName, $StoreName, $StoreScope)
Write-Host -ForegroundColor Magenta "Сертификат успешно импортирован!"
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