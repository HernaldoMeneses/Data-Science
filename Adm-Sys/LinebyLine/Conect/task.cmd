rem to delet
rem schtasks /delete /tn "ReloadReport"
rem to create
rem schtasks /create /tn "ReloadReport" /tr "L:\GitHub\Data-Science\Adm-Sys\Python\Conect" /sc minute /mo 1
rem pause
rem to virify create
rem schtasks /query /tn "ReloadReport"
rem pause
rem to verify exec
schtasks /query /tn "ReloadReport" /fo LIST /v
pause

