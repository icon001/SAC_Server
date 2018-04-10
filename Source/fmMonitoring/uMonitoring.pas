unit uMonitoring;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, AdvOfficePager,
  AdvOfficeTabSet, AdvOfficeTabSetStylers, AdvAppStyler, AdvOfficePagerStylers,
  AdvSmoothPanel, Vcl.ExtCtrls, AdvSplitter, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Menus, Vcl.ImgList, uSubForm, CommandArray,Winapi.ShellAPI,
  AdvSmoothButton, Vcl.Imaging.pngimage,System.IniFiles, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, AdvPageControl,Vcl.Clipbrd, Vcl.Buttons, AdvCombo, AdvProgr,
  AdvSmoothLabel, AdvEdit;

const
  //con_AlarmStateNotEvent = -1;
  //con_AlarmStateNormalEvent = 0;
  //con_AlarmStateAlarmEvent = 1;

  con_ArmAreaImageNothing = 0;
  con_ArmAreaNormalImageDisArm = 1;
  con_ArmAreaNormalImagePartArm = 2;
  con_ArmAreaNormalImageArm = 3;
  con_ArmAreaEventImageDisArm = 4;
  con_ArmAreaEventImagePartArm = 5;
  con_ArmAreaEventImageArm = 6;
  con_ArmAreaAlarmImageDisArm = 7;
  con_ArmAreaAlarmImagePartArm = 8;
  con_ArmAreaAlarmImageArm = 9;

  con_BuildingArmAreaImageNothing = 0;
  con_BuildingArmAreaNormalImageDisArm = 1;
  con_BuildingArmAreaNormalImagePartArm = 2;
  con_BuildingArmAreaNormalImageArm = 3;
  con_BuildingArmAreaEventImageDisArm = 4;
  con_BuildingArmAreaEventImagePartArm = 5;
  con_BuildingArmAreaEventImageArm = 6;
  con_BuildingArmAreaAlarmImageDisArm = 7;
  con_BuildingArmAreaAlarmImagePartArm = 8;
  con_BuildingArmAreaAlarmImageArm = 9;

const
  con_LocalNodeAllConnectedImageIndex = 2;
  con_LocalNodeConnectedImageIndex = 1;
  con_LocalNodeDisConnectedImageIndex = 0;

  con_LocalDeviceConnectedImageIndex = 4;
  con_LocalDeviceDisConnectedImageIndex = 3;

  con_DoorStatePosiManageMode = 0;
  con_DoorStateNegaManageMode = 1;
  con_DoorStatePosiOpenMode = -1;
  con_DoorStateNegaOpenMode = -1;
  con_DoorStatePosiCloseMode = 2;
  con_DoorStateNegaCloseMode = 2;

  con_DoorImageFire = 4;
  con_DoorImageLongTime = 3;
  con_DoorImageOpen = 1;
  con_DoorImageClose = 0;
  con_DoorImageNothing = 2;
  con_BuildingImage = 5;

