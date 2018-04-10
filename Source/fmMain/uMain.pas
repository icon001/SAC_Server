unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvAppStyler,AdvToolBar, AdvPreviewMenu,
  AdvPreviewMenuStylers, Vcl.ImgList, AdvToolBarStylers, AdvShapeButton,
  AdvGlowButton, Vcl.ExtCtrls, Vcl.Imaging.jpeg, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers,ADODB,ActiveX,DB,
  uNode, FolderDialog,System.Win.Registry,Winapi.ShellAPI,System.IniFiles,
  Vcl.ComCtrls, AdvProgr, Vcl.StdCtrls, AdvSmoothPanel, AdvSmoothLabel;

const
    con_NODESOCKETDELAYTIME = 30; //소켓 연결 끊는 시간

type
  TfmMain = class(TAdvToolBarForm)
    AdvFormStyler1: TAdvFormStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    MenuDisableImageList32: TImageList;
    MenuEnableImageList32: TImageList;
    AdvPreviewMenuOfficeStyler2: TAdvPreviewMenuOfficeStyler;
    KTTMenuEnableImageList: TImageList;
    Image1: TImage;
    KTTMenuDisableImageList: TImageList;
    at_Menu: TAdvToolBarPager;
    ApBasicAdmin: TAdvPage;
    mn_CodeAdmin: TAdvToolBar;
    mn_BuildingCode: TAdvGlowButton;
    AdvToolBar1: TAdvToolBar;
    mn_DoorCode: TAdvGlowButton;
    ApReport: TAdvPage;
    AdvToolBar8: TAdvToolBar;
    mn_AccessReport: TAdvGlowButton;
    apAdmin: TAdvPage;
    AdvToolBar11: TAdvToolBar;
    mn_AdminManager: TAdvGlowButton;
    ap_Other: TAdvPage;
    AdvQuickAccessToolBar1: TAdvQuickAccessToolBar;
    AdvShapeButton1: TAdvShapeButton;
    AdvToolBar2: TAdvToolBar;
    mn_CardRestore: TAdvGlowButton;
    mn_CardBackup: TAdvGlowButton;
    StartMenu: TAdvPreviewMenu;
    ImageList2: TImageList;
    mn_FloorCode: TAdvGlowButton;
    mn_AreaCode: TAdvGlowButton;
    ApManager: TAdvPage;
    mn_CardGroup: TAdvToolBar;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    mn_Card: TAdvGlowButton;
    mn_CardGrade: TAdvGlowButton;
    AdvToolBar3: TAdvToolBar;
    mn_Monitoring: TAdvGlowButton;
    mn_DBBackup: TAdvGlowButton;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    sb_Status: TAdvOfficeStatusBar;
    AdvToolBar4: TAdvToolBar;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    mn_Group: TAdvGlowButton;
    mn_GroupGrade: TAdvGlowButton;
    mn_ComMonitoring: TAdvGlowButton;
    NodeConnectTimer: TTimer;
    CardDownLoadTimer: TTimer;
    ValidDateTimer: TTimer;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    FolderDialog1: TFolderDialog;
    AdvToolBar9: TAdvToolBar;
    btn_ConfigSetting: TAdvGlowButton;
    btn_RemoteControl: TAdvGlowButton;
    AdvToolBar5: TAdvToolBar;
    mn_FireRecovery: TAdvGlowButton;
    mn_CardDownLoad: TAdvGlowButton;
    pan_Prograss: TAdvSmoothPanel;
    AdvProgress1: TAdvProgress;
    btn_PrograssClose: TAdvGlowButton;
    lb_CardDownloadMessage: TAdvSmoothLabel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    DBInsertTimer: TTimer;
    NodeSendTimer: TTimer;
    procedure StartMenuMenuItems4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StartMenuMenuItems2Click(Sender: TObject);
    procedure StartMenuMenuItems1Click(Sender: TObject);
    procedure mn_BuildingCodeClick(Sender: TObject);
    procedure mn_AreaCodeClick(Sender: TObject);
    procedure mn_FloorCodeClick(Sender: TObject);
    procedure mn_DoorCodeClick(Sender: TObject);
    procedure mn_GroupClick(Sender: TObject);
    procedure mn_GroupGradeClick(Sender: TObject);
    procedure mn_BuildingCodeMouseEnter(Sender: TObject);
    procedure mn_CardClick(Sender: TObject);
    procedure mn_CardGradeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NodeConnectTimerTimer(Sender: TObject);
    procedure mn_MonitoringClick(Sender: TObject);
    procedure mn_ComMonitoringClick(Sender: TObject);
    procedure CardDownLoadTimerTimer(Sender: TObject);
    procedure ValidDateTimerTimer(Sender: TObject);
    procedure mn_AccessReportClick(Sender: TObject);
    procedure mn_AdminManagerClick(Sender: TObject);
    procedure mn_CardBackupClick(Sender: TObject);
    procedure mn_CardRestoreClick(Sender: TObject);
    procedure mn_DBBackupClick(Sender: TObject);
    procedure btn_RemoteControlClick(Sender: TObject);
    procedure btn_ConfigSettingClick(Sender: TObject);
    procedure mn_FireRecoveryClick(Sender: TObject);
    procedure mn_CardDownLoadClick(Sender: TObject);
    procedure btn_PrograssCloseClick(Sender: TObject);
    procedure DBInsertTimerTimer(Sender: TObject);
    procedure NodeSendTimerTimer(Sender: TObject);
  private
    L_bLoadCardPermit : Boolean;
    L_bCustomer : Boolean;
    L_bNodeLoding : Boolean;
    L_nReConnectSeq : integer;
    L_nNodeSendPacketNo : integer;
    L_nCardDownloadCount : integer;
    L_nNodeConnectCount : integer;
    DBInsertSqlList : TStringList;
    DBUpdateSqlList : TStringList;
    FLogined: Boolean;
    procedure SetLogined(const Value: Boolean);
    { Private declarations }
    procedure LoadAccessResultCode;
    procedure LoadBuildingCode;
    procedure LoadBuildingAreaCode;
    procedure LoadCard(aCardNo:string='');
    procedure LoadCardPermit(aAutoDownLoad:Boolean=True);
    procedure LoadLockMode;
    procedure LoadNode;
    procedure UnLoadAccessResultCode;
    procedure UnLoadBuildingCode;
    procedure UnLoadCard;
    procedure UnLoadLockMode;
    procedure UnLoadNode;
    procedure AccessEvent(Sender: TObject;  aNodeSeq : integer;aDeviceName,aBuildingCode,aBuildingAreaCode,aAccessTime,aAccessResult,aLockMode,aCardNo,aCardType:string);
    procedure CardBackup(aFileName:string);
    procedure CardLineRestore(aRestoreLine:string);
    procedure CardLoding(Sender: TObject;  aNodeSeq : integer;aCardNo:string);
    procedure CardRegEvent(Sender: TObject; aNodeSeq:integer;aCardNo,aPermit:string);
    procedure CardRestore(aFileName:string);
    procedure CardUpLoadEvent(Sender: TObject;  aNodeSeq : integer;aBuildingCode,aBuildingAreaCode,aCardNo,aCardType,aAddr:string);
    procedure CardUploadProcess(Sender: TObject;  aNodeSeq : integer;aBuildingCode,aBuildingAreaCode:string;aTotCount,aCurCount:integer);
    procedure ClientConfigIniSetting; //INI 파일 읽어서 메모리 설정
    procedure DataBaseBackup(aFolderName:string);
    procedure DoorLockSetting(Sender: TObject; aNodeSeq:integer;aLockPortType,aLockMode:string;aLockControlTime:integer);
    procedure DoorState(Sender: TObject;  aNodeSeq : integer;aValue:string);
    procedure FireEvent(Sender: TObject;  aNodeSeq : integer;aValue:string);
    procedure NodeConnected(Sender: TObject;  aNodeSeq : integer;aValue: TConnectedState);
    procedure NodePacketEvent(Sender: TObject;  aNodeSeq : integer;aTxRx,aDeviceName,aCmd,aPacketData:string);
    procedure PasswordEvent(Sender: TObject;  aNodeSeq : integer;aCmd,aPassword:string);
    procedure ValidDate_Apply; //유효기간 적용
  public
    procedure FORMCHANGE(aName:integer;aValue:string);
    Function FormChangeEvent(aFormNumber,aFormName:integer):Boolean;  //여기서 해당하는 폼 전체에 데이터 전송 해 주자
    procedure FORMSTATUSMSG(aIndex:integer;aMessage:string);
    procedure FORMENABLE(aName:integer;aValue:string);
    Function ChildFormClose(aFormNumber:integer):Boolean;
    procedure MDIFormAllClose;
    Function MDIChildShow(FormName:String):Boolean;
    Function MDIForm(FormName:string):TForm;
    procedure EventCardReader(Sender: TObject; aCardNo:string);
  public
    { Public declarations }
    property Logined : Boolean read FLogined write SetLogined;
  end;

