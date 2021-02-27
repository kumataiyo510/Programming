# 漢字の姓名でADアカウントを検索する
Function getKanjiToAccount($sei, $mei){
    $result = Get-AdUser -Filter "sn -like ""$sei"" -and givenName ""$mei"""
    return $result
}

# メッセージボックスの表示
$ntype = メッセージボックスに表示するボタンとアイコンの種類を示す数値。
$msgbox = New-Object -ComObject wscript.shell
$msgbox.Popup("message", 0, "title", $ntype)

# 文字列からの文字抽出
$str = "文字列"
$startnum = "開始場所の数値"
$endnum = "開始場所からの抽出文字数の数値"
$str.Substring($startnum, $endnum)

# 検索文字の文字数を調べる
$str.indexof("<target_char>")

# 文字置換
$str.replace("<before_char>", "<after_char>")

# クラス
class ClassName{
    # プロパティ
    # コンストラクタ
    ClassName($arg1, $arg2){
        # first_statement
    }
    # メソッド
    methodName($arg1, $arg2){
        # statement
    }
}

# 関数
function FunctionName {
    #statement
}

# 配列についてあれこれ
# 連想配列(hash-table)
$hash = @{
    "key" = "value"
    "key2" = "value2"
}

# 空の配列を作成する
$data = @()
write-output $data
$data = @("one", "two", "three", "four") # 配列に代入を行う
write-output $data

## 多次元配列
$data = @(
    @(1, 2, 3),
    @(4, 5, 6),
    @(7, 8, 9)
)
## ジャグ配列（配列の配列）
$jag = @(
    @(1, 2, 3),
    @(4, 5),
    @(6),
    @(7, 8, 9)
)
write-output $jag
## 可変長配列
$variablearray = [system.collections.arraylist]::new()
[void]$variablearray.Add("value") # voidでコンソールへの出力抑制
[void]$variablearray.remove("value")

# 型の指定
$array = [int[]](1, 2, 3) # @(1, 2, 3)は[object[]](1, 2, 3)と同義

## オブジェクト配列
$data = @(
    [PSCustomObject]@{
        FirstName = "FirstValue";
        LastName = "LastValue"
    }
    [PSCustomObject]@{
        FirstName = "FirstValue";
        LastName = "LastValue"
    }
)
$data[0].FirstName # FirstValueへのアクセス

## 配列のオペレーター
# join
$array = @(1, 2, 3, 4)
$array -join "-"
# 1-2-3-4
# placeとsplit
$array -replace "1", "5"
$array -split ","
# containとinは戻り値がboolean
# eqとneは戻り値が配列の要素（≒likeやmatch）

# 注意点
# $null配列はカウントは0で空の配列と同じではない
# 変数、プロパティ、コマンドレットの戻り値などで、その値が配列かそうでないかが事前にわからない場合でも、必ず配列として処理したい場合には＠を用いる
# [bool]$配列名がFALSEになるときは値が空文字もしくはNULLの場合

# オブジェクトの操作
select-object   # オブジェクトの一部を選択する
ForEach-Object  # オブジェクトのデータを繰り返し処理する
Where-object    # オブジェクトをフィルターする
Group-Object    # グループ化してアイテム数を算出する（集計する）
Sort-object     # オブジェクトのデータを並び替えする

# foreachメソッド
$array.foreach({$_})