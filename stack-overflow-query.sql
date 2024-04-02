
SELECT *
FROM
  (SELECT tags_delimited
        ,  count(*) AS cnt
   FROM
     (SELECT string_agg(t.tagname, ',') within GROUP (
                                                      ORDER BY t.tagname) AS tags_delimited
      FROM posts p
      INNER JOIN posttags pt ON p.id = pt.postid
      INNER JOIN tags t ON pt.tagid = t.id
      WHERE t.count > 5000
      GROUP BY p.id) ts
   GROUP BY ts.tags_delimited) gb
WHERE cnt > 35
ORDER BY tags_delimited