var
  fmMain: TfmMain;

implementation
uses
  uAccessReport,
  uAdminUserID,
  uBuildingAreaCode,
  uBuildingCode,
  uCardAdmin,
  uCardGradeReport,
  uCardGroupCode,
  uCardGroupGrade,
  uCardGubunCode,
  uCardPermit,
  uClientConfig,
  uCommonFunction,
  uCommonVariable,
  uComPort,
  uDataBase,
  uDataBaseConfig,
  uDBDelete,
  uDBFunction,
  uDBInsert,
  uDBSelect,
  uDBUpdate,
  uDeviceComMonitoring,
  uDoorAdmin,
  uFormVariable,
  uLogin,
  uMonitoring,
  systeminfos;

{$R *.dfm}

procedure TfmMain.AccessEvent(Sender: TObject; aNodeSeq: integer; aDeviceName,
  aBuildingCode, aBuildingAreaCode, aAccessTime, aAccessResult, aLockMode,
  aCardNo,aCardType: string);
var
  fmTemp : TForm;
  stSql : string;
begin
  stSql := dmDBInsert.InsertIntoTB_ACCESSEVENT_StringValue(copy(aAccessTime,1,8), copy(aAccessTime,9,6), inttostr(aNodeSeq),
            aCardNo, aAccessResult, aLockMode, 'SYSTEM', FormatDateTime('yyyymmddhhnnsszzz',now),aCardType);
  if DBInsertSqlList.IndexOf(stSql) < 0 then
    DBInsertSqlList.Add(stSql);

  //dmDBInsert.InsertIntoTB_ACCESSEVENT_Value(copy(aAccessTime,1,8), copy(aAccessTime,9,6), inttostr(aNodeSeq),
  //           aCardNo, aAccessResult, aLockMode, 'SYSTEM', FormatDateTime('yyyymmddhhnnsszzz',now),aCardType);
  if G_bFormEnabled[con_FormMONITOR] then
  begin
    fmTemp := MDIForm('TfmMonitoring');
    if fmTemp <> nil then TfmMonitoring(fmTemp).AccessEvent(aNodeSeq,aDeviceName,aBuildingCode,aBuildingAreaCode,aAccessTime,aAccessResult,aLockMode,aCardNo,aCardType);
  end;

end;

procedure TfmMain.btn_ConfigSettingClick(Sender: TObject);
begin
  dmComPort.PortOpen := False;
  fmClientConfig := TfmClientConfig.create(self);
  fmClientConfig.ShowModal;
  fmClientConfig.Free;
  ClientConfigIniSetting;
end;

procedure TfmMain.btn_PrograssCloseClick(Sender: TObject);
begin
  L_bCustomer := False;
  pan_Prograss.Visible := False;
end;

procedure TfmMain.btn_RemoteControlClick(Sender: TObject);
var
  regKey : TRegistry;
  stPath : string;
  stUrl : string;
begin
//  ShellExecute(0, 'open', pchar('http://zeron.co.kr/help'), '','', SW_Normal);
//  MDIChildShow('TfmRemoteSupport');
  regKey := nil;
  Try
    regKey := TRegistry.Create;
    regKey.RootKey := HKEY_CURRENT_USER;
    if (not regKey.KeyExists('\Software\Zeron\Seetrol')) then
    begin
      if (Assigned(regKey)) then
      // REGISTRY KEY 해제
         regKey.Free;

      ShellExecute(0, 'open', pchar(ExtractFileDir(Application.ExeName) + '\seetrol_Setup.exe'),'','', SW_Normal);

      Exit;
    end;
    regKey.OpenKey ('\Software\Zeron\Seetrol',False);
    stPath := regKey.ReadString('path');
    if stPath = '' then
    begin
      if (Assigned(regKey)) then
      // REGISTRY KEY 해제
         regKey.Free;
      ShellExecute(0, 'open', pchar(ExtractFileDir(Application.ExeName) + '\seetrol_Setup.exe'),'','', SW_Normal);
      Exit;
    end;
    ShellExecute(0, 'open', pchar(stPath + 'SeetrolClient.exe'), pchar('-SAC_Client' + FormatDateTime('hhnnss',now) + ' -zeron.co.kr -8081 -8082 -8083 -auto'),'', SW_Normal)
  Except
    if (Assigned(regKey)) then
    // REGISTRY KEY 해제
       regKey.Free;
    Exit;
  End;
  if (Assigned(regKey)) then
  // REGISTRY KEY 해제
     regKey.Free;

end;

procedure TfmMain.CardBackup(aFileName: string);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  stLine : string;
  csv: TStringList;
  i : integer;
begin
  stSql := dmDBSelect.SelectTB_CARD_Backup;
  Try
    csv := TStringList.Create;
    stLine := '카드번호,사용자명,위치(동),위치(출구),위치(호),카드구분';
    csv.Add(stLine);
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;

      while Not Eof do
      begin
        stLine := '';
        for i:=0 to recordset.Fields.Count-1 do
        begin
          stLine := stLine + VarToStr(Recordset.Fields.Item[i].Value);
          if i < recordset.Fields.Count-1 then
            stLine := stLine + ',';
        end;
        csv.Add(stLine);
        Next;
      end;
    end;
  Finally
    if aFileName <> '' then csv.SaveToFile(aFileName);
    csv.Free;
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.CardDownLoadTimerTimer(Sender: TObject);
begin
  if G_bApplicationTerminate then Exit;
  if L_bCustomer then Exit;

  CardDownLoadTimer.Enabled := False;
  Try
    LoadCardPermit;
  Finally
    CardDownLoadTimer.Enabled := Not G_bApplicationTerminate;
  End;
end;

