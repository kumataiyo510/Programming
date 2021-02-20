USE bitnami_redmine;

SELECT
    "project_name", "unfinished_tickets", "estimated_hours", "spend_times", "remaining_times", "ratio"

UNION

SELECT
    *
FROM
    (
    SELECT
        pj.name,
        COUNT(*) AS unfinished_tickets,
        IFNULL(ROUND(SUM(estimated_hours), 1), 0) AS iestimated_hours,
        IFNULL(no008.spend_times, 0),
        IFNULL(ROUND(SUM(estimated_hours) - no008.spend_times, 1), 0) AS remaining_time,
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
) AS finaltable
INTO OUTFILE <FILE PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
;