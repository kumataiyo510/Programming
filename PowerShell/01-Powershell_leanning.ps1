#�׋��T�C�ghttp://trend-desk.com/archives/2360
# 0.popup("���b�Z�[�W",�\������,�^�C�g��,���) http://trend-desk.com/archives/519
<# $wsobj = new-object -ComObject wscript.shell
$result = $wsobj.popup("Hello project")
$result = $wsobj.popup("Test Message",0,"Test Message Title",3) #>

# 1.�ϐ��@powershell�ŕϐ��̌^���m�F����ɂ�"$�ϐ���.gettype()"�Ŏ擾�ł���
<# #���͕�
$name = Read-Host "���O����͂��Ă��������i��F�c�����Y�j"
$birthday = Read-Host "���N��������͂��Ă��������i��F2000�N1��1��"
$age = Read-Host "�N�����͂��Ă��������i��F30�j"
#�o�͕�
Write-Host "���O�F"$name
Write-Host "���N�����F"$birthday
Write-Host "�N��F"$age #>

<# #Question 1-1
#���͕�
$YesterdayWeather = Read-Host "����̓V�C�́H"
$TodayWeather = Read-Host "�����̓V�C�́H"
#�o�͕�
Write-Host "����V�C�� $YesterdayWeather �A�����̓V�C�� $TodayWeather �ł��B" #>

# �Q�D���Z�q�@���Z�̑ΏۂƂȂ���̂�"�I�y�����h"�ƌĂԁB�@Powershell�̉��Z�q�łׂ����"[Math]::Pow(a,b)�Ƃ����֐��Ŏ��������B�@%��]�����߂鉉�Z�q�i���W�������Z�j
<# $date1 = Get-Date "2020/1/1 3:00:00"
$date2 = Get-Date "2020/1/1 20:00:00"
($date1 - $date2).Hours #>
# [Math]::Pow(5,2)
<# $a = 3
$a++ #�C���N�������g
$b-- #�f�N�������g #>

# ����͔�r���Z�q�Ƙ_�����Z�����瑱�����s���B
# �Y��₷����r���Z�q�i"-like","-notlike", "-match", "-notmatch"�jlike�̓��C���h�J�[�h�Amatch�͐��K�\���B�啶���������̋�ʂ�����ꍇ�͂��ׂē���"c"������B�i��F"-clike", "-ceq"�j
# "a" -eq "a" #return "true"
# Get-ChildItem -Path c:\users\ -Recurse | Where-Object {$_.FullName -like "*test"} | Select-Object FullName
# �L���X�g���@�@$a = [int]$a

# 3�̐��l����͂����A���̍��v��\������v���O���������܂��傤�B
<# # ���͕�
$a = Read-Host "���l����͂��Ă�������"
$b = Read-Host "���l����͂��Ă�������"
$c = Read-Host "���l����͂��Ă�������"

# �o�͕�
$sum = [int]$a + [int]$b + [int]$c
$result = "���͂������l�̍��v�� $sum �ł�"
Write-Host $result #>

<# # �O�p�`�̖ʐς����߂�v���O�������쐬����
$teihen = Read-Host "��ӂ̒�������͂��Ă�������"
$takasa = Read-Host "��������͂��Ă�������"

$menseki = [int]$teihen * [int]$takasa / 2

Write-Host "���̎O�p�`�̖ʐς� $menseki �ł��B" #>

# �����̔N��������͂��āA���̓�����������u������v�Ȃ̂���\������v���O���������܂��傤
<# #���͕�
$miraibi = Read-Host "����������͂��Ă�������"
#�v�Z��
$honjitu = Get-Date
$result = ([datetime]$miraibi - [datetime]$honjitu).Days
#�\����
Write-Host "���̍��� $result ���ł�" #>

# IF��
<# #���͕�
$weather = Read-Host "�����̓V�C�͉��ł����H�i��F����A�J�A�Ȃǁj"
#���Z��
if ($weather -eq "����") {
    Write-Output "�U���ɍs����"
} 
elseif ($weather -eq "�J"){
    Write-Output "�Ƃɂ����낤"
}
else {
    Write-Output "�ǂ�ȓV�C��˂�I"
} #>

# swith��
<# #���͕�
$weather = Read-Host "�����̓V�C�͉��ł����H�i��F����A�J�A�Ȃǁj"
#���Z��
switch ($weather) {
    "����" { Write-Output "�����ɍs����" }
    "�J" { Write-Output "�Ƃɂ����낤" }
    Default { Write-Output "�ǂ�ȓV�C��˂�" }
} #>

