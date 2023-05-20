## step1

### 手順書

### ①データベースの構築



- データベースを作成
MySQLでデータベースを作成するために、CREATE DATABASE文というSQL文を実行します。以下のSQL文を実行してください。

`CREATE DATABASE internet_tv;`

データベース一覧を表示するSHOW DATABASES文でデータベースがきちんと作成されたか確認しましょう。

`SHOW DATABASES;`

なお、データベースやテーブル、列などの名前に使える文字はは**半角文字（アルファベット、数字、記号）に限られます**ので注意してください。

データベースの作成ができたら、次のステップはテーブルの構築です。

### ②テーブルの構築

- テーブルの作成

データベースを作成したらまずinternet_tvを利用するため、以下のSQL文を実行して下さい。

`USE internet_tv;`

CREATE TABLE文で①で作成したテーブルをinternet_tvの中に作成します。以下のSQL文を実行し、テーブルを作成しましょう。

- channelsテーブル

```

create table channels
(channel_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
channel_name VARCHAR(50) NOT NULL,
create_at TIMESTAMP,
update_at TIMESTAMP,
PRIMARY KEY (channel_id));

```



- genresテーブル

```

create table genres
(genre_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
genre_name VARCHAR(30) NOT NULL,
create_at TIMESTAMP,
update_at TIMESTAMP,
PRIMARY KEY (genre_id));

```
- programsテーブル


```

create table programs
(program_id INT UNSIGNED AUTO_INCREMENT NOT NULL,
title VARCHAR(50) NOT NULL,
details TEXT NOT NULL,
total_series TINYINT UNSIGNED,
create_at TIMESTAMP,
update_at TIMESTAMP,
PRIMARY KEY (program_id),
INDEX(title));

```

- program_genreテーブル

```

create table program_genres
(program_id INT UNSIGNED NOT NULL,
genre_id INT UNSIGNED NOT NULL,
create_at TIMESTAMP,
update_at TIMESTAMP,
PRIMARY KEY (program_id,genre_id),
FOREIGN KEY (program_id) REFERENCES programs(program_id),
FOREIGN KEY (genre_id) REFERENCES genres(genre_id));

```


- seriesテーブル

```


create table series
(series_id INT UNSIGNED NOT NULL auto_increment,
program_id INT UNSIGNED NOT NULL,
series_no TINYINT UNSIGNED,
total_episodes TINYINT UNSIGNED,
create_at TIMESTAMP,
update_at TIMESTAMP,
PRIMARY KEY (series_id),
FOREIGN KEY (program_id) REFERENCES programs(program_id),
INDEX(program_id)
);

```


- episodesテーブル

```

create table episodes
(episode_id INT UNSIGNED NOT NULL auto_increment,
series_id INT UNSIGNED NOT NULL,
episode_no TINYINT UNSIGNED,
title VARCHAR(100),
details TEXT,
play_time FLOAT NOT NULL,
publised_date DATE NOT NULL,
create_at TIMESTAMP,
update_at TIMESTAMP,
PRIMARY KEY (episode_id),
FOREIGN KEY (series_id) REFERENCES series(series_id),
INDEX(series_id)
);

```


- schedulesテーブル


```
create table schedules
(schedule_id INT UNSIGNED NOT NULL auto_increment,
channel_id INT UNSIGNED NOT NULL,
episode_id INT UNSIGNED NOT NULL,
air_date DATE NOT NULL,
air_time TIME NOT NULL,
views INT UNSIGNED NOT NULL,
create_at TIMESTAMP,
update_at TIMESTAMP,
PRIMARY KEY (schedule_id),
FOREIGN KEY (channel_id) REFERENCES channels(channel_id),
FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
INDEX(episode_id)
);


```

- データ型を確認するにはDESCRIBE <テーブル名>で確認できます。

### ③サンプルデータの格納

テーブルが作成できたら、それぞれに以下のSQL文でサンプルデータを格納しましょう。

- channelsテーブル

