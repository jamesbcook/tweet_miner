tweet_miner
===========


A ruby script that gathers data from Twitter in real time and saves it to a database

Sources: [pg-gem] (https://github.com/ged/ruby-pg) or [sqlite3-gem] (https://github.com/sparklemotion/sqlite3-ruby),  [mysql2-gem](https://github.com/brianmario/mysql2) and [tweetstream gem](https://github.com/tweetstream/tweetstream)

***run script***

```   
miner_<database>.rb <db_name> <table_name> <search_terms>
```

***example***

```

./miner_pg.rb twitter trending NSA,Obama
```
***output in the db***
```

 11 | Patriot Act signed away so many civil liberties. Politicians dnt care about the NSA.                                                             | LazareStJames   | 416693480157904896 | en   | Quito                      | 2013-12-27 15:14:02 -0700
 12 | Big Mouth Toys Funny Toilet Paper: Obama http://t.co/B1qimysjN9                                                                                  | MARKETINGDEFINE | 416693484087566337 | en   | Pacific Time (US & Canada) | 2013-12-27 15:14:03 -0700
 13 | Need to find me my Michelle Obama                                                                                                                | KingLP1         | 416693485165887488 | en   |                            | 2013-12-27 15:14:03 -0700
 14 | RT @LeMarquand: Obama's top homeland security adviser, still wondering about the arsenal of arms &amp; tanks... http://t.co/Tucv3piN3t           | jeanlaurienti1  | 416693486860398593 | en   |                            | 2013-12-27 15:14:03 -0700
 15 | Obama, Democrats Push for Extension of Unemployment Benefits http://t.co/yAvuKlbZd9                                                              | DemocracyMotion | 416693488445431808 | en   | Eastern Time (US & Canada) | 2013-12-27 15:14:04 -0700
 16 | I get nauseous when people talk about Obama.                                                                                                     | madddmuse       | 416693489523372032 | en   | Quito                      | 2013-12-27 15:14:04 -0700
```
