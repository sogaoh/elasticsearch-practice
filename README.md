# elasticsearch-practice

## これは何？
個人的に Elasticsearch を練習する意図の環境起動用ファイル一式です

## Pre-Requirements
- Docker (version 19.03.5, build 633a0ea)
- docker-compose (version 1.24.1, build 4667896b)

## 起動手順

### Volume作成

```sh
docker volume create db-store
docker volume create es-data

#docker volume create db-log  # 書き込みがうまくいかないのでローカルで保持する
```

### 一式の取得と起動
```sh
git clone https://github.com/sogaoh/elasticsearch-practice.git
cd elasticsearch-practice

docker-compose up -d
```

## Applications
- Elasticsearch
    - http://localhost:9200/
- Kibana 
    - http://localhost:5601/
- Logstash
- MySQL

## Plugins
- Elasticsearch
    - kuromoji


## Practice(s)

### 1. MySQLのデータをElasticSearchに取り込む

~~データと MySQLのJDBCコネクタ はこのリポジトリに同梱していないので取得が必要です~~  
-> 同梱するようにしたので取得不要です。起動すれば取り込まれます。  
　（マシンスペックによるものの、結構時間かかります）


#### How to import `world.sql` to DB
MySQL のサンプルDB `world.sql` を投入する手順

- https://dev.mysql.com/doc/index-other.html から `world database` をダウンロード
- ダウンロードしたデータを docker/mysql/sql/ ディレクトリに置いて、 `make upb` # docker-compose up -d --build
- dbコンテナに入り、以下を順次実行する
    - `docker exec -it mysql bash`
        - ( `docker exec -it ${dbコンテナの CONTAINER ID or NAME} bash` )
    - `cd docker-entrypoint-initdb.d`
    - (ls して world.sql.* の存在を確認。適宜、解凍する)
    - `mysql -u root -p < world.sql`
    - `mysql -u root world -p` で DBに接続してデータを確認

DB から ElasticSearch への投入は refs の (*1) を参照して Python のスクリプトを適宜利用するか、
↓の Logstash を使ってデータを流す方法を利用してください


#### How to import `world.city Data` to ElasticSearch via Logstash 
world database の city テーブルを Logstash を使って ElasticSearch に流す手順

- (前提) `world database` 投入済み
- https://www.mysql.com/jp/products/connector/ から MySQLのJDBCコネクタ(JDBC Driver for MySQL (Connector/J))をダウンロード [^1]
- ダウンロードしたコネクタ (jarファイル) を docker/logstash/ ディレクトリに置く
- docker-compose.yml の `service: logstash` パートのコメントアウトを外す
- `make upb` # docker-compose up -d --build
- http://localhost:9200/city/_count で取り込まれた件数を確認可能
    - 取り込み中・起動中の場合、 ElasticSearch(localhost:9200)・Kibana(localhost:5601)のURLリクエストが失敗するが、少し時間が経てば確認できると思う


## refs
- [Elasticsearch + Kibana を docker-compose でさくっと動かす - Qiita](https://qiita.com/nobuman/items/6308ea3bfd0aa0c58fdb)
- [(日本語用のAnalyzerであるプラグインanalysis-kuromojiを入れる)](https://tsgkdt.hatenablog.jp/entry/2019/01/03/215752)
- [docker-compose MySQL8.0 のDBコンテナを作成する](https://qiita.com/ucan-lab/items/b094dbfc12ac1cbee8cb)
- (*1) [MySQL(MariaDB)の表データからElasticsearchのインデックスにデータをインポートする](https://qiita.com/halhosono/items/91a54ef1ac691f43c11c) 
- [Dockerで、DatabaseからElasticsearchにLogstashを使ってデータを流してみた](https://qiita.com/takayuki-miura0203/items/ba9d59a8b267d785d0c6)
- [[solved] Multiple logstash config file - Logstash - Discuss the Elastic Stack](https://discuss.elastic.co/t/solved-multiple-logstash-config-file/51692/10)
- [LogstashがElasticsearchにつながらない - Discuss the Elastic Stack](https://discuss.elastic.co/t/logstash-elasticsearch/206159/2)
- [絶対的に使った方がいいLogstashのMultiple Pipelinesについて書いてみた - Qiita](https://qiita.com/micci184/items/24e197a168891f089b3d)

# Footnote
[^1] : ダウンロードにはOracleアカウントのサインアップが必要になる