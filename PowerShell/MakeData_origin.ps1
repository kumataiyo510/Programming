# シート名一覧
$second = "<FILENAME>"
$third = "<FILENAME>"
$forth = "<FILENAME>"
$fifth = "<FILENAME>"
$sixth = "<FILENAME>"
$seventh = "<FILENAME>"
$eighth = "<FILENAME>"
$nineth = "<FILENAME>"
$tenth = "<FILENAME>"
$eleventh = "<FILENAME>"

# カレントパスを相対パスから絶対パスへ変換（後にエクセルファイルを開くための準備）
$EXCELPATH = (Convert-Path ..\)

# 読み取りファイル名の取得（絶対パス）
$REPORTEXCEL = "$EXCELPATH\<FILENAME>"

# 新規エクセルオブジェクトの作成
$excel = New-Object -ComObject Excel.Application

# 可視設定
$excel.Visible = $false

# シート削除や保存時のアラートを表示させない（強制上書き的な使い方≒Force）
$excel.DisplayAlerts = $false

# エクセルファイルを開きブックオブジェクトを取得
# $book = $excel.Workbooks.Add()
$book = $excel.Workbooks.Open($REPORTEXCEL)

# 現状存在するシート一覧の取得（後に削除するために利用する）
$oldsheets = ($book.Worksheets | ForEach-Object { $_.name })

# 取り込むCSVファイル名一覧の取得
$csvlist = Get-ChildItem -Path .\ *.csv

# 時間を(hhmm)の形で取得（後にシート名に利用）
$exetime = Get-Date -Format hhmm

# グラフ作成のための関数
function DrawChart($countnum, $titlename, $graph){
    $excel.ScreenUpdating = $false

    # グラフサイズ定数
    $CHARTWIDTH  = 900
    $CHARTHIGHTH = 400
    
    # その他の定数
    $CHARTSTYLE         = 328
    $XLCOLUMNCLUSTERED  = 51
    $XLLINE             = 4
    $XLCATEGORY         = 1
    $XLLOW              = -4134
    $XLCOLUMNSTACKED100 = 53
    $XLPIE              = 5

    # グラフオブジェクトの作成
    $chartobject = $sheet.ChartObjects()
    $newchartobject = $chartobject.add(1, 1 + $countnum * $CHARTHIGHTH - $CHARTHIGHTH, $CHARTWIDTH, $CHARTHIGHTH)
    $chart = $newchartobject.Chart

    # データ部の指定と読み込み
    $range1 = $sheet.range("A1")
    $endrow = $sheet.Cells.Item(1, 1).end([Microsoft.Office.Interop.Excel.Xldirection]::xlDown).Row
    $endcol = $sheet.Cells.Item(1, 1).end([Microsoft.Office.Interop.Excel.Xldirection]::xlToRight).Column
    $range2 = $sheet.range($sheet.Cells.Item(1,$endcol), $sheet.Cells.Item($endrow, $endcol))
    $srcrng = $sheet.Range($range1, $range2)
    $chart.SetSourceData($srcrng)

    # タイトル表示
    $chart.HasTitle = $true
    $chart.ChartTitle.text = "$titlename"

    # グラフスタイルの設定
    $chart.ChartStyle = $CHARTSTYLE

    # グラフの系列ポジション調整
    $chart.Axes($XLCATEGORY).TickLabelPosition = $XLLOW

    # 系列処理（一旦全データをグラフ化）
    for($i = 1; $i -le $endcol - 1; $i++){
        $chart.SeriesCollection($i).ChartType = $XLLINE
        $chart.SeriesCollection($i).AxisGroup = 1
    }

    # グラフ整形（要らないグラフの削除とグラフ種別の指定）
    for($j = $graph.Count - 1; $j -gt 0; $j--){
        if($graph[$j][0] -eq 1){
            $chart.SeriesCollection($j).ChartType = $graph[$j][1]
            $chart.SeriesCollection($j).HasDataLabels = $true
        } else {
            $chart.SeriesCollection($j).Delete() | Out-Null
        }
    }

    # グラフの最大値
    # $chart.Axes(2).MaximumScale = 100

    # 汎用の削除（描画部等の説明部）
    # $chart.Legend.LegendEntries(1).delete()

    $excel.ScreenUpdating =$true
}

