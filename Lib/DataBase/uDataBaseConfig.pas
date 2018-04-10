unit uDataBaseConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel,
  W7Classes, W7Buttons, Vcl.ImgList,System.iniFiles,Data.DB,Data.Win.ADODB,JclMime,
  ActiveX,uDBVariable;

type
  TDataBaseConfig = class(TComponent)
  private
    FCancel: Boolean;
    FDBConnected: Boolean;
    class function FindSelf:TComponent;
    procedure SetCancel(const Value: Boolean);
    procedure SetDBConnected(const Value: Boolean);
  private
    FOnAdoConnected: TAdoConnectedEvent;
    function Table_0001_VersionMake:Boolean;
    function Table_0002_VersionMake:Boolean;

  public
    { Public declarations }
    Procedure ShowDataBaseConfig;
    Function DataBaseConnect(aMessage:Boolean=True):Boolean;
    Function ChekProgramEndTime : Boolean;
    Function TableVersionCheck:Boolean;
    Function GetTableVersion:integer;
    Function DBCreate(aDBHost,aDBPort,aDBUserID,aDBUserPw,aDBName:string):Boolean;
  public
    class Function GetObject:TDataBaseConfig;   //자기자신을 찾는것  class 는 폼생성전에도 사용가능
  Published
    { Published declarations }
    Property Cancel:Boolean read FCancel write SetCancel;
    Property DBConnected : Boolean read FDBConnected write SetDBConnected;
  Published
    property OnAdoConnected:      TAdoConnectedEvent read FOnAdoConnected       write FOnAdoConnected;
  end;

  TfmDataBaseConfig = class(TForm)
    rg_DBType: TRadioGroup;
    AdvPanel1: TAdvPanel;
    edPasswd: TEdit;
    edDataBaseName: TEdit;
    Label5: TLabel;
    Label4: TLabel;
    edUserid: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    edServerPort: TEdit;
    edServerIP: TEdit;
    Label1: TLabel;
    btn_Save: TW7SpeedButton;
    btn_Close: TW7SpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure rg_DBTypeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function SQLConfigDataSource(hwndParent : HWND; fRequest : WORD; lpszDriver : LPCSTR; lpszAttributes : LPCSTR) : Boolean; stdcall; external 'ODBCCP32.DLL';
var
  fmDataBaseConfig: TfmDataBaseConfig;

implementation
uses
  uCommonFunction,
  uCommonVariable,
  uDBCreate,
  uDataBase,
  uDBFunction,
  uDBInsert,
  uDBUpdate;

{$R *.dfm}

{ TDataBaseConfig }

function TDataBaseConfig.ChekProgramEndTime: Boolean;
var
  stSql : string;
  stDate : string;
begin
  result := True;
  stSql := ' Select * from TB_CONFIG where CO_CONFIGGROUP = ''COMMON'' AND CO_CONFIGCODE = ''ENDDATE'' ';

  with dmDataBase.ADOTempQuery do
  begin
    Close;
    Sql.Clear;
    Sql.Text := stSql;
    Try
      Open;
    Except
      Exit;
    End;
    if recordCount < 1 then Exit;
    Try
      stDate := MimeDecodeString(FindField('CO_CONFIGVALUE').AsString);
      if Not IsDate(stDate) then result := False;
      if stDate < FormatDateTime('yyyymmdd',now) then result := False;
    Except
      Exit;
    End;
  end;

end;

function TDataBaseConfig.DataBaseConnect(aMessage: Boolean): Boolean;
var
  ini_fun : TiniFile;
  stConnectString : string;
  stConnectString1 : string;
  stDBType : string;
