# カレントディレクトの取得
Write-Host (Get-Location)

# カレントディレクトリの変更
Set-Location "C:\users\kinta\OneDrive\デスクトップ"
Write-Host (Get-Location)
Set-Location Z:\Learnning\Programming\PowerShell
Write-Host (Get-Location)

# スタックの利用（関数内でカレントディレクトリの変更を行っても呼び出し元に影響を与えない）
function test_fun(){
    Push-Location -StackName n1 C:\UtiltyTool
    Write-Host "something to do :" (Get-Location).Path
    Pop-Location -StackName n1
}
Set-Location C:\
test_fun
Write-Host "represent of current directry is c:\ " (Get-Location).Path
Set-Location Z:\Learnning\Programming\PowerShell


# 空ファイルの作成
Write-Host "空ファイルの作成と削除"
New-Item -Path .\TestOfNewItem.txt -Type File
Write-Host (Get-ChildItem)
write-host "-------------------------------------------------------------"
Remove-Item -Path .\TestOfNewItem.txt
Write-Host (Get-ChildItem)

# 空フォルダの作成
Write-Host "空フォルダの作成と削除"
New-Item -path .\test -ItemType Directory
Write-Host (Get-ChildItem)
write-host "-------------------------------------------------------------"
Remove-Item -Path .\test
Write-Host (Get-ChildItem)

# シンボリックリンクの作成　要管理者権限
<#
Write-Host "シンボリックリンクの作成と削除"
New-Item -Value ".\test.txt" -Path ".\lin_test.txt" -ItemType SymbolicLink 
Write-Host (Get-Item .\lin_test.txt).LinkType
Write-Host (Get-Item .\lin_test.txt).Target
Remove-Item -Path ".\lin_test.txt"
 #>

 
# 色々なファイル一覧の表示方法
Write-Host "色々なファイル一覧の表示方法"
Get-ChildItem -Path *.txt ,*.ps1
Get-ChildItem C:\Users\kinta\Documents\ -Include *.py -Recurse -Depth 2
Get-ChildItem . -Filter *.txt -Recurse | Where-Object {$_.Length -gt 10}

# 出力書式変更
Write-Host "出力書式変更"
Get-ChildItem | Format-Wide

# ファイルの削除
Write-Host "ファイルの削除"
New-Item .\whatif_test -ItemType Directory
Remove-Item .\whatif_test -WhatIf
Remove-Item .\whatif_test -Force
Write-Host (Get-ChildItem)

# ファイルのコピー
Write-Host "ファイルのコピー"
Copy-Item　-Path .\test.txt -Destination C:\Users\kinta\Documents
Write-Host (Get-ChildItem C:\Users\kinta\Documents)
Remove-Item C:\Users\kinta\Documents\test.txt -WhatIf
Remove-Item C:\Users\kinta\Documents\test.txt
Write-Host (Get-ChildItem C:\users\kinta\Documents\)

# ファイルの移動
Write-Host "ファイルの移動"
Move-Item -Path .\test.txt -Destination ..\
Write-Host (Get-ChildItem .\)
Write-Host (Get-ChildItem ..\)
Move-Item -Path ..\test.txt -Destination .\test.txt
Write-Host (Get-ChildItem ..\)
Write-Host (Get-ChildItem .\)

# ファイル名の変更
Write-Host "ファイル名の変更"
Rename-Item -Path .\test.txt -NewName test2.txt
Write-Host (Get-ChildItem .\)
Rename-Item -Path .\test2.txt -NewName .\test.txt
Write-Host (Get-ChildItem .\)

# ファイルの中身の編集
Write-Host "ファイルの中身の表示"
Set-Content -Path .\test.txt -Value "初期セットアップ"
Get-Content -Path .\test.txt
Set-Content -Path .\test.txt -value "Set-Content:中身の更新"
Get-Content -Path .\test.txt
Out-File .\test.txt -InputObject "Out-File:中身の更新"
Get-Content -Path .\test.txt
Add-Content -Path .\test.txt -Value "---------------------"
Add-Content -Path .\test.txt -Value "Add-Content:中身の追記"
Get-Content -Path .\test.txt
Out-File .\test.txt -InputObject "----------------" -Append
Out-File .\test.txt -InputObject "Out-File -Append:中身の追記" -Append
Get-Content .\test.txt
Clear-Content .\test.txt
Get-Content .\test.txt
Add-Content -Path .\test.txt -Value "test01,test02,test03,tes04"
Add-Content -Path .\test.txt -Value "test05,test06,test07,tes08"
Get-Content -Path .\test.txt

# ファイル内の文字列検索
Write-Host (Select-String -Path .\test.txt -Pattern "test")
Write-Host (Select-String -Path .\test.txt -Pattern "test05")

# ファイルの存在確認
Test-Path -Path .\test01.txt

# パスの結合
Join-Path C:\Windows,'C:\Program Files' test

# 絶対パスと相対パスの変換
Write-Host (resolve-path -Path ../JavaScript)