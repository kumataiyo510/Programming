/*--------------------------------------------------
-- èoóÕÅiNo.019 íSìñï ì˙ï çÏã∆éûä‘ó\íËÅj
--------------------------------------------------*/
-- No.019
USE bitnami_redmine
SELECT
    "id", "project_name", "subject", "estimated_hours", "username", "start_date", "due_date", "interval", "hours_per_day", "done_ratio"

UNION

SELECT
    *
FROM
    (
        SELECT
            i.id,
            pj.name,
            i.subject,
            ROUND(IFNULL(estimated_hours, 0), 2) AS estimated_hours,
            CONCAT(us.lastname, us.firstname) AS "username",
            i.start_date,
            i.due_date,
            DATEDIFF(due_date, start_date) + 1 AS "interval",
            IFNULL(ROUND(estimated_hours / (DATEDIFF(due_date, start_date) + 1), 2), 0) AS hours_per_day,
            i.done_ratio
        FROM
            issues i
            LEFT OUTER JOIN issue_statuses iss ON i.status_id = iss.id
            LEFT OUTER JOIN users us ON i.assigned_to_id = us.id
            LEFT OUTER JOIN projects AS pj ON i.project_id = pj.id
        WHERE
            iss.is_closed = 0
        ORDER BY
            start_date
    ) AS work_tbl
INTO OUTFILE '<FILE_PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
;


