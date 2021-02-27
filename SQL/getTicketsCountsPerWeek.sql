/*--------------------------------------------------
-- 出力（No.006 週別チケット増減数 + 未完了チケット累計数）
--------------------------------------------------*/
-- No.006
USE bitnami_redmine;

SELECT
    "y-m-w", "finished_tickets", "fi_judo_tickets", "fi_nodo_tickets", "created_tickets", "cr_judo_tickets", "cr_nodo_tickets", "calc_tickets", "unfinish_tickets"

UNION

SELECT
    no005a.yw4,
    no005a.finished_tickets,
    no005a.tracker_3judo AS fi_judo_tickets,
    no005a.tracker_5nodo AS fi_nodo_tickets,
    no005a.created_tickets,
    no005a.tracker2_3judo AS cr_judo_tickets,
    no005a.tracker2_5nodo AS cr_nodo_tickets,
    calc_tickets,
    (
        SELECT
            SUM(calc_tickets)
        FROM
            (
                -- No.005
                SELECT
                    *,
                    no003.created_tickets - no004.finished_tickets AS calc_tickets
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
                            COUNT(*) AS finished_tickets
                        FROM
                            (
                                -- No.002
                                SELECT
                                    i.closed_on
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
                            COUNT(*) AS created_tickets
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
    ) AS total_unfinished_tickets
FROM
    (
        -- No.005
        SELECT
            *,
            no003.created_tickets - no004.finished_tickets AS calc_tickets
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
                    COUNT(*) AS finished_tickets,
                    SUM(
                        CASE
                            WHEN tracker_id = 3
                                THEN 1
                            ELSE 0
                        END
                    ) AS tracker_3judo,
                    SUM(
                        CASE
                            WHEN tracker_id = 5
                                THEN 1
                            ELSE 0
                        END
                    ) AS tracker_5nodo
                FROM
                    (
                        -- No.002
                        SELECT
                            i.closed_on,
                            tracker_id
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
                    COUNT(*) AS created_tickets,
                    SUM(
                        CASE
                            WHEN tracker_id = 3
                                THEN 1
                            ELSE 0
                        END
                    ) AS tracker2_3judo,
                    SUM(
                        CASE
                            WHEN tracker_id = 5
                                THEN 1
                            ELSE 0
                        END
                    ) AS tracker2_5nodo
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
    ) AS no005a
INTO OUTFILE '<FILE_PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
;