# ピボットテーブル作成のための関数
function CreatePivot($title, $xlcolf, $xlrowf, $xldataf, $xldataf2, $xlrowf2, $xldataf3){
    $excel.ScreenUpdating =$false

    # グラフサイズ定数
    $CHARTHIGHTH = 400
    $CHARTWIDTH  = 900

    # その他の定数
    $CHARTSTYLE = 328
    $XLDATABASE = 1
    $XLROWFIELD =1
    $XLCOLUMNFIELD = 2
    $XLDATAFIELD = 4
    $VERSION = 6
    $XLLINE = 4
    $XLLEGENDPOSITIONBOTTOM = -4107
    $MSOELEMENTDATALABELTOP = 208
    $XLCOLUMNCLUSTERED = 51

    # ピボットテーブルのデータ範囲を指定
    $range1 = $sheet.range("A1")
    $endrow = $sheet.Cells.Item(1, 1).end([Microsoft.Office.Interop.Excel.Xldirection]::xlDown).Row
    $endcol = $sheet.Cells.Item(1, 1).end([Microsoft.Office.Interop.Excel.Xldirection]::xlToRight).Column
    $range2 = $sheet.range($sheet.Cells.Item(1,$endcol), $sheet.Cells.Item($endrow, $endcol))
    $selection = $sheet.Range($range1, $range2)

    # ピボットキャッシュを作成しテーブルを作図する（キャッシュを経るのは必須の工程）
    $pivotcache = $book.PivotCaches().Create($XLDATABASE, $selection, $VERSION)
    $endcol += 2
    $destination = "R1C$endcol"
    $pivotcache.CreatePivotTable($destination, $sn) | Out-Null
    
    # 列の指定
    $pivotfields = $sheet.PivotTables($sn).PivotFields($xlcolf)
    $pivotfields.Orientation = $XLROWFIELD
    $pivotfields.Position = 1

    # 行の指定
    $pivotfields = $sheet.PivotTables($sn).PivotFields($xlrowf)
    $pivotfields.Orientation = $XLCOLUMNFIELD
    $pivotfields.Position = 1

    # 行の指定
    if($sn -eq "TicketsAmountPerName"){
        $pivotfields = $sheet.PivotTables($sn).PivotFields($xlrowf2)
        $pivotfields.Orientation = $XLCOLUMNFIELD
        $pivotfields.Position = 2
    }

    # データ部の指定
    $pivotfields = $sheet.PivotTables($sn).PivotFields($xldataf)
    $pivotfields.Orientation = $XLDATAFIELD
    $pivotfields.Position = 1

    # データフィールドが二つのシート用追加処理
    if(($sn -eq "TCPWPN") -or ($sn -eq "TicketsAmountPerName")){
        $pivotfields = $sheet.PivotTables($sn).PivotFields($xldataf2)
        $pivotfields.Orientation = $XLDATAFIELD
        $pivotfields.Position = 2

        # データフィールドへの処理
        $datapivotfield = $sheet.PivotTables($sn).DataPivotField
        $datapivotfield.Orientation = $XLCOLUMNFIELD
        $datapivotfield.Position = 2
    }

    # データフィールドが二つのシート用追加処理
    if($sn -eq "TCPWPN"){
        $pivotfields = $sheet.PivotTables($sn).PivotFields($xldataf3)
        $pivotfields.Orientation = $XLDATAFIELD

        # データフィールドへの処理
        $datapivotfield = $sheet.PivotTables($sn).DataPivotField
        $datapivotfield.Orientation = $XLCOLUMNFIELD
    }

    # 空白セルに0を入れる処理
    $sheet.PivotTables($sn).NullString = "0"

    # ピボットグラフの作成
    $newchart = $sheet.Shapes.AddChart2($CHARTSTYLE, $XLLINE, 1, 1, $CHARTWIDTH, $CHARTHIGHTH)
    $chartobj = $newchart.chart
    
    # タイトル表示
    $chartobj.HasTitle = $true
    $chartobj.ChartTitle.text = "$title"

    # データの設定
    $sorce = $sheet.PivotTables($sn).DataBodyRange
    $chartobj.SetSourceData($sorce)
    $chartobj.HasLegend = $true
    $chartobj.Legend.Position = $XLLEGENDPOSITIONBOTTOM
    $chartobj.SetElement($MSOELEMENTDATALABELTOP)

    # グラフ種類の変更
    if($sn -eq "TCPWPN"){
        for($i = 1; $i -le 24; $i++){
            if($i % 3 -eq 0){
                $chartobj.FullSeriesCollection($i).ChartType = $XLCOLUMNCLUSTERED
                $chartobj.FullSeriesCollection($i).AxisGroup = 1
            }
            else {
                $chartobj.FullSeriesCollection($i).ChartType = $XLLINE
                $chartobj.FullSeriesCollection($i).AxisGroup = 1
            }
        }
    }

    $excel.ScreenUpdating =$true
}

