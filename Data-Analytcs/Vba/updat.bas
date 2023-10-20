Sub update_103()
'
' update_103 Macro
'
    Range("A2").Select
    Range(Selection, Selection.End(xlToRight)).Select
    Selection.AutoFill Destination:=Range("A2:V10122")
    Range("A2:V10122").Select
    Range("A1").Select
End Sub