#勉強サイトhttp://trend-desk.com/archives/2360
# 0.popup("メッセージ",表示時間,タイトル,種類) http://trend-desk.com/archives/519
<# $wsobj = new-object -ComObject wscript.shell
$result = $wsobj.popup("Hello project")
$result = $wsobj.popup("Test Message",0,"Test Message Title",3) #>

# 1.変数　powershellで変数の型を確認するには"$変数名.gettype()"で取得できる
<# #入力部
$name = Read-Host "名前を入力してください（例：田中太郎）"
$birthday = Read-Host "生年月日を入力してください（例：2000年1月1日"
$age = Read-Host "年齢を入力してください（例：30）"
#出力部
Write-Host "名前："$name
Write-Host "生年月日："$birthday
Write-Host "年齢："$age #>

<# #Question 1-1
#入力部
$YesterdayWeather = Read-Host "昨日の天気は？"
$TodayWeather = Read-Host "今日の天気は？"
#出力部
Write-Host "昨日天気は $YesterdayWeather 、今日の天気は $TodayWeather です。" #>

# ２．演算子　演算の対象となるものを"オペランド"と呼ぶ。　Powershellの演算子でべき乗は"[Math]::Pow(a,b)という関数で実現される。　%剰余を求める演算子（モジュロ演算）
<# $date1 = Get-Date "2020/1/1 3:00:00"
$date2 = Get-Date "2020/1/1 20:00:00"
($date1 - $date2).Hours #>
# [Math]::Pow(5,2)
<# $a = 3
$a++ #インクリメント
$b-- #デクリメント #>

# 次回は比較演算子と論理演算しから続きを行う。
# 忘れやすい比較演算子（"-like","-notlike", "-match", "-notmatch"）likeはワイルドカード、matchは正規表現。大文字小文字の区別をする場合はすべて頭に"c"をつける。（例："-clike", "-ceq"）
# "a" -eq "a" #return "true"
# Get-ChildItem -Path c:\users\ -Recurse | Where-Object {$_.FullName -like "*test"} | Select-Object FullName
# キャスト方法　$a = [int]$a

# 3つの数値を入力させ、その合計を表示するプログラムを作りましょう。
<# # 入力部
$a = Read-Host "数値を入力してください"
$b = Read-Host "数値を入力してください"
$c = Read-Host "数値を入力してください"

# 出力部
$sum = [int]$a + [int]$b + [int]$c
$result = "入力した数値の合計は $sum です"
Write-Host $result #>

<# # 三角形の面積を求めるプログラムを作成する
$teihen = Read-Host "底辺の長さを入力してください"
$takasa = Read-Host "高さを入力してください"

$menseki = [int]$teihen * [int]$takasa / 2

Write-Host "この三角形の面積は $menseki です。" #>

# 未来の年月日を入力して、その日が今日から「何日後」なのかを表示するプログラムを作りましょう
<# #入力部
$miraibi = Read-Host "未来日を入力してください"
#計算部
$honjitu = Get-Date
$result = ([datetime]$miraibi - [datetime]$honjitu).Days
#表示部
Write-Host "その差は $result 日です" #>

# IF文
<# #入力部
$weather = Read-Host "今日の天気は何ですか？（例：晴れ、雨、など）"
#演算部
if ($weather -eq "晴れ") {
    Write-Output "散歩に行こう"
} 
elseif ($weather -eq "雨"){
    Write-Output "家にこもろう"
}
else {
    Write-Output "どんな天気やねん！"
} #>

# swith文
<# #入力部
$weather = Read-Host "今日の天気は何ですか？（例：晴れ、雨、など）"
#演算部
switch ($weather) {
    "晴れ" { Write-Output "公園に行こう" }
    "雨" { Write-Output "家にこもろう" }
    Default { Write-Output "どんな天気やねん" }
} #>

<# 入力された西暦がうるう年かどうか判別するプログラムを作成せよ。なお、うるう年の条件は以下となる。
・西暦が4で割り切れる
・ただし、上記のうち100で割り切れるものはうるう年ではない
・ただし、上記のうち400で割り切れる年はうるう年 #>
<# #入力部
$nyuryoku = Read-Host "西暦を入力してください"
#演算部
if ($nyuryoku % 4 -eq 0){
    if ($nyuryoku % 100 -eq 0) {
        if ($nyuryoku %400 -eq 0){
            Write-Output "うるう年なんだよー！"
        }
        else {
            Write-Output "うるう年・・・ではない！"
        }
    }
    else {
        Write-Output "うるう年だよ、全員集合ーー"
    }
}
else {
    Write-Host "うるう年ではないが・・・どうだろう・・・よいかな？"
} #>

#別解
<# $nyuryoku = Read-Host "西暦を入力してください"

