Solution-1: Using ROUND, ROW_NUMBER, CEIL Function

SELECT t.lat
FROM(
    SELECT ROUND(LAT_N, 4) as lat, 
    ROW_NUMBER() OVER(ORDER BY LAT_N) AS ROW_NUM
    FROM STATION
    ORDER BY ROW_NUM
  ) t
WHERE t.ROW_NUM = CEIL((SELECT COUNT(*) + 1 FROM STATION) / 2);



Solution-2: Using ROUND, ROW_NUMBER, FLOOR Function

SELECT t.lat 
FROM(
    SELECT ROUND(LAT_N, 4) as lat,
    ROW_NUMBER() OVER(ORDER BY LAT_N) AS ROW_NUM
    FROM STATION
    ORDER BY ROW_NUM
  ) t
WHERE t.ROW_NUM IN (FLOOR((SELECT COUNT(*) + 1 FROM STATION) / 2), FLOOR((SELECT COUNT(*) + 2 FROM STATION) / 2));



Solution-3: Using ROUND, FLOOR Function

SELECT ROUND(t.LAT_N, 4)
FROM(
    SELECT s.LAT_N,
      @rownum := @rownum + 1 as `row_number`,
      @total_rows := @rownum
    FROM STATION s, (SELECT @rownum := 0) r
    ORDER BY s.LAT_N
  ) as t
WHERE t.row_number IN (FLOOR((@total_rows + 1) / 2), FLOOR((@total_rows + 2) / 2));



Solution-4: Using ROUND, FLOOR Function

SELECT ROUND(t.LAT_N, 4)
FROM(
    SELECT s.LAT_N,
      @rownum := @rownum + 1 as `row_number`
    FROM STATION s, (SELECT @rownum := 0) r
    ORDER BY s.LAT_N
  ) as t
WHERE t.row_number IN (FLOOR((@rownum + 1) / 2), FLOOR((@rownum + 2) / 2));