type
  TfmMonitoring = class(TfmASubForm)
    AdvOfficePager1: TAdvOfficePager;
    ap_Access: TAdvOfficePage;
    btn_minimize: TAdvGlowButton;
    btn_Close: TAdvGlowButton;
    pan_Device: TAdvSmoothPanel;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvFormStyler1: TAdvFormStyler;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    AdvSplitter1: TAdvSplitter;
    lb_List: TLabel;
    toolslist: TImageList;
    PopupMenu1: TPopupMenu;
    pm_PingTest: TMenuItem;
    pm_TimeSync: TMenuItem;
    N3: TMenuItem;
    pm_DeviceReset: TMenuItem;
    pm_PermitReSend: TMenuItem;
    MenuImageList16: TImageList;
    tv_DeviceList: TTreeView;
    tv_DeviceCode: TTreeView;
    gb_DeviceState: TGroupBox;
    Image1: TImage;
    lb_NodeState1: TLabel;
    lb_NodeDisConnect1: TLabel;
    Image2: TImage;
    lb_NodeConnect1: TLabel;
    pan_Access: TAdvSmoothPanel;
    pan_DoorState: TAdvSmoothPanel;
    lb_DoorState: TLabel;
    SmallDoorList: TImageList;
    pm_DoorControl: TPopupMenu;
    mn_DoorOpen: TMenuItem;
    N9: TMenuItem;
    pm_DoorManageMode: TMenuItem;
    pm_DooOpenMode: TMenuItem;
    pm_DoorCloseMode: TMenuItem;
    N1: TMenuItem;
    N11: TMenuItem;
    mn_LargeIcon: TMenuItem;
    mn_SmallIcon: TMenuItem;
    N14: TMenuItem;
    pm_DoorInfo: TMenuItem;
    doorListView: TListView;
    gb_DoorState: TGroupBox;
    AdvSplitter3: TAdvSplitter;
    ReSizeTimer: TTimer;
    ActiveTimer: TTimer;
    AdvSmoothPanel2: TAdvSmoothPanel;
    PageControl1: TAdvPageControl;
    tb_AccessEvent: TAdvTabSheet;
    sg_AccessEvent: TAdvStringGrid;
    PopupMenu3: TPopupMenu;
    mn_CardNOCopy: TMenuItem;
    stateArmArealist: TImageList;
    SmallArmAreaList: TImageList;
    PopupMenu5: TPopupMenu;
    mn_AlarmConfirm1: TMenuItem;
    lb_DeviceStateExample: TLabel;
    lb_DoorstateExample: TLabel;
    LargeImageList32: TImageList;
    LargeArmAreaList32: TImageList;
    lb_DoorState1: TLabel;
    GroupBox2: TGroupBox;
    lb_DoorOpenState: TLabel;
    SpeedButton5: TSpeedButton;
    ap_DoorState: TAdvOfficePager;
    ap_Door: TAdvOfficePage;
    pan_DoorInfo: TAdvSmoothPanel;
    lb_DoorNodeIP: TLabel;
    lb_NodeIP: TLabel;
    lb_DoorName1: TLabel;
    lb_DoorName: TLabel;
    lb_DoorInfo: TLabel;
    btn_DoorInfoConfirm: TAdvGlowButton;
    lb_DoorLock: TLabel;
    SpeedButton4: TSpeedButton;
    lb_DoorPManager: TLabel;
    SpeedButton2: TSpeedButton;
    N2: TMenuItem;
    mn_DoorInfoSetting: TMenuItem;
    pan_DoorSetting: TAdvSmoothPanel;
    Label1: TLabel;
    Label3: TLabel;
    lb_SettingDoorName: TLabel;
    Label5: TLabel;
    btn_DoorSetting: TAdvGlowButton;
    cmb_DoorLockType: TAdvComboBox;
    Label2: TLabel;
    cmb_DoorControlTime: TAdvComboBox;
    btn_SettingCancel: TAdvGlowButton;
    lb_NodeNo: TLabel;
    pm_DeviceCardLoad: TMenuItem;
    N5: TMenuItem;
    N4: TMenuItem;
    pm_DeviceCardInit: TMenuItem;
    pan_Prograss: TAdvSmoothPanel;
    AdvProgress1: TAdvProgress;
    ClosePanelTimer: TTimer;
    AdvSmoothLabel1: TAdvSmoothLabel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    mn_msr7000PW: TMenuItem;
    mn_msr7000Line: TMenuItem;
    mn_PW: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    pan_Password: TAdvSmoothPanel;
    lb_Password: TLabel;
    btn_PasswordApply: TAdvGlowButton;
    btn_PasswordCancel: TAdvGlowButton;
    ed_Passwd: TAdvEdit;
    lb_PWName: TAdvSmoothLabel;
    lb_PasswordMessage: TAdvSmoothLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_minimizeClick(Sender: TObject);
    procedure pan_DeviceResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pm_PingTestClick(Sender: TObject);
    procedure pm_TimeSyncClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReSizeTimerTimer(Sender: TObject);
    procedure ActiveTimerTimer(Sender: TObject);
    procedure doorListViewClick(Sender: TObject);
    procedure doorListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btn_DoorInfoConfirmClick(Sender: TObject);
    procedure mn_DoorOpenClick(Sender: TObject);
    procedure pm_DooOpenModeClick(Sender: TObject);
    procedure pm_DoorInfoClick(Sender: TObject);
    procedure sg_AccessEventKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mn_CardNOCopyClick(Sender: TObject);
    procedure ap_AccessShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lb_DeviceStateExampleMouseEnter(Sender: TObject);
    procedure lb_DeviceStateExampleMouseLeave(Sender: TObject);
    procedure pan_DoorStateResize(Sender: TObject);
    procedure AdvSmoothPanel2Resize(Sender: TObject);
    procedure lb_DoorstateExampleMouseEnter(Sender: TObject);
    procedure lb_DoorstateExampleMouseLeave(Sender: TObject);
    procedure sg_AccessEventColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure ap_DoorStateChange(Sender: TObject);
    procedure pm_DeviceResetClick(Sender: TObject);
    procedure pm_PermitReSendClick(Sender: TObject);
    procedure pm_DoorManageModeClick(Sender: TObject);
    procedure pm_DoorCloseModeClick(Sender: TObject);
    procedure mn_LargeIconClick(Sender: TObject);
    procedure mn_SmallIconClick(Sender: TObject);
    procedure mn_DoorInfoSettingClick(Sender: TObject);
    procedure btn_SettingCancelClick(Sender: TObject);
    procedure btn_DoorSettingClick(Sender: TObject);
    procedure cmb_DoorLockTypeChange(Sender: TObject);
    procedure cmb_DoorControlTimeChange(Sender: TObject);
    procedure pm_DeviceCardLoadClick(Sender: TObject);
    procedure pm_DeviceCardInitClick(Sender: TObject);
    procedure tv_DeviceListClick(Sender: TObject);
    procedure ClosePanelTimerTimer(Sender: TObject);
    procedure mn_PWClick(Sender: TObject);
    procedure btn_PasswordCancelClick(Sender: TObject);
    procedure btn_PasswordApplyClick(Sender: TObject);
  private
    AccessEventHeaderNameList : TStringList;

    L_arrAccessEventIndexArray:Array of integer; //출입이벤트 리스트 순서 배열
    L_arrRelAccessEventIndexArray:Array of integer; //출입이벤트 실제 위치
    L_arrAccessEventShowTable : Array of integer;  //출입이벤트 조회 항목테이블
    L_arrAccessEventSizeTable : Array of integer;  //출입이벤트 Cell Size

    L_bFormActive : Boolean;
    L_bViewRefresh : Boolean;
    L_nCount : integer;
    L_nAlarmViewListStyle : integer;
    L_nAccessEventShowCount : integer;
    L_nAlarmEventShowCount : integer;
    L_nAlarmModeShowCount : integer;
    L_nDeviceEventShowCount : integer;
    L_nViewListStyle : integer;
    L_stMenuID : string;
    L_stPasswordNode : string;
    L_stPasswordWork : string;

    { Private declarations }
    procedure ChangeAccessEventIndex(FromIndex,ToIndex:integer);
    function  ListCellSize:Boolean;
    function  ListConfigRead:Boolean;
    function  ListHeaderNameGet:Boolean;
    function  ListHeaderNameSetting:Boolean;
    function  ListFieldNameSetting:Boolean;
    function  LoadBuildingDoor : Boolean;
    procedure LoadTreeDeviceList(aTreeList,vTreeList:TTreeView);
    procedure TreeViewDeviceConnectChange(aTreeList,vTreeList:TTreeView;aNodeNo, aEcuID,aData:string);
    procedure TreeViewNodeConnectChange(aTreeList,vTreeList:TTreeView;aNodeNo, aEcuID,aData:string);
    function  WriteIniConfig:Boolean;
  private
    function CardPermitResend(aNodeNo:string):Boolean;
    function GetAccessResultName(aAccessResult:string):string;
    function GetBuildingAreaName(aBuildingCode,aBuindigAreaCode:string):string;
    function GetBuildingName(aBuildingCode:string):string;
    function GetCardName(aCardNo:string):string;
    function GetDoorListViewIndex(aNodeSeq:integer):integer;
    function GetDoorLockModeImageIndex(aDoorLockMode:string):integer;
    function GetLockModeName(aLockMode:string):string;
  public
    procedure CardUploadProcess(aNodeSeq:integer;aBuildingCode, aBuildingAreaCode:string;aTotCount, aCurCount:integer);
    procedure DeviceReload;
  public
    { Public declarations }
    procedure AccessEvent(aNodeSeq : integer;aDeviceName,aBuildingCode,aBuildingAreaCode,aAccessTime,aAccessResult,aLockMode,aCardNo,aCardType:string);
    procedure DoorLockSetting(aNodeSeq:integer;aLockPortType,aLockMode:string;aLockControlTime:integer);
    procedure DoorState(aNodeSeq : integer;aDoorLockMode:string);
    procedure FormChangeEvent(aFormName:integer);
    procedure FormGradeRefresh;
    procedure FormIDSetting(aID:string);
    procedure NodeConnected(aNodeSeq : integer;aValue: integer);
    procedure PasswordEvent(aNodeSeq:integer;aCmd,aPassword:string);
    procedure RcvDeviceConnectedChangeEvent(aNodeNo,aEcuID,aData:string);
    procedure RcvNodeConnectedChangeEvent(aNodeNo,aEcuID,aData:string);
  end;

var
  fmMonitoring: TfmMonitoring;

implementation
uses
  uCommonFunction,
  uCommonVariable,
  uDBFunction,
  uDBInsert,
  uDBUpdate,
  uFormVariable,
  uMain,
  uNode;
{$R *.dfm}


procedure TfmMonitoring.AccessEvent(aNodeSeq: integer; aDeviceName,
  aBuildingCode, aBuildingAreaCode, aAccessTime, aAccessResult, aLockMode,
  aCardNo,aCardType: string);
var
  nIndex : integer;
  stBuildingName : string;
  stBuildingAreaName : string;
  stCardName : string;
  stAccessResultName : string;
  stLockModeName : string;
begin
  if aCardType <> '0A' then
  begin
    stCardName := GetCardName(aCardNo);
  end else
  begin
    stCardName := '비밀번호';
  end;
  stBuildingName := GetBuildingName(aBuildingCode);
  stBuildingAreaName := GetBuildingAreaName(aBuildingCode,aBuildingAreaCode);
  stAccessResultName := GetAccessResultName(aAccessResult);
  stLockModeName := GetLockModeName(aLockMode);

  with sg_AccessEvent do
  begin
    if Cells[L_arrAccessEventIndexArray[0],1] <> '' then InsertRows(1,1);
    Cells[L_arrAccessEventIndexArray[0],1] := MakeDatetimeStr(aAccessTime);
    Cells[L_arrAccessEventIndexArray[1],1] := stBuildingName;
    Cells[L_arrAccessEventIndexArray[2],1] := stBuildingAreaName;
    Cells[L_arrAccessEventIndexArray[3],1] := aDeviceName;
    Cells[L_arrAccessEventIndexArray[4],1] := aCardNo;
    Cells[L_arrAccessEventIndexArray[5],1] := stCardName;
    Cells[L_arrAccessEventIndexArray[6],1] := stAccessResultName;
    Cells[L_arrAccessEventIndexArray[7],1] := stLockModeName;


    if RowCount > 1000 then RowCount := 1000;

  end;

end;

procedure TfmMonitoring.ActiveTimerTimer(Sender: TObject);
var
  nSelectIndex : integer;
begin
  inherited;
  Exit;
  ActiveTimer.Enabled := False;
//  if L_bFormActive then Exit;
  if L_bViewRefresh then Exit;
  L_bViewRefresh := True;
  Try

    if L_nViewListStyle = 0 then
    begin
      doorListView.ViewStyle := vsList;
      Delay(100);
      doorListView.ViewStyle := vsICon;
      //doorListView.Refresh;
    end else
    begin
      doorListView.ViewStyle := vsICon;
      Delay(100);
      doorListView.ViewStyle := vsList;
      //doorListView.Refresh;
    end;

    FormResize(self);
  Finally
    L_bViewRefresh := False;
  End;
end;

