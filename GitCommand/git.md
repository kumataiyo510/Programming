次回は（https://backlog.com/ja/git-tutorial/stepup/17/ ）から

# Git

## Git用語
- repository : データを保存する場所、修正履歴も保存されている
- remote repository : サーバにあるリポジトリ
- local repository : ローカルに保存されているリポジトリ
- clone : リモートリポジトリを複製作成すること
- branch : 一連の修正を、主流から枝のように分岐させて管理するもの。ブランチでの修正なようはほかのブランチの影響を受けないため、同じリポジトリで同時に複数の開発を行うことができる。
- checkout ほかのブランチへ移動し、作業ディレクトリを任意のコミット状態にすること。
- commit 修正内容をローカルリポジトリに反映すること。
- push ローカルリポジトリの修正内容をリモートリポジトリに反映すること。
- pull リモートリポジトリの修正内容をローカルリポジトリに反映すること。
- merge 異なるブランチの修正内容を反映すること。マージ先とマージ元の両方に変更履歴が残る。
	- git merge branchName早送りできればする、無理なら普通のマージ
	- git merge --no-ff branchName   //常に普通のマージ（non fast-forward）
	- git merge --ff-only branchName //常に早送り、できなければエラー
- fast-forward ブランチとマスターが同じものになること（マージではなく早送り）
- coflict マージの際に、リモートとローカルで同じファイルの同じ個所に対して修正がされており、自動でマージできないこと。両方の修正を合わせた内容に手動で編集する必要がある。マージをした際に、それぞれのファイルが編集されており衝突が起きている。
- master masterブランチの事
- head カレントブランチを指すポインタ

## origin/master とは

- origin : remote repositoryの別名(URL指定の手間を省く)
- master : ブランチ名（その枝分かれ時点での最新のコミット）

## Git操作
    バージョン確認
        git --version
	初期設定 : .gitconfiにgitの設定は保存されている
		git config --global user.name "YOURNAME"
		git config --global user.email YOURNAME@EXAMPLE.COM
		git config --global --list で確認する
	SSH接続の場合
        鍵を生成する
            ssh-keygen -t rsa -b 4096 -C "TOWRITEANYCOMMENT"
            //-t で鍵のタイプ, -b で鍵の長さ, -C でコメントを付加
            //NAMEOFKEY.pubの公開鍵とNAMEOFKEYの秘密鍵が作成されます
            chmod 600 ~/.ssh/NAMEOFKEY
            //秘密鍵のパーミッションを変更する
            vi ~/.ssh/config
                Host bitbucket.org
                HostName bitbucket.org
                IdentityFile ~/.ssh/id_rsa_bitbucket
                User git
                Port 22
                TCPKeepAlive yes
                IdentitiesOnly yes
            //bitbucketへの接続は自動的にid_rsa_bitbucketが使用されるようにします
            ssh -T bitbucket.org
            //接続テスト
	Gitコマンド
		ローカルリポジトリからリモートリポジトリを作成する場合
			git init
			//ローカルリポジトリとして登録
			git add <FILENAME>
			//管理するファイルを登録
			git commit -m "MESSAGE"
			//メッセージを添えてコミットする
			git remote add <origin> <REMOTE_REPOSITRY_URL>
			//リモートリポジトリを登録する（次回からURLを入力する必要をなくす:originがURLの別名になる）
			git push -u origin master
			//masterブランチへpushする
		リモートリポジトリからローカルリポジトリを作成する場合
			git clone <REMOTE_REPOSITRY_URL> <directory>
			//リモートのクローンを<directory>へ作成し作業開始
		ブランチの操作
			git branch <NEWBRANCH>
			//ブランチを作成する
			git branch
			//ブランチの一覧を表示、*でカレントブランチがどこにあるのか表示
			git branch --all //remoteも含めてブランチ情報を取得
			git checkout <BRANCHNAME>
			//カレントブランチの切り替え
			git checkout -- {FILENAME}
			//特定のファイルのステージされていない変更を取り消す
			git brach -d <BRANCHNAME>
			//ブランチの削除
		マージ操作
			git merge <SORCE_BRACHNAME>
			//ソースブランチをカレントブランチにマージする
		コミット操作
			git commit --amend
			//直前のコミットを修正する
			//コメントやコミットファイルなど

## gitコマンド
gitk       //guiでbranchの状況等を確認できる
git log    //ローカルのcommitのログを確認できる
git status //ワークツリーとインデックスの状態を確認する
git remote get-url origin //originのurlを確認できる
git revert <commit> //<commit>のコミットを取り消すためのコミットを作る
git reset --hard <commit> //<commit>時点の状態まで完全に巻き戻す
git rebase //rebase先のコミットを取り込んでから、今のブランチのコミットをマージする
git merge --allow-unrelated-histories マージ先のブランチ名　//祖先を異にするブランチ同士のマージが可能になる
git fetch //リモートリポジトリの変更状況をローカルに持ってくる、mergeまではせずに情報だけ持ってくるイメージ
git push --delete origin branch_name //リモートブランチの削除
git stash save <message>　//変更を退避する
git stash list　//退避した作業の一覧
git stash apply stash@{0}　//退避した作業を元に戻す　stash名を指定しないと直前のstashが戻される
git stash drop stash@{0}　//stash下作業を削除する
git reset --hard HEAD //編集・ステージングいずれの変更内容を取り消し、最後にコミットした状態に戻す
git pull //リモートリポジトリーからローカルリポジトリーを更新する fetch + merge


リポジトリ ⇔ commit ⇔ インデックス ⇔ add ⇔ ワークツリー
基本の流れ push → error → merge(rebase) → push