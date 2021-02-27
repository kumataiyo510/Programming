/*--------------------------------------------------
-- èoóÕÅiNo.009 èTï çHêîëùå∏êî + ó›åvçHêî + é¿çÏã∆éûä‘Åj
--------------------------------------------------*/
-- No.009
USE bitnami_redmine;

SELECT
    "y-m-w", "estimated_hours", "finished_hours", "spended_hours", "jitu_spended_ratio", "calc_hours", "total_hours"

UNION

SELECT
    no005a.yw4,
    no005a.estimated_hours,
    no005a.finished_hours,
    IFNULL(no010.finished_tickets_total_spend_time, 0)AS spended_hours,
    100 - ROUND((IFNULL(no010.finished_tickets_total_spend_time, 0) / no005a.finished_hours) * 100, 1) AS jitu_spended_ratio,
    no005a.calc_hours,
    (
        SELECT
            SUM(calc_hours) AS total_hours1
        FROM (
            -- No.005
            SELECT
                *,
                no003.estimated_hours - no004.finished_hours AS calc_hours
            FROM
                (
                    -- No.004
                    SELECT
                        CONCAT(
                            YEAR(no002.closed_on),
                            "-",
                            RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(no002.closed_on), "/1/1"), interval WEEK(no002.closed_on) * 7 day))), 2),
                            "-",
                            RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)
                        ) AS yw4,
                        ROUND(SUM(estimated_hours), 1) AS finished_hours
                    FROM
                        (
                            -- No.002
                            SELECT
                                i.closed_on,
                                i.estimated_hours
                            FROM
                                issues i
                                LEFT OUTER JOIN issue_statuses iss
                                    ON i.status_id = iss.id
                            WHERE
                                iss.is_closed = 1
                        ) AS no002
                    GROUP BY
                        CONCAT(
                            YEAR(no002.closed_on),
                            "-",
                            RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(no002.closed_on), "/1/1"), interval WEEK(no002.closed_on) * 7 day))), 2),
                            "-",
                            RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)
                        )
                )AS no004
                RIGHT OUTER JOIN (
                    -- No.003
                    SELECT
                        CONCAT(
                            YEAR(i.created_on), 
                            "-",
                            RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
                            "-",
                            RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
                        ) AS yw3,
                        ROUND(SUM(estimated_hours), 1) AS estimated_hours
                    FROM
                        issues i
                    GROUP BY
                        CONCAT(
                            YEAR(i.created_on),
                            "-", 
                            RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
                            "-",
                            RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
                        )
                ) AS no003
                    ON no003.yw3 = no004.yw4
            ) AS no005b
        WHERE
            no005b.yw4 <= no005a.yw4
    ) AS total_hours
FROM(
    -- No.005
    SELECT
        *,
        no003.estimated_hours - no004.finished_hours AS calc_hours
    FROM
        (
            -- No.004
            SELECT
                CONCAT(
                    YEAR(no002.closed_on),
                    "-",
                    RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(no002.closed_on), "/1/1"), interval WEEK(no002.closed_on) * 7 day))), 2),
                    "-",
                    RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)
                ) AS yw4,
                ROUND(SUM(estimated_hours), 1) AS finished_hours
            FROM
                (
                    -- No.002
                    SELECT
                        i.closed_on,
                        i.estimated_hours
                    FROM
                        issues i
                        LEFT OUTER JOIN issue_statuses iss
                            ON i.status_id = iss.id
                    WHERE
                        iss.is_closed = 1
                ) AS no002
            GROUP BY
                CONCAT(
                    YEAR(no002.closed_on),
                    "-",
                    RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(no002.closed_on), "/1/1"), interval WEEK(no002.closed_on) * 7 day))), 2),
                    "-",
                    RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)
                )
        )AS no004
        RIGHT OUTER JOIN (
            -- No.003
            SELECT
                CONCAT(
                    YEAR(i.created_on), 
                    "-",
                    RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
                    "-",
                    RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
                ) AS yw3,
                ROUND(SUM(estimated_hours), 1) AS estimated_hours
            FROM
                issues i
            GROUP BY
                CONCAT(
                    YEAR(i.created_on),
                    "-", 
                    RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
                    "-",
                    RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
                )
        ) AS no003
            ON no003.yw3 = no004.yw4
    ) no005a
    LEFT OUTER JOIN (
        -- No.010
        SELECT
            CONCAT(
                YEAR(i.closed_on),
                "-", 
                RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.closed_on), "/1/1"), interval WEEK(i.closed_on) * 7 day))), 2),
                "-",
                RIGHT(CONCAT("00", WEEK(i.closed_on)), 3)
            ) AS yw10,
            SUM(ft.hours) AS finished_tickets_total_spend_time
        FROM(
            SELECT
                issue_id,
                ROUND(SUM(hours), 1) AS hours
            FROM
                time_entries AS te
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
                issue_id
            ) AS ft
             LEFT OUTER JOIN issues AS i
                ON ft.issue_id = i.id
        GROUP BY
            CONCAT(
                YEAR(i.closed_on),
                "-", 
                RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.closed_on), "/1/1"), interval WEEK(i.closed_on) * 7 day))), 2),
                "-",
                RIGHT(CONCAT("00", WEEK(i.closed_on)), 3)
            )
    ) AS no010
        ON no010.yw10 = no005a.yw4
INTO OUTFILE 'FILE_PATH'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'

;