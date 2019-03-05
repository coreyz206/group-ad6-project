PEW RESEARCH CENTER 
SCIENE AND NEWS SURVEY
May 30 - June 12, 2017
N=4,024


**************************************************************************************************************************

This survey was conducted by the GfK group in English and Spanish using KnowledgePanel, its nationally representative online research panel.
 
***************************************************************************************************************************

To protect the privacy of respondents, state has been removed from the public data file.

***************************************************************************************************************************

Releases from this survey:

September 20, 2017 Science News and Information Today
http://www.journalism.org/2017/09/20/science-news-and-information-today/


***************************************************************************************************************************
SYNTAX

**The syntax to create the science news variable**

compute scinews_consumer=$sysmis.
if any(scioften,1,2) and (seek=1) scinews_consumer=1.
if  any(scioften,1,2) and (seek=2) scinews_consumer=2.
if any(scioften,3,4) and (seek=1) scinews_consumer=2.
if any(scioften,3,4) and (seek=2) scinews_consumer=3.
if (scioften=-1) or (seek=-1) scinews_consumer=-1.
execute.

**variable labels

variable labels scinews_consumer "Type of science news consumer (index from SCI_OFTEN and SEEK)".

value labels scinews_consumer 1 "Active" 2 "Casual" 3 "Uninterested" -1 "Refused on SCIOFTEN or SEEK".

crosstabs scinews_consumer by scioften.
crosstabs scinews_consumer by seek.

freq scinews_consumer.

**The syntax to create the sum/count variable of sources types (SOURCE3)**

compute SOURCE3_sum = SOURCE3_a + SOURCE3_b + SOURCE3_c + SOURCE3_d + SOURCE3_e + SOURCE3_f + SOURCE3_g + SOURCE3_h + SOURCE3_i + SOURCE3_j.
if (SOURCE3_k=1) SOURCE3_sum=0.
if (SOURCE3_Refused=1) SOURCE3_sum=99. 
execute.



