unit uDataBase;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB,
  Winapi.ActiveX,uDBVariable, IBDatabase;

type
  TdmDataBase = class(TDataModule)
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    ADOEventQuery: TADOQuery;
    ADOTempQuery: TADOQuery;
    ADOEventConnection: TADOConnection;
  private
    FOnAdoConnected: TAdoConnectedEvent;
    { Private declarations }
  public
    { Public declarations }
    Function ProcessExecSQL(aSql:String;bUpdateResult:Boolean=False): Boolean;
    Function ProcessEventExecSQL(aSql:String): Boolean;
  published
    property OnAdoConnected:      TAdoConnectedEvent read FOnAdoConnected       write FOnAdoConnected;
  end;

var
  dmDataBase: TdmDataBase;

implementation
uses
  uCommonFunction,
  uCommonVariable;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmDataBase }

function TdmDataBase.ProcessEventExecSQL(aSql: String): Boolean;
var
  ExecQuery :TADOQuery;
begin
  Result:= False;
  Try
    CoInitialize(nil);
    ExecQuery := TADOQuery.Create(nil);
    ExecQuery.Connection := ADOEventConnection;
    ExecQuery.DisableControls;
    with ExecQuery do
    begin
      Close;
      SQL.Text:= aSql;
      try
        ExecSql;
      except
      ON E: Exception do
        begin
          LogSave(G_stExeFolder + '\..\Log\DB' + FormatDateTime('yyyymmdd',Now) + '.log','DBError('+ E.Message + ')' + aSql);
          if Pos('no connection to the server',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end else if Pos('server closed the connection',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end else if Pos('connection dead',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end else if Pos('연결을 실패했습니다',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end;
          Exit;
        end
      end;
    end;
  Finally
    ExecQuery.EnableControls;
    ExecQuery.Free;
    CoUninitialize;
  End;
  Result:= True;
end;

function TdmDataBase.ProcessExecSQL(aSql: String;
  bUpdateResult: Boolean): Boolean;
var
  ExecQuery :TADOQuery;
  nResult : integer;
begin
  //원복시키자
  Result:= False;
  Try
    CoInitialize(nil);
    ExecQuery := TADOQuery.Create(nil);
    ExecQuery.Connection := ADOConnection;
    ExecQuery.DisableControls;
    with ExecQuery do
    begin
      Close;
      SQL.Text:= aSql;
      try
        nResult := ExecSQL;
//        LogSave(G_stExeFolder + '\..\Log\DBSUCCESS' + FormatDateTime('yyyymmdd',Now) + '.log',aSql);
      except
      ON E: Exception do
        begin
          LogSave(G_stExeFolder + '\..\Log\DB' + FormatDateTime('yyyymmdd',Now) + '.log','DBError('+ E.Message + ')' + aSql);

          if Pos('no connection to the server',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end else if Pos('out of memory',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end else if Pos('server closed the connection',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end else if Pos('connection dead',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end else if Pos('연결을 실패했습니다',E.Message) > 0 then
          begin
            if Assigned(FOnAdoConnected) then
            begin
              OnAdoConnected(Self,False);
            end;
          end;

          Exit;
        end
      end;
    end;
  Finally
    ExecQuery.EnableControls;
    ExecQuery.Free;
    CoUninitialize;
  End;

  if bUpdateResult then
  begin
    if nResult > 0 then Result := True
    else
    begin
      Result := False;
      LogSave(G_stExeFolder + '\..\Log\DB' + FormatDateTime('yyyymmdd',Now) + '.log','DBError(UPDATE)' + aSql);
    end;
  end else
  begin
    Result:= True;
  end;
end;

end.