if($nyuryoku % 400 -eq 0){
    Write-Output "うるう年ーー"
}
elseif ($nyuryoku % 100 -eq 0){
    Write-Output "うるう年・・・ではない！"
}
elseif ($nyuryoku % 4 -eq 0){
    Write-Output "うるう年・・・です！！"
}
else {
    Write-Output "うるう年ではありませーーーーんｊｎ"
} #>

#while文
<# [int]$counter = 1
while ($counter -le 5) {
    [int]$counter++
} #>

#do-while文
<# $num = 1
do {
    $num++
    Write-Output $num
}
while($num -le 5) #>

#do-until文
<# $num = 1
do {
    $num++
    Write-Output $num
} until ($num -ge 5) #>

#for文　whileとの使い分けについて、forの場合は毎回する処理が必ずあるが、forだと任意
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

#continue 後の処理のスキップ
<# for ($i = 1;$i -le 10;$i++){
    if ($i -eq 5){
        continue
    }
    Write-Output $i
} #>

#入力された数字の回数だけ「*」を表示するプログラムを作成せよ
<# #入力受付部
$entry = Read-Host "回数を入力してください"
#処理部
for($i = 1; $i -le $entry; $i++){
    Write-Output '*'
} #>

<# 入力された数字が素数であるかどうか判別するプログラムを作成せよ
※素数：1より大きくて、1と自分自身以外の数字で割り切れる数が無い自然数のこと #>
<# #入力受付部
$entry = Read-Host "数字を入力してください"
#処理部
for($i = 2; $i -le $entry; $i++){
    if($entry -eq 1){
        Write-Output "君・・・１じゃね？"
        break
    }
    elseif($entry -eq $i){
        Write-Output "君は孤独な・・・素数である！！！！"
    }
    elseif ($entry % $i -eq 0){
        Write-Output "素数ではない、孤独ではないのだーーー！！！"
        break
    }
} #>

#別解
<# $num = [int]$num
$primenumber = $true

$num = Read-Host "数値を入力してください"

for ($i = 2; $i -lt $num; $i++){
    if ($num % $i -eq 0){
        Write-Output "素数じゃないの！"
        $primenumber = $false
        break
    }
}
if ($primenumber){
    Write-Output "そ・・・素数じゃ！"
} #>

#配列　PowerShellの配列の特徴は、型がバラバラな値も要素として入れることができる
<# #パターン1　","区切りとの違いは、"@"の場合には値が一つでも配列として作成されるという点
$int_array1 = @(1,2,3,4,5)
#パターン2
$int_array2 = 1..5
#パターン3
$int_array3 = 1,2,3,4,5 #>

#型がバラバラな値
<# $array1 = 1, 1.5, "abc"
$array1[0].GetType()
$array1[1].GetType()
$array1[2].GetType() #>

#配列に要素を足す　$int_array.add(11)などをしても、IsFixedSize（固定サイズ）がTrueだと追加できない。
<# # "+="を使う
$int_array = 1..10
$int_array += 11
$int_array #>
<# # ArrayListから配列を作り直す　可変サイズの配列として作り直す
$array_list = 1..10
$array_list.IsFixedSize
$array_list1 = New-Object System.Collections.ArrayList
$array_list1.IsFixedSize
foreach ($i in $array_list){
    $array_list1.add($i)
}
$array_list1.Add(11)
$array_list1 #>

#配列から要素を削除する　こちらも固定サイズだと削除ができない　（１．配列を作り直す or ２．ArrayListで作り直す）
<# $array_list = 1..10
$array_list = $array_list [ 1..$array_list [ $array_list.Length - 1 ] ] #>
<# $array_list = 1..10
$array_list_new = New-Object System.Collections.ArrayList
$array_list_new.IsFixedSize
foreach($i in $array_list){
    $array_list_new.add($i)
}
$array_list_new.remove(1) #>

#配列の要素の抽出
<# $array_list = 1..5
$array_list[4] #>
<# $array_list = 1..5
$array_list -eq 5 #>
<# $array_list = @( 1..5 )
$array_list -ge 3 #>

#配列の比較
<# $array_list_org = @( 1..5 )
$array_list_imp = @( 1..7 )
Compare-Object $array_list_org $array_list_imp #>
<# $array_list_org = @( 1, 3, 5 )
$array_list_imp = @( 2, 4, 6 )
Compare-Object $array_list_org $array_list_imp #>

#ユーザーに好きな食べ物を複数入力させて、その結果を配列に格納して表示するプログラムを作成せよ。
<# $favFoods = New-Object System.Collections.ArrayList
for($i = 0; $i -le 5; $i++){
    $favFood = Read-Host "好きな食べ物を１品入力してね（合計５品入力できるよー、ちなみに $i 品目）"
    $favFoods += $favFood
}
#表示部
$favFoods #>
#別解
<# $favFoods = New-Object System.Collections.ArrayList
while( $true ){
    $food = Read-Host "好きな食べ物を入力してね（１品だよ）"
    $favFoods.add($food) | Out-Null

    $ans = Read-Host "続けて入力しますか（Y/N）"
    if( $ans -eq "N" ){
        break
    }
}
Write-Output $favFoods #>

