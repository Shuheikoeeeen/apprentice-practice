## step3

### 以下のデータを抽出するクエリを書いてください。

#### ①よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください

```
select sc.views as "エピソード視聴数", ep.title as "エピソードタイトル" 
from schedules as sc
inner join episodes as ep
on sc.episode_id = ep.episode_id
order by sc.views desc
limit 3;

```
#### ②よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください

```
select pr.title as "番組タイトル", se.series_no as "シーズン数", ep.episode_no as "エピソード数",ep.title as "エピソードタイトル", sc.views as "視聴数"
from episodes as ep
inner join schedules as sc
on sc.episode_id = ep.episode_id
inner join series as se
on ep.series_id = se.series_id
inner join programs as pr
on se.program_id = pr.program_id
order by views desc
limit 3;

```

#### ③本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします

```

select channel_name as "チャンネル名", air_date as "放送開始日", air_time as "放送開始時間", 
DATE_ADD(air_time, interval play_time MINUTE) as "放送終了時間", series_no as "シーズン数", 
episode_no as "エピソード数", ep.title as "エピソードタイトル", ep.details as "エピソード詳細"
from schedules as sc
inner join channels as ch
on sc.channel_id = ch.channel_id
inner join episodes as ep
on sc.episode_id = ep.episode_id
inner join series as se
on se.series_id = ep.series_id
where air_date = "2023-05-21";

```

#### ④ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください

```

select channel_name as "チャンネル名", air_date as "放送開始日", air_time as "放送開始時間", 
DATE_ADD(air_time, interval play_time MINUTE) as "放送終了時間", series_no as "シーズン数", 
episode_no as "エピソード数", ep.title as "エピソードタイトル", ep.details as "エピソード詳細"
from schedules as sc
inner join channels as ch
on sc.channel_id = ch.channel_id
inner join episodes as ep
on sc.episode_id = ep.episode_id
inner join series as se
on se.series_id = ep.series_id
where ch.channel_name = 'ドラマチャンネル'
and (air_date between '2023-05-21' and '2023-05-28');

```

#### ⑤(advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください

```

select pr.title as "番組タイトル", sc.views as "視聴数"
from schedules as sc
inner join channels as ch
on sc.channel_id = ch.channel_id
inner join episodes as ep
on sc.episode_id = ep.episode_id
inner join series as se
on se.series_id = ep.series_id
inner join programs as pr
on pr.program_id = se.program_id
and (air_date between '2023-05-14' and '2023-05-21')
order by sc.views desc
limit 2;

```

#### ⑥(advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。

```

select ge.genre_name as "ジャンル名",pr.title as "番組タイトル", round(avg(sc.views),1) as "エピソード平均視聴数"
from schedules as sc
inner join channels as ch
on sc.channel_id = ch.channel_id
inner join episodes as ep
on sc.episode_id = ep.episode_id
inner join series as se
on se.series_id = ep.series_id
inner join programs as pr
on pr.program_id = se.program_id
inner join program_genres as pg
on pr.program_id = pg.program_id
inner join genres as ge
on pg.genre_id = ge.genre_id
group by ge.genre_id
order by sc.views desc
limit 1;

```

＊解答はSTEP3_answerをご覧ください

