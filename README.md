# elasticsearch-practice

## これは何？
個人的に Elasticsearch を練習する意図の環境起動用ファイル一式です

## 起動方法
```
git clone https://github.com/sogaoh/elasticsearch-practice.git
cd elasticsearch-practice

docker-compose up -d
```

## Applications
- Elasticsearch
    - http://localhost:9200/
- Kibana 
    - http://localhost:5601/
- MySQL

## Plugins
- Elasticsearch
    - kuromoji


## How to import `world.sql` to DB
MySQL のサンプルDB `world.sql` を投入する手順

- https://dev.mysql.com/doc/index-other.html から `world database` をダウンロード
- ダウンロードしたデータを docker/mysql/sql/ ディレクトリに置いて、 `make upb` # docker-compose up -d --build
- dbコンテナに入り、以下を順次実行する
    - `docker-compose exec -it ${dbコンテナの CONTAINER ID or NAME} bash`
    - `cd docker-entrypoint-initdb.d`
    - (ls して world.sql.* の存在を確認。適宜、解凍する)
    - `mysql -u root mydb -p < world.sql`
    - `mysql -u root mydb -p` で DBに接続してデータを確認

DB から ElasticSearch への投入は refs の (*1) を参照して Python のスクリプトを適宜利用してください


## refs
- [Elasticsearch + Kibana を docker-compose でさくっと動かす - Qiita](https://qiita.com/nobuman/items/6308ea3bfd0aa0c58fdb)
- [(日本語用のAnalyzerであるプラグインanalysis-kuromojiを入れる)](https://tsgkdt.hatenablog.jp/entry/2019/01/03/215752)
- [docker-compose MySQL8.0 のDBコンテナを作成する](https://qiita.com/ucan-lab/items/b094dbfc12ac1cbee8cb)
- (*1) [MySQL(MariaDB)の表データからElasticsearchのインデックスにデータをインポートする](https://qiita.com/halhosono/items/91a54ef1ac691f43c11c) 
