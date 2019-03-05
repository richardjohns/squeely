select 
	t.PROJ_CODE AS 'Project number',
	p.PROJ_DESCR AS 'Project',
	t.TASK_NBRI AS 'Task number',
	c.TASK_DESCR AS 'Task',
	r.supp_name AS 'Supplier name',
	c.TASK_NARR AS 'Task narration',
	t.EST_AMT1 AS 'Estimate',
	t.REST_AMT1 AS 'Revised estimate',
	t.ACT_AMT1 AS 'Actual',
	c.CRDATEI AS 'Create date',
	c.FINAL_COMPL_DATEI AS 'Final Complete Date',
	a.ACTY_DESCR AS 'Activity',
	w.ASSNBRI AS 'Asset number',
	w.ASSET_LONG_DESCR AS 'Asset',
	-- l.SUP_CODE,
	-- l.SUP_PROD_NBR,
	g.descr
from F1WRK_TASK_BAL_VW t
LEFT JOIN F1WRK_TASK_EST e ON t.TASK_NBRI = e.TASK_NBRI
LEFT JOIN F1WRK_PROJ_CTL p ON t.PROJ_CODE = p.PROJ_CODE
LEFT JOIN PUF_REQ_CTL r ON t.TASK_NBRI = r.prqnbr
LEFT JOIN F1WRK_TASK_CTL c ON t.TASK_NBRI = c.TASK_NBRI
LEFT JOIN F1WRK_ACTY_CTL a ON a.ACTY_CODE = t.ACTY_CODE
LEFT JOIN F1ASR_WS_MNT_ASS w ON t.TASK_NBRI = w.TASK_NBRI
LEFT JOIN F1WRK_TASK_LNE l ON t.TASK_NBRI = l.TASK_NBRI
LEFT JOIN INF_CLG_PROD g ON l.SUP_PROD_NBR = g.prod_nbr
WHERE
	t.WORK_SYS_NAME = 'REFURB'
	AND
	t.PROJ_CODE like 'REF%'