<# ���͂��ꂽ������邤�N���ǂ������ʂ���v���O�������쐬����B�Ȃ��A���邤�N�̏����͈ȉ��ƂȂ�B
�E���4�Ŋ���؂��
�E�������A��L�̂���100�Ŋ���؂����̂͂��邤�N�ł͂Ȃ�
�E�������A��L�̂���400�Ŋ���؂��N�͂��邤�N #>
<# #���͕�
$nyuryoku = Read-Host "�������͂��Ă�������"
#���Z��
if ($nyuryoku % 4 -eq 0){
    if ($nyuryoku % 100 -eq 0) {
        if ($nyuryoku %400 -eq 0){
            Write-Output "���邤�N�Ȃ񂾂�[�I"
        }
        else {
            Write-Output "���邤�N�E�E�E�ł͂Ȃ��I"
        }
    }
    else {
        Write-Output "���邤�N����A�S���W���[�["
    }
}
else {
    Write-Host "���邤�N�ł͂Ȃ����E�E�E�ǂ����낤�E�E�E�悢���ȁH"
} #>

#�ʉ�
<# $nyuryoku = Read-Host "�������͂��Ă�������"

if($nyuryoku % 400 -eq 0){
    Write-Output "���邤�N�[�["
}
elseif ($nyuryoku % 100 -eq 0){
    Write-Output "���邤�N�E�E�E�ł͂Ȃ��I"
}
elseif ($nyuryoku % 4 -eq 0){
    Write-Output "���邤�N�E�E�E�ł��I�I"
}
else {
    Write-Output "���邤�N�ł͂���܂��[�[�[�[�񂊂�"
} #>

#while��
<# [int]$counter = 1
while ($counter -le 5) {
    [int]$counter++
} #>

#do-while��
<# $num = 1
do {
    $num++
    Write-Output $num
}
while($num -le 5) #>

#do-until��
<# $num = 1
do {
    $num++
    Write-Output $num
} until ($num -ge 5) #>

#for���@while�Ƃ̎g�������ɂ��āAfor�̏ꍇ�͖��񂷂鏈�����K�����邪�Afor���ƔC��
<# for ($i = 0; $i -le 10; $i++){
    Write-Output $i
} #>

#foreach
<# $items = @(1,2,3,4,6)
foreach ($item in $items){
    Write-Output "$item"
} #>

#break
<# for ($i = 0; $i -le 10; $i++){
    Write-Output $i
   
    if ($i -eq 5){
        break
    }
} #>

#continue ��̏����̃X�L�b�v
<# for ($i = 1;$i -le 10;$i++){
    if ($i -eq 5){
        continue
    }
    Write-Output $i
} #>

#���͂��ꂽ�����̉񐔂����u*�v��\������v���O�������쐬����
<# #���͎�t��
$entry = Read-Host "�񐔂���͂��Ă�������"
#������
for($i = 1; $i -le $entry; $i++){
    Write-Output '*'
} #>

<# ���͂��ꂽ�������f���ł��邩�ǂ������ʂ���v���O�������쐬����
���f���F1���傫���āA1�Ǝ������g�ȊO�̐����Ŋ���؂�鐔���������R���̂��� #>
<# #���͎�t��
$entry = Read-Host "��������͂��Ă�������"
#������
for($i = 2; $i -le $entry; $i++){
    if($entry -eq 1){
        Write-Output "�N�E�E�E�P����ˁH"
        break
    }
    elseif($entry -eq $i){
        Write-Output "�N�͌ǓƂȁE�E�E�f���ł���I�I�I�I"
    }
    elseif ($entry % $i -eq 0){
        Write-Output "�f���ł͂Ȃ��A�ǓƂł͂Ȃ��̂��[�[�[�I�I�I"
        break
    }
} #>

#�ʉ�
<# $num = [int]$num
$primenumber = $true

$num = Read-Host "���l����͂��Ă�������"

for ($i = 2; $i -lt $num; $i++){
    if ($num % $i -eq 0){
        Write-Output "�f������Ȃ��́I"
        $primenumber = $false
        break
    }
}
if ($primenumber){
    Write-Output "���E�E�E�f������I"
} #>

#�z��@PowerShell�̔z��̓����́A�^���o���o���Ȓl���v�f�Ƃ��ē���邱�Ƃ��ł���
<# #�p�^�[��1�@","��؂�Ƃ̈Ⴂ�́A"@"�̏ꍇ�ɂ͒l����ł��z��Ƃ��č쐬�����Ƃ����_
$int_array1 = @(1,2,3,4,5)
#�p�^�[��2
$int_array2 = 1..5
#�p�^�[��3
$int_array3 = 1,2,3,4,5 #>

