USE bitnami_redmine

SELECT
    "y-m-w", "assigned_name", "project_name", "created_ticket_count", "closed_ticket_count"

UNION

SELECT
    created_week AS "y-m-w",
    created_table.username,
    created_table.name,
    IFNULL(created_table.cr_ticket_count, 0) AS created_ticket_count,
    IFNULL(closed_ticket_count, 0) AS closed_ticket_count
FROM
    (
        SELECT
            CONCAT(YEAR(i.created_on), "-", RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2), "-", RIGHT(CONCAT("00", WEEK(i.created_on)), 3)) AS created_week,
            CONCAT(us.lastname, us.firstname) AS "username",
            i.assigned_to_id,
            pj.name,
            COUNT(*) AS cr_ticket_count
        FROM
            issues i
            LEFT OUTER JOIN users AS us ON i.assigned_to_id = us.id
            LEFT OUTER JOIN projects AS pj ON i.project_id = pj.id
        GROUP BY
            CONCAT(YEAR(i.created_on), "-", RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2), "-", RIGHT(CONCAT("00", WEEK(i.created_on)), 3)),
            i.assigned_to_id,
            project_id
    ) AS created_table
    LEFT OUTER JOIN(
        SELECT
            CONCAT(YEAR(no002.closed_on), "-", RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(no002.closed_on), "/1/1"), interval WEEK(no002.closed_on) * 7 day))), 2), "-", RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)) AS closed_week,
            CONCAT(us.lastname, us.firstname) AS "username",
            no002.assigned_to_id,
            COUNT(*) AS closed_ticket_count
        FROM
            (
                -- No.002
                SELECT
                    i.closed_on,
                    i.assigned_to_id
                FROM
                    issues i
                    LEFT OUTER JOIN issue_statuses iss
                        ON i.status_id = iss.id
                WHERE
                    iss.is_closed = 1
            ) AS no002
            LEFT OUTER JOIN users AS us ON no002.assigned_to_id = us.id
        GROUP BY
            CONCAT(YEAR(no002.closed_on), "-", RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(no002.closed_on), "/1/1"), interval WEEK(no002.closed_on) * 7 day))), 2), "-", RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)),
            no002.assigned_to_id
    ) AS closed_table ON created_table.created_week = closed_table.closed_week AND created_table.assigned_to_id = closed_table.assigned_to_id
INTO OUTFILE '<FILE PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
;