procedure TfmMonitoring.AdvSmoothPanel2Resize(Sender: TObject);
begin
  inherited;
  sg_AccessEvent.Top := 5;
  sg_AccessEvent.Left := 5;
  sg_AccessEvent.Height := tb_AccessEvent.Height - (sg_AccessEvent.Top * 2);
  sg_AccessEvent.Width := tb_AccessEvent.Width - (sg_AccessEvent.Left * 2);

end;

procedure TfmMonitoring.ap_AccessShow(Sender: TObject);
begin
  inherited;
  FormResize(self);
end;

procedure TfmMonitoring.ap_DoorStateChange(Sender: TObject);
begin
  inherited;
  //pan_DoorState.Refresh;
end;


procedure TfmMonitoring.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMonitoring.btn_DoorInfoConfirmClick(Sender: TObject);
begin
  inherited;
  pan_DoorInfo.Visible := False;
end;

procedure TfmMonitoring.btn_DoorSettingClick(Sender: TObject);
var
  nIndex : integer;
  stNodeNo : string;
begin
  inherited;
  stNodeNo := lb_NodeNo.Caption;
  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;

  if TNode(NodeList.Objects[nIndex]).NodeConnected <> csConnected then
  begin
    showmessage('기기와 통신연결이 안되었습니다.연결된 후 출입문 설정이 가능합니다.');
    Exit;
  end;
  if cmb_DoorLockType.ItemIndex = 0 then TNode(NodeList.Objects[nIndex]).LockPortType := '01'
  else TNode(NodeList.Objects[nIndex]).LockPortType := '02';
  TNode(NodeList.Objects[nIndex]).LockControlTime := cmb_DoorControlTime.ItemIndex + 1;

  cmb_DoorControlTime.Color := clWhite;
  cmb_DoorControlTime.Color := clWhite;

  TNode(NodeList.Objects[nIndex]).LockPortSetting(TNode(NodeList.Objects[nIndex]).LockPortType,TNode(NodeList.Objects[nIndex]).LockMode,Dec2Hex(TNode(NodeList.Objects[nIndex]).LockControlTime,2));
  Delay(300);
  TNode(NodeList.Objects[nIndex]).LockPortSearch;
end;

procedure TfmMonitoring.btn_minimizeClick(Sender: TObject);
begin
  windowState := wsNormal;
end;

procedure TfmMonitoring.btn_PasswordApplyClick(Sender: TObject);
var
  i : integer;
  nIndex : integer;
  nDelay : integer;
begin
  Try
    if doorListView.SelCount < 1 then Exit;
    ed_Passwd.Color := clWhite;
    lb_PasswordMessage.Caption.Text := '';
    Try
      doorListView.Enabled := False;
      L_stPasswordNode:= doorListView.Selected.SubItems.Strings[0];
      nIndex := NodeList.IndexOf(L_stPasswordNode);
      if nIndex > - 1 then
      begin
        TNode(NodeList.Objects[nIndex]).PasswordApply(L_stPasswordWork,ed_Passwd.Text);
      end;
    Finally
      doorListView.Enabled := True;
    End;
  Except
    Exit;
  End;  //pan_Password.Visible := False;
end;

procedure TfmMonitoring.btn_PasswordCancelClick(Sender: TObject);
begin
  inherited;
  pan_Password.Visible := False;
end;

procedure TfmMonitoring.btn_SettingCancelClick(Sender: TObject);
begin
  inherited;
  pan_DoorSetting.Visible := False;
end;

function TfmMonitoring.CardPermitResend(aNodeNo: string): Boolean;
begin
  dmDBUpdate.UpdateTB_DEVICECARDNO_CardResend(aNodeNo);
end;

procedure TfmMonitoring.CardUploadProcess(aNodeSeq:integer; aBuildingCode,
  aBuildingAreaCode: string; aTotCount, aCurCount: integer);
begin
  if aTotCount = 0 then Exit;

  AdvProgress1.Max := aTotCount;
  AdvProgress1.Position := aCurCount;

  if aCurCount >= aTotCount then
  begin
    ClosePanelTimer.enabled := True;
    //pan_Prograss.Visible := False;
  end;

end;

procedure TfmMonitoring.ChangeAccessEventIndex(FromIndex, ToIndex: integer);
var
  i : integer;
  nChangData : integer;
begin
  nChangData := L_arrRelAccessEventIndexArray[FromIndex];
  if FromIndex > ToIndex then   //뒤에 있는 놈이 앞으로 오는 경우
  begin
    for i := FromIndex downto ToIndex + 1 do
    begin
      L_arrRelAccessEventIndexArray[i] := L_arrRelAccessEventIndexArray[i - 1];
    end;
    L_arrRelAccessEventIndexArray[ToIndex] := nChangData;
  end else   //앞에 있는 놈이 뒤로 가는 경우
  begin
    for i := FromIndex to ToIndex - 1 do
    begin
      L_arrRelAccessEventIndexArray[i] := L_arrRelAccessEventIndexArray[i + 1];
    end;
    L_arrRelAccessEventIndexArray[ToIndex] := nChangData;
  end;

  for i := LOW(L_arrRelAccessEventIndexArray) to HIGH(L_arrRelAccessEventIndexArray) do
  begin
    L_arrAccessEventIndexArray[L_arrRelAccessEventIndexArray[i]] := i;
  end;

end;


procedure TfmMonitoring.ClosePanelTimerTimer(Sender: TObject);
begin
  inherited;
  ClosePanelTimer.Enabled := False;
  pan_Prograss.Visible := False;
end;

procedure TfmMonitoring.cmb_DoorControlTimeChange(Sender: TObject);
begin
  inherited;
  cmb_DoorControlTime.Color := clWhite;

end;

procedure TfmMonitoring.cmb_DoorLockTypeChange(Sender: TObject);
begin
  inherited;
  cmb_DoorLockType.Color := clWhite;
end;

procedure TfmMonitoring.DeviceReload;
begin
  LoadTreeDeviceList(tv_DeviceList,tv_DeviceCode);
  LoadBuildingDoor;
end;

procedure TfmMonitoring.doorListViewClick(Sender: TObject);
var
  stNodeNo : string;
  nIndex : integer;
begin
  inherited;
  popupMenu := nil;
  if doorListView.ItemIndex < 0 then Exit;
  if doorListView.ItemIndex > (doorListView.Items.Count ) then Exit;
  popupMenu := popupMenu1;
  mn_DoorOpen.Enabled := True;
  pm_DoorManageMode.Enabled := True;
  pm_DooOpenMode.Enabled := True;
  pm_DoorCloseMode.Enabled := True;
  N1.Visible := G_bCardModeShow;

  stNodeNo:= doorListView.Selected.SubItems.Strings[0];

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;
  if (TNode(NodeList.Objects[nIndex]).DeviceType = '02') or (TNode(NodeList.Objects[nIndex]).DeviceType = '03') then
  begin
    mn_msr7000Line.Enabled := True;
    mn_msr7000PW.Enabled := True;
  end else
  begin
    mn_msr7000Line.Enabled := True;
    mn_msr7000PW.Enabled := True;
  end;
end;

procedure TfmMonitoring.doorListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  stLockType : string;
  bJavaraType : Boolean;
begin
  if Selected then
  begin
      stLockType := TListView(Sender).Selected.SubItems.Strings[1];
      popupMenu := PopupMenu1;
      if stLockType = '10' then
      begin
        bJavaraType := True;
      end else
      begin
        bJavaraType := False;
      end;
      mn_DoorOpen.Visible := Not bJavaraType;
      N9.Visible := Not bJavaraType;
      pm_DoorManageMode.Visible := Not bJavaraType;
      pm_DooOpenMode.Visible := Not bJavaraType;
      pm_DoorCloseMode.Visible := Not bJavaraType;
  end else popupMenu := nil;
end;

procedure TfmMonitoring.DoorLockSetting(aNodeSeq: integer; aLockPortType,
  aLockMode: string; aLockControlTime: integer);
begin
  if lb_NodeNo.Caption <> FillZeroNumber(aNodeSeq,G_nNodeCodeLength) then Exit;
  cmb_DoorLockType.Color := clYellow;
  cmb_DoorControlTime.Color := clYellow;

  if aLockPortType = '01' then cmb_DoorLockType.ItemIndex := 0
  else cmb_DoorLockType.ItemIndex := 1;
  cmb_DoorControlTime.ItemIndex := aLockControlTime - 1;

