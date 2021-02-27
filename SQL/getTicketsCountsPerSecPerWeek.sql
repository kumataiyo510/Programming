/*--------------------------------------------------
-- 出力（No.014 週別部署別問い合わせ件数）
--------------------------------------------------*/
-- No.014
USE bitnami_redmine;

SELECT
    "y-m-w", "value", "counts"

UNION ALL

SELECT
    CONCAT(
        YEAR(i.created_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ),
    IFNULL(vt.value, "能動作業"),
    COUNT(*)
FROM
    issues i
    LEFT OUTER JOIN
        (
        SELECT
            *
        FROM
            custom_values
        WHERE
            custom_field_id = 2
        ) AS vt ON i.id = vt.customized_id
WHERE
    vt.value LIKE '%課%'
GROUP BY
    CONCAT(
        YEAR(i.created_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ),
    vt.value
INTO OUTFILE '<FILE_PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
;