begin
  if DBConnected then Exit;
  result := False;
  CanCel := False;
  G_stExeFolder  := ExtractFileDir(Application.ExeName);
  G_stLogDirectory := G_stExeFolder + '\..\log';
  if not DirectoryExists(G_stLogDirectory) then
  begin
   if Not CreateDir(G_stLogDirectory) then
   begin
   end;
  end;
  if not DirectoryExists(G_stExeFolder + '\..\DB') then
  begin
   if Not CreateDir(G_stExeFolder + '\..\DB') then
   begin
   end;
  end;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\SAC.INI');

    stDBType := UpperCase(ini_fun.ReadString('DBConfig','TYPE','MDB'));
    G_stDBHost  := ini_fun.ReadString('DBConfig','Host','127.0.0.1');
    if stDBType = 'MSSQL' then
    begin
      G_stDBUserPw := MimeDecodeString(ini_fun.ReadString('DBConfig','UserPW','c2FwYXNzd2Q='));
      G_stDBPort := ini_fun.ReadString('DBConfig','Port','1433');
      G_stDBUserID := ini_fun.ReadString('DBConfig','UserID','sa');
    end else if stDBType = 'FB' then
    begin
      G_stDBUserPw := MimeDecodeString(ini_fun.ReadString('DBConfig','UserPW','bWFzdGVya2V5'));  //saPasswd
      G_stDBPort := ini_fun.ReadString('DBConfig','Port','3050');
      G_stDBUserID := ini_fun.ReadString('DBConfig','UserID','SYSDBA');
    end else if stDBType = 'PG' then
    begin
      G_stDBUserPw := MimeDecodeString(ini_fun.ReadString('DBConfig','UserPW','MQ=='));
      G_stDBPort := ini_fun.ReadString('DBConfig','Port','5432');
      G_stDBUserID := ini_fun.ReadString('DBConfig','UserID','postgres');
    end;
    G_stDBName := lowerCase(ini_fun.ReadString('DBConfig','DBNAME','SAC'));
    G_stGroupCode := ini_fun.ReadString('COMPANY','GROUPCODE','1234567890');

    if UpperCase(stDBType) = 'MSSQL' then G_nDBType := MSSQL
    else if UpperCase(stDBType) = 'PG' then G_nDBType := POSTGRESQL
    else if UpperCase(stDBType) = 'FB' then G_nDBType := FIREBIRD
    else if UpperCase(stDBType) = 'MDB' then G_nDBType := MDB;

    G_nMaxComPort := ini_fun.ReadInteger('RS232','MAXPORT',40);
    G_nCardRegisterPort := ini_fun.ReadInteger('FORM','CardRegisterPort',0);

    DBCreate(G_stDBHost,G_stDBPort,G_stDBUserID,G_stDBUserPw,G_stDBName);
    if G_nDBType = MSSQL then
    begin
      stConnectString := stConnectString + 'Provider=SQLOLEDB.1;';
      stConnectString := stConnectString + 'Password=' + G_stDBUserPw + ';';
      stConnectString := stConnectString + 'Persist Security Info=True;';
      stConnectString := stConnectString + 'User ID=' + G_stDBUserID + ';';
      stConnectString := stConnectString + 'Initial Catalog=' + G_stDBName + ';';
      stConnectString := stConnectString + 'Data Source=' + G_stDBHost  + ',' + G_stDBPort;
    end else if G_nDBType = POSTGRESQL then
    begin
      stConnectString := 'Provider=PostgreSQL OLE DB Provider;';
      stConnectString := stConnectString + 'Data Source=' + G_stDBHost + ';'   ;
      stConnectString := stConnectString + 'location=' + G_stDBName + ';';
      stConnectString := stConnectString + 'User Id='+ G_stDBUserID + ';';
      stConnectString := stConnectString + 'password=' + G_stDBUserPw;
    end else if G_nDBType = FIREBIRD then
    begin
      stConnectString := 'Provider=ZStyle IBOLE Provider;';
      stConnectString := stConnectString + 'Data Source=' + G_stDBHost + ':' + G_stDBName + ';';
      stConnectString := stConnectString + 'UID='+ G_stDBUserID + ';';
      stConnectString := stConnectString + 'Password=' + G_stDBUserPw + ';';
      stConnectString := stConnectString + 'DIALECT=3;';
      //IBOLE.dll 파일을 등록 할것
