/*--------------------------------------------------
-- 出力（No.011 週別作業種別完了チケットの実作業時間）
--------------------------------------------------*/
-- No.011
USE bitnami_redmine;

SELECT
    "y-m-w", "activity_name", "hours"

UNION

SELECT
    CONCAT(
        YEAR(hbtba.closed_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(hbtba.closed_on), "/1/1"), interval WEEK(hbtba.closed_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(hbtba.closed_on)), 3)
    ) AS yw011,
    hbtba.name,
    ROUND(SUM(hbtba.hours), 1) AS tmp
FROM
    (
        SELECT
            issue_id,
            activity_id,
            en.name,
            ROUND(SUM(hours), 1) AS hours,
            i.closed_on
        FROM
            time_entries AS te
            LEFT OUTER JOIN enumerations en
                ON te.activity_id = en.id
            LEFT OUTER JOIN issues i
                ON te.issue_id = i.id
        WHERE
            issue_id IN (
                -- No.002
                SELECT
                    i.id
                FROM
                    issues i
                    LEFT OUTER JOIN issue_statuses iss
                        ON i.status_id = iss.id
                WHERE
                    iss.is_closed = 1
            )
        GROUP BY
            issue_id,
            activity_id,
            en.name
    ) AS hbtba
GROUP BY
    CONCAT(
        YEAR(hbtba.closed_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(hbtba.closed_on), "/1/1"), interval WEEK(hbtba.closed_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(hbtba.closed_on)), 3)
    ),
    hbtba.activity_id
INTO OUTFILE '<FILE_PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
;