```
INSERT INTO channels (channel_name, create_at, update_at) VALUES
  ('アニメチャンネル', NOW(), NOW()),
  ('映画チャンネル', NOW(), NOW()),
  ('ドラマチャンネル', NOW(), NOW()),
  ('バラエティチャンネル', NOW(), NOW()),
  ('子供向けチャンネル', NOW(), NOW());
```

- genresテーブル

```

INSERT INTO genres (genre_name, create_at, update_at) VALUES
  ('アニメ', NOW(), NOW()),
  ('日本映画', NOW(), NOW()),
  ('ハリウッド映画', NOW(), NOW()),
  ('韓国映画', NOW(), NOW()),
  ('日本ドラマ', NOW(), NOW()),
  ('アメリカドラマ', NOW(), NOW()),
  ('韓国ドラマ', NOW(), NOW()),
  ('ドキュメンタリー', NOW(), NOW()),
  ('音楽', NOW(), NOW()),
  ('子供向け', NOW(), NOW()),
  ('SF', NOW(), NOW()),
  ('格闘技', NOW(), NOW()),
  ('クラシック', NOW(), NOW()),
  ('教育', NOW(), NOW()),
  ('バラエティ', NOW(), NOW()),
  ('スポーツ', NOW(), NOW()),
  ('ニュース', NOW(), NOW()),
  ('旅行', NOW(), NOW());

```

- programsテーブル

```
INSERT INTO programs (title, details, total_series, create_at, update_at) VALUES
  ('ドラえもん', '21世紀にタイムスリップしてやってきたネコ型ロボット「ドラえもん」と、彼の友達「野比のび太」の冒険を描くアニメシリーズ。未来の道具を使ってさまざまな問題を解決します。', 3, NOW(), NOW()),
  ('タイタニック', '実在した豪華客船タイタニック号の運命を描いた映画。1912年に起きた沈没事故と、乗客と乗組員のドラマを追います。', null ,NOW(), NOW()),
  ('逃げるは恥だが役に立つ', 'OLの「森山みくり」と「津崎平匡」が偽装結婚し、共同生活を送ることになるラブコメドラマ。お互いの違いや葛藤を乗り越えながら、心を通わせていきます。', 2, NOW(), NOW()),
  ('ワンピース', '海賊王を目指す少年「モンキー・D・ルフィ」の冒険を描く大人気アニメシリーズ。仲間との絆や海賊の世界を舞台に、数々の戦いや冒険を繰り広げます。', 2, NOW(), NOW()),
  ('アメトーク', '日本バラエティ。芸人が色々面白いことする', 1, NOW(), NOW());
 
  
```
- program_genreテーブル

```
INSERT INTO program_genres (program_id, genre_id, create_at, update_at) VALUES
  (1, 1, NOW(), NOW()),
  (1, 10, NOW(), NOW()),
  (2, 3, NOW(), NOW()),
  (3, 5, NOW(), NOW()),
  (4, 1, NOW(), NOW()),
  (5, 14, NOW(), NOW()),
  (5, 15, NOW(), NOW());

```
- seriesテーブル

```
INSERT INTO series (program_id, series_no, total_episodes, create_at, update_at) VALUES
  (1, 1, 2, NOW(), NOW()),
  (1, 2, 2, NOW(), NOW()),
  (1, 3, 3, NOW(), NOW()),
  (2, null , null , NOW(), NOW()),
  (3, 1, 2, NOW(), NOW()),
  (3, 2, 3, NOW(), NOW()),
  (4, 1, 2, NOW(), NOW()),
  (4, 2, 1, NOW(), NOW()),
  (5, 1, 2, NOW(), NOW());

```
- episodesテーブル