(*      stConnectString := 'Provider=LCPI.IBProvider;';
      //stConnectString := 'Provider=Firebird/InterBase(r) driver;';
      stConnectString := 'DRIVER=Firebird/InterBase(r) driver;';
      //stConnectString := 'DRIVER=XTG Systems InterBase6 ODBC driver;';
      stConnectString := stConnectString + 'DB=' + G_stDBHost + ':' + G_stDBName + ';';
      stConnectString := stConnectString + 'UID='+ G_stDBUserID + ';';
      stConnectString := stConnectString + 'Password=' + G_stDBUserPw + ';';
      stConnectString := stConnectString + 'Auto Commit=true;';
      stConnectString := stConnectString + 'DIALECT=3;';  *)
//      stConnectString := 'DRIVER={XTG Systems InterBase6 ODBC driver};DB=127.0.0.1:BMOS;UID=SYSDBA;Password=masterkey';
    end else //디폴트로 MDB로 인식하자
    begin
      if Not FileExists(G_stExeFolder + '\..\db\SAC.mdb') then
      begin
        ChDir(G_stExeFolder + '\..\db');
        SQLConfigDataSource(0, 1, LPCSTR('Microsoft Access Driver (*.mdb)'), LPCSTR('CREATE_DB=SAC.mdb General'));
      end;

      stConnectString := 'Provider=Microsoft.Jet.OLEDB.4.0;';
      stConnectString := stConnectString + 'Data Source=' + G_stExeFolder + '\..\db\SAC.mdb' + ';';
      stConnectString := stConnectString + 'Persist Security Info=True;';
      stConnectString := stConnectString + 'Jet OLEDB:Database ';
    end;

    if G_nDBType <> MDB then
    begin
      stConnectString1 := stConnectString;
    end else
    begin
      if Not FileExists(G_stExeFolder + '\..\db\SACEVENT.mdb') then
      begin
        ChDir(G_stExeFolder + '\..\db');
        SQLConfigDataSource(0, 1, LPCSTR('Microsoft Access Driver (*.mdb)'), LPCSTR('CREATE_DB=SACEVENT.mdb General'));
      end;
      //MDB 에서는 이벤트 DB 와 정보 DB를 구분하기 위함
      stConnectString1 := 'Provider=Microsoft.Jet.OLEDB.4.0;';
      stConnectString1 := stConnectString1 + 'Data Source=' + G_stExeFolder + '\..\db\SACEVENT.mdb' + ';';
      stConnectString1 := stConnectString1 + 'Persist Security Info=True;';
      stConnectString1 := stConnectString1 + 'Jet OLEDB:Database ';
    end;

    with dmDataBase.ADOConnection do
    begin
      Connected := False;
      Try
        ConnectionString := stConnectString;
        LoginPrompt:= false ;
        Connected := True;
      Except
        on E : EDatabaseError do
          begin
            // ERROR MESSAGE-BOX DISPLAY
            if aMessage then
              ShowMessage(stConnectString + E.Message );
            Exit;
          end;
        else
          begin
            if aMessage then
              ShowMessage('데이터베이스 접속에러' );
            Exit;
          end;
      End;
      CursorLocation := clUseServer;
      //CursorLocation := clUseClient;
    end;

    with dmDataBase.ADOEventConnection do
    begin
      Connected := False;
      Try
        ConnectionString := stConnectString1;
        LoginPrompt:= false ;
        Connected := True;
      Except
        on E : EDatabaseError do
          begin
            // ERROR MESSAGE-BOX DISPLAY
            if aMessage then
              ShowMessage(E.Message );
            Exit;
          end;
        else
          begin
            if aMessage then
              ShowMessage('데이터베이스 접속 에러' );
            Exit;
          end;
      End;
      CursorLocation := clUseServer;
      //CursorLocation := clUseClient;
    end;
    if Not TableVersionCheck then Exit;
    if Not ChekProgramEndTime then
    begin
      showmessage('데이터 베이스 연결에 실패 하였습니다.');
      dmDataBase.ADOConnection.Connected := False;
      DBConnected := False;
      Exit;
    end;

    DBConnected := True;
    result := True;
  Finally
    ini_fun.Free;
  End;

end;

function TDataBaseConfig.DBCreate(aDBHost, aDBPort, aDBUserID, aDBUserPw,
  aDBName: string): Boolean;
var
  stConnectString : string;
  stSql : string;
