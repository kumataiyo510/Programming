/*--------------------------------------------------
-- No.000 ファイル出力
--------------------------------------------------*/
-- No.000
INTO OUTFILE '<filename>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'


/*--------------------------------------------------
-- No.001 全チケットSQL
--------------------------------------------------*/
-- No.001
SELECT
    COUNT(*) AS all_tickets
FROM
    issues
;


/*--------------------------------------------------
-- No.002（未）完了チケットSQL
--------------------------------------------------*/
-- No.002
SELECT
    COUNT(*) AS volume_tickets
FROM
    issues i
    LEFT OUTER JOIN issue_statuses iss
        ON i.status_id = iss.id
WHERE
    -- 未完了の場合は"0"に変更する
    iss.is_closed = 1
;


/*--------------------------------------------------
-- No.003 週別新規発行チケット数
--------------------------------------------------*/
-- No.003
SELECT
    CONCAT(
        YEAR(i.created_on), 
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ) AS yw,
    COUNT(*) AS created_tickets
FROM
    issues i
GROUP BY
    CONCAT(
        YEAR(i.created_on), 
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    )
;


/*--------------------------------------------------
-- No.004 週別完了チケット数
--------------------------------------------------*/
-- No.004
SELECT
    CONCAT(
        YEAR(no002.closed_on),
        "-",
        RIGHT(CONCAT("00", WEEK(closed_on)), 3)
    ) AS yw,
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
        RIGHT(CONCAT("00", WEEK(closed_on)), 3)
    )
;


/*--------------------------------------------------
-- No.005 週別チケット増減数
--------------------------------------------------*/
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
                RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)
            ) AS yw,
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
                RIGHT(CONCAT("00", WEEK(no002.closed_on)), 3)
            )
    )AS no004
    RIGHT OUTER JOIN (
        -- No.003
        SELECT
            CONCAT(
                YEAR(i.created_on), 
                "-",
                RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
            ) AS yw,
            COUNT(*) AS created_tickets
        FROM
            issues i
        GROUP BY
            CONCAT(
                YEAR(i.created_on),
                "-", 
                RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
            )
    ) AS no003
        ON no003.yw = no004.yw
;


/*--------------------------------------------------
-- 出力（No.006 週別チケット増減数 + 未完了チケット累計数）
--------------------------------------------------*/
-- No.006
SELECT
    no005a.yw4,
    no005a.finished_tickets,
    no005a.tracker_3judo AS judo_tickets,
    no005a.tracker_5nodo AS nodo_tickets,
    no005a.created_tickets,
    no005a.tracker2_3judo AS judo_tickets,
    no005a.tracker2_5nodo AS nodo_tickets,
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
;


/*--------------------------------------------------
-- 出力（No.007 プロジェクト別未完了チケット情報）
--------------------------------------------------*/
-- No.007
SELECT
    pj.name,
    COUNT(*) AS unfinished_tickets,
    ROUND(SUM(estimated_hours), 1) AS iestimated_hours,
    no008.spend_times,
    ROUND(SUM(estimated_hours) - no008.spend_times, 1) AS remaining_time,
    (
        ROUND(
            COUNT(*) / (
                SELECT
                    COUNT(*) AS unfinished_tickets2
                FROM
                    issues i
                    LEFT OUTER JOIN issue_statuses iss
                        ON i.status_id = iss.id
                WHERE
                    -- 未完了の場合は"0"に変更する
                    iss.is_closed = 0
            ) * 100, 1
        )
    ) AS ratio
FROM
    (
        -- No.002
        SELECT
            i.id AS iid,
            i.project_id,
            i.estimated_hours
        FROM
            issues i
            LEFT OUTER JOIN issue_statuses iss
                ON i.status_id = iss.id
        WHERE
            -- 未完了の場合は"0"に変更する
            iss.is_closed = 0
    ) AS no002
    LEFT OUTER JOIN projects AS pj
        ON no002.project_id = pj.id
    LEFT OUTER JOIN (
        -- No.008
        SELECT
            project_id AS project_id8,
            ROUND(SUM(hours), 1) AS spend_times
        FROM
            time_entries
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
                    iss.is_closed = 0
            )
        GROUP BY
            project_id
    ) AS no008
        ON pj.id = no008.project_id8
GROUP BY
    pj.id
ORDER BY
    unfinished_tickets DESC
;


/*--------------------------------------------------
-- No.008 プロジェクト別消費時間
--------------------------------------------------*/
-- No.008
SELECT
    project_id,
    SUM(hours)
FROM
    time_entries
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
            iss.is_closed = 0
    )
GROUP BY
    project_id
;


/*--------------------------------------------------
-- 出力（No.009 週別工数増減数 + 累計工数 + 実作業時間）
--------------------------------------------------*/
-- No.009
SELECT
    no005a.yw4,
    no005a.estimated_hours,
    no005a.finished_hours,
    no010.finished_tickets_total_spend_time AS spended_hours,
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
;


/*--------------------------------------------------
-- No.010 週別終了チケット実作業時間
--------------------------------------------------*/
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
;


/*--------------------------------------------------
-- 出力（No.011 週別作業種別完了チケットの実作業時間）
--------------------------------------------------*/
-- No.011
SELECT
    CONCAT(
        YEAR(hbtba.closed_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(hbtba.closed_on), "/1/1"), interval WEEK(hbtba.closed_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(hbtba.closed_on)), 3)
    ) AS yw011,
    hbtba.activity_id,
    hbtba.name,
    SUM(hbtba.hours) hbtba
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
;


/*--------------------------------------------------
-- 出力（No.012 週別どういったチケット種別のチケット数になっているか）
--------------------------------------------------*/
-- No.012
SELECT
    CONCAT(
        YEAR(i.created_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ) AS yw12,
    cvft.value,
    COUNT(*) AS ticket_counts
FROM
    issues i
    LEFT OUTER JOIN (
        SELECT
            customized_id,
            value
        FROM
            custom_values
        WHERE
            customized_type LIKE 'Issue'
            AND custom_field_id = 7
    ) AS cvft ON i.id = cvft.customized_id
GROUP BY
    CONCAT(
        YEAR(i.created_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ),
    cvft.value
;


/*--------------------------------------------------
-- No.013 個人別日別作業予定時間表
--------------------------------------------------*/
-- No.013
SELECT
    id,
    
FROM
    (
        SELECT
            i.*
        FROM
            issues i
            LEFT OUTER JOIN issue_statuses iss
                ON i.status_id = iss.id
        WHERE
            iss.is_closed = 0
    ) AS uf
    LEFT OUTER JOIN
        (
            SELECT
                issue_id,
                SUM(hours)
            FROM
                time_entries te
            GROUP BY
                issue_id
        ) AS st
        ON uf.id = st.issue_id
;


/*--------------------------------------------------
-- 出力（No.014 週別部署別問い合わせ件数）
--------------------------------------------------*/
-- No.014
SELECT
    CONCAT(
        YEAR(i.created_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ),
    vt.value,
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
GROUP BY
    CONCAT(
        YEAR(i.created_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ),
    vt.value
;


/*--------------------------------------------------
-- No.015
--------------------------------------------------*/
-- No.015

