# Amateur's-sports-liege
### Amateur's sports liege database
:football: | :soccer: | :basketball: | :tennis: | :bowling: | :8ball: | :trophy:
</br>
</br>
**The database will be formed following tables:**</br>
- Team(tid, nickname, color)</br>
- Player(pid, pname, address, phone, rating, tid)</br>
- Coach(cid, cname, address, phone, status, tid)</br>
- Game(gdate, htid, vtid, hscore, vscore)</br>
- Points(pid, gdate, htid, pscore)</br>


>The system keeps information on the data status in the current season only
</br>

**The system also keeps information about:**</br>
-	Liege's teams</br>
-	Liege's players</br>
-	Liege's coaches</br>
-	Season's games</br>
-	Season's points for players of selected games</br>
</br>

**Primary keys:**
-	tid = Team identifier
-	pid = Player identifier
-	cid = coach identifier
-	gdate = date of game
-	htid = host's team identifier
-	vtid = visited team identifier
</br>

**Notes:**
-	Every coach has a status (0 or 1) which defines the seniority of each one (which 0 is a new coach the 1 is a senior coach)
-	Player identifier and Coach identifier are taking from the same value field (tid&cid)
-	Every Coach and Player are related to a Team and there is no team without a Coach
</br>



**Trigger Function:**</br>
When adding points to the Points table, the program will check if the player is belonging to a team who plays in the specific game. If not, the user will get an EROR message, and the insertion of points will not take place. If the player does belong to one of the teams playing in the specific game, the insertion will occur and the points for the specific team will be updated
</br>
</br>

**Queries:**
| Query number  | Values to print      | Query         |
| :---          | :---                 | :---          |
| - QD1 -       | pname                | Players that have a rating > 3 and plays in group number 2     |
| - QD2 -       | nickname, cname      | Coaches that coach a group with a blue uniform                 |
| - QD3 -       | nickname             | For every game, the nickname of the winning team                 |
| - QD4 -       | cname                | For every new coach(status=0), the amount of players in his team                 |
| - QD5 -       | pname, rating        | A player who played in at least 3 games and never got a score (points) < 10 in a game                                            |
| - QD6 -       | pname                | For every team, the mvp player (mvp player = player who got the highest total amount                                           of all the team's games)                 |
| - QD7 -       | tid, nickname, color | From teams who has never won a game, the team that accumulated the highest sum of                                              points in all of it games                 |

---
#### Postgresql 10 // PgAdmin4 </br>