function MakeGantt(){
    # 定数設定
    $XLDATABAR = 4
    $XLDATABAFILLSOLID = 0
    $STARTDATECOL = 6
    $ENDDATECOL = 7
    $HOURSPERDAYCOL = 9
    $ESTIMATEDHOURSCOL = 4
    
    # 変数宣言
    $term = 35

    $endrow = $sheet.Cells.Item(1, 1).end([Microsoft.Office.Interop.Excel.Xldirection]::xlDown).Row
    $endcol = $sheet.Cells.Item(1, 1).end([Microsoft.Office.Interop.Excel.Xldirection]::xlToRight).Column

    for($i = 0; $i -le $term; $i++){
        $sheet.Cells.Item(1, $endcol + 2 + $i).value = Get-Date (Get-Date).AddDays(+$i) -Format yyyy/MM/dd
    }

    for($i = 2; $i -le $endrow; $i++){
        $startdate = $sheet.Cells.Item($i, $STARTDATECOL).value()
        $enddate   = $sheet.Cells.Item($i, $ENDDATECOL).value()
        
        for($j = 0; $j -le $term; $j++){
            $targetdate = $sheet.Cells.Item(1, $endcol + 2 + $j).value()
            if(($targetdate -ge $startdate) -and ($targetdate -le $enddate)){
                $sheet.Cells.Item($i, $endcol + 2 + $j).value() = $sheet.Cells.Item($i, $HOURSPERDAYCOL).value()
            } elseif((($targetdate -ge $startdate) -and ($targetdate -gt $enddate)) -and ($sheet.Cells.Item(1, $endcol + 2).value() -gt $enddate)){
                $sheet.Cells.Item($i, $endcol + 2 + $j).value() = $sheet.Cells.Item($i, $ESTIMATEDHOURSCOL).value()
            }
        }
    }
    for($i = 0; $i -le $term; $i++){
        $nowcol = $endcol + 2 + $i
        $first = $sheet.Cells.Item(2, $nowcol).Address()
        $last = $sheet.Cells.Item($endrow, $nowcol).Address()
        $formula = $first +  ":" + $last
        $sheet.Cells.Item($endrow + 1, $nowcol) = "=SUBTOTAL(9, $formula)"
    }
    # カラーバー設定
    $barrange = $sheet.Range($sheet.Cells.Item(2, $endcol), $sheet.Cells.Item($endrow, $endcol))
    $bar = $barrange.FormatConditions.Add($XLDATABAR, 3)
    $bar.BarFillType = $XLDATABAFILLSOLID

    # フィルター設定
    $sheet.Range("A1", $sheet.Cells.Item($endrow, $endcol + $term + 2)).AutoFilter() | Out-Null

    # 日付表示設定
    $targetarea = $sheet.Range($sheet.Cells.Item(1, $endcol + 2), $sheet.Cells.Item(1, $endcol + 2 + $term))
    $targetarea.Orientation = 90
    $targetarea.NumberFormatLocal = "m/d;@"
    $firstcol = $sheet.Cells.Item(1, $endcol + 2)
    $lastcol  = $sheet.Cells.Item(1, $endcol + 2 + $term)
    $sheet.Range($sheet.Columns.Item($endcol + 2), $sheet.Columns.Item($endcol + 2 + $term)).ColumnWidth = 4
}

