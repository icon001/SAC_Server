unit uLoginVariable;

interface

type TLogInfo = Record
    Log_Time: TDatetime;
    User_ID:  String[10];
    Log_Note: String[40];
    IP_Addr:  String[20];
  end;

var
  G_LogInfo: TLogInfo;

implementation

end.