#�^���o���o���Ȓl
<# $array1 = 1, 1.5, "abc"
$array1[0].GetType()
$array1[1].GetType()
$array1[2].GetType() #>

#�z��ɗv�f�𑫂��@$int_array.add(11)�Ȃǂ����Ă��AIsFixedSize�i�Œ�T�C�Y�j��True���ƒǉ��ł��Ȃ��B
<# # "+="���g��
$int_array = 1..10
$int_array += 11
$int_array #>
<# # ArrayList����z�����蒼���@�σT�C�Y�̔z��Ƃ��č�蒼��
$array_list = 1..10
$array_list.IsFixedSize
$array_list1 = New-Object System.Collections.ArrayList
$array_list1.IsFixedSize
foreach ($i in $array_list){
    $array_list1.add($i)
}
$array_list1.Add(11)
$array_list1 #>

#�z�񂩂�v�f���폜����@��������Œ�T�C�Y���ƍ폜���ł��Ȃ��@�i�P�D�z�����蒼�� or �Q�DArrayList�ō�蒼���j
<# $array_list = 1..10
$array_list = $array_list [ 1..$array_list [ $array_list.Length - 1 ] ] #>
<# $array_list = 1..10
$array_list_new = New-Object System.Collections.ArrayList
$array_list_new.IsFixedSize
foreach($i in $array_list){
    $array_list_new.add($i)
}
$array_list_new.remove(1) #>

#�z��̗v�f�̒��o
<# $array_list = 1..5
$array_list[4] #>
<# $array_list = 1..5
$array_list -eq 5 #>
<# $array_list = @( 1..5 )
$array_list -ge 3 #>

#�z��̔�r
<# $array_list_org = @( 1..5 )
$array_list_imp = @( 1..7 )
Compare-Object $array_list_org $array_list_imp #>
<# $array_list_org = @( 1, 3, 5 )
$array_list_imp = @( 2, 4, 6 )
Compare-Object $array_list_org $array_list_imp #>

#���[�U�[�ɍD���ȐH�ו��𕡐����͂����āA���̌��ʂ�z��Ɋi�[���ĕ\������v���O�������쐬����B
<# $favFoods = New-Object System.Collections.ArrayList
for($i = 0; $i -le 5; $i++){
    $favFood = Read-Host "�D���ȐH�ו����P�i���͂��Ăˁi���v�T�i���͂ł����[�A���Ȃ݂� $i �i�ځj"
    $favFoods += $favFood
}
#�\����
$favFoods #>
#�ʉ�
<# $favFoods = New-Object System.Collections.ArrayList
while( $true ){
    $food = Read-Host "�D���ȐH�ו�����͂��Ăˁi�P�i����j"
    $favFoods.add($food) | Out-Null

    $ans = Read-Host "�����ē��͂��܂����iY/N�j"
    if( $ans -eq "N" ){
        break
    }
}
Write-Output $favFoods #>