begin
    if G_nDBType = MSSQL then
    begin
      stConnectString := stConnectString + 'Provider=SQLOLEDB.1;';
      stConnectString := stConnectString + 'Password=' + aDBUserPw + ';';
      stConnectString := stConnectString + 'Persist Security Info=True;';
      stConnectString := stConnectString + 'User ID=' + aDBUserID + ';';
      stConnectString := stConnectString + 'Initial Catalog=master;';
      stConnectString := stConnectString + 'Data Source=' + aDBHost  + ',' + aDBPort;
    end else if G_nDBType = POSTGRESQL then
    begin
      stConnectString := 'Provider=PostgreSQL OLE DB Provider;';
      stConnectString := stConnectString + 'Data Source=' + aDBHost + ';'   ;
      stConnectString := stConnectString + 'location=postgres;';
      stConnectString := stConnectString + 'User Id='+ aDBUserID + ';';
      stConnectString := stConnectString + 'password=' + aDBUserPw;
    end else if G_nDBType = FIREBIRD then
    begin
      Exit;
      //IBOLE.dll 파일을 등록 할것
    end else //디폴트로 MDB로 인식하자
    begin
      if Not FileExists(G_stExeFolder + '\..\DB\SAC.mdb') then
      begin
        ChDir(G_stExeFolder+ '\..\DB');
        SQLConfigDataSource(0, 1, LPCSTR('Microsoft Access Driver (*.mdb)'), LPCSTR('CREATE_DB=SAC.mdb General'));
      end;
      if Not FileExists(G_stExeFolder + '\..\DB\SACEvent.mdb') then
      begin
        ChDir(G_stExeFolder+ '\..\DB');
        SQLConfigDataSource(0, 1, LPCSTR('Microsoft Access Driver (*.mdb)'), LPCSTR('CREATE_DB=SACEvent.mdb General'));
      end;
      Exit;
    end;
    with dmDataBase.ADOConnection do
    begin
      Connected := False;
      Try
        ConnectionString := stConnectString;
        LoginPrompt:= false ;
        Connected := True;
      Except
        on E : EDatabaseError do
          begin
            Exit;
          end;
        else
          begin
            Exit;
          end;
      End;
      CursorLocation := clUseServer;
    end;
    stSql := 'Create DataBase ' + aDBName ;
    dmDataBase.ProcessExecSQL(stSql);

end;

class function TDataBaseConfig.FindSelf: TComponent;
var
  Loop:Integer;
begin
  Result:=Nil;
  for Loop:=0 to Application.ComponentCount-1 do begin
      if Application.Components[Loop] is TDataBaseConfig then begin
          Result:= Application.Components[Loop];
          Break;
      end;
  end;
end;

class function TDataBaseConfig.GetObject: TDataBaseConfig;
begin
   If FindSelf = Nil then TDataBaseConfig.Create(Application);
   Result := TDataBaseConfig(FindSelf);
end;

function TDataBaseConfig.GetTableVersion: integer;
var
  stSql : string;
begin
  result := 0;
  stSql := 'select * from TB_CONFIG ';
  stSql := stSql + ' where CO_CONFIGGROUP = ''COMMON'' ';
  stSql := stSql + ' AND CO_CONFIGCODE = ''TABLE_VER'' ';
  with dmDataBase.ADOTempQuery do
  begin
    Close;
    Sql.Clear;
    Sql.Text := stSql;
    Try
      Open;
    Except
      Exit;
    End;
    if recordCount < 1 then Exit;
    Try
      result := strtoint(FindField('CO_CONFIGVALUE').AsString);
    Except
      Exit;
    End;
  end;
end;


procedure TDataBaseConfig.SetCancel(const Value: Boolean);
begin
  FCancel := Value;
end;

procedure TDataBaseConfig.SetDBConnected(const Value: Boolean);
begin
  if FDBConnected = Value then Exit;

  FDBConnected := Value;
  if Assigned(FOnAdoConnected) then
  begin
    OnAdoConnected(Self,Value);
  end;
end;

