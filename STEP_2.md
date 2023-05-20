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

### ③サンプルデータの格納

