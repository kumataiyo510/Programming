/*--------------------------------------------------
-- �o�́iNo.016 �T�ʃv���W�F�N�g�ʍ쐬�`�P�b�g�����j
--------------------------------------------------*/
-- No.016
USE bitnami_redmine

SELECT
    "created_week", "project_name", "creTicketCount"

UNION

SELECT
    CONCAT(YEAR(i.created_on), "-", RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2), "-", RIGHT(CONCAT("00", WEEK(i.created_on)), 3)) AS created_week,
    p.name,
    COUNT(*) AS "creTicketCount"
FROM
    issues i
    LEFT OUTER JOIN projects p ON i.project_id = p.id
GROUP BY
    CONCAT(YEAR(i.created_on), "-", RIGHT(CONCAT("00", MONTH(DATE_ADD(CONCAT(YEAR(i.created_on), "/1/1"), interval WEEK(i.created_on) * 7 day))), 2), "-", RIGHT(CONCAT("00", WEEK(i.created_on)), 3)),
    project_id
INTO OUTFILE '<FILE_PATH>'
CHARACTER SET 'sjis'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
;