procedure TfmMain.CardLineRestore(aRestoreLine: string);
var
  LineList:TstringList;
  stCardNo : string;
  stCardName : string;
  stBuildingName : string;
  stBuildingAreaName : string;
  stAddr : string;
  stCardGubunName : string;
  stBuildingCode : string;
  stBuildingAreaCode : string;
  stCardGubunCode : string;
begin
  LineList := TstringList.Create;
  Try
    LineList.StrictDelimiter := True;
    LineList.Delimiter := ',';
    LineList.DelimitedText := aRestoreLine;
    if LineList.Count < 1 then Exit;
    stCardNo := Trim(LineList.Strings[0]);
    if pos('+',stCardNo) > 0 then Exit;
    if Length(stCardNo) <> 8 then
    begin
      stCardNo := FillZeroStrNum(stCardNo,8);
    end;


    if LineList.Count > 1 then stCardName := LineList.Strings[1];
    if LineList.Count > 2 then stBuildingName := LineList.Strings[2];
    if LineList.Count > 3 then stBuildingAreaName := LineList.Strings[3];
    if LineList.Count > 4 then stAddr := LineList.Strings[4];
    if LineList.Count > 5 then stCardGubunName := LineList.Strings[5];
    if stBuildingName <> '' then
    begin
      stBuildingCode := dmDBFunction.GetBuildingCode(stBuildingName);
      if Not IsDigit(stBuildingCode) then
      begin
        stBuildingCode := dmDBFunction.GetNextBuildingCode;
        dmDBInsert.InsertIntoTB_BUILDINGCODE_Value(stBuildingCode,stBuildingName,'');
      end;
      if stBuildingAreaName <> '' then
      begin
        stBuildingAreaCode := dmDBFunction.GetBuildingAreaCode(stBuildingCode,stBuildingAreaName);
        if Not IsDigit(stBuildingAreaCode) then
        begin
          stBuildingAreaCode := dmDBFunction.GetNextBuildingAreaCode(stBuildingCode);
          dmDBInsert.InsertIntoTB_BUILDINGAREACODE_Value(stBuildingCode,stBuildingAreaCode,stBuildingAreaName);
        end;
      end;
    end;
    if stCardGubunName <> '' then
    begin
      stCardGubunCode := dmDBFunction.GetCardGubunCode(stCardGubunName);
      if Not IsDigit(stCardGubunCode) then
      begin
        stCardGubunCode := dmDBFunction.GetNextCardGubunCode;
        dmDBInsert.InsertIntoTB_CARDGUBUNCODE_Value(stCardGubunCode,stCardGubunName);
      end;
    end;
    if Not isDigit(stBuildingCode) then stBuildingCode := '0';
    if Not isDigit(stBuildingAreaCode) then stBuildingAreaCode := '0';
    if Not isDigit(stCardGubunCode) then stCardGubunCode := '0';

    if dmDBFunction.CheckTB_CARD_Key(stCardNo) = 1 then
    begin
      dmDBUpdate.UpdateTB_CARD_FieldString(stCardNo,'CA_NAME',stCardName);
      dmDBUpdate.UpdateTB_CARD_FieldInteger(stCardNo,'CA_GUBUN',stCardGubunCode);
      dmDBUpdate.UpdateTB_CARD_FieldInteger(stCardNo,'BC_BUILDINGCODE',stBuildingCode);
      dmDBUpdate.UpdateTB_CARD_FieldInteger(stCardNo,'BC_BUILDINGAREACODE',stBuildingAreaCode);
      dmDBUpdate.UpdateTB_CARD_FieldString(stCardNo,'CA_ADDR',stAddr);
    end else
    begin
      dmDBInsert.InsertIntoTB_CARD_Value(stCardNo,'1',stCardName,stCardGubunCode,stBuildingCode,stBuildingAreaCode,'0',stAddr,'0','0',FormatDateTime('yyyymmdd',Now),'99991231','N','N');
    end;

  Finally
    LineList.Free;
  End;
end;

procedure TfmMain.CardLoding(Sender: TObject; aNodeSeq: integer;
  aCardNo: string);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  stCardNo : string;
  stPermit : string;
  stNodeNo : string;
  stAddr : string;
  nIndex : integer;
begin
  stSql := dmDBSelect.SelectTB_DEVICECARDNO_CardNoPermit(inttostr(aNodeSeq),aCardNo);
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        stCardNo := FindField('CA_CARDNO').AsString;
        stPermit := FindField('CP_PERMIT').AsString;
        stAddr := FindField('CA_ADDR').AsString;
        if Not isDigit(stAddr) then stAddr := '0';
        stAddr := FillZeroStrNum(stAddr,4);

        if FindField('CARDNO').AsString = '' then stPermit := '0';
        stNodeNo := FillZeroNumber(FindField('DE_SEQ').AsInteger,G_nNodeCodeLength);

        nIndex := NodeList.IndexOf(stNodeNo);
        if nIndex > -1 then
        begin
          TNode(NodeList.Objects[nIndex]).CardDataLoading(stCardNo,stPermit,stAddr);
        end;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.CardRegEvent(Sender: TObject; aNodeSeq: integer; aCardNo,
  aPermit: string);
var
  stSql : string;
begin
  AdvProgress1.Position := AdvProgress1.Position + 1;
  lb_CardDownloadMessage.Caption.Text :=  '카드권한 전송 중입니다.(' + inttostr(AdvProgress1.Position) + '/' + inttostr(AdvProgress1.Max ) + ')' ;
  if AdvProgress1.Position = AdvProgress1.Max then
  begin
    L_bCustomer := False;
    pan_Prograss.Visible := False;
  end;
  stSql := dmDBUpdate.UpdateTB_DEVICECARDNO_CardNoSendType_StringValue(inttostr(aNodeSeq),aCardNo,'Y'); //삭제 된 것(?)
  if DBUpdateSqlList.IndexOf(stSql) < 0 then
    DBUpdateSqlList.Add(stSql);
end;

procedure TfmMain.CardRestore(aFileName: string);
var
  RestoreFileList:TStringList;
  i :integer;
begin
  RestoreFileList:=TStringList.Create;
  Try
    RestoreFileList.LoadFromFile(aFileName);
    if RestoreFileList.Count < 2 then Exit;
    lb_CardDownloadMessage.Caption.Text := '카드데이터 복구중입니다.';
    pan_Prograss.Visible := True;
    AdvProgress1.Max := RestoreFileList.Count - 1;
    for i := 1 to RestoreFileList.Count - 1 do
    begin
      AdvProgress1.Position := i;
      CardLineRestore(RestoreFileList.Strings[i]);
      Application.ProcessMessages;
    end;
    pan_Prograss.Visible := False;
  Finally
    RestoreFileList.Free;
  End;
end;

procedure TfmMain.CardUpLoadEvent(Sender: TObject; aNodeSeq: integer;
  aBuildingCode, aBuildingAreaCode, aCardNo, aCardType, aAddr: string);
begin
  if dmDBFunction.CheckTB_CARD_Key(aCardNo) <> 1 then
  begin
    dmDBInsert.InsertIntoTB_CARD_Value(aCardNo,'1','입주자','1',aBuildingCode,aBuildingAreaCode,'0',aAddr,'0','0',FormatDateTime('yyyymmdd',now),'99991231','Y','Y');
  end;

  if dmDBFunction.CheckTB_DEVICECARDNO_Key(inttostr(aNodeSeq),aCardNo) <> 1 then
  begin
    dmDBInsert.InsertIntoTB_DEVICECARDNO_Value(inttostr(aNodeSeq),aCardNo,'1','Y');
  end;

