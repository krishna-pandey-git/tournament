-- Table definitions for the tournament project.
create table player (
id serial primary key,
name text
);

create table matches (
matchid serial primary key,
player1id integer references player(id),
player2id integer references player(id),
winnerid integer references player(id)
);

create view playerstanding as
select p.id,p.name,(select count(m.*) from matches m where m.winnerid=p.id) as win,
count(m1.matchid) as TotalMatch from player p left join matches m1 on p.id=m1.player1id or p.id=m1.player2id 
group by p.id,p.name 
order by win;

drop view playerstandingrank ;
create view playerstandingrank as
select *,ntile(2) over(order by totalmatch,win) playerrank from playerstanding;

-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.