end;

procedure TfmMonitoring.DoorState(aNodeSeq: integer; aDoorLockMode: string);
var
  nIndex : Integer;
  nImageIndex : integer;
  nNodeIndex : integer;
  bFire : Boolean;
begin
  nIndex := GetDoorListViewIndex(aNodeSeq);
  nImageIndex := GetDoorLockModeImageIndex(aDoorLockMode);

  nNodeIndex := NodeList.IndexOf(FillZeroNumber(aNodeSeq,G_nNodeCodeLength));
  if nNodeIndex > -1 then
  begin
    bFire := TNode(NodeList.Objects[nNodeIndex]).DoorFire;
  end;
  if Not bFire then
  begin
    DoorListView.Items[nIndex].ImageIndex := nImageIndex;
  end else
  begin
    DoorListView.Items[nIndex].ImageIndex := con_DoorImageFire;
  end;
end;

procedure TfmMonitoring.FormActivate(Sender: TObject);
begin
  inherited;
  ActiveTimer.Enabled := True;
end;

procedure TfmMonitoring.FormChangeEvent(aFormName: integer);
var
  stOldData : string;
  nIndex : integer;
begin
  case aFormName of
    con_FormDoorAdmin : begin
      DeviceReload;
    end;
  end;
end;

procedure TfmMonitoring.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini_fun : TiniFile;
  i : integer;
begin
  WriteIniConfig;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\Monitoring.INI');
    with ini_fun do
    begin
      WriteInteger('Form','DoorDeviceWidth',Pan_Device.Width);
      WriteInteger('Form','DoorStateHeight',ap_DoorState.Height);
    end;
  Finally
    ini_fun.Free;
  End;
  fmMain.FORMENABLE(con_FormMONITOR,'FALSE');

  Action := caFree;
end;

procedure TfmMonitoring.FormCreate(Sender: TObject);
begin
  inherited;
  AccessEventHeaderNameList := TStringList.Create;

  tv_DeviceCode.Left := -200;  //Visible =  False 로 하면 코드를 찾지 못한다.

  LoadTreeDeviceList(tv_DeviceList,tv_DeviceCode);

  PageControl1.ActivePageIndex := 0;
  sg_AccessEvent.RowCount := 2;
  mn_DoorInfoSetting.Enabled := G_bIsMaster;
end;

procedure TfmMonitoring.FormGradeRefresh;
begin

end;

procedure TfmMonitoring.FormIDSetting(aID: string);
begin
  L_stMenuID := aID;
end;


procedure TfmMonitoring.FormResize(Sender: TObject);
begin
  btn_Close.Left := AdvOfficePager1.Width - btn_Close.Width - 10;
  btn_minimize.Left := btn_Close.Left - btn_minimize.Width - 2;

  pan_Prograss.Left := (Width div 2) - (pan_Prograss.Width div 2);
  pan_Prograss.Top := (Height div 2) - (pan_Prograss.Height div 2);

  pan_Password.Left := (Width div 2) - (pan_Password.Width div 2);
  pan_Password.Top := (Height div 2) - (pan_Password.Height div 2);


  if Windowstate = wsMaximized then
  begin
    btn_minimize.Visible := True;
    btn_Close.Visible := True;
  end else
  begin
    btn_minimize.Visible := False;
    btn_Close.Visible := False;
  end;

  ReSizeTimer.Enabled := False;
  ReSizeTimer.Enabled := True;

  pan_DoorStateResize(pan_DoorState);
end;

procedure TfmMonitoring.FormShow(Sender: TObject);
var
  ini_fun : TiniFile;
  i : integer;
begin
  inherited;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\MonitoringDoorState.INI');
    with ini_fun do
    begin
      L_nViewListStyle := 0;
      if ReadString('MONITOR','ViewStyle','VSICON') = 'VSLIST' then
      begin
        DoorListView.ViewStyle := vsList;
        L_nViewListStyle := 1;
      end else
      begin
        DoorListView.ViewStyle := vsIcon;
        L_nViewListStyle := 0;
      end;
    end;
  Finally
    ini_fun.Free;
  End;

  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\Monitoring.INI');
    with ini_fun do
    begin
      Pan_Device.Width := ReadInteger('Form','DoorDeviceWidth',256);
      ap_DoorState.Height := ReadInteger('Form','DoorStateHeight',400);
    end;
  Finally
    ini_fun.Free;
  End;

  ListHeaderNameGet;  //먼저 가져 온 후...

  SetLength(L_arrAccessEventIndexArray,AccessEventHeaderNameList.Count);
  SetLength(L_arrRelAccessEventIndexArray,AccessEventHeaderNameList.Count);
  SetLength(L_arrAccessEventShowTable,AccessEventHeaderNameList.Count);
  SetLength(L_arrAccessEventSizeTable,AccessEventHeaderNameList.Count);

  ListConfigRead;
  ListHeaderNameSetting;
  ListCellSize;

  N14.Visible := True;
  N1.Visible := True;

  fmMain.FORMENABLE(con_FormMONITOR,'TRUE');

end;

function TfmMonitoring.GetAccessResultName(aAccessResult: string): string;
var
  nIndex : integer;
begin
  result := '';
  nIndex := AccessResultCodeNameList.IndexOf(aAccessResult);
  if nIndex < 0 then Exit;
  result := TAccessResultCode(AccessResultCodeNameList.Objects[nIndex]).AccessResultName;
end;

function TfmMonitoring.GetBuildingAreaName(aBuildingCode,
  aBuindigAreaCode: string): string;
var
  nIndex : integer;
begin
  result := '';
  nIndex := BuildingCodeNameList.IndexOf(aBuildingCode);
  if nIndex < 0 then Exit;
  result := TBuildingCode(BuildingCodeNameList.Objects[nIndex]).GetBuildingAreaName(aBuindigAreaCode);
end;

function TfmMonitoring.GetBuildingName(aBuildingCode: string): string;
var
  nIndex : integer;
begin
  result := '';
  nIndex := BuildingCodeNameList.IndexOf(aBuildingCode);
  if nIndex < 0 then Exit;
  result := TBuildingCode(BuildingCodeNameList.Objects[nIndex]).BuildingName;
end;

function TfmMonitoring.GetCardName(aCardNo: string): string;
var
  nIndex : integer;
begin
  result := '';
  nIndex := CardNameList.IndexOf(aCardNo);
  if nIndex < 0 then Exit;
  result := TCard(CardNameList.Objects[nIndex]).CardName;
end;

function TfmMonitoring.GetDoorListViewIndex(aNodeSeq: integer): integer;
var
  i :integer;
  stNodeNo : string;
begin
  result := -1;
  stNodeNo := FillZeroNumber(aNodeSeq,G_nNodeCodeLength);
  if DoorListView.Items.Count < 1 then Exit;
  for i := 0 to DoorListView.Items.Count - 1 do
  begin
    if doorListView.Items[i].SubItems.Strings[0] = stNodeNo then
    begin
      result := i;
      break;
    end;
  end;
end;

function TfmMonitoring.GetDoorLockModeImageIndex(
  aDoorLockMode: string): integer;
begin
  result := 0;

  //00.사용안함,21.강제열기,22.포트정상,23.강제닫기
  if aDoorLockMode = '00' then result := 0
  else if aDoorLockMode = '21' then result := 1
  else if aDoorLockMode = '22' then result := 2
  else if aDoorLockMode = '23' then result := 3;

end;

function TfmMonitoring.GetLockModeName(aLockMode: string): string;
var
  nIndex : integer;
begin
  result := '';
  nIndex := LockModeNameList.IndexOf(aLockMode);
  if nIndex < 0 then Exit;
  result := TLockMode(LockModeNameList.Objects[nIndex]).LockModeName;
end;

procedure TfmMonitoring.lb_DeviceStateExampleMouseEnter(Sender: TObject);
begin
  inherited;
  gb_DeviceState.Visible := True;
end;