end;

procedure TfmMain.CardUploadProcess(Sender: TObject; aNodeSeq: integer;
  aBuildingCode, aBuildingAreaCode: string; aTotCount, aCurCount: integer);
var
  fmTemp : TForm;
begin
  if G_bFormEnabled[con_FormMONITOR] then
  begin
    fmTemp := MDIForm('TfmMonitoring');
    if fmTemp <> nil then TfmMonitoring(fmTemp).CardUploadProcess(aNodeSeq,aBuildingCode, aBuildingAreaCode,aTotCount, aCurCount);
  end;
end;

function TfmMain.ChildFormClose(aFormNumber: integer): Boolean;
var
  fmTemp : TForm;
begin
  case aFormNumber of
    con_FormACCESSREPORT : begin
      fmTemp := MDIForm('TfmAccessReport');
      if fmTemp <> nil then TfmAccessReport(fmTemp).Form_Close;
    end;
    con_FormADMINUSERID : begin
      fmTemp := MDIForm('TfmAdminUserID');
      if fmTemp <> nil then TfmAdminUserID(fmTemp).Form_Close;
    end;
    con_FormBuildingAreaCode : begin
      fmTemp := MDIForm('TfmBuildingAreaCode');
      if fmTemp <> nil then TfmBuildingAreaCode(fmTemp).Form_Close;
    end;
    con_FormBuildingCode : begin
      fmTemp := MDIForm('TfmBuildingCode');
      if fmTemp <> nil then TfmBuildingCode(fmTemp).Form_Close;
    end;
    con_FormCardAdmin : begin
      fmTemp := MDIForm('TfmCardAdmin');
      if fmTemp <> nil then TfmCardAdmin(fmTemp).Form_Close;
    end;
    con_FormCardGradeReport : begin
      fmTemp := MDIForm('TfmCardGradeReport');
      if fmTemp <> nil then TfmCardGradeReport(fmTemp).Form_Close;
    end;
    con_FormCardGroup : begin
      fmTemp := MDIForm('TfmCardGroupCode');
      if fmTemp <> nil then TfmCardGroupCode(fmTemp).Form_Close;
    end;
    con_FormCardGroupGrade : begin
      fmTemp := MDIForm('TfmCardGroupGrade');
      if fmTemp <> nil then TfmCardGroupGrade(fmTemp).Form_Close;
    end;
    con_FormCardGubunCode : begin
      fmTemp := MDIForm('TfmCardGubunCode');
      if fmTemp <> nil then TfmCardGubunCode(fmTemp).Form_Close;
    end;
    con_FormDeviceMONITOR : begin
      fmTemp := MDIForm('TfmDeviceComMonitoring');
      if fmTemp <> nil then TfmDeviceComMonitoring(fmTemp).Form_Close;
    end;
    con_FormDoorAdmin : begin
      fmTemp := MDIForm('TfmDoorAdmin');
      if fmTemp <> nil then TfmDoorAdmin(fmTemp).Form_Close;
    end;
    con_FormMONITOR : begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).Form_Close;
    end;
  end;
end;

procedure TfmMain.ClientConfigIniSetting;
var
  ini_fun : TiniFile;
  stType : string;
  i : integer;
  nTemp : integer;
begin
  inherited;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\SAC.INI');
    with ini_fun do
    begin
      G_nEnqTime := ReadInteger('Config','ENQTime',30);
      G_nCardRegisterPort := ReadInteger('Config','CardRegPort',0);
      if ReadInteger('Config','Debug',0) = 1 then G_bDebuging := True
      else G_bDebuging := False;

      if G_nCardRegisterPort <> 0 then
      begin
        try
          dmComPort.PortOpen := False;
          dmComPort.SERIALPORT := G_nCardRegisterPort;
          dmComPort.PortOpen := True;
        except
        end;
      end;
    end;
  Finally
    ini_fun.Free;
  End;
end;

procedure TfmMain.DataBaseBackup(aFolderName: string);
var
  stDBDir : string;
begin
  stDBDir := G_stExeFolder + '\..\DB';

  if FileExists(stDBDir + '/SAC.mdb') then
    CopyFile(pchar(stDBDir + '/SAC.mdb'),pchar(aFolderName + '/SAC.mdb'),True);
  if FileExists(stDBDir + '/SACEvent.mdb') then
    CopyFile(pchar(stDBDir + '/SACEvent.mdb'),pchar(aFolderName + '/SACEvent.mdb'),True );

end;

procedure TfmMain.DBInsertTimerTimer(Sender: TObject);
begin
  if (DBInsertSqlList.Count < 1) and (DBUpdateSqlList.Count < 1) then Exit;
  DBInsertTimer.Enabled := False;
  Try
    if DBInsertSqlList.Count > 0 then
    begin
      dmDataBase.ProcessEventExecSQL(DBInsertSqlList.Strings[0]);
      DBInsertSqlList.Delete(0);
    end;
    if DBUpdateSqlList.Count > 0 then
    begin
      dmDataBase.ProcessExecSQL(DBUpdateSqlList.Strings[0]);
      DBUpdateSqlList.Delete(0);
    end;
  Finally
    DBInsertTimer.Enabled := Not G_bApplicationTerminate;
  End;
end;

procedure TfmMain.DoorLockSetting(Sender: TObject; aNodeSeq: integer;
  aLockPortType, aLockMode: string; aLockControlTime: integer);
var
  fmTemp : TForm;
begin
  if G_bFormEnabled[con_FormMONITOR] then
  begin
    fmTemp := MDIForm('TfmMonitoring');
    if fmTemp <> nil then TfmMonitoring(fmTemp).DoorLockSetting(aNodeSeq,aLockPortType,aLockMode,aLockControlTime);
  end;
end;

procedure TfmMain.DoorState(Sender: TObject; aNodeSeq: integer; aValue: string);
var
  fmTemp : TForm;
begin
  if G_bFormEnabled[con_FormMONITOR] then
  begin
    fmTemp := MDIForm('TfmMonitoring');
    if fmTemp <> nil then TfmMonitoring(fmTemp).DoorState(aNodeSeq,aValue);
  end;

end;

procedure TfmMain.EventCardReader(Sender: TObject; aCardNo: string);
var
  fmTemp : TForm;
begin
//카드등록기 이벤트
  if G_bFormEnabled[con_FormCardAdmin] then
  begin
    fmTemp := MDIForm('TfmCardAdmin');
    if fmTemp <> nil then TfmCardAdmin(fmTemp).CardRegistEvent(aCardNo);
  end;
end;

procedure TfmMain.FireEvent(Sender: TObject; aNodeSeq: integer; aValue: string);
var
  i : integer;
begin
  if NodeList.Count < 1 then Exit;

  for i := 0 to NodeList.Count - 1 do
  begin
    TNode(NodeList.Objects[i]).DoorFire := True;
    TNode(NodeList.Objects[i]).RcvDoorFireEvent := 'S'; //전송하자.
  end;
end;

procedure TfmMain.FORMCHANGE(aName: integer; aValue: string);
var
  i : integer;
