## step1

### テーブル設計


テーブル：channels


| カラム名 | データ型 | NULL | キー|初期値 |AUTO INCREMENT|
| --- | --- |--- |--- |--- |--- |
| channel_id | INT UNSIGNED | | PRIMARY| |AUTO INCREMENT| 
| channel_name |VARCHAR(50)|
| create_at |TIMESTAMP|
| update_at |TIMESTAMP|

テーブル：genres


| カラム名 | データ型 | NULL | キー|初期値 |AUTO INCREMENT|
| --- | --- |--- |--- |--- |--- |
| genre_id | INT UNSIGNED | | PRIMARY|| AUTO INCREMENT| 
| genre_name |VARCHAR(30)|
| create_at |TIMESTAMP|
| update_at |TIMESTAMP|

テーブル：programs

| カラム名 | データ型 | NULL | キー|初期値 |AUTO INCREMENT|
| --- | --- |--- |--- |--- |--- |
| program_id | INT UNSIGNED | |PRIMARY||AUTO INCREMENT | 
| title |VARCHAR(50)|| INDEX |
| details |text|
| total_series |TINYINT UNSIGNED|YES|
| create_at |TIMESTAMP|
| update_at |TIMESTAMP|



テーブル：program_genres


| カラム名 | データ型 | NULL | キー|初期値 |AUTO INCREMENT|
| --- | --- |--- |--- |--- |--- |
| program_id | INT UNSIGNED | |PRIMARY| | 
| genre_id |INT UNSIGNED||PRIMARY|
| create_at |TIMESTAMP|
| update_at |TIMESTAMP|

- 外部キー制約：program_id,genre_idに対して、それぞれprogramsテーブル、genresテーブルのidカラムから設定

テーブル：series

| カラム名 | データ型 | NULL | キー|初期値 |AUTO INCREMENT|
| --- | --- |--- |--- |--- |--- |
| series_id | INT UNSIGNED | |PRIMARY||AUTO INCREMENT | 
| program_id |INT UNSIGNED||INDEX|
| series_no |TINYINT UNSIGNED|YES||
| total_episodes |TINYINT UNSIGNED|YES|
| create_at |TIMESTAMP|
| update_at |TIMESTAMP|

- 外部キー制約：program_id に対して、programsテーブルのid カラムから設定

テーブル：episodes

| カラム名 | データ型 | NULL | キー|初期値 |AUTO INCREMENT|
| --- | --- |--- |--- |--- |--- |
| episode_id | INT UNSIGNED | |PRIMARY||AUTO INCREMENT | 
| series_id |INT UNSIGNED||INDEX|
| episode_no |TINYINT UNSIGNED|YES||
| title |VARCHAR(100)|YES|
| details |TEXT|YES|
| play_time |FLOAT|||
| published_date |DATE||
| create_at |TIMESTAMP|
| update_at |TIMESTAMP|

- 外部キー制約：series_id に対して、seriesテーブルのid カラムから設定

テーブル：schedules

| カラム名 | データ型 | NULL | キー|初期値 |AUTO INCREMENT|
| --- | --- |--- |--- |--- |--- |
| schedule_id | INT UNSIGNED | |PRIMARY||AUTO INCREMENT | 
| channel_id |INT UNSIGNED|
| episode_id |INT UNSIGNED||INDEX|
| air_date |DATE||
| air_time |TIME||
| views |INT UNSIGNED|||0|
| create_at |TIMESTAMP|
| update_at |TIMESTAMP|

- 外部キー制約：channel_id,episode_idに対して、それぞれchannelsテーブル、episodesテーブルのidカラムから設定

![ER図](https://github.com/Shuheikoeeeen/apprentice-practice/assets/127010682/0c67544b-18c0-46cc-b2f4-8c737e9d442f)