procedure TfmMonitoring.lb_DeviceStateExampleMouseLeave(Sender: TObject);
begin
  inherited;
  gb_DeviceState.Visible := False;
end;

procedure TfmMonitoring.lb_DoorstateExampleMouseEnter(Sender: TObject);
begin
  inherited;
  gb_DoorState.Visible := True;
end;

procedure TfmMonitoring.lb_DoorstateExampleMouseLeave(Sender: TObject);
begin
  inherited;
  gb_DoorState.Visible := False;

end;

function TfmMonitoring.ListCellSize: Boolean;
var
  i : integer;
begin
  for i := 0 to sg_AccessEvent.ColCount - 1 do
  begin
    if L_arrAccessEventShowTable[i] = 0 then
    begin
      sg_AccessEvent.ColWidths[L_arrAccessEventIndexArray[i]] := 0;
    end else
    begin
      if L_arrAccessEventSizeTable[L_arrAccessEventIndexArray[i]] <> 0 then sg_AccessEvent.ColWidths[L_arrAccessEventIndexArray[i]] := L_arrAccessEventSizeTable[L_arrAccessEventIndexArray[i]]
      else sg_AccessEvent.ColWidths[L_arrAccessEventIndexArray[i]] := 90;
    end;
  end;
end;

function TfmMonitoring.ListConfigRead: Boolean;
var
  ini_fun : TiniFile;
  nShowCount : integer;
  nSize : integer;
  i : integer;
begin
  L_nAccessEventShowCount := 0;
  ini_fun := TiniFile.Create(G_stExeFolder + '\Monitoring.INI');
  Try
    with ini_fun do
    begin
      for i := LOW(L_arrAccessEventIndexArray) to HIGH(L_arrAccessEventIndexArray) do
      begin
        L_arrAccessEventIndexArray[i] := ReadInteger('LIST','AccessEventIndexArray'+inttostr(i),i);
      end;
      for i := LOW(L_arrRelAccessEventIndexArray) to HIGH(L_arrRelAccessEventIndexArray) do
      begin
        L_arrRelAccessEventIndexArray[i] := ReadInteger('LIST','RelAccessEventIndexArray'+inttostr(i),i);
      end;
      for i := LOW(L_arrAccessEventShowTable) to HIGH(L_arrAccessEventShowTable) do
      begin
        L_arrAccessEventShowTable[i] := ReadInteger('LIST','RelAccessEventShowArray'+inttostr(i),1);
        L_nAccessEventShowCount := L_nAccessEventShowCount + L_arrAccessEventShowTable[i];
      end;
      nSize := 90;
      for i := LOW(L_arrAccessEventSizeTable) to HIGH(L_arrAccessEventSizeTable) do
      begin
        L_arrAccessEventSizeTable[i] := ReadInteger('LIST','RelAccessEventSizeArray'+inttostr(i),nSize);
      end;
    end;
  Finally
    ini_fun.Free;
  End;

end;

function TfmMonitoring.ListFieldNameSetting: Boolean;
begin

end;

function TfmMonitoring.ListHeaderNameGet: Boolean;
begin

  if AccessEventHeaderNameList = nil then AccessEventHeaderNameList := TStringList.Create;

  AccessEventHeaderNameList.Clear;
  AccessEventHeaderNameList.Add('출입시간');
  AccessEventHeaderNameList.Add('위치(동)');
  AccessEventHeaderNameList.Add('위치(출구)');
  AccessEventHeaderNameList.Add('출입문');
  AccessEventHeaderNameList.Add('카드번호');
  AccessEventHeaderNameList.Add('사용자명');
  AccessEventHeaderNameList.Add('승인상태');
  AccessEventHeaderNameList.Add('출입문모드');

  result := True;
end;

function TfmMonitoring.ListHeaderNameSetting: Boolean;
var
  i : integer;
begin
  sg_AccessEvent.ColCount := AccessEventHeaderNameList.Count;
  for i := LOW(L_arrAccessEventIndexArray) to HIGH(L_arrAccessEventIndexArray) do
  begin
    if (sg_AccessEvent.ColCount - 1) < i then Exit;
    if (AccessEventHeaderNameList.Count - 1) < i then Exit;

    sg_AccessEvent.cells[L_arrAccessEventIndexArray[i],0] := AccessEventHeaderNameList[i];
  end;
end;

function TfmMonitoring.LoadBuildingDoor:Boolean;
var
  nIndex : integer;
  i : integer;
  stNodeNo : string;
  stEcuID : string;
  stDoorNo : string;
  stDoorName : string;
  nDoorIndex : integer;
  stDoorManageMode : string;
  stDoorDSState : string;
  stDoorLSState : string;
  stDoorFireEvent : string;
  stDoorLongTimeEvent : string;
  nImageIndex : integer;
begin
  result := False;
  Try
    doorListView.Clear;
    if NodeList.Count < 1 then Exit;

    nDoorIndex := 0;
    for i := 0 to NodeList.Count - 1 do
    begin
      stNodeNo := FillZeroNumber(TNode(NodeList.Objects[i]).NodeSeq,G_nNodeCodeLength);
      stDoorManageMode := TNode(NodeList.Objects[i]).LockMode;
      DoorListView.Items.Add.Caption:= TNode(NodeList.Objects[i]).DeviceName;
      DoorListView.Items[nDoorIndex].SubItems.Add(stNodeNo);
      DoorListView.Items[nDoorIndex].SubItems.Add(stDoorManageMode);               //락타입 확인해서 자바라이면 자바라 열림/닫힘으로 설정 하도록
      nImageIndex := GetDoorLockModeImageIndex(stDoorManageMode);
      DoorListView.Items[nDoorIndex].ImageIndex := nImageIndex;
      nDoorIndex := nDoorIndex + 1;
    end;
    result := True;
  Except
    Exit;
  End;

end;

procedure TfmMonitoring.LoadTreeDeviceList(aTreeList,vTreeList:TTreeView);
var
  aTreeView : TTreeview;
  vTreeView : TTreeview;
  aNode,bNode,cNode,dNode : TTreeNode;
  vNode1,vNode2,vNode3 : TTreeNode;
  i : integer;
  j : integer;
  stNodeNo : string;
  stEcuID,stEcuName : string;
begin
  aTreeView := aTreeList;
  aTreeView.ReadOnly:= True;
  aTreeView.Items.Clear;
  vTreeView := vTreeList;
  vTreeView.ReadOnly := True;
  vTreeView.Items.Clear;
  if NodeList.Count < 1 then Exit;

  for i := 0 to NodeList.Count - 1 do
  begin
    aNode := aTreeView.Items.Add(nil,TNode(NodeList.Objects[i]).NodeIP + ':' + TNode(NodeList.Objects[i]).DeviceName);
    case TNode(NodeList.Objects[i]).NodeConnected of
      csConnected : begin
        aNode.ImageIndex := con_LocalNodeAllConnectedImageIndex;
        aNode.SelectedIndex := con_LocalNodeAllConnectedImageIndex;
      end;
      else begin
        aNode.ImageIndex := con_LocalNodeDisConnectedImageIndex;
        aNode.SelectedIndex := con_LocalNodeDisConnectedImageIndex;
      end;
    end;
    stNodeNo := FillZeroNumber(TNode(NodeList.Objects[i]).NodeSeq,G_nNodeCodeLength);
    vNode1 := vTreeView.Items.AddChild(nil,stNodeNo);
  end;
  aTreeList.Refresh;
end;

procedure TfmMonitoring.mn_CardNOCopyClick(Sender: TObject);
var
  stTemp : string;
  stMessage : string;
begin
  inherited;
    with sg_AccessEvent do
    begin
      stTemp:= Cells[L_arrAccessEventIndexArray[4],Row];

      if stTemp <> '' then ClipBoard.SetTextBuf(PChar(stTemp));
      stMessage := '$DATA 를 클립보드에 복사하였습니다.';
      stMessage := stringReplace(stMessage,'$DATA',stTemp,[rfReplaceAll]);
      fmMain.FORMSTATUSMSG(2,stMessage);
      //showmessage(stTemp + ' 가 ClipBoard에 복사 되었습니다.');
    end;
end;