begin
  inherited;
  if aName = con_FormDoorAdmin then
  begin
    LoadNode;
  end else if aName = con_FormCardAdmin then
  begin
    LoadCard(aValue);
  end;
  for i := 0 to HIGH(G_bFormEnabled) do
  begin
    if G_bFormEnabled[i] then FormChangeEvent(i,aName);
  end;
end;

function TfmMain.FormChangeEvent(aFormNumber, aFormName: integer): Boolean;
var
  fmTemp : TForm;
begin
  case aFormNumber of
    con_FormACCESSREPORT : begin
      fmTemp := MDIForm('TfmAccessReport');
      if fmTemp <> nil then TfmAccessReport(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormADMINUSERID : begin
      fmTemp := MDIForm('TfmAdminUserID');
      if fmTemp <> nil then TfmAdminUserID(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormBuildingAreaCode : begin
      fmTemp := MDIForm('TfmBuildingAreaCode');
      if fmTemp <> nil then TfmBuildingAreaCode(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormBuildingCode : begin
      fmTemp := MDIForm('TfmBuildingCode');
      if fmTemp <> nil then TfmBuildingCode(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormCardAdmin : begin
      fmTemp := MDIForm('TfmCardAdmin');
      if fmTemp <> nil then TfmCardAdmin(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormCardGradeReport : begin
      fmTemp := MDIForm('TfmCardGradeReport');
      if fmTemp <> nil then TfmCardGradeReport(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormCardGroup : begin
      fmTemp := MDIForm('TfmCardGroupCode');
      if fmTemp <> nil then TfmCardGroupCode(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormCardGroupGrade : begin
      fmTemp := MDIForm('TfmCardGroupGrade');
      if fmTemp <> nil then TfmCardGroupGrade(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormCardGubunCode : begin
      fmTemp := MDIForm('TfmCardGubunCode');
      if fmTemp <> nil then TfmCardGubunCode(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormDeviceMONITOR : begin
      fmTemp := MDIForm('TfmDeviceComMonitoring');
      if fmTemp <> nil then TfmDeviceComMonitoring(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormDoorAdmin : begin
      fmTemp := MDIForm('TfmDoorAdmin');
      if fmTemp <> nil then TfmDoorAdmin(fmTemp).FormChangeEvent(aFormName);
    end;
    con_FormMONITOR : begin
      fmTemp := MDIForm('TfmMonitoring');
      if fmTemp <> nil then TfmMonitoring(fmTemp).FormChangeEvent(aFormName);
    end;
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if G_bApplicationTerminate then Exit;

  G_bApplicationTerminate := True;
  UnLoadNode;
  Delay(1000);
  NodeConnectTimer.Enabled := False;
  CardDownLoadTimer.Enabled := False;
  ValidDateTimer.Enabled := False;
  DBInsertTimer.Enabled := False;

  UnLoadCard;
  UnLoadBuildingCode;
  UnLoadAccessResultCode;
  UnLoadLockMode;
  BuildingCodeNameList.Free;
  AccessResultCodeNameList.Free;
  CardNameList.Free;
  NodeList.Free;
  LockModeNameList.Free;
  DBInsertSqlList.Free;
  DBUpdateSqlList.Free;

end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  L_nReConnectSeq :=0 ;
  L_nNodeSendPacketNo := 0;
  L_bNodeLoding := False;
  AccessResultCodeNameList := TStringList.Create;
  BuildingCodeNameList := TStringList.Create;
  CardNameList := TStringList.Create;
  NodeList := TStringList.Create;
  LockModeNameList := TStringList.Create;
  DBInsertSqlList := TStringList.Create;
  DBUpdateSqlList := TStringList.Create;

  Logined := False;
  TDataBaseConfig.GetObject.DataBaseConnect(False);
  if Not TDataBaseConfig.GetObject.DBConnected then
  begin
    showmessage('데이터베이스 접속 에러');
    Application.Terminate;
    G_bApplicationTerminate := True;
    Exit;
  end;
  at_Menu.ActivePage := ApManager;
  ClientConfigIniSetting;
  dmComPort.OnCardReadEvent := EventCardReader;

  DBInsertTimer.Enabled := True;
end;

procedure TfmMain.FORMENABLE(aName: integer; aValue: string);
var
  bValue : Boolean;
begin
  if UpperCase(aValue) = 'TRUE' then bValue := True
  else bValue := False;

  G_bFormEnabled[aName] := bValue;   //해당 폼

end;

procedure TfmMain.FormResize(Sender: TObject);
begin
  pan_Prograss.Left := (Width div 2) - (pan_Prograss.Width div 2);
  pan_Prograss.Top := (Height div 2) - (pan_Prograss.Height div 2);

  sb_Status.Panels[0].Width := 150;
  sb_Status.Panels[2].Width := 100;
  sb_Status.Panels[3].Width := 100;
  sb_Status.Panels[2].Width := Width - 350;

end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  LoadAccessResultCode;
  LoadBuildingCode;
  LoadBuildingAreaCode;
  LoadCard;
  LoadNode; //기기 전체를 로딩 한다.
  LoadLockMode;

  dmDBUpdate.UpdateTB_DEVICECARDNO_AllSendTypeClear;
  //CardDownLoadTimer.Enabled := True;
  //ValidDateTimer.Enabled := True;

  Caption := 'SAC_Server[' + strBuildInfo + ']';
  at_Menu.Caption.Caption := 'SAC_Server[' + strBuildInfo + ']';
  StartMenu.SubMenuItems[1].Title := strBuildInfo;
end;

procedure TfmMain.FORMSTATUSMSG(aIndex: integer; aMessage: string);
begin
  sb_Status.Panels[aIndex].Text := aMessage;
end;

procedure TfmMain.LoadAccessResultCode;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  oAccessResultCode : TAccessResultCode;
begin
  UnLoadAccessResultCode;
  stSql := 'Select * from TB_ACCESSEVENTCODE ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        oAccessResultCode := TAccessResultCode.Create(nil);
        oAccessResultCode.AccessResultCode := FindField('AE_EVENTCODE').AsString;
        oAccessResultCode.AccessResultName := FindField('AE_EVENTCODENAME').AsString;
        AccessResultCodeNameList.AddObject(FindField('AE_EVENTCODE').AsString,oAccessResultCode);
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.LoadBuildingAreaCode;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nIndex : integer;
begin
  stSql := 'Select * from TB_BUILDINGAREACODE ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        nIndex := BuildingCodeNameList.IndexOf(FindField('BC_BUILDINGCODE').AsString);
        if nIndex > -1 then
        begin
          TBuildingCode(BuildingCodeNameList.Objects[nIndex]).AddBuildingAreaCode(FindField('BC_BUILDINGAREACODE').AsString,FindField('BC_BUILDINGAREANAME').AsString);
        end;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.LoadBuildingCode;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  oBuidingCode : TBuildingCode;
begin
  UnLoadBuildingCode;
  stSql := 'Select * from TB_BUILDINGCODE ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        oBuidingCode := TBuildingCode.Create(nil);
        oBuidingCode.BuildingCode := FindField('BC_BUILDINGCODE').AsString;
        oBuidingCode.BuildingName := FindField('BC_BUILDINGNAME').AsString;
        BuildingCodeNameList.AddObject(FindField('BC_BUILDINGCODE').AsString,oBuidingCode);
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.LoadCard(aCardNo:string='');
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  oCard : TCard;
  nIndex : integer;
begin
  if aCardNo = '' then
  begin
    UnLoadCard;
  end;
  stSql := 'Select * from TB_CARD ';
  if aCardNo <> '' then stSql := stSql + ' Where CA_CARDNO = ''' + aCardNo + ''' ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        nIndex := CardNameList.IndexOf(FindField('CA_CARDNO').AsString);
        if nIndex < 0 then
        begin
          oCard := TCard.Create(nil);
          oCard.CardNo := FindField('CA_CARDNO').AsString;
          oCard.CardName := FindField('CA_NAME').AsString;
          CardNameList.AddObject(FindField('CA_CARDNO').AsString,oCard);
        end else
        begin
          TCard(CardNameList.Objects[nIndex]).CardName := FindField('CA_NAME').AsString;
        end;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.LoadCardPermit(aAutoDownLoad:Boolean=True);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  stCardNo : string;
  stPermit : string;
  stNodeNo : string;
  nIndex : integer;
  stAddr : string;
  i : integer;
  bHangul : Boolean;
begin
  if L_bLoadCardPermit then Exit;
  L_bLoadCardPermit := True;


  dmDBUpdate.UpdateTB_DEVICECARDNO_SendType('N','R');
  if Not aAutoDownLoad then dmDBUpdate.UpdateTB_DEVICECARDNO_SendType('S','R'); //전송중인것도 재전송 하자.

  stSql := dmDBSelect.SelectTB_DEVICECARDNO_SendType('R');
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        L_bCustomer := False;
        pan_Prograss.Visible := False;
        Exit;
      End;
      if recordcount < 1 then
      begin
        if Not aAutoDownLoad then
        begin
          L_nCardDownloadCount := 0;
          AdvProgress1.Max := 100;
          AdvProgress1.Position := 100;
          Delay(1000);
          pan_Prograss.Visible := False;
        end;
        L_bCustomer := False;
        pan_Prograss.Visible := False;
        Exit;
      end;
      if Not aAutoDownLoad then
      begin
        L_nCardDownloadCount := recordcount;
        AdvProgress1.Max := L_nCardDownloadCount;
        AdvProgress1.Position := 0;
      end;
      lb_CardDownloadMessage.Caption.Text :=  '카드권한 전송 중입니다.(' + inttostr(AdvProgress1.Position) + '/' + inttostr(AdvProgress1.Max ) + ')' ;

      while Not Eof do
      begin
        bHangul := False;
        stCardNo := FindField('CA_CARDNO').AsString;
        if IsHangul(stCardNo) then
        begin
          dmDBDelete.DeleteTB_DEVICECARD_CARDNO(stCardNo);
        end else
        begin
          stPermit := FindField('CP_PERMIT').AsString;
          stAddr := FindField('CA_ADDR').AsString;
          if Not IsDigit(stAddr) then stAddr := '0';
          stAddr := FillZeroStrNum(stAddr,4);

          if FindField('CARDNO').AsString = '' then stPermit := '0';
          stNodeNo := FillZeroNumber(FindField('DE_SEQ').AsInteger,G_nNodeCodeLength);

          nIndex := NodeList.IndexOf(stNodeNo);
          if nIndex > -1 then
          begin
            TNode(NodeList.Objects[nIndex]).CardDataDownLoad(stCardNo,stPermit,stAddr);
            dmDBUpdate.UpdateTB_DEVICECARDNO_CardNoSendType(FindField('DE_SEQ').AsString,stCardNo,'S');
          end else
          begin
            dmDBUpdate.UpdateTB_DEVICECARDNO_CardNoSendType(FindField('DE_SEQ').AsString,stCardNo,'Y');
          end;
        end;
        Next;
      end;

      if NodeList.Count > 0 then
      begin
        Try
          for i := 0 to NodeList.Count - 1 do
          begin
            if TNode(NodeList.Objects[i]).GetCardDownLoadCount > 0 then
               TNode(NodeList.Objects[i]).DeviceStateRcvStop := True;
          end;
          for i := 0 to NodeList.Count - 1 do
          begin
            TNode(NodeList.Objects[i]).CardDownLoadStart := True;
            FORMSTATUSMSG(2,TNode(NodeList.Objects[i]).NodeIP + ':' + inttostr(TNode(NodeList.Objects[i]).GetCardDownLoadCount)) ;
            While TNode(NodeList.Objects[i]).CardDownLoadStart do
            begin
              if G_bApplicationTerminate then Exit;
              if Not L_bCustomer then
              begin
                TNode(NodeList.Objects[i]).CardDownLoadStart := False;
                Exit; //전송 중지
              end;

              //MyProcessMessage;
              sleep(1);
              Application.ProcessMessages;
            end;
            TNode(NodeList.Objects[i]).DeviceStateRcvStop := False;
          end;
        Finally
          if Not G_bApplicationTerminate then
          begin
            for i := 0 to NodeList.Count - 1 do
            begin
              TNode(NodeList.Objects[i]).DeviceStateRcvStop := False;
            end;
          end;
        End;
      end;
    end;
  Finally
    L_bLoadCardPermit := False;
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.LoadLockMode;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  oLockMode : TLockMode;
begin
  UnLoadLockMode;
  stSql := 'Select * from TB_DOORLOCKPORT ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        oLockMode := TLockMode.Create(nil);
        oLockMode.LockModeCode := FindField('DE_LOCKMODE').AsString;
        oLockMode.LockModeName := FindField('DE_LOCKMODENAME').AsString;
        LockModeNameList.AddObject(FindField('DE_LOCKMODE').AsString,oLockMode);
        Next;
      end;
    end;
    NodeConnectTimer.Enabled := True;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmMain.LoadNode;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  oNode : TNode;
begin
  L_bNodeLoding := True;
  UnLoadNode;
  stSql := 'Select * from TB_DEVICE ';
  stSql := stSql + ' Order by DE_SEQ ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        oNode := TNode.Create(nil);
        oNode.NodeSeq := FindField('DE_SEQ').AsInteger;
        oNode.NodeIP := FindField('DE_NODEIP').AsString;
        oNode.NodePort := FindField('DE_NODEPORT').AsInteger;
        oNode.ReaderNo := FindField('DE_READERID').AsInteger;
        oNode.DeviceName := FindField('DE_DEVICENAME').AsString;
        oNode.BuildingCode := FindField('BC_BUILDINGCODE').AsString;
        oNode.BuildingAreaCode := FindField('BC_BUILDINGAREACODE').AsString;
        oNode.OnAccessEvent := AccessEvent;
        oNode.OnCardLoding := CardLoding;
        oNode.OnCardRegEvent := CardRegEvent;
        oNode.OnCardUpLoadEvent := CardUpLoadEvent;
        oNode.OnCardUploadProcess := CardUploadProcess;
        oNode.OnDoorLockSetting := DoorLockSetting;
        oNode.OnDoorState := DoorState;
        oNode.OnFireEvent := FireEvent;
        oNode.OnNodeConnected := NodeConnected;
        oNode.OnNodePacketEvent := NodePacketEvent;
        oNode.OnPasswordEvent := PasswordEvent;
        oNode.SendTimerStart := True;
        NodeList.AddObject(FillZeroNumber(FindField('DE_SEQ').AsInteger,G_nNodeCodeLength),oNode);
        Next;
      end;
    end;
    NodeSendTimer.Enabled := True;
    L_bNodeLoding := False;
    NodeConnectTimer.Enabled := True;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

function TfmMain.MDIChildShow(FormName: String): Boolean;
var
  tmpFormClass : TFormClass;
  tmpClass : TPersistentClass;
  tmpForm : TForm;
  clsName : String;
  i : Integer;
begin
  result := False;
  clsName := FormName;
  tmpClass := FindClass(clsName);
  if tmpClass <> nil then
  begin
    for i := 0 to Screen.FormCount - 1 do
    begin
      if Screen.Forms[i].ClassNameIs(clsName) then
      begin
        if Screen.ActiveForm = Screen.Forms[i] then
        begin
          //Screen.Forms[i].WindowState := wsMaximized;
          Exit;
        end;
        Screen.Forms[i].Show;
        result := True;
        Exit;
      end;
    end;

    tmpFormClass := TFormClass(tmpClass);
    tmpForm := tmpFormClass.Create(Self);
    tmpForm.Show;
    result := True;
  end;
end;

function TfmMain.MDIForm(FormName: string): TForm;
var
  tmpFormClass : TFormClass;
  tmpClass : TPersistentClass;
  tmpForm : TForm;
  clsName : String;
  i : Integer;
begin
  result := nil;
  clsName := FormName;
  tmpClass := FindClass(clsName);
  if tmpClass <> nil then
  begin
    for i := 0 to Screen.FormCount - 1 do
    begin
      if Screen.Forms[i].ClassNameIs(clsName) then
      begin
        result := Screen.Forms[i];
        Exit;
      end;
    end;
  end;
end;

procedure TfmMain.MDIFormAllClose;
var
  i : integer;
begin
  for i := 0 to HIGH(G_bFormEnabled) do
  begin
    if G_bFormEnabled[i] then ChildFormClose(i);
  end;
end;

procedure TfmMain.mn_AccessReportClick(Sender: TObject);
begin
  MDIChildShow('TfmAccessReport');
end;

procedure TfmMain.mn_AdminManagerClick(Sender: TObject);
begin
  MDIChildShow('TfmAdminUserID');
end;

procedure TfmMain.mn_AreaCodeClick(Sender: TObject);
begin
  MDIChildShow('TfmBuildingAreaCode');
end;

procedure TfmMain.mn_BuildingCodeClick(Sender: TObject);
begin
  MDIChildShow('TfmBuildingCode');
end;

procedure TfmMain.mn_BuildingCodeMouseEnter(Sender: TObject);
var
  stMessage : string;
begin
  inherited;
  stMessage := '$WORK 작업을 수행합니다.';
  stMessage := stringReplace(stMessage,'$WORK',TAdvGlowButton(Sender).Caption,[rfReplaceAll]);
  FORMSTATUSMSG(2,stMessage);

end;

procedure TfmMain.mn_CardBackupClick(Sender: TObject);
var
  stFileName : string;
begin
  SaveDialog1.DefaultExt := '*.csv';
  SaveDialog1.Filter := '*.csv (csv file)|*.csv';
  if SaveDialog1.Execute then
  begin
    stFileName := SaveDialog1.FileName;
    CardBackup(stFileName);
  end;
end;

procedure TfmMain.mn_CardClick(Sender: TObject);
begin
  MDIChildShow('TfmCardAdmin');
end;

procedure TfmMain.mn_CardDownLoadClick(Sender: TObject);
begin
  L_bCustomer := True;
  pan_Prograss.Visible := True;
  LoadCardPermit(False);
  if L_bCustomer and (AdvProgress1.Max <> AdvProgress1.Position) then mn_CardDownLoadClick(mn_CardDownLoad);

end;

procedure TfmMain.mn_CardGradeClick(Sender: TObject);
begin
  MDIChildShow('TfmCardGradeReport');
end;

procedure TfmMain.mn_CardRestoreClick(Sender: TObject);
var
  stFileName : string;
begin
  OpenDialog1.Filter := '*.csv (csv file)|*.csv';
  if OpenDialog1.Execute then
  begin
    stFileName := OpenDialog1.FileName;
    CardRestore(stFileName);
  end;

end;

procedure TfmMain.mn_ComMonitoringClick(Sender: TObject);
begin
  MDIChildShow('TfmDeviceComMonitoring');
end;

procedure TfmMain.mn_DBBackupClick(Sender: TObject);
begin
  if FolderDialog1.Execute then
  begin
    DataBaseBackup(FolderDialog1.Directory);
  end;
end;

procedure TfmMain.mn_DoorCodeClick(Sender: TObject);
begin
  MDIChildShow('TfmDoorAdmin');
end;

procedure TfmMain.mn_FireRecoveryClick(Sender: TObject);
var
  i : integer;
begin
  if NodeList.Count < 1 then Exit;

  for i := 0 to NodeList.Count - 1 do
  begin
    TNode(NodeList.Objects[i]).DoorFire := False;
    TNode(NodeList.Objects[i]).RcvDoorFireEvent := 'S'; //전송하자.
  end;

end;

procedure TfmMain.mn_FloorCodeClick(Sender: TObject);
begin
  MDIChildShow('TfmCardGubunCode');
end;

procedure TfmMain.mn_GroupClick(Sender: TObject);
begin
  MDIChildShow('TfmCardGroupCode');
end;

procedure TfmMain.mn_GroupGradeClick(Sender: TObject);
begin
  MDIChildShow('TfmCardGroupGrade');
end;

procedure TfmMain.mn_MonitoringClick(Sender: TObject);
begin
  MDIChildShow('TfmMonitoring');
end;

procedure TfmMain.NodeConnected(Sender: TObject; aNodeSeq: integer;
  aValue: TConnectedState);
var
  fmTemp : TForm;
  nConnected : integer;
begin
  if aValue = csConnected then nConnected := 1
  else nConnected := 0;

  if G_bFormEnabled[con_FormMONITOR] then
  begin
    fmTemp := MDIForm('TfmMonitoring');
    if fmTemp <> nil then TfmMonitoring(fmTemp).NodeConnected(aNodeSeq,nConnected);
  end;
end;

procedure TfmMain.NodeConnectTimerTimer(Sender: TObject);
var
  i : integer;
  dtPollingTime: TDatetime;
  dtTimeOut: TDatetime;
begin
  inherited;
//  Exit;
  if NodeList.Count < 1 then Exit;
  if L_nNodeConnectCount > 3 then     //처음 구동 시 3번만 Connect 시도 하고 접속 타이머 돌리지 말자.
  begin
    NodeConnectTimer.Enabled := False;
    Exit;
  end;
  inc(L_nNodeConnectCount);

  Try
    Try
      NodeConnectTimer.Enabled := False;
      for i := 0 to NodeList.Count - 1 do
      begin
        if G_bApplicationTerminate then Exit;
        if TNode(NodeList.Objects[i]).SocketOpen then
        begin
          Try
            dtPollingTime:= TNode(NodeList.Objects[i]).LastReceiveTime;
            dtTimeOut:= IncTime(dtPollingTime,0,0,con_NODESOCKETDELAYTIME,0);
            if Now > dtTimeOut then
            begin
               TNode(NodeList.Objects[i]).SocketOpen := False; //30초간 아무 데이터가 없으면 소켓 끊고 재접속 해 보자
               TNode(NodeList.Objects[i]).LastReceiveTime := Now; //일정시간 후에 다시 Open 시도
            end;
          Except
            LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','NodeConnectTimerTimer');
          End;
        end;
      end;

      if L_nReConnectSeq > (NodeList.Count - 1)  then L_nReConnectSeq := 0;

      for i := 0 to NodeList.Count - 1 do
      begin
        if G_bApplicationTerminate then Exit;
        if Not TNode(NodeList.Objects[i]).SocketOpen then
        begin
          TNode(NodeList.Objects[i]).SocketOpen := True;
          LogSave(G_stLogDirectory + '\ReConnected' + FormatDateTime('yyyymmdd',now) + '.log',TNode(NodeList.Objects[i]).NodeIP);
          L_nReConnectSeq := i + 1;
          break;
        end;
        L_nReConnectSeq := i + 1;
      end;
    Finally
      NodeConnectTimer.Enabled := Not G_bApplicationTerminate;
    End;
  Except
    LogSave(G_stLogDirectory + '\Err' + FormatDateTime('yyyymmdd',now) + '.log','NodeConnectTimerTimer');
  End;
end;

procedure TfmMain.NodePacketEvent(Sender: TObject; aNodeSeq: integer; aTxRx,aDeviceName,
  aCmd, aPacketData: string);
var
  fmTemp : TForm;
  nConnected : integer;
begin
  if G_bFormEnabled[con_FormDeviceMONITOR] then
  begin
    fmTemp := MDIForm('TfmDeviceComMonitoring');
    if fmTemp <> nil then TfmDeviceComMonitoring(fmTemp).NodePacketEvent(aNodeSeq,aTxRx,aDeviceName,aCmd,aPacketData);
  end;
end;

procedure TfmMain.NodeSendTimerTimer(Sender: TObject);
var
  i : integer;
begin
  if G_bApplicationTerminate then Exit;
  if L_bNodeLoding then Exit; //노드 로딩 중에는 수행하지 말자

  if NodeList.Count < 1 then Exit;
  Try
    NodeSendTimer.Enabled := False;

    if L_nNodeSendPacketNo > NodeList.Count - 1 then  L_nNodeSendPacketNo := 0;

    //for i := 0 to NodeList.Count - 1 do
    //begin
      if L_bNodeLoding then Exit; //노드 로딩 중에는 수행하지 말자
      if G_bApplicationTerminate then Exit;
      //if TNode(NodeList.Objects[L_nNodeSendPacketNo]).RealConnected then

          TNode(NodeList.Objects[L_nNodeSendPacketNo]).ExecSendPacket;
//      Delay(1);
    //end;
  Finally
    NodeSendTimer.Enabled := Not G_bApplicationTerminate;
  End;

end;

procedure TfmMain.PasswordEvent(Sender: TObject; aNodeSeq: integer; aCmd,
  aPassword: string);
var
  fmTemp : TForm;
begin

  if G_bFormEnabled[con_FormMONITOR] then
  begin
    fmTemp := MDIForm('TfmMonitoring');
    if fmTemp <> nil then TfmMonitoring(fmTemp).PasswordEvent(aNodeSeq,aCmd,aPassword);
  end;
end;

procedure TfmMain.SetLogined(const Value: Boolean);
begin

  FLogined := Value;
  StartMenu.MenuItems.Items[1].Enabled := Not Value;
  StartMenu.MenuItems.Items[2].Enabled := Value;

  if Value then
  begin
    FORMSTATUSMSG(0,G_stAdminUserID);
    FORMSTATUSMSG(2,'로그인성공');
    mn_MonitoringClick(mn_Monitoring);
  end else
  begin
    FORMSTATUSMSG(0,'');
    FORMSTATUSMSG(2,'로그아웃');
    G_bIsMaster := False;
    MDIFormAllClose;
  end;

  mn_BuildingCode.Enabled := Value;
  mn_AreaCode.Enabled := Value;
  mn_FloorCode.Enabled := Value;
  mn_DoorCode.Enabled := Value;
  mn_Group.Enabled := Value;
  mn_GroupGrade.Enabled := Value;
  mn_Card.Enabled := Value;
  mn_CardGrade.Enabled := Value;
  mn_CardDownLoad.Enabled := Value;
  mn_Monitoring.Enabled := Value;
  mn_ComMonitoring.Enabled := Value;
  mn_FireRecovery.Enabled := Value;
  mn_AccessReport.Enabled := Value;
  mn_AdminManager.Enabled := Value;
  mn_CardBackup.Enabled := Value;
  mn_CardRestore.Enabled := Value;
  mn_DBBackup.Enabled := Value;
  apAdmin.TabVisible := G_bIsMaster;

end;

procedure TfmMain.StartMenuMenuItems1Click(Sender: TObject);
begin
  TLogin.GetObject.ShowLoginDlg(inttostr(G_nBMSType));
  G_stAdminUserID := TLogin.GetObject.UserID;
  G_stAdminUserName := TLogin.GetObject.UserName;
  Logined := TLogin.GetObject.Logined;

  FORMSTATUSMSG(0,G_stAdminUserName);
end;

procedure TfmMain.StartMenuMenuItems2Click(Sender: TObject);
begin
  Logined :=False;
end;

procedure TfmMain.StartMenuMenuItems4Click(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.UnLoadAccessResultCode;
var
  i : integer;
begin
  if AccessResultCodeNameList.Count < 1 then Exit;
  for i := AccessResultCodeNameList.Count - 1 downto 0 do
    TAccessResultCode(AccessResultCodeNameList.Objects[i]).Free;
  AccessResultCodeNameList.Clear;

end;

procedure TfmMain.UnLoadBuildingCode;
var
  i : integer;
begin
  if BuildingCodeNameList.Count < 1 then Exit;

  for i := BuildingCodeNameList.Count - 1 downto 0 do
    TBuildingCode(BuildingCodeNameList.Objects[i]).Free;
  BuildingCodeNameList.Clear;
end;

procedure TfmMain.UnLoadCard;
var
  i : integer;
begin
  if CardNameList.Count < 1 then Exit;

  for i := CardNameList.Count - 1 downto 0 do
    TCard(CardNameList.Objects[i]).Free;
  CardNameList.Clear;
end;

procedure TfmMain.UnLoadLockMode;
var
  i : integer;
begin
  if LockModeNameList.Count < 1 then Exit;

  for i := LockModeNameList.Count - 1 downto 0 do
    TLockMode(LockModeNameList.Objects[i]).Free;
  LockModeNameList.Clear;

end;

procedure TfmMain.UnLoadNode;
var
  i : integer;
begin
  NodeSendTimer.Enabled := False;
  if NodeList.Count < 1 then Exit;

  for i := NodeList.Count - 1 downto 0 do
  begin
    TNode(NodeList.Objects[i]).Free;
  end;
  NodeList.Clear;
end;

procedure TfmMain.ValidDateTimerTimer(Sender: TObject);
begin
  if G_bApplicationTerminate then Exit;
  ValidDate_Apply;
end;

procedure TfmMain.ValidDate_Apply;
begin
  dmCardPermit.ValidStartDate_Apply;
  dmCardPermit.ValidExpiredDate_Apply;
end;

end.