```
INSERT INTO episodes (series_id, episode_no, title, details, play_time, publised_date, create_at, update_at) VALUES
  (1, 1, 'ドラえもん season1_Episode 1', 'ドラえもんの第1話です。', 24.5, '2023-05-01', NOW(), NOW()),
  (1, 2, 'ドラえもん season1_Episode 2', 'ドラえもんの第2話です。', 24.5, '2023-05-08', NOW(), NOW()),
  (2, 1, 'ドラえもん season2_Episode 1', 'ドラえもんのシーズン２第1話です。', 24.5, '2023-05-11', NOW(), NOW()),
  (2, 2, 'ドラえもん season2_Episode 2', 'ドラえもんのシーズン２第2話です。', 24.5, '2023-05-12', NOW(), NOW()),
  (3, 1, 'ドラえもん season3_Episode 1', 'ドラえもんのシーズン３第1話です。', 40.5, '2023-05-13', NOW(), NOW()),
  (3, 2, 'ドラえもん season3_Episode 2', 'ドラえもんのシーズン３第2話です。', 24.5, '2023-05-14', NOW(), NOW()),
  (3, 3, 'ドラえもん season3_Episode 3', 'ドラえもんのシーズン３第3話です。', 30.5, '2023-05-15', NOW(), NOW()),
  (4, NULL, 'タイタニック', 'タイタニックです。', 120.0, '1993-05-02', NOW(), NOW()),
  (5, 1, '逃げるは恥だが役に立つ season_1 Episode 1', '逃げるは恥だが役に立つの第1話です。', 45.0, '2022-05-03', NOW(), NOW()),
  (5, 2, '逃げるは恥だが役に立つ season_1 Episode 2', '逃げるは恥だが役に立つの第2話です。', 45.0, '2022-05-10', NOW(), NOW()),
  (6, 1, '逃げるは恥だが役に立つ season_2 Episode 1', '逃げるは恥だが役に立つのシーズン２第1話です。', 45.0, '2023-05-03', NOW(), NOW()),
  (6, 2, '逃げるは恥だが役に立つ season_2 Episode 2', '逃げるは恥だが役に立つのシーズン２第2話です。', 45.0, '2023-05-10', NOW(), NOW()),
  (6, 3, '逃げるは恥だが役に立つ season_2 Episode 3', '逃げるは恥だが役に立つのシーズン２第3話です。', 45.0, '2023-05-10', NOW(), NOW()),
  (7, 1, 'ワンピース Episode 1', 'ワンピースの第1話です。', 23.5, '2023-05-04', NOW(), NOW()),
  (7, 2, 'ワンピース Episode 2', 'ワンピースの第2話です。', 23.5, '2023-05-11', NOW(), NOW()),
  (8, 1, 'アメトーク Episode 1', 'アメトークの第1話です。', 60.0, '2020-05-05', NOW(), NOW()),
  (8, 2, 'アメトーク Episode 2', 'アメトークの第2話です。', 60.0, '2020-05-05', NOW(), NOW());
  
```
- schedulesテーブル

```
INSERT INTO schedules (channel_id, episode_id, air_date, air_time, views, create_at, update_at) VALUES
(1, 1, '2023-05-20', '20:00:00', 1000, NOW(), NOW()),
(1, 2, '2023-05-21', '20:00:00', 1500, NOW(), NOW()),
(2, 1, '2023-05-22', '19:30:00', 800, NOW(), NOW()),
(2, 2, '2023-05-23', '19:30:00', 1200, NOW(), NOW()),
(3, 1, '2023-05-25', '21:00:00', 2000, NOW(), NOW()),
(3, 2, '2023-05-26', '21:00:00', 1800, NOW(), NOW()),
(3, 3, '2023-05-27', '21:00:00', 2200, NOW(), NOW()),
(4, 7, '2023-05-21', '18:00:00', 500, NOW(), NOW()),
(5, 8, '2023-05-22', '22:30:00', 900, NOW(), NOW()),
(6, 10, '2023-05-23', '19:00:00', 700, NOW(), NOW()),
(7, 13, '2023-05-24', '20:30:00', 1500, NOW(), NOW()),
(8, 15, '2023-05-25', '22:00:00', 1800, NOW(), NOW());
```