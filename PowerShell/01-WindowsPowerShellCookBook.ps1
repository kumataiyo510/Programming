次回は12章から
PowerShellの基本
    Windows PowerShell インタラクティブシェル
        コマンドの基本は Verb-Noun
        pushd . 現在のロケーションをスタックに格納し、指定したディレクトリへ移動します。
        popd    スタックからロケーションを取得し、カレントディレクトリにします。
        パワーシェルの実行コマンド
            & 'c:\program files\program\program.exe' arguments
            &は実行演算子
            powershell "& 'スクリプトのフルパス' arguments"
        パワーシェルで頻出のコマンド
            Get-Command
            Get-Help
            Get-Member
        最後に終了したスクリプトまたはアプリケーションの終了コード／エラーレベルを表す数値
            $LASTEXITCODE
        コマンドの継続時間を測定する
            Measure-Command
        リダイレクション演算子とout-fileコマンドレットの使い分け
            Out-Fileは出力幅の構成と文字コードなどの情報を指定できる
            リダイレクション演算子は対象の個々のストリームに対して制御できる"example.exe 2> errors.txt"
        リストとして表示
            Format-List
            Format-Table
            Format-Wide
        現在のセッションで発生したすべてのエラーは$Error配列に含まれている
            $Error[]
    パイプライン
        出力項目のフィルタリングをしたい(Where-Object)処理は一つの変数ずつ処理
            Get-Process | Where-Object{ $_.Name -like "*search"}
        リストの各項目を処理したい(foreach)≒%≒foreach-object
            1..10 | ForEach-Object{ $_ * 2 }
        CSVファイルを取り込んで、ヘッダーファイル名ごとにプロパティをもつオブジェクトを自動的に生成する
            $date = Import-Csv
    変数とオブジェクト
        変数のメモリ開放
            $Variable = $null
        環境変数にアクセスする
            PowerShellは環境プロバイダを通じて環境変数へのアクセスを提供します。規定では環境プロバイダを操作するドライブ(env)を作成し、環境変数へのアクセスを可能にします。
                env:variablename
            ドライブを通じてではなく直接プロバイダにアクセスしたい場合は
                environment::variablename
        変数、エイリアス、関数、ドライブ等の項目に関するアクセスとスコープを制御する(Global, Script, Local)
            $SCOPE:variable = value
        .NET オブジェクトを利用する
            PowerShellは、メソッド（スタティックとインスタンス）およびプロパティにアクセスするための方法を提供しています。
            クラスのスタティックメソッドを呼び出すには、型名を角括弧で囲み、次に２つのコロンを置いてクラス名とメソッド名を区切ります。
                [ClassName]::MethodName(parameter_list)
            オブジェクトのメソッドを呼び出すには、オブジェクトを表す変数とメソッド名の間にドットを入れる。
                $objectReference.MethodName(parameter_list)
            クラスのスタティックプロパティにアクセスするには、型名を角括弧で囲み、次に２つのコロンを置いてクラスメイトプロパティ名を区切ります。
                [ClassName]::PropertyName
            オブジェクトのプロパティにアクセスするにはオブジェクトを表す変数とプロパティ名の間にドットを置きます。
                $objectReference.PropertyName
            スタティックメソッド（プロパティ）
                クラスがあらわす概念のみに適用されるメソッド（プロパティ）である。インスタンスには適用されない。
            インスタンスを作成する
                $obj = new-object system.random
                $obj.nextdouble()
            現在のオブジェクトがサポートするメソッドやプロパティを知りたい場合
                $object | Get-Member
            スタティックメソッドやスタティックプロパティを知りたい場合
                $object | Get-Member -Static
    ループ処理とフロー制御
        $temperature = 90
        if($temperature -le 0){
            "balmy Canadian Summer"
        }
        elseif($temperature -le 32) {
            "Freezing"            
        }
        elseif($temperature -le 50){
            "cold"
        }
        else{
            "hot"
        }

        switch ($temperature) {
            {$_ -lt 32} {"Below Freezing"; break}
            32          {"Exactly Freezing";break}
            {$_ -le 50} {"cold"; break}
            Default     {"hot"}
        }

        for($i = 0; $i -le 10; $i++){
            "Loop number $i"
        }

        foreach ($file in dir) {
            "File length; " + $file.length
        }

        Get-ChildItem | ForEach-Object{"File length; " + $_.Length}

        $response = ""
        while ($response -ne "QUIT") {
            $response = Read-Host "Type something"
        }

        $response1 = ""
        do {
            $response1 = Read-Host "Type something1"
        } while ($response1 -ne "QUIT")

        一時停止または遅延を追加する
        Read-Host                       #エンターによる入力完了まで入力を受け付ける（待ちで使える）
        $host.ui.RawUI.ReadKey()        #入力を受け付ける（待ちで利用できる）
        Start-Sleep -Milliseconds 300   #時間指定で待ち

        #一定の速度でループを実行（ループ内のコマンド完了までの時間を計測し、それから目的の時間との差を埋めて遅延させる
        $loopDelayMilliseconds = 650
        while($true){
            $startTime = Get-Date

            write-host "hello world"

            $endTime = Get-Date
            $loopLength = ($endTime - $startTime).totalmilliseconds
            $timeRemaining = $loopDelayMilliseconds - $loopLength

            if($timeRemaining -gt 0){
                Start-Sleep -Milliseconds $timeRemaining
            }
        }
        
    文字列と非構造化テキスト
        展開文字列と非展開文字列
            "hello world"  #展開文字列
            'hello $world' #非展開（リテラル）文字列（変数が展開されずに処理される）
        ヒア文字列
            改行やその他の書式情報を含むテキストを格納する
            $string = @"
            この間はヒア文字列とし
            て認識されるので
