# Dockerとは
コンテナ技術（仮想化技術）<br><br>

# Dockerのメリット
* コマンドを何行か打つだけ
* コードで管理できる
* 誰のパソコンでも平等な環境
* Dockerデプロイ<br><br>
# Dockerイメージ
作成したいコンテナのイメージを取得する  
イメージの検索  
`search [オプション] [キーワード]`  
自分で作成する場合はDockerfileを作成する<br><br>
# コンテナ
イメージからコンテナを作成する（ビルドする）<br><br>
# Docker-compose
複数のコンテナを管理する  
docker-compose.ymlで管理する<br>
ただし、単体のコンテナであってもdocker-compose.ymlを利用してビルドすることは可能、その場合はDockerfileではなく、docker-compose.ymlによって設定はビルドされる

docker pull  
docker run  
docker stop  
docker start  
docker rm  
docker ps
docker exec -it [container_name | container_id] bash  
exit  
docker rm -i  


kino-code  
docker-compose up -d  

docker run -p 8888:8888 -v local_root:container_root --name container_name container_id