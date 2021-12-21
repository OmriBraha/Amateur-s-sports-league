--- Triger Function Q2 ----
create or replace function trigf1() returns trigger as $$
declare
	-- Team to player verificator
	team2player integer; 
begin
	select t.tid from team t, player p
	where p.tid = t.tid and new.pid = p.pid
	into team2player;
	-- the inserted teamID is the host team 
	if (team2player) in (select htid from game g where new.htid = g.htid and g.gdate = new.gdate)
	then
		update game g
		set hscore = hscore + new.pscore
		where htid = new.htid and g.gdate = new.gdate;
		return new;
	-- the inserted teamID is the visitor team
	elseif (team2player) in (select vtid from game g where new.htid = g.htid and g.gdate = new.gdate)
	then
		update game g
		set vscore = vscore + new.pscore
		where htid = new.htid and g.gdate = new.gdate;
		return new;
	-- non of the above
	else
		raise notice 'EROR! Iserting/updating the data has been failed due to missed relations between player to teams!';
	end if;
end;
$$ LANGUAGE plpgsql;

create trigger T1
before insert on points
for each row
execute procedure trigf1();

---------------------------------------------------------------------
--- All Queries QD(1-7) ----


-- QD1 --
select p.pname from player p
where p.tid = 2 and p.rating > 3;

-- QD2 --
select c.cname, t.nickname
from coach c, team t
where c.tid = t.tid and t.color = 'blue';

-- QD3 --
-- host wins --
select t.nickname, g.gdate, g.htid
from team t, game g
where t.tid = g.htid and hscore > vscore
-- union between result of the queries --
union
-- visitor wins --
select t.nickname, g.gdate, g.vtid
from team t, game g
where t.tid = g.vtid and hscore < vscore

-- QD4 --
select c.cid, c.cname, count(*)
from coach c, player p
where c.tid = p.tid and c.status = 0
group by c.cid;

-- QD5 --
select p.pname, p.rating
from player p, points x
where p.pid = x.pid and x.pscore > 10
group by p.pname, p.rating
having count(*) >= 3;

-- QD6 --
with temp (teamID, pName, totalPoints) as (
	select t.tid, p.pname, sum(x.pscore)
	from player p, points x, team t
	where t.tid = p.tid and p.pid = x.pid
	group by t.tid, p.pid)
select temp.teamID, temp.pName, temp.totalPoints
from temp
where temp.totalPoints = (select max(totalPoints) from temp as t where t.teamID = temp.teamID);

-- QD7 --
with teamsCollection(teams, totalScore) as (
	select htid as teams, sum(hscore) as totalScore
	from game
	group by htid
	union
	select vtid as teams, sum(vscore) as totalScore
	from game
	group by vtid
	)
select t.tid, t.nickname, t.color
from team t, game g, teamsCollection c
where t.tid not in (select tid from game g, team t
			   where g.htid = t.tid and g.hscore > g.vscore
			   union
			   select tid from game g, team t
			   where g.vtid = t.tid and g.hscore < g.vscore) 
			   and tid = c.teams
group by t.tid, t.nickname, t.color
having sum(c.totalScore) >=  all (select sum(g.hscore) as totalScore
								 from game g
								 group by g.htid
								 union
								 select sum(g.vscore) as totalScore
								 from game g
								 group by g.vtid);

