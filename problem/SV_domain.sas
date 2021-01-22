*SV domain里同一个week按照visit name排序，有时候LB test在同一天但是分为HOUR 1,HOUR 4,HOUR 24,HOUR 48，但是svstdtc和svendtv是相同的，在不能用visitnum排序的情况下，assign一个根据visit name的新变量sort帮助排序;