procedure TfmMonitoring.mn_DoorInfoSettingClick(Sender: TObject);
var
  stNodeNo : string;
  nIndex : integer;
begin
  if doorListView.Selected = nil then Exit;

  lb_DoorName.Caption := doorListView.Selected.Caption;
  stNodeNo:= doorListView.Selected.SubItems.Strings[0];

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;

  if TNode(NodeList.Objects[nIndex]).NodeConnected <> csConnected then
  begin
    showmessage('기기와 통신연결이 안되었습니다.연결된 후 출입문 설정이 가능합니다.');
    Exit;
  end;

  lb_NodeNo.Caption := stNodeNo;

  lb_SettingDoorName.Caption := TNode(NodeList.Objects[nIndex]).DeviceName;
  if TNode(NodeList.Objects[nIndex]).LockPortType = '01' then cmb_DoorLockType.ItemIndex := 0
  else cmb_DoorLockType.ItemIndex := 1;
  cmb_DoorControlTime.ItemIndex := TNode(NodeList.Objects[nIndex]).LockControlTime - 1;

  if (TNode(NodeList.Objects[nIndex]).DeviceType = '02') or (TNode(NodeList.Objects[nIndex]).DeviceType = '03') then
  begin
    cmb_DoorLockType.Enabled := False;
  end else
  begin
    cmb_DoorLockType.Enabled := True;
  end;

  cmb_DoorControlTime.Color := clWhite;
  cmb_DoorControlTime.Color := clWhite;

  pan_DoorSetting.Visible := True;

end;

procedure TfmMonitoring.mn_DoorOpenClick(Sender: TObject);
var
  stNodeNo : string;
  i : integer;
  nIndex : integer;
  nDelay : integer;
begin
  Try
    if doorListView.SelCount < 1 then Exit;
    Try
      doorListView.Enabled := False;
      for i := 0 to doorListView.Items.Count - 1 do
      begin
        if doorListView.Items[i].Selected then
        begin
          stNodeNo:= doorListView.Items[i].SubItems.Strings[0];
          nIndex := NodeList.IndexOf(stNodeNo);
          if nIndex > - 1 then
          begin
            TNode(NodeList.Objects[nIndex]).OldLockMode := TNode(NodeList.Objects[nIndex]).LockMode;
            TNode(NodeList.Objects[nIndex]).LockPortSetting(TNode(NodeList.Objects[nIndex]).LockPortType,'21',Dec2Hex(TNode(NodeList.Objects[nIndex]).LockControlTime,2));
            Delay(300);
            TNode(NodeList.Objects[nIndex]).LockPortSearch;
          end;
        end;
      end;
      Delay(3000);
      for i := 0 to doorListView.Items.Count - 1 do
      begin
        if doorListView.Items[i].Selected then
        begin
          stNodeNo:= doorListView.Items[i].SubItems.Strings[0];
          nIndex := NodeList.IndexOf(stNodeNo);
          if nIndex > - 1 then
          begin
            TNode(NodeList.Objects[nIndex]).LockPortSetting(TNode(NodeList.Objects[nIndex]).LockPortType,TNode(NodeList.Objects[nIndex]).OldLockMode,Dec2Hex(TNode(NodeList.Objects[nIndex]).LockControlTime,2));
            Delay(300);
            TNode(NodeList.Objects[nIndex]).LockPortSearch;
          end;
        end;
      end;
    Finally
      doorListView.Enabled := True;
    End;

  Except
    Exit;
  End;

end;

procedure TfmMonitoring.mn_LargeIconClick(Sender: TObject);
var
  ini_fun : TiniFile;
begin
  L_nViewListStyle := 0;
  doorListView.ViewStyle := vsIcon;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\MonitoringDoorState.INI');
    with ini_fun do
    begin
      if L_nViewListStyle = 0 then
        WriteString('MONITOR','ViewStyle' ,'VSICON')
      else WriteString('MONITOR','ViewStyle','VSLIST');
    end;
  Finally
    ini_fun.Free;
  End;

end;

procedure TfmMonitoring.mn_PWClick(Sender: TObject);
begin
  inherited;
  pan_Password.Visible := True;
  ed_Passwd.Text := '';
  lb_PasswordMessage.Caption.Text := '';
  if TMenuITem(Sender).Hint = '0' then
  begin
    lb_PWName.Caption.Text := '비밀번호등록';
    btn_PasswordApply.Caption := '등록';
    lb_Password.Visible := True;
    ed_Passwd.Visible := True;
    ed_Passwd.Enabled := True;
    ed_Passwd.SetFocus;
    ed_Passwd.Color := clWhite;
    L_stPasswordWork := '0';
  end else if TMenuITem(Sender).Hint = '1' then
  begin
    lb_PWName.Caption.Text := '비밀번호삭제';
    btn_PasswordApply.Caption := '삭제';
    lb_Password.Visible := False;
    ed_Passwd.Visible := False;
    L_stPasswordWork := '1';
  end else if TMenuITem(Sender).Hint = '2' then
  begin
    lb_PWName.Caption.Text := '비밀번호조회';
    btn_PasswordApply.Caption := '조회';
    lb_Password.Visible := True;
    ed_Passwd.Visible := True;
    ed_Passwd.Enabled := False;
    ed_Passwd.Color := clWhite;
    L_stPasswordWork := '2';
  end;

end;

procedure TfmMonitoring.mn_SmallIconClick(Sender: TObject);
var
  ini_fun : TiniFile;
begin
  L_nViewListStyle := 1;
  doorListView.ViewStyle := vsList;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\MonitoringDoorState.INI');
    with ini_fun do
    begin
      if L_nViewListStyle = 0 then
        WriteString('MONITOR','ViewStyle' ,'VSICON')
      else WriteString('MONITOR','ViewStyle','VSLIST');
    end;
  Finally
    ini_fun.Free;
  End;

end;

procedure TfmMonitoring.NodeConnected(aNodeSeq, aValue: integer);
var
  stNodeNo : string;
  aTreeView   : TTreeview;
  vTreeView   : TTreeview;
  aNode       : TTreeNode;
  nItemIndex : integer;
begin
  stNodeNo := FillZeroNumber(aNodeSeq,G_nNodeCodeLength);
  aTreeView := tv_DeviceList;
  if aTreeView.Items.Count < 1 then Exit;
  vTreeView := tv_DeviceCode;
  aNode:= GetNodeByText(vTreeView,stNodeNo,False);
  if aNode = nil then Exit;
  nItemIndex := aNode.AbsoluteIndex;

  case aValue of
    1 : begin
      aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalNodeAllConnectedImageIndex;
      aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalNodeAllConnectedImageIndex;
    end;
    else begin
      aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalNodeDisConnectedImageIndex;
      aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalNodeDisConnectedImageIndex;
    end;
  end;

end;

procedure TfmMonitoring.pan_DeviceResize(Sender: TObject);
begin
  tv_DeviceList.Left := 10;
  //tv_DeviceList.Top := (gb_DeviceState.Top + gb_DeviceState.Height + 10);
  tv_DeviceList.Width := pan_Device.Width - (tv_DeviceList.Left * 2);
  tv_DeviceList.Height := pan_Device.Height - tv_DeviceList.Top - 10;

  gb_DeviceState.Width := pan_Device.Width - (gb_DeviceState.Left * 2);

  lb_DeviceStateExample.Left := tv_DeviceList.Left + tv_DeviceList.Width - lb_DeviceStateExample.Width;
  gb_DeviceState.Top := tv_DeviceList.Top;
  gb_DeviceState.Left := tv_DeviceList.Left;
//
end;

procedure TfmMonitoring.pan_DoorStateResize(Sender: TObject);
begin
  inherited;
  doorListView.Left := 10;
  doorListView.Height := pan_DoorState.Height - doorListView.Top - 10;
  doorListView.Width := pan_DoorState.Width - (doorListView.Left * 2);
  doorListView.Top := 64;

  gb_DoorState.Left := doorListView.Left;
  gb_DoorState.Top := doorListView.Top;
  gb_DoorState.Width := doorListView.Width;

  lb_DoorstateExample.Left := doorListView.Left + doorListView.Width - lb_DoorstateExample.Width;

  pan_DoorInfo.Top := (pan_DoorState.Height div 2) - (pan_DoorInfo.Height div 2);
  pan_DoorInfo.Left := (pan_DoorState.Width div 2) - (pan_DoorInfo.Width div 2);
  pan_DoorSetting.Top := (pan_DoorState.Height div 2) - (pan_DoorSetting.Height div 2);
  pan_DoorSetting.Left := (pan_DoorState.Width div 2) - (pan_DoorSetting.Width div 2);


  LoadBuildingDoor;
