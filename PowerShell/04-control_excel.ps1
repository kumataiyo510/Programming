try{
    # excelオブジェクト作成
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $true

    # ワークブック作成
    $book = $excel.Workbooks.Add()

    # シートの数を取得
    $book.Sheets.Count
    $book.Sheets(1).Name
    $book.ActiveSheet.Name = "hoge"
    $sheet = $book.sheets("hoge")

    # セルに値を入れる
    $sheet.Name
    $sheet.Cells.Item(1, 1) = 100
    $sheet.Cells.Item(1, 2) = 200
    $sheet.Range("A2", "B2") = 300

    $sheet.Range("A3") = "=SUM(A1:A2)"

    $sheet.Range("B1", "B2").copy($sheet.Range("C1", "C2"))

    $sheet.Range("C1:C2").Font.Bold = $true
    $sheet.Range("C1:C2").interior.ColorIndex = 3
    $sheet.Range("C1:C2").Font.ColorIndex = 2

    $sheet.Range("B1:B2").copy($sheet.Range("D1:D2"))
    $sheet.Range("D1:D2").Borders.LineStyle = 1

    
    # $book.SaveAs("C:\Users\kinta\Documents\test.xlsx")
    # $book.Close()
    # $excel.Quit()
}

catch{
    $excel,$book,$sheet | foreach{$_ =  $null}
}

finally{
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($sheet)
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($book)
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($excel)
    $excel,$book,$sheet | foreach{$_ =  $null}
    $excel = $null
    [GC]::Collect()
}