select 
	LEFT(p.PROJ_DESCR,3) AS 'Site',
	t.PROJ_CODE AS 'Project number',
	p.PROJ_DESCR AS 'Project',
	t.TASK_NBRI AS 'Task number',
	c.TASK_DESCR AS 'Task',
	c.TASK_STAGE AS 'Task stage',
	CASE c.TASK_STAGE
		WHEN 'C' THEN 'Financially complete'
		WHEN 'A' THEN 'Approved'
		WHEN 'R' THEN 'Cancelled'
		ELSE 'Work complete'
	END AS 'Task stage description',	
	ISNULL(r.supp_name,'') AS 'Supplier name',
	c.TASK_NARR AS 'Task narration',
	t.EST_AMT1 AS 'Estimate',
	t.REST_AMT1 AS 'Revised estimate',
	t.ACT_COM_AMT1 AS 'Commitments',
	t.ACT_AMT1 AS 'Actual',
	c.CRUSER AS 'Create user',
	c.CRDATEI AS 'Create date',
	c.TASK_APPR_USER AS 'Task approver',
	c.TASK_APPR_DATEI AS 'Task approved date',
	m.UF_VAL05 AS 'Refurb handover date',
	m.UF_VAL12 AS 'Length of license',
	a.ACTY_DESCR AS 'Activity',
	ISNULL(k.ASSNBRI,'') AS 'Asset number',
	ISNULL(s.DESCR,'') AS 'Asset description',
	ISNULL (g.descr,'') AS 'Catalogue'
from F1WRK_TASK_BAL_VW t
LEFT JOIN F1WRK_TASK_EST e ON t.TASK_NBRI = e.TASK_NBRI
LEFT JOIN F1WRK_PROJ_CTL p ON t.PROJ_CODE = p.PROJ_CODE
LEFT JOIN AMRPT_PROJECT_UF_VAL m ON t.PROJ_CODE = m.PROJ_CODE
LEFT JOIN PUF_REQ_CTL r ON t.TASK_NBRI = r.prqnbr
LEFT JOIN F1WRK_TASK_CTL c ON t.TASK_NBRI = c.TASK_NBRI
LEFT JOIN F1WRK_ACTY_CTL a ON a.ACTY_CODE = t.ACTY_CODE
LEFT JOIN F1ASR_WS_MNT_ASS w ON t.TASK_NBRI = w.TASK_NBRI
LEFT JOIN F1WRK_TASK_CTL_ASS k ON t.TASK_NBRI = k.TASK_NBRI
LEFT JOIN F1WRK_TASK_LNE l ON t.TASK_NBRI = l.TASK_NBRI
LEFT JOIN INF_CLG_PROD g ON l.SUP_PROD_NBR = g.prod_nbr
LEFT JOIN F1ASR_REG_ASSET s ON k.ASSNBRI = s.ASSNBRI
WHERE
	t.WORK_SYS_NAME = 'REFURB'
	AND
	t.PROJ_CODE like 'REF%'
	AND
	c.TASK_STAGE <> 'R'
ORDER BY
	Site,
	[Project number],
	[Task number];

-- below are two tables for refurb handover date. 1st has column headings, 2nd has values
select * from AMRPT_PROJECT_UF_LBL
where PROJ_CODE = 'REF000648'

select * from AMRPT_PROJECT_UF_VAL
where PROJ_CODE = 'REF000648'
