$url = "XXXX"

# シェルを取得
$shell = New-Object -ComObject Shell.Application

# IEを起動
# $ie = New-Object -ComObject InternetExplorer.Application
# 非保護モード
$clsid = New-Object Guid "D5E8041D-920F-45e9-B8FB-B1DEB82C6E5E"
$type = [Type]::GetTypeFromCLSID($clsid)
$ie = [Activator]::CreateInstance($type)

# 可視化
$ie.Visible = $true

# URLへアクセス
$ie.Navigate("$url")

while($ie.Busy){
    Start-Sleep -Milliseconds 100
}

$doc = $ie.Document

# id="userID" name="userID"
$txt = $doc.getElementsByName("userID")
$txt[0].value = "administrator"

# id="Pass" name="Pass"
$txt = $doc.getElementsByName("Pass")
$txt[0].value = "Nawate1!"

# id="LoginButton" name="LoginButton"
$btn = $doc.getElementsByName("XXXX")
$btn[0].click()


while($ie.Busy){
    Start-Sleep -Milliseconds 100
}

$doc2 = $ie.Document

# class="linkButton" id="XXXX" name=""
$btn = $doc2.getElementById("XXXX")
$btn.click()

while($ie.Busy){
    Start-Sleep -Milliseconds 100
}

$ielist = $shell.Windows() | where { $_.Name -match "Internet Explorer" }
# $doc3 = $ielist | where { $_.LocationName -match "XXXX" }
$ie = $ielist | where { $_.LocationName -match "XXXX" }
$doc3 = $ie.Document

# id="XXXX"
$btn = $doc3.getElementById("XXXX")
$btn.click()