<# ���1�Ō��ʂ�\����������A����Ƀ��[�U�[�ɂ���Ƀ��[�U�[�ɐH�ו�����͂����āA
���ɑ��݂���H�ו���������z�񂩂�폜�A�܂����݂��Ȃ��H�ו���������z��ɒǉ����āA
���̌��ʂ�\������B���[�U�[���u�I���v�Ɠ��͂���܂ł�����J��Ԃ��v���O�������쐬����B #>
<# $favFoods = New-Object System.Collections.ArrayList
while( $true ){
    $food = Read-Host "�D���ȐH�ו�����͂��Ăˁi�P�i����j"
    $favFoods.add($food) | Out-Null

    $ans = Read-Host "�����ē��͂��܂����iY/N�j"
    if( $ans -eq "N" ){
        break
    }
}
Write-Output $favFoods

while( $true ) {
    $food = Read-Host "�ǉ��̐H�ו�����͂��Ăˁi�I���̏ꍇ��""�I��""�Ɠ��́j"

    if ($food -eq "�I��") {
        Write-Output "�I�����܂�"
        break
    }
    elseif($favFoods.Contains($food)){
        $favFoods.Remove($food) | Out-Null
    }
    else {
        $favFood.add($food) | Out-Null
    }
    Write-Output $favFoods
} #>

#Question
<# �g���Ƒ̏d����͂����āABMI���v�Z���Č��ʂ�\������B
�܂��ABMI�̌v�Z�iBMI = �̏d[kg] �� �g��[m]��2��j���ʂ��画�������ɂȂ邩���A���킹�ĕ\������B #>
<# 
#���͕�
$sintyo = Read-Host "�g��[m]����͂��Ă��������B"
$taijyu = Read-Host "�̏d[kg]����͂��Ă��������B"

#���Z��
$bmi = $taijyu / [math]::Pow($sintyo, 2)

#�\����
Write-Host "���Ȃ���BMI�� $bmi �ł��B"

switch ( $bmi ) {
    {$_ -lt 18.5} {
        Write-Host "��̏d�i�₹�^�j"
     }
     {$_ -ge 18.5 -and $_ -lt 25 } {
        Write-Host "���ʑ̏d"
     }
     {$_ -ge 25 -and $_ -lt 30 }  {
        Write-Host "�얞�i�P�x�j"
     }
     {$_ -ge 30 -and $_ -lt 35 }  {
        Write-Host "�얞�i�Q�x�j"
     }
     {$_ -ge 35 -and $_ -lt 40 }  {
        Write-Host "�얞�i�R�x�j"
     }
     {$_ -ge 40} {
        Write-Host "�얞�i�S�x�j"
     }
} #>


#for����p���āA�ȉ��̂悤�Ɋ|���Z���̕\���o�͂���v���O�������쐬����B
<# for ($i = 0; $i -lt 10; $i++)
{
    $row = ""
    for ($j = 0; $j -lt 10; $j++)
    {
        if($i -eq 0)
        {
            $row += $j.ToString().PadLeft(3," ")        
        }
        else
        {
            if($j -eq 0)
            {
                $row += $i.ToString().PadLeft(3, " ")
            }
            else
            {
                $row += ($i * $j).ToString().PadLeft(3, " ")
            }
        }
    }
    Write-Output $row
} #>

<# 5�l�̐g������͂����āA�e���̐g���ƁA�ł������l�A�ł��Ⴂ�l�A���ς̐g�������ꂼ��o�͂���v���O�������쐬����B
�A���A���͂����g���͔z��Ɋi�[����悤�ɂ���B #>
<# #�ϐ��錾
$sintyouLists = New-Object system.Collections.ArrayList
$i = 0
$j = 0
$MAX = 0
$MIN = [int32]::MaxValue
$SUM = 0
#���͕�
while ($i -lt 5)
{
    [int32]$sintyou = Read-Host ($i + 1) "�l�ڂ̐g������͂��Ă��������B"
    $sintyouLists.Add($sintyou) | Out-Null
    $i++
}
#�o�͕�
foreach ($sintyou in $sintyouLists)
{
    $text = "" + ($j + 1) + "�l�ڂ̐g����" + $sintyouLists[$j] + "�ł��B"
    Write-Output $text
    $j++
}
#���Z��
foreach ($sintyou in $sintyouLists)
{
    if ($MAX -lt $sintyou)
    {
        $MAX = $sintyou
    }
}
$text = "�ł������g����" + $MAX + "�ł��B"
Write-Output $text

foreach ($sintyou in $sintyouLists)
{
    if ($MIN -gt $sintyou)
    {
        $MIN = $sintyou
    }
}
$text = "�ł��Ⴂ�g����" + $MIN + "�ł��B"
Write-Output $text

foreach ($sintyou in $sintyouLists)
{
    $SUM += $sintyou
}
$text = "���ϐg����" + $sum / $sintyouLists.Count + "�ł��B"
Write-Output $text

Remove-Variable i #>

<# �u����Ƃ�v���O�����v���쐬����B
���͂��ꂽ���t������Ƃ�ɂȂ��Ă��Ȃ���΃Q�[���I�[�o�[�A
�u��v�ŏI���΃Q�[���I�[�o�[�ƂȂ�悤�ɂ���B #>
<# $beforeword = "����Ƃ�"
Write-Output "����Ƃ�X�b�^�[�g"
Write-Output $beforeword
while ($true) 
{
    $ans = Read-Host

    if ($ans.Substring(0,1) -ne $beforeword.Substring($beforeword.Length - 1, 1))
    {
        Write-Output "��q����ɂȂ��Ă��܂���B"
        break
    }
    elseif ($ans.Substring($ans.Length - 1, 1) -eq "��")
    {
        Write-Output "�u��v�ŏI���܂��B"
        break
    }
    $beforeword = $ans
}
Write-Output "�Q�[���I�[�o�[" #>