procedure TDataBaseConfig.ShowDataBaseConfig;
begin
  FDBConnected := False;

  fmDataBaseConfig:=TfmDataBaseConfig.Create(Nil);
  Try
    fmDataBaseConfig.ShowModal;
  Finally
    fmDataBaseConfig.Free;
  End;
end;

Function TDataBaseConfig.TableVersionCheck:Boolean;
var
  nTableVersion : integer;
begin
  result := False;
  nTableVersion := GetTableVersion;
  if nTableVersion < 1 then Table_0001_VersionMake;
  if nTableVersion < 2 then Table_0002_VersionMake;

  result := True;
end;

function TDataBaseConfig.Table_0001_VersionMake: Boolean;
begin
  dmDBCreate.CreateTB_ACCESSEVENT;
  dmDBCreate.CreateTB_ACCESSEVENTCODE;
  dmDBInsert.InsertIntoTB_ACCESSEVENTCODE_Value('21','강제열림'); //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  dmDBInsert.InsertIntoTB_ACCESSEVENTCODE_Value('22','정상'); //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  dmDBInsert.InsertIntoTB_ACCESSEVENTCODE_Value('23','강제닫힘'); //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  dmDBInsert.InsertIntoTB_ACCESSEVENTCODE_Value('10','정상출입'); //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  dmDBInsert.InsertIntoTB_ACCESSEVENTCODE_Value('11','미등록카드'); //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  dmDBInsert.InsertIntoTB_ACCESSEVENTCODE_Value('14','비밀번호출입'); //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  dmDBCreate.CreateTB_ADMIN;
  dmDBInsert.InsertIntoTB_ADMIN_All('1234','1234','Admin','1','000','0','0','1');
  dmDBCreate.CreateTB_BUILDINGCODE;
  dmDBCreate.CreateTB_BUILDINGAREACODE;
  dmDBCreate.CreateTB_BUILDINGFLOORCODE;
  dmDBCreate.CreateTB_CARD;
  dmDBCreate.CreateTB_CARDGROUPCODE;
  dmDBInsert.InsertIntoTB_CARDGROUPCODE_Value('1','전체권한');
  dmDBCreate.CreateTB_CARDGUBUNCODE;
  dmDBInsert.InsertIntoTB_CARDGUBUNCODE_Value('1','입주자');
  dmDBInsert.InsertIntoTB_CARDGUBUNCODE_Value('2','관리자');
  dmDBInsert.InsertIntoTB_CARDGUBUNCODE_Value('3','용역');
  dmDBInsert.InsertIntoTB_CARDGUBUNCODE_Value('4','방문');
  dmDBCreate.CreateTB_CARDPERMITGROUP;
  dmDBCreate.CreateTB_CONFIG;
  dmDBInsert.InsertIntoTB_CONFIG_All('COMMON','TABLE_VER','1','테이블 버젼정보');
  dmDBInsert.InsertIntoTB_CONFIG_All('COMMON','ENDDATE',MimeEncodeString('99991231'),'프로그램종료기간');
  dmDBCreate.CreateTB_DEVICE;
  dmDBCreate.CreateTB_DEVICECARDNO;
  dmDBCreate.CreateTB_DEVICETYPE;
  dmDBInsert.InsertIntoTB_DEVICETYPE_Value('01','로비폰');
  dmDBInsert.InsertIntoTB_DEVICETYPE_Value('10','독립형');
  dmDBCreate.CreateTB_DOORCONTROLTYPE;
  dmDBInsert.InsertIntoTB_DOORCONTROLTYPE_Value('01','Normal Open');
  dmDBInsert.InsertIntoTB_DOORCONTROLTYPE_Value('02','Normal Close');
  dmDBCreate.CreateTB_DOORLOCKPORT;
  dmDBInsert.InsertIntoTB_DOORLOCKPORT_Value('00','사용 안함');
  dmDBInsert.InsertIntoTB_DOORLOCKPORT_Value('21','개방 모드');
  dmDBInsert.InsertIntoTB_DOORLOCKPORT_Value('22','운영 모드');
  dmDBInsert.InsertIntoTB_DOORLOCKPORT_Value('23','폐쇄 모드');

end;