# CSVファイル一つ毎の処理
foreach($csv IN $csvlist){
    $fn = $csv.name
    $sn = $fn.Substring(0, ($fn.Length - 4))
    $imcsv = Import-Csv .\$fn -Encoding Default
    $cntf = (Get-Content .\$fn | Select-Object -First 1 | % {$_ -replace """", ""})
    $cnthds = $cntf.Split(",")
    
    foreach($osn IN $oldsheets) {
        if($sn -eq $osn.Substring(4, $osn.Length - 4)){
            $book.Worksheets.Item("$osn").Delete()
        }
    }

    # 今回取り込んデータのシートを作成
    $sheetcount = $book.Sheets($book.Sheets.Count)
    $sheet = $book.Worksheets.Add([System.Reflection.Missing]::Value, $sheetcount)
    $sheet.Name = "$exetime$sn"

    # ヘッダーデータの取得
    $header = $cnthds

    $row = 0

    # データ部の書き込み（ヘッダー部）
    foreach($head IN $header){
        $row ++
        $sheet.Cells.Item(1, $row) = $head
        $col = 2

        # データ部の書き込み（データ部）
        foreach($data IN $imcsv){
            $sheet.Cells.Item($col, $row) = $data.$head
            $col ++
        }
    }

    # シート別処理振り分け部
    switch($sn){
        $seventh  { CreatePivot "<CHARTNAME>"1 2 3 }
        $eleventh { MakeGantt }
        $fifth    { CreatePivot "<CHARTNAME>" 1 2 3 }
        $third {
            $graph = @(@(0, 0), @(1, 4), @(1, 4), @(0, 0), @(0, 0), @(0, 0), @(1, 51))
            DrawChart 1 "<CHARTNAME>" $graph
            $graph = @(@(0, 0), @(0, 0), @(0, 0), @(0, 0), @(1, 51), @(0, 0), @(0, 0))
            DrawChart 2 "<CHARTNAME>" $graph
        }
        $forth  { CreatePivot "<CHARTNAME>" 1 2 3 }
        $nineth { CreatePivot "<CHARTNAME>" 1 2 3 4 0 6 }
        $sixth  { CreatePivot "<CHARTNAME>" 1 2 3 }
        $second {
            $graph = @(@(0, 0), @(1, 4), @(0, 0), @(0, 0), @(1, 4), @(0, 0), @(0, 0), @(0, 0), @(1, 51))
            DrawChart 1 "<CHARTNAME>" $graph
            $graph = @(@(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0), @(1, 53), @(1, 53), @(0, 0), @(0, 0))
            DrawChart 2 "<CHARTNAME>" $graph
        }
        $eighth {
            $graph = @(@(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0), @(1, 5))
            DrawChart 1 "<CHARTNAME>" $graph
        }
        $tenth { CreatePivot "<CHARTNAME>" 1 2 4 5 3 }
    }
}
# シートの移動
$book.Sheets("$exetime$second").Move($book.Sheets(2))
$book.Sheets("$exetime$third").Move($book.Sheets(3))
$book.Sheets("$exetime$forth").Move($book.Sheets(4))
$book.Sheets("$exetime$fifth").Move($book.Sheets(5))
$book.Sheets("$exetime$sixth").Move($book.Sheets(6))
$book.Sheets("$exetime$seventh").Move($book.Sheets(7))
$book.Sheets("$exetime$eighth").Move($book.Sheets(8))
$book.Sheets("$exetime$nineth").Move($book.Sheets(9))
$book.Sheets("$exetime$tenth").Move($book.Sheets(10))

# ブックの保存
$book.Save()

# エクセルの終了
$excel.Quit()

# 事後処理（変数等の解放とエクセルプロセスの停止）
$REPORTEXCEL = $null
$EXCELPATH = $null
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
