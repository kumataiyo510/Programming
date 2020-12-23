次回は５章から
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
        または、変数よりも複雑な値を含めるには
            $header = "report for Today"
            $string = "$header `n('-' *  $header.length)"
        サブ式を利用する

    計算と算術
一般的なタスク
    単純なファイル
    構造化ファイル
    インターネット対応スクリプト
    コードの再利用
    リスト、配列、ハッシュテーブル
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