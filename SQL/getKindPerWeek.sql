USE bitnami_redmine;

SELECT
    "y-m-w", "value", "ticket_counts"

UNION ALL

SELECT
    CONCAT(
        YEAR(i.created_on),
        "-", 
        RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2),
        "-",
        RIGHT(CONCAT("00", WEEK(i.created_on)), 3)
    ) AS yw12,
    IFNULL(cvft.value, "未設定"),
    COUNT(*)
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
INTO OUTFILE '<FILE PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'

;