function TDataBaseConfig.Table_0002_VersionMake: Boolean;
begin
  dmDBCreate.AlterTB_ACCESSEVENT_CARDTYPE_ADD;
  dmDBCreate.CreateTB_CARDTYPE;
  dmDBInsert.InsertIntoTB_CARDTYPE_Value('01','4Byte카드');
  dmDBInsert.InsertIntoTB_CARDTYPE_Value('02','7Byte카드');
  dmDBInsert.InsertIntoTB_CARDTYPE_Value('03','10Byte카드');
  dmDBInsert.InsertIntoTB_CARDTYPE_Value('04','티머니카드');
  dmDBInsert.InsertIntoTB_CARDTYPE_Value('0A','비밀번호');
  dmDBUpdate.UpdateTB_CONFIG_Value('COMMON','TABLE_VER','2');

end;

procedure TfmDataBaseConfig.FormCreate(Sender: TObject);
var
  ini_fun : TiniFile;
  stDBType : string;
begin
  Try
    if G_stExeFolder = '' then G_stExeFolder := ExtractFileDir(Application.ExeName);
    ini_fun := TiniFile.Create(G_stExeFolder + '\SAC.ini');

    stDBType := UpperCase(ini_fun.ReadString('DBConfig','TYPE','MDB'));
    if UpperCase(stDBType) = 'MSSQL' then G_nDBType := MSSQL
    else if UpperCase(stDBType) = 'PG' then G_nDBType := POSTGRESQL
    else if UpperCase(stDBType) = 'FB' then G_nDBType := FIREBIRD
    else if UpperCase(stDBType) = 'MDB' then G_nDBType := MDB;

    rg_DBType.ItemIndex := G_nDBType;

    edServerIP.Text  := ini_fun.ReadString('DBConfig','Host','127.0.0.1');
    edServerPort.Text := ini_fun.ReadString('DBConfig','Port','1433');
    edUserid.Text := ini_fun.ReadString('DBConfig','UserID','sa');
    edPasswd.Text := MimeDecodeString(ini_fun.ReadString('DBConfig','UserPW',MimeEncodeString('sapasswd')));  //saPasswd
    edDataBaseName.Text := lowerCase(ini_fun.ReadString('DBConfig','DBNAME','SAC'));
  Finally
    ini_fun.Free;
  End;
  rg_DBTypeClick(sender);
end;

procedure TfmDataBaseConfig.rg_DBTypeClick(Sender: TObject);
begin
  if rg_DBType.ItemIndex = MDB then AdvPanel1.Visible := False
  else AdvPanel1.Visible := True;

end;

procedure TfmDataBaseConfig.btn_CloseClick(Sender: TObject);
begin
  TDataBaseConfig.GetObject.Cancel := True;
  Close;
end;

procedure TfmDataBaseConfig.btn_SaveClick(Sender: TObject);
var
  ini_fun : TiniFile;
begin
  Try
    if G_stExeFolder = '' then G_stExeFolder := ExtractFileDir(Application.ExeName);
    ini_fun := TiniFile.Create(G_stExeFolder + '\SAC.INI');

    if rg_DBType.ItemIndex = 0 then ini_fun.WriteString('DBConfig','TYPE','MDB')
    else if rg_DBType.ItemIndex = 1 then ini_fun.WriteString('DBConfig','TYPE','MDB')
    else if rg_DBType.ItemIndex = 2 then ini_fun.WriteString('DBConfig','TYPE','PG')
    else if rg_DBType.ItemIndex = 3 then ini_fun.WriteString('DBConfig','TYPE','FB');

    ini_fun.WriteString('DBConfig','Host',Trim(edServerIP.Text));
    ini_fun.WriteString('DBConfig','Port',Trim(edServerPort.Text));
    ini_fun.WriteString('DBConfig','UserID',Trim(edUserid.Text));
    ini_fun.WriteString('DBConfig','UserPW',MimeEncodeString(Trim(edPasswd.Text)));
    ini_fun.WriteString('DBConfig','DBNAME',Trim(edDataBaseName.Text));

  Finally
    ini_fun.Free;
  End;

  TDataBaseConfig.GetObject.DataBaseConnect;
  Close;

end;

end.