end;

procedure TfmMonitoring.PasswordEvent(aNodeSeq: integer; aCmd,
  aPassword: string);
begin
  if L_stPasswordNode <> FillZeroNumber(aNodeSeq,G_nNodeCodeLength) then Exit;
  ed_Passwd.Text := aPassword;
  ed_Passwd.Color := clYellow;
  lb_PasswordMessage.Caption.Text := stringReplace('비밀번호 $WORK 작업을 성공하였습니다.','$WORK',btn_PasswordApply.Caption,[rfReplaceAll]);
end;

procedure TfmMonitoring.pm_DeviceCardInitClick(Sender: TObject);
var
  stNodeNo : string;
  stClientIP : string;
  stTime : string;
  nIndex : integer;
begin
  if AdvOfficePager1.ActivePage = ap_Access then
  begin
    stNodeNo := tv_DeviceCode.Items.Item[tv_DeviceList.Selected.AbsoluteIndex].Text;
  end else Exit;

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;
  if TNode(NodeList.Objects[nIndex]).NodeConnected <> csConnected then
  begin
    showmessage('현재 통신이 연결되어 있지 않습니다.');
    Exit;
  end;

  if (Application.MessageBox(PChar('기기에 있는 권한이 모두 삭제 됩니다. 정말 삭제하시겠습니까?'),'Information',MB_OKCANCEL) = IDCANCEL)  then Exit;

  TNode(NodeList.Objects[nIndex]).DeviceCardInit;

end;

procedure TfmMonitoring.pm_DeviceCardLoadClick(Sender: TObject);
var
  stNodeNo : string;
  stClientIP : string;
  stTime : string;
  nIndex : integer;
begin
  if AdvOfficePager1.ActivePage = ap_Access then
  begin
    stNodeNo := tv_DeviceCode.Items.Item[tv_DeviceList.Selected.AbsoluteIndex].Text;
  end else Exit;

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;
  if TNode(NodeList.Objects[nIndex]).NodeConnected <> csConnected then
  begin
    showmessage('현재 통신이 연결되어 있지 않습니다.');
    Exit;
  end;
  TNode(NodeList.Objects[nIndex]).DeviceCardSearch;
  pan_Prograss.Visible := True;
  AdvProgress1.Position := 0;
end;

procedure TfmMonitoring.pm_DeviceResetClick(Sender: TObject);
var
  stNodeNo : string;
  stClientIP : string;
  stTime : string;
  nIndex : integer;
begin
  if AdvOfficePager1.ActivePage = ap_Access then
  begin
    stNodeNo := tv_DeviceCode.Items.Item[tv_DeviceList.Selected.AbsoluteIndex].Text;
  end else Exit;

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;
  if TNode(NodeList.Objects[nIndex]).NodeConnected <> csConnected then
  begin
    showmessage('현재 통신이 연결되어 있지 않습니다.');
    Exit;
  end;
  TNode(NodeList.Objects[nIndex]).DeviceReset;
end;

procedure TfmMonitoring.pm_DooOpenModeClick(Sender: TObject);
var
  stNodeNo : string;
  i : integer;
  nIndex : integer;
begin
  Try
    if doorListView.SelCount < 1 then Exit;
    for i := 0 to doorListView.Items.Count - 1 do
    begin
      if doorListView.Items[i].Selected then
      begin
        stNodeNo:= doorListView.Items[i].SubItems.Strings[0];
        nIndex := NodeList.IndexOf(stNodeNo);
        if nIndex > - 1 then
        begin
          TNode(NodeList.Objects[nIndex]).LockPortSetting(TNode(NodeList.Objects[nIndex]).LockPortType,'21',Dec2Hex(TNode(NodeList.Objects[nIndex]).LockControlTime,2));
          Delay(300);
          TNode(NodeList.Objects[nIndex]).LockPortSearch;
        end;
      end;
    end;
  Except
    Exit;
  End;
end;

procedure TfmMonitoring.pm_DoorCloseModeClick(Sender: TObject);
var
  stNodeNo : string;
  i : integer;
  nIndex : integer;
begin
  Try
    if doorListView.SelCount < 1 then Exit;
    for i := 0 to doorListView.Items.Count - 1 do
    begin
      if doorListView.Items[i].Selected then
      begin
        stNodeNo:= doorListView.Items[i].SubItems.Strings[0];
        nIndex := NodeList.IndexOf(stNodeNo);
        if nIndex > - 1 then
        begin
          TNode(NodeList.Objects[nIndex]).LockPortSetting(TNode(NodeList.Objects[nIndex]).LockPortType,'23',Dec2Hex(TNode(NodeList.Objects[nIndex]).LockControlTime,2));
          Delay(300);
          TNode(NodeList.Objects[nIndex]).LockPortSearch;
        end;
      end;
    end;
  Except
    Exit;
  End;
end;

procedure TfmMonitoring.pm_DoorInfoClick(Sender: TObject);
var
  stNodeNo : string;
  nIndex : integer;
begin
  if doorListView.Selected = nil then Exit;

  lb_DoorName.Caption := doorListView.Selected.Caption;
  stNodeNo:= doorListView.Selected.SubItems.Strings[0];

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;


  lb_NodeIP.Caption := TNode(NodeList.Objects[nIndex]).NodeIP;
  pan_DoorInfo.Visible := True;
end;

procedure TfmMonitoring.pm_DoorManageModeClick(Sender: TObject);
var
  stNodeNo : string;
  i : integer;
  nIndex : integer;
begin
  Try
    if doorListView.SelCount < 1 then Exit;
    for i := 0 to doorListView.Items.Count - 1 do
    begin
      if doorListView.Items[i].Selected then
      begin
        stNodeNo:= doorListView.Items[i].SubItems.Strings[0];
        nIndex := NodeList.IndexOf(stNodeNo);
        if nIndex > - 1 then
        begin
          TNode(NodeList.Objects[nIndex]).LockPortSetting(TNode(NodeList.Objects[nIndex]).LockPortType,'22',Dec2Hex(TNode(NodeList.Objects[nIndex]).LockControlTime,2));
          Delay(300);
          TNode(NodeList.Objects[nIndex]).LockPortSearch;
        end;
      end;
    end;
  Except
    Exit;
  End;
end;

procedure TfmMonitoring.pm_PermitReSendClick(Sender: TObject);
var
  stNodeNo : string;
  stClientIP : string;
  stTime : string;
  nIndex : integer;
begin
  if AdvOfficePager1.ActivePage = ap_Access then
  begin
    stNodeNo := tv_DeviceCode.Items.Item[tv_DeviceList.Selected.AbsoluteIndex].Text;
  end else Exit;

  CardPermitResend(stNodeNo);
end;

procedure TfmMonitoring.pm_PingTestClick(Sender: TObject);
var
  stNodeIp : string;
  stMessage : string;
  stExe:string;
begin
  if AdvOfficePager1.ActivePage = ap_Access then
  begin
    stNodeIp := tv_DeviceList.Selected.Text;
  end else Exit;

  stNodeIp := FindCharCopy(stNodeIp,0,':');
  if Not IsIPTypeCheck(stNodeIp) then
  begin
    stMessage := 'IP Type 이 잘못 되었습니다.';
    showmessage(stNodeIp + ':' + stMessage);
    Exit;
  end;
  ShellExecute(0, 'open', PChar('ping.exe'), PChar(stNodeIp), nil, SW_SHOWNORMAL );
end;

procedure TfmMonitoring.pm_TimeSyncClick(Sender: TObject);
var
  stNodeNo : string;
  stClientIP : string;
  stTime : string;
  nIndex : integer;