"@
        エスケープシーケンス
            `を利用
        動的な情報を文字列に入れる
            $header = "report for Today"
            $string = "$header `n--"
            または、変数よりも複雑な値を含めるにはサブ式を利用する
                $header = "report for Today"
                $string = "$header `n$('-' *  $header.length)"
        書式設定された情報（右揃えや特定の桁数での丸め数字）を文字列に配置したい #0は数量で8は右から8桁目、D4は十進数4桁で1は価格を表しcは通貨を表す
            $formatString = "{0,8:D4} {1:C}'n"
            $report  = "Quantity Price'n"
            $report += "--------------'n"
            $report += $formatString -f 50, 2.5677
            $report += $formatString -f 3, 9
            #以下結果
            "@
            Quantity Price
            --------------
                0050  \3
                0003  \9
"@
        例2
            $number1 = 10; $number2 = 32;
            "{0} divied by {1} is {2}" -f $number2, $number1, ($number2 / $number1)
            #結果 32 divided by 10 is 3.2
        文字列検索
            "hello world" -like "*llo w" #ワイルドカード利用可能（低機能単純４行でルールをかける）
            "hello world" -match '.*l[l-z]o w.*$' #正規表現利用可能（高機能複雑使用規則で１冊の本ができる）
            "hello world".contains("world") #結果はTrue
            "hello world".IndexOf("world") #結果は6
            #検索結果を変数に格納するとオブジェクトになるので検索がうまくできないことがある
            $helpContent = Get-Help Get-ChildItem
            $helpContent -match "場所" #結果はFalse
            $helpContent = Get-Help Get-ChildItem | out-string
            $helpContent -match "場所" #結果はTrue
        文字列置換
            "hello world".Replace("world", "powershell") #簡単な置換
                #結果 hello powershell
            "hello world" -replace '(.*) (.*)','$2 $1' #高度な置換（正規表現を利用可能）
                #結果 world hello
        空白や特定の文字の削除
            "hello world".TrimEnd('d','l','r') #結果 heo wo
        日付を比較するときはオブジェクト動詞を比較するように注意する
        テキストデータのやり取りに使うコマンド
            sed の置き換えで -replace #テキスト置換
            grepの置き換えで select-string #テキスト検索
        大きなレポートまたは大量のデータを生成するスクリプト
            $files = Get-ChildItem c:\*.txt -recurse
            $files | Out-File c:\temp\AllTextFiles.txt #1
            Get-ChildItem c:\*.txt -recurse | out-file c:\temp\AllTextFiles.txt #2
                2はストリーミング処理されるので1よりも早い処理が可能になる
    計算と算術
        オブジェクトのリストの数値特性またはテキスト特性を測定したい
        1..10 | measure-object -Average -Sum #数値特性
        get-childitem | measure-object -p0roperty Length -max -min -average -sum #特定のプロパティの数値特性
        get-content output.txt | measure-object -character -word -line #テキスト特性の測定