<# 問題1で結果を表示させた後、さらにユーザーにさらにユーザーに食べ物を入力させて、
既に存在する食べ物だったら配列から削除、まだ存在しない食べ物だったら配列に追加して、
その結果を表示する。ユーザーが「終了」と入力するまでこれを繰り返すプログラムを作成せよ。 #>
<# $favFoods = New-Object System.Collections.ArrayList
while( $true ){
    $food = Read-Host "好きな食べ物を入力してね（１品だよ）"
    $favFoods.add($food) | Out-Null

    $ans = Read-Host "続けて入力しますか（Y/N）"
    if( $ans -eq "N" ){
        break
    }
}
Write-Output $favFoods

while( $true ) {
    $food = Read-Host "追加の食べ物を入力してね（終了の場合は""終了""と入力）"

    if ($food -eq "終了") {
        Write-Output "終了します"
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
<# 身長と体重を入力させて、BMIを計算して結果を表示せよ。
また、BMIの計算（BMI = 体重[kg] ÷ 身長[m]の2乗）結果から判定基準が何になるかも、合わせて表示せよ。 #>
<# 
#入力部
$sintyo = Read-Host "身長[m]を入力してください。"
$taijyu = Read-Host "体重[kg]を入力してください。"

#演算部
$bmi = $taijyu / [math]::Pow($sintyo, 2)

#表示部
Write-Host "あなたのBMIは $bmi です。"

switch ( $bmi ) {
    {$_ -lt 18.5} {
        Write-Host "低体重（やせ型）"
     }
     {$_ -ge 18.5 -and $_ -lt 25 } {
        Write-Host "普通体重"
     }
     {$_ -ge 25 -and $_ -lt 30 }  {
        Write-Host "肥満（１度）"
     }
     {$_ -ge 30 -and $_ -lt 35 }  {
        Write-Host "肥満（２度）"
     }
     {$_ -ge 35 -and $_ -lt 40 }  {
        Write-Host "肥満（３度）"
     }
     {$_ -ge 40} {
        Write-Host "肥満（４度）"
     }
} #>


#for文を用いて、以下のように掛け算九九の表を出力するプログラムを作成せよ。
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

<# 5人の身長を入力させて、各自の身長と、最も高い人、最も低い人、平均の身長をそれぞれ出力するプログラムを作成せよ。
但し、入力した身長は配列に格納するようにせよ。 #>
<# #変数宣言
$sintyouLists = New-Object system.Collections.ArrayList
$i = 0
$j = 0
$MAX = 0
$MIN = [int32]::MaxValue
$SUM = 0
#入力部
while ($i -lt 5)
{
    [int32]$sintyou = Read-Host ($i + 1) "人目の身長を入力してください。"
    $sintyouLists.Add($sintyou) | Out-Null
    $i++
}
#出力部
foreach ($sintyou in $sintyouLists)
{
    $text = "" + ($j + 1) + "人目の身長は" + $sintyouLists[$j] + "です。"
    Write-Output $text
    $j++
}
#演算部
foreach ($sintyou in $sintyouLists)
{
    if ($MAX -lt $sintyou)
    {
        $MAX = $sintyou
    }
}
$text = "最も高い身長は" + $MAX + "です。"
Write-Output $text

foreach ($sintyou in $sintyouLists)
{
    if ($MIN -gt $sintyou)
    {
        $MIN = $sintyou
    }
}
$text = "最も低い身長は" + $MIN + "です。"
Write-Output $text

foreach ($sintyou in $sintyouLists)
{
    $SUM += $sintyou
}
$text = "平均身長は" + $sum / $sintyouLists.Count + "です。"
Write-Output $text

Remove-Variable i #>

<# 「しりとりプログラム」を作成せよ。
入力された言葉がしりとりになっていなければゲームオーバー、
「ん」で終わればゲームオーバーとなるようにせよ。 #>
<# $beforeword = "しりとり"
Write-Output "しりとりスッタート"
Write-Output $beforeword
while ($true) 
{
    $ans = Read-Host

    if ($ans.Substring(0,1) -ne $beforeword.Substring($beforeword.Length - 1, 1))
    {
        Write-Output "語繋がりになっていません。"
        break
    }
    elseif ($ans.Substring($ans.Length - 1, 1) -eq "ん")
    {
        Write-Output "「ん」で終わります。"
        break
    }
    $beforeword = $ans
}
Write-Output "ゲームオーバー" #>