begin
  if AdvOfficePager1.ActivePage = ap_Access then
  begin
    stNodeNo := tv_DeviceCode.Items.Item[tv_DeviceList.Selected.AbsoluteIndex].Text;
  end else Exit;

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;
  if TNode(NodeList.Objects[nIndex]).NodeConnected <> csConnected then
  begin
    showmessage('현재 통신이 연결되어 있지 않습니다.');
    Exit;
  end;
  TNode(NodeList.Objects[nIndex]).TimeSync;
end;

procedure TfmMonitoring.RcvDeviceConnectedChangeEvent(aNodeNo, aEcuID,
  aData: string);
begin
  TreeViewDeviceConnectChange(tv_DeviceList,tv_DeviceCode,aNodeNo, aEcuID,aData);
end;

procedure TfmMonitoring.RcvNodeConnectedChangeEvent(aNodeNo, aEcuID,
  aData: string);
begin
  TreeViewNodeConnectChange(tv_DeviceList,tv_DeviceCode,aNodeNo, aEcuID,aData);

end;

procedure TfmMonitoring.ReSizeTimerTimer(Sender: TObject);
begin
  inherited;
  ReSizeTimer.Enabled := False;
  if L_bViewRefresh then Exit;
  L_bViewRefresh := True;
  Try
    if L_nViewListStyle = 0 then
    begin
      doorListView.ViewStyle := vsList;
      Delay(100);
      doorListView.ViewStyle := vsICon;
      //doorListView.Refresh;
    end else
    begin
      doorListView.ViewStyle := vsICon;
      Delay(100);
      doorListView.ViewStyle := vsList;
      //doorListView.Refresh;
    end;
  Finally
    L_bViewRefresh := False;
  End;
end;

procedure TfmMonitoring.sg_AccessEventColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
  inherited;
  ChangeAccessEventIndex(FromIndex, ToIndex);
end;

procedure TfmMonitoring.sg_AccessEventKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  stTemp: string;
  stMessage : string;
begin
  if key = 17 then Exit;
  if (Key = 67) and (Shift = [ssCtrl]) 	then
  begin
    with Sender as TAdvStringGrid do
    begin
      stTemp:= Cells[L_arrAccessEventIndexArray[4],Row];

      if stTemp <> '' then ClipBoard.SetTextBuf(PChar(stTemp));
      stMessage := '$DATA 를 클릭보드에 복사하였습니다.';
      stMessage := stringReplace(stMessage,'$DATA',stTemp,[rfReplaceAll]);
      fmMain.FORMSTATUSMSG(2,stMessage);
      //showmessage(stTemp + ' 가 ClipBoard에 복사 되었습니다.');
    end;
  end;
end;

procedure TfmMonitoring.TreeViewDeviceConnectChange(aTreeList,vTreeList: TTreeView; aNodeNo,
  aEcuID, aData: string);
var
  stNodeNo : string;
  aTreeView   : TTreeview;
  vTreeView   : TTreeview;
  aNode       : TTreeNode;
  nItemIndex : integer;
begin
  stNodeNo := FillZeroNumber(strtoint(aNodeNo),G_nNodeCodeLength);
  aTreeView := aTreeList;
  if aTreeView.Items.Count < 1 then Exit;
  vTreeView := vTreeList;
  aNode:= GetNodeByText(vTreeView,'E' + stNodeNo + aEcuID ,False);

  if aNode = nil then
  begin
    aNode:= GetNodeByText(vTreeView,'E' + stNodeNo + aEcuID ,False);
    exit;
  end;

  nItemIndex := aNode.AbsoluteIndex;
  if aData <> '' then
  begin
    case aData[1] of
      '0' : begin
        aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalDeviceDisConnectedImageIndex;
        aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalDeviceDisConnectedImageIndex;
      end;
      '1' : begin
        aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalDeviceConnectedImageIndex;
        aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalDeviceConnectedImageIndex;
      end;
      else begin
        aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalDeviceDisConnectedImageIndex;
        aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalDeviceDisConnectedImageIndex;
      end;
    end;
  end else
  begin
    aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalDeviceDisConnectedImageIndex;
    aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalDeviceDisConnectedImageIndex;
  end;
end;

procedure TfmMonitoring.TreeViewNodeConnectChange(aTreeList,
  vTreeList: TTreeView; aNodeNo, aEcuID, aData: string);
var
  stNodeNo : string;
  aTreeView   : TTreeview;
  vTreeView   : TTreeview;
  aNode       : TTreeNode;
  nItemIndex : integer;
begin
  stNodeNo := FillZeroNumber(strtoint(aNodeNo),G_nNodeCodeLength);
  aTreeView := aTreeList;
  if aTreeView.Items.Count < 1 then Exit;
  vTreeView := vTreeList;
  aNode:= GetNodeByText(vTreeView,'N' + stNodeNo ,False);

  if aNode = nil then
  begin
    aNode:= GetNodeByText(vTreeView,'N' + stNodeNo ,False);
    exit;
  end;

  nItemIndex := aNode.AbsoluteIndex;
  if aData <> '' then
  begin
    case aData[1] of
      '2' : begin
        aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalNodeAllConnectedImageIndex;
        aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalNodeAllConnectedImageIndex;
      end;
      '1' : begin
        aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalNodeConnectedImageIndex;
        aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalNodeConnectedImageIndex;
      end;
      '0' : begin
        aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalNodeDisConnectedImageIndex;
        aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalNodeDisConnectedImageIndex;
      end;
      else begin
        aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalNodeDisConnectedImageIndex;
        aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalNodeDisConnectedImageIndex;
      end;
    end;
  end else
  begin
    aTreeView.Items.Item[nItemIndex].ImageIndex := con_LocalNodeDisConnectedImageIndex;
    aTreeView.Items.Item[nItemIndex].SelectedIndex := con_LocalNodeDisConnectedImageIndex;
  end;
  aTreeView.Refresh;
end;

procedure TfmMonitoring.tv_DeviceListClick(Sender: TObject);
var
  stNodeNo : string;
  nIndex : integer;
begin
  inherited;
  stNodeNo := tv_DeviceCode.Items.Item[tv_DeviceList.Selected.AbsoluteIndex].Text;

  nIndex := NodeList.IndexOf(stNodeNo);
  if nIndex < 0 then Exit;
  if (TNode(NodeList.Objects[nIndex]).DeviceType = '02') or (TNode(NodeList.Objects[nIndex]).DeviceType = '03') then
  begin
    pm_TimeSync.Enabled := True;
    pm_DeviceCardLoad.Enabled := False;
  end else if TNode(NodeList.Objects[nIndex]).DeviceType = '01' then
  begin
    pm_TimeSync.Enabled := False;
    pm_DeviceCardLoad.Enabled := True;
  end else
  begin
    pm_TimeSync.Enabled := True;
    pm_DeviceCardLoad.Enabled := True;
  end;

end;

function TfmMonitoring.WriteIniConfig: Boolean;
var
  ini_fun : TiniFile;
  i : integer;
begin
  ini_fun := TiniFile.Create(G_stExeFolder + '\Monitoring.INI');
  Try
    with ini_fun do
    begin
      for i := LOW(L_arrAccessEventIndexArray) to HIGH(L_arrAccessEventIndexArray) do
      begin
        WriteInteger('LIST','AccessEventIndexArray'+inttostr(i),L_arrAccessEventIndexArray[i]);
      end;
      for i := LOW(L_arrRelAccessEventIndexArray) to HIGH(L_arrRelAccessEventIndexArray) do
      begin
        WriteInteger('LIST','RelAccessEventIndexArray'+inttostr(i),L_arrRelAccessEventIndexArray[i]);
      end;
      for i := 0 to sg_AccessEvent.ColCount - 1 do
      begin
        if i > HIGH(L_arrAccessEventSizeTable) then break;

        L_arrAccessEventSizeTable[i] := sg_AccessEvent.ColWidths[i];
        WriteInteger('LIST','RelAccessEventSizeArray' + inttostr(i),sg_AccessEvent.ColWidths[i]);
      end;
    end;

  Finally
    ini_fun.Free;
  End;
end;

initialization
  RegisterClass(TfmMonitoring);
Finalization
  UnRegisterClass(TfmMonitoring);

end.
