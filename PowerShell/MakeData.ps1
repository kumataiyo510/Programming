# カレントパスを相対パスから絶対パスへ変換（後にエクセルファイルを開くための準備）
$currentpath = (Convert-Path ..\)

# 定例代用ファイル名の取得
$REPORTEXCEL = "$currentpath\電算業務報告資料（定例）.xlsx"

# 新規エクセルオブジェクトの作成
$excel = New-Object -ComObject Excel.Application

# 可視設定
$excel.visible = $true

# シート削除や保存時のアラートを表示させない（強制上書き的な使い方≒Force）
$excel.DisplayAlerts = $false

# 定例ファイルを開く
# $book = $excel.Workbooks.Add()
$book = $excel.Workbooks.Open($REPORTEXCEL)

# 現状存在するシート一覧の取得（後に削除するために利用する）
$oldsheets = ($book.worksheets | ForEach-Object { $_.name })

# 取り込むCSVファイル一覧の取得
$csvlist = Get-ChildItem -Path .\ *.csv

# 時間を(hhmm)の形で取得（名前から今回作られたシートなのか判別するため）
$exetime = Get-Date -Format hhmm

# CSVファイル一つ毎の処理
foreach($csv IN $csvlist){
    $fn = $csv.name
    $sn = $fn.Substring(0, ($fn.length - 4))
    $imcsv = Import-Csv .\$fn -Encoding Default
    $cntf = (Get-Content .\$fn | Select-Object -First 1 | % {$_ -replace """", ""})
    $cnthds = $cntf.Split(",")
    
    foreach($osn IN $oldsheets){
        if($sn -eq $osn){
            $book.worksheets.item("$osn").delete()
        }
    }

    # 今回取り込んデータのシートを作成
    $sheet = $book.Worksheets.Add()
    $sheet.Name = "$exetime$sn"

    # ヘッダーデータの取得
    # $header = $imcsv | Get-Member -MemberType "NoteProperty" | Select-Object -ExpandProperty "Name"
    $header = $cnthds

    $row = 0

    # データ部の書き込み（ヘッダー部）
    foreach($head in $header){
        $row ++
        $sheet.Cells.Item(1, $row) = $head
        $col = 2

        # データ部の書き込み（データ部）
        foreach($data IN $imcsv){
            $sheet.Cells.Item($col, $row) = $data.$head
            $col ++
        }
    }
}


$chartobject = $sheet.ChartObjects()
$newchartobject = $chartobject.add(1, 50, 350, 300)
$chart = $newchartobject.Chart

# グラフタイプ
$chart.ChartType = 51

# データ部の指定と読み込み
$srcrng = $sheet.Range("A2:B20")
$chart.SetSourceData($srcrng)

# グラフの最大値
$chart.Axes(2).MaximumScale = 100

# 汎用の削除（描画部等の説明部）
$chart.Legend.LegendEntries(1).delete()

$excel.ScreenUpdating =$true

# ブックの保存
# $book.Save()

# エクセルの終了
# $excel.Quit()


# 事後処理（変数等の解放とエクセルプロセスの停止）
$REPORTEXCEL = $null
$currentpath = $null
$oldsheets = $null
$csvlist = $null
$head = $null
$j = $null
$i = $null
$fn = $null
$sn = $null
$imcsv = $null
$header = $null
$sheet = $null
$book  = $null
$excel = $null
[GC]::Collect()
