select * from GLF_LDG_ACC_TRANS
where ldg_name = 'DP1A0018' or ldg_name = 'DPA19NZ'

select 
ldg_name,
period,
pdatei,
doc_type,
doc_datei1,
doc_ref1,
doc_ref2,
source,
amt1,
EXC_TAX_AMT,
narr1,
narr2,
narr3,
bat_name,
bat_crtimei,
doc_xref,
trans_nbr,
status,
user_fld7 as 'GUID',
user_fld8,
user_fld9,
user_fld10,
doc_reg_name,
bat_cruser,
LDG_TRANS_RID,
DOC_UNIQUE_ID,
ATTACH_IND
from GLF_LDG_ACC_TRANS
where ldg_name = 'DP1A0018' or ldg_name = 'DPA19NZ'

-- Look for all POs within specific processing group
select * from PUF_ORD_CTL
where pgrp_name = 'SHD18A'
-- and pordnbr = 'CTRM000088'

-- Look by PO across all processing groups
select * from PUF_ORD_CTL
where pordnbr = 'AOT0004380'

-- Count by pordnbr rather than lines, as multiple backorders possible per PO.

-- pord_status <> 'C' (cancelled) 
-- pgrp_name = 'SHD18A' 
-- pord_datei - order (raised) date (may be unnecessary if going by processing group)
-- user_fld10 - requisitioner
-- user_fld3 - PO approver
-- slocn_code = 'TRM'

-- Count
select
	pgrp_name AS 'Processing group',
	user_fld3 AS 'Approver',
	COUNT(DISTINCT pordnbr) AS 'Number of POs approved' 
from PUF_ORD_CTL
where pord_status <> 'C' and plocn_code <> 'AU' and (pgrp_name = 'SHD18A' or pgrp_name = 'PG19ANZ')
group by
	pgrp_name,
	user_fld3
order by
	pgrp_name
