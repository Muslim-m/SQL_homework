Puzzle 1: Finding Distinct Values
 Explain at least two ways to find distinct values based on two columns.
 ANSWERS:
 1)SELECT  DISTINCT * FROM InputTbl
 WHERE col1<col2;
2)SELECT DISTINCT CASE WHEN COL1 < COL2 THEN COL1 ELSE COL2 END AS col1,
       CASE WHEN COL1 < COL2 THEN COL2 ELSE COL1 END AS col2
FROM InputTbl;
Puzzle 2: Removing Rows with All Zeroes
Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
I am going to provide two solution for this puzzle
1)SELECT  * FROM TestMultipleZero
WHERE A!=0 or B!=0 or C!=0 or D!=0;
2)SELECT * FROM TestMultipleZero
WHERE A + B + C + D != 0;


Puzzle 3: Find those with odd ids
select * from  section1
where id%2=1;
Puzzle 4: Person with the smallest id (use the table in puzzle 3)
 SELECT * FROM section1
ORDER BY id ASC
LIMIT 1;
Puzzle 5: Person with the highest id (use the table in puzzle 3)
  SELECT * FROM section1
ORDER BY id DESC
LIMIT 1;
Puzzle 6:People whose name starts with b (use the table in puzzle 3)
    select * from section1
   where name like 'B%';
Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
select * from ProductCodes
where Code like '%!_%' escape  '!';

