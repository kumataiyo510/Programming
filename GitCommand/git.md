次回は（https://backlog.com/ja/git-tutorial/stepup/17/ ）から

# Git
バージョン管理ツール
<br><br><br>

# Git用語
|名称|説明|
|---|---|
|clone | リモートリポジトリをローカルに複製作成すること|
|branch | 一連の修正を、主流から枝のように分岐させて管理するもの。ブランチでの修正なようはほかのブランチの影響を受けないため、同じリポジトリで同時に複数の開発を行うことができる。|
|checkout| ほかのブランチへ移動し、作業ディレクトリを任意のコミット状態にすること。|
|commit| 修正内容をローカルリポジトリに反映すること。|
|push |ローカルリポジトリの修正内容をリモートリポジトリに反映すること。|
|pull |リモートリポジトリの修正内容をローカルリポジトリに反映すること。|
|merge |異なるブランチの修正内容を反映すること。マージ先とマージ元の両方に変更履歴が残る。|
|fast-forward|ブランチとマスターが同じものになること。（マージではなく早送り）|
|coflict|マージの際に、リモートとローカルで同じファイルの同じ個所に対して修正がされており、自動でマージできないこと。両方の修正を合わせた内容に手動で編集する必要がある。マージをした際に、それぞれのファイルが編集されており衝突が起きている。|
|head|カレントブランチを指すポインタのこと。|
|tag|タグとは、コミットを参照しやすくするためにつけるもので、軽量タグと注釈付きタグがある。|
<br><br><br>

# Gitの基本的な考え方
1. リモートリポジトリ ⇔ push | pull ⇔ ローカルリポジトリ ⇔ commit | amend | revert ⇔ インデックス ⇔ add ⇔ ワークツリー
1. 基本の流れ push → error → merge(rebase) → push
<br><br><br>

# origin/master とは
- origin : remote repositoryの別名(URL指定の手間を省く)
- master : ブランチ名
<br><br><br>

# Git操作（基本的な流れ）
## バージョン確認
1. git --version

## 初期設定（.gitconfiにgitの設定は保存されている）
1. git config --global user.name "\<username>"
1. git config --global user.email \<emailaddress>
1. git config --global --list で確認する

## SSH接続の場合
1. 鍵を生成する（公開鍵と秘密鍵の作成）<br>
ssh-keygen -t rsa -b 4096 -C "\<comment>" <br>
-t : 鍵のタイプ<br>
-b : 鍵の長さ<br>
-C : コメント<br>
1. 秘密鍵のパーミッションを変更する<br>
chmod 600 ~/.ssh/\<keyname> <br>
1. SSH接続の設定を行う<br>
vi ~/.ssh/config <br>
Host \<hostname> <br>
HostName \<hostnmae> <br>
IdentityFile ~/.ssh/\<keyname> <br>
User \<usename> <br>
Port \<portnumber> <br>
TCPKeepAlive yes（常時接続設定）<br>
IdentitiesOnly yes（\<username>を利用して接続）<br>
ssh -T \<hostnmae>（接続テストを行う）<br>
## ローカルリポジトリからリモートリポジトリを作成する場合
1. ローカルリポジトリの作成（登録）<br>
git init<br>
1. 管理するファイルを登録<br>
git add \<FILENAME> <br>
1. メッセージを添えてコミットする<br>
git commit -m "\<message>" <br>
1. リモートリポジトリを登録する（次回からURLを入力する必要をなくす）<br>
git remote add \<URL_aliase> <Remote_Repository_URL> <br>
1. リモートリポジトリへプッシュする<br>
git push -u \<URL_aliase> <branch_name>
## リモートリポジトリからローカルリポジトリを作成する場合
1. リモートのクローンを\<Local_Directory>へ作成し作業開始<br>
git clone <Remote_Repository_URL> <Local_Directory>
<br><br><br>

# Gitコマンド
## ブランチの操作
- ブランチを作成する<br>
git branch \<NEWBRANCH> <br>
- ブランチの一覧を表示<br>
git branch
- すべてのブランチ（リモート含む）を表示<br>
git branch --all
- カレントブランチの切り替え<br>
git checkout \<BRANCHNAME>
- 特定のファイルのステージされていない変更を取り消す<br>
git checkout -- {FILENAME}
- ブランチの削除<br>
git brach -d <BRANCHNAME>
## マージ操作
- ソースブランチをカレントブランチにマージする<br>
git merge <SORCE_BRACHNAME>
- 祖先を異にするブランチ同士のマージが可能になる<br>
git merge --allow-unrelated-histories <branch_name>　
- リモートリポジトリの変更状況をmergeせずにローカルに持ってくる<br>
git fetch
- rebase先のコミットを取り込んでから、今のブランチのコミットをマージする<br>
git rebase
- リモートリポジトリーからローカルリポジトリーを更新する（fetch + merge）<br>
git pull
## コミット操作
- 直前のコミットを修正する<br>
git commit --amend
- \<commit>のコミットを取り消すためのコミットを作る<br>
git revert \<commit>
- \<commit>時点の状態まで完全に巻き戻す<br>
git reset --hard \<commit> 
## その他
- gitk       //guiでbranchの状況等を確認できる
- git log    //ローカルのcommitのログを確認できる
- git status //ワークツリーとインデックスの状態を確認する
- git remote get-url origin //originのurlを確認できる
- git push --delete origin branch_name //リモートブランチの削除
- git stash save \<message>　//変更を退避する
- git stash list　//退避した作業の一覧
- git stash apply stash@{0}　//退避した作業を元に戻す　stash名を指定しないと直前のstashが戻される
- git stash drop stash@{0}　//stash下作業を削除する
- git reset --hard HEAD //編集・ステージングいずれの変更内容を取り消し、最後にコミットした状態に戻す
- git tag \<tagname>  //軽量タグのつけ方
- git tag -a \<tagname>  //注釈付きタグの追加方法
- git tag -n タグの一覧とコメントの表示
- git tag -d タグの削除
- git revert \<revision> 過去のコミットを打ち消す
- git reset <--hard> \<HEAD~~> コミットを捨てる<二世代分消す>
- cherry-pick コミットを抜き取る
- git merge branchName早送りできればする、無理なら普通のマージ
- git merge --no-ff branchName   //常に普通のマージ（non fast-forward）
- git merge --ff-only branchName //常に早送り、できなければエラー


