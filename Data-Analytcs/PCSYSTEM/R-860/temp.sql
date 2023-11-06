PositCLiNat:=COUNTROWS(SUMMARIZE(Rel_NatOne;[CODCLI]))

%_Posit:=[PositCLiNat]/[Qt_Cli]

Ganho R$:=sum(Rel_NatOne[50])