一般的なタスク
    単純なファイル
        ファイルの中身を取得する
            get-content ファイル名　#一行ずつ処理され、それぞれに情報が付加される（オブジェクトとして）
            get-content [system.io.file]::ReadAllText("ファイル名") #ファイルをすべて読みだして処理する
        ファイルから文字列または正規表現を検索する
            Select-String -Simple 検索内容 ファイル名
            Select-String "\(...|) ...-...." ファイル名 #正規表現を利用
            Get-ChildItem | Where { $_ | Select-String "Debug" -Quiet}
        テキストベースのファイルの解析と管理
            convert-textobject　#を利用する
        一時ファイルを作成する
            [system.io.path]::GetTempFileName() #を利用する
        ファイル内でテキストの検索／置換を行う（基本形）
            $filename    = "filename.txt"
            $match       = "source text"
            $replacement = "replacement text" 
            $content = Get-Content $filename
            $content = $content -creplace $match, $replacement
            $content | Set-Content $filename
    構造化ファイル
        xmlファイルの情報へのアクセスと処理を行いたい
            xmlファイルへキャストする
                $xml = [xml](get-content powershell_blog.sml) #この型であれば、プロパティへアクセスするように、またメソッドのようにデータへアクセス可能
            xmlファイルのデータを修正する
                $filename = (get-item phone.xml).FullName
                Get-Content $filename
                <AddressBook>
                  <Person contactType="Personal">
                    <Name>Lee</Name>
                    <Phone type="home">555-1212</Phone>
                    <Phone type="work">555-1213</Phone>
                  </Person>
                  <Person contactType="Personal">
                    <Name>Ariel</Name>
                    <Phone>555-1234</Phone>
                  </Person>
                </AddressBook>
                $phoneBook = [xml](get-content $filename)
                $person = $phoneBook.AddressBook.Person[0]
                $person.Phone[0]."#text" = "555-1214"
                $person.Phone[0].type = "mobile"
                $newNumber = [xml]'<Phone type="home">555-1215</Phone>'
                $newNode  = $phoneBook.ImportNode($newNumber.Phone, $true)
                [void]$person.AppendChild($newNode)
                $phoenBook.Save($filename)
    インターネット対応スクリプト
        インターネットからファイルをダウンロードする #downloadfileメソッドを使用※ユーザーエージェント（ブラウザ情報）やプロキシ、資格情報を指定も可能
            $source = "http://www.leeholmes.com/favicon.ico"
            $destination = "c:\temp\favicon.ico"
            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($source, $destination)
        インターネットからWebページをダウンロードする
            System.Net.WebClientクラスのDownloadString()メソッドを使用
        コマンド出力をWebページとしてエクスポートする
            $filename = "c:\temp\help.html"
            $commands = Get-Command | where {$_.CommandType -ne "alias"}
            $summary = $commands | Get-Help | select name,synopsis
            $summary |ConvertTo-Html | Set-Content $filename
    コードの再利用
        関数を記述する
            function functionName (hikisu){
                statement
            }
            fanctionName hikisu #関数の呼び出し
        スクリプト、関数、スクリプトブロックからデータを返す
            #コレクション（配列やArrayList）などから出力パイプラインに書き出す際には、コレクションの状態を保つにはコレクションを戻す際にコレクション名の前にカンマ(,)をつける
            function WriteArrayList {
                $arrayList = New-Object System.Collections.ArrayList
                [void]$arrayList.Add("Hello")                
                [void]$arrayList.Add("world")
                ,$arrayList
            }
            WriteArrayList
    リスト、配列、ハッシュテーブル
        配列の作り方 #配列とリストの違いは、配列はあらかじめメモリを確保して連続した番地へ記録（軽いが、追加等が難しい）、リストはポインタでデータをつなげる（重いが、追加等が簡単）
            $myArray = 1, 2, "hello world"
            $myArray = new-object string[] 10 #特定のサイズ
            $myArray = new-object System.Collections.ArrayList
        リストの作り方
            $myArray = Get-Process
        ジャグ配列と多次元配列 #ジャグ配列は配列に配列を入れる、多次元配列は配列の中にすべての情報が入っている
            $jagged = @(
                (1,2,3,4),
                (5,6,7,8)
            )

            $multidimensional = new-object "int32[,]" 2,4
        比較演算子
            -cointains 含まれているかの真偽を図る
            -like ワイルドカード
            -match 正規表現
        配列の要素の検索
            $array -eq "Item 1" #-like -matchも可能
        ハッシュテーブルの作成
            $myHashTable = @{key1 = "value1"; key2 = 1, 2, 3; key3 = 5}
        ハッシュテーブルの要素へ順番にアクセスする #ハッシュテーブルは順番の概念を持っていないので、すべてにアクセスするためにgetenumeratorメソッドが用意されている
            foreach($item in $myHashTable.GetEnumerator() | sort name){
                $item.value
            }
    ユーザーとの対話
    トレースとエラー管理
    実行環境の認識
    Windows PowerShellの適用範囲を広げる
    セキュリティとスクリプト署名
管理者タスク
    ファイルとディレクトリ
    Windowsレジストリ
    データの比較
    イベントログ
    プロセス
    システムサービス
    Active Directory
    企業のコンピュータ管理
    Exchange Server 2007の管理
    Operations Manager 2007 の管理
付録
    PowerShell言語と環境
    正規表現リファレンス
    PowerShell自動変数
    標準のPowerShell動詞
    便利な.NETクラスとその使用法
    WMIリファレンス
    便利なCOMオブジェクトとその使用法
    .NETの文字列書式
    .NET DateTime書式指定子