# �J�����g�f�B���N�g�̎擾
Write-Host (Get-Location)

# �J�����g�f�B���N�g���̕ύX
Set-Location "C:\users\kinta\OneDrive\�f�X�N�g�b�v"
Write-Host (Get-Location)
Set-Location Z:\Learnning\Programming\PowerShell
Write-Host (Get-Location)

# �X�^�b�N�̗��p�i�֐����ŃJ�����g�f�B���N�g���̕ύX���s���Ă��Ăяo�����ɉe����^���Ȃ��j
function test_fun(){
    Push-Location -StackName n1 C:\UtiltyTool
    Write-Host "something to do :" (Get-Location).Path
    Pop-Location -StackName n1
}
Set-Location C:\
test_fun
Write-Host "represent of current directry is c:\ " (Get-Location).Path
Set-Location Z:\Learnning\Programming\PowerShell


# ��t�@�C���̍쐬
Write-Host "��t�@�C���̍쐬�ƍ폜"
New-Item -Path .\TestOfNewItem.txt -Type File
Write-Host (Get-ChildItem)
write-host "-------------------------------------------------------------"
Remove-Item -Path .\TestOfNewItem.txt
Write-Host (Get-ChildItem)

# ��t�H���_�̍쐬
Write-Host "��t�H���_�̍쐬�ƍ폜"
New-Item -path .\test -ItemType Directory
Write-Host (Get-ChildItem)
write-host "-------------------------------------------------------------"
Remove-Item -Path .\test
Write-Host (Get-ChildItem)

# �V���{���b�N�����N�̍쐬�@�v�Ǘ��Ҍ���
<#
Write-Host "�V���{���b�N�����N�̍쐬�ƍ폜"
New-Item -Value ".\test.txt" -Path ".\lin_test.txt" -ItemType SymbolicLink 
Write-Host (Get-Item .\lin_test.txt).LinkType
Write-Host (Get-Item .\lin_test.txt).Target
Remove-Item -Path ".\lin_test.txt"
 #>

 
# �F�X�ȃt�@�C���ꗗ�̕\�����@
Write-Host "�F�X�ȃt�@�C���ꗗ�̕\�����@"
Get-ChildItem -Path *.txt ,*.ps1
Get-ChildItem C:\Users\kinta\Documents\ -Include *.py -Recurse -Depth 2
Get-ChildItem . -Filter *.txt -Recurse | Where-Object {$_.Length -gt 10}

# �o�͏����ύX
Write-Host "�o�͏����ύX"
Get-ChildItem | Format-Wide

# �t�@�C���̍폜
Write-Host "�t�@�C���̍폜"
New-Item .\whatif_test -ItemType Directory
Remove-Item .\whatif_test -WhatIf
Remove-Item .\whatif_test -Force
Write-Host (Get-ChildItem)

# �t�@�C���̃R�s�[
Write-Host "�t�@�C���̃R�s�["
Copy-Item�@-Path .\test.txt -Destination C:\Users\kinta\Documents
Write-Host (Get-ChildItem C:\Users\kinta\Documents)
Remove-Item C:\Users\kinta\Documents\test.txt -WhatIf
Remove-Item C:\Users\kinta\Documents\test.txt
Write-Host (Get-ChildItem C:\users\kinta\Documents\)

# �t�@�C���̈ړ�
Write-Host "�t�@�C���̈ړ�"
Move-Item -Path .\test.txt -Destination ..\
Write-Host (Get-ChildItem .\)
Write-Host (Get-ChildItem ..\)
Move-Item -Path ..\test.txt -Destination .\test.txt
Write-Host (Get-ChildItem ..\)
Write-Host (Get-ChildItem .\)

# �t�@�C�����̕ύX
Write-Host "�t�@�C�����̕ύX"
Rename-Item -Path .\test.txt -NewName test2.txt
Write-Host (Get-ChildItem .\)
Rename-Item -Path .\test2.txt -NewName .\test.txt
Write-Host (Get-ChildItem .\)

# �t�@�C���̒��g�̕ҏW
Write-Host "�t�@�C���̒��g�̕\��"
Set-Content -Path .\test.txt -Value "�����Z�b�g�A�b�v"
Get-Content -Path .\test.txt
Set-Content -Path .\test.txt -value "Set-Content:���g�̍X�V"
Get-Content -Path .\test.txt
Out-File .\test.txt -InputObject "Out-File:���g�̍X�V"
Get-Content -Path .\test.txt
Add-Content -Path .\test.txt -Value "---------------------"
Add-Content -Path .\test.txt -Value "Add-Content:���g�̒ǋL"
Get-Content -Path .\test.txt
Out-File .\test.txt -InputObject "----------------" -Append
Out-File .\test.txt -InputObject "Out-File -Append:���g�̒ǋL" -Append
Get-Content .\test.txt
Clear-Content .\test.txt
Get-Content .\test.txt
Add-Content -Path .\test.txt -Value "test01,test02,test03,tes04"
Add-Content -Path .\test.txt -Value "test05,test06,test07,tes08"
Get-Content -Path .\test.txt

# �t�@�C�����̕����񌟍�
Write-Host (Select-String -Path .\test.txt -Pattern "test")
Write-Host (Select-String -Path .\test.txt -Pattern "test05")

# �t�@�C���̑��݊m�F
Test-Path -Path .\test01.txt

# �p�X�̌���
Join-Path C:\Windows,'C:\Program Files' test

# ��΃p�X�Ƒ��΃p�X�̕ϊ�
Write-Host (resolve-path -Path ../JavaScript)