unit uNode;

interface

uses
  System.SysUtils, System.Classes,Winapi.Messages,Winapi.WinSock,Vcl.Forms,Vcl.ExtCtrls,
  u_c_byte_buffer,Winapi.Windows;

const wm_asynch_select= wm_User;
const k_buffer_max= 65536; //k_buffer_max= 4096;
      k_tcp_ip_chunk= 1500;

const
  cmd_DeviceReset = #$05;         //장비리셋
  cmd_DeviceIDSearch = #$06;      //아이디 조회
  cmd_TimeSync = #$11;            //시간동기화
  cmd_LockPortRegist = #$14;      //락포트설정
  cmd_LockPortSearch = #$15;      //락포트조회
  cmd_DeviceVerSearch = #$22;     //기기 버젼조회
  cmd_CardAdd = #$31;             //카드등록
  cmd_CardDelete = #$34;          //카드삭제
  cmd_DeviceCardInit= #$35;       //카드초기화
  cmd_CardCountSearch = #$37;     //카드등록건수조회
  cmd_CardSearch = #$38;          //등록 카드조회
  cmd_AccessEventSearch = #$40;   //출입이력 조회
  cmd_Fire=#$49;                  //화재전송 및 화재복구
  cmd_FireEvent=#$80;             //화재발생
  cmd_Password=#$90;              //비밀번호


type
  TConnectedState = (csNothing,csDisConnected,csConnected);

  TAccessEvent = procedure(Sender: TObject;  aNodeSeq : integer;aDeviceName,aBuildingCode,aBuildingAreaCode,aAccessTime,aAccessResult,aLockMode,aCardNo,aCardType:string) of object;
  TCardUploadEvent = procedure(Sender: TObject;  aNodeSeq : integer;aBuildingCode,aBuildingAreaCode,aCardNo,aCardType,aAddr:string) of object;
  TCardUploadProcess = procedure(Sender: TObject;  aNodeSeq : integer;aBuildingCode,aBuildingAreaCode:string;aTotCount,aCurCount:integer) of object;
  TCardRegEvent = procedure(Sender: TObject; aNodeSeq:integer;aCardNo,aPermit:string) of object;
  TDeviceState = procedure(Sender: TObject; aNodeSeq:integer;aValue:string) of object;
  TDoorLockSetting = procedure(Sender: TObject; aNodeSeq:integer;aLockPortType,aLockMode:string;aLockControlTime:integer) of object;
  TNodeConnected = procedure(Sender: TObject;  aNodeSeq : integer;aConnected:TConnectedState) of object;
  TNodePacketEvent = procedure(Sender: TObject;  aNodeSeq : integer;aTxRx,aDeviceName,aCmd,aPacketData:string) of object;
  TPassWordEvent = procedure(Sender: TObject; aNodeSeq:integer;aCmd,aPassword:string) of object;

  TCardPermit = Class(TComponent)
  private
    FPermit: string;
    FCardNo: string;
    FAddr: string;
  public
    property Addr : string read FAddr write FAddr;
    property CardNo : string read FCardNo write FCardNo;
    property Permit : string read FPermit write FPermit;
  End;

  TNode = Class(TComponent)
  private
    function CardUploadPacketProcess(aCardData:string):Boolean;
    function DeviceCardCountSearch:Boolean;
    function DeviceCardUpLoadPacket(aCardUpLoadPacketSeq:integer):Boolean;
    function MakeHexCheckSum(aData:string;aLength:integer):string;
    procedure NodeDataReadingProcessing;
    Function NodeDataHexPacketProcess(aPacketData:string):Boolean;
    function PacketFormatCheck(aData: RawByteString;var aLeavePacketData,aPacketData: String): integer;
    function PutHexString(aHexData:string):Boolean;
    function SendHexPacket(aHexCmd,aHexSendData:string;aPriority:integer=0):Boolean;
  private
    procedure CardDownLoadTimerTimer(Sender: TObject);
    procedure CardSearchTimerTimer(Sender: TObject);
    procedure DeviceReceiveTimerTimer(Sender: TObject);
    procedure FireSendTimerTimer(Sender: TObject);
    procedure NodeSendPacketTimerTimer(Sender: TObject);
    procedure ReConnectedTimerTimer(Sender:TObject);
    function ReceiveAccessEventSearch(aData:string):Boolean;
    function ReceiveDeviceCardCount(aData:string):Boolean;
    function ReceiveDeviceCardUpload(aData:string):Boolean;
    function ReceiveDeviceID(aData:string):Boolean;
    function ReceiveDeviceVerSearch(aData:string):Boolean;
    function ReceiveLockPortSetting(aData:string):Boolean;
    function ReceivePassWord(aData:string):Boolean;
    function ReSocketConnected : Boolean;
  private
    CardDownLoadTimer : TTimer;  //카드 다운로드 타이머
    CardSearchTimer : TTimer;    //등록 카드 조회 타이머
    DeviceReceiveTimer : TTimer; //컨트롤러 이벤트 수신 및 버젼 정보 수신
    FireSendTimer : TTimer;      //화재전송 복구 전송 타이머
    NodeSendPacketTimer : TTimer;
    ReConnectedTimer : TTimer;
    //********************* WinSock 변수
    l_wsa_data: twsaData;
    l_c_reception_buffer: c_byte_buffer;
    L_bCardSearching : Boolean;
    L_bCardDownLoad : Boolean;
    L_bCardDownLoadAck : Boolean;
    L_bPacketSending : Boolean;
    L_bSocketDestroy : Boolean;
    L_bSocketWriting : Boolean;
    L_bSocketSending : Boolean; //현재 전송 중이다.
    L_bSocketAckReceive : Boolean;
    L_n1stCount : integer;
    L_n2ndCount : integer;
    L_n3rdCount : integer;
    L_n4thCount : integer;
    L_nCardDownLoadSeq : integer;
    L_nCardDownLoadFailCount : integer;
    L_nCardUpLoadPacketSeq : integer;
    L_nSendDelayCount : integer;
    L_nSendErrCount : integer;
    L_nSendStopCount : integer;
    L_nTimeSyncCount : integer;
    L_stComBuffer : RawByteString;
    CardDownLoadList : TStringList;
    CardPermitList : TStringList;
    Send1stDataList : TStringList;
    Send2ndDataList : TStringList;
    Send3rdDataList : TStringList;
    Send4thDataList : TStringList;
    //Handle 생성 부분
    FHandle : THandle;
    FSocketOpen: Boolean;
    FNodeConnected: TConnectedState;
    FWinSocket: tSocket;
    FNodePort: integer;
    FNodeIP: string;
    FLastReceiveTime: TDateTime;
    FReaderNo: integer;
    FNodeSeq: integer;
    FLockPortType: string;
    FLockMode: string;
    FRcvLockPort: string;
    FLockControlTime: integer;
    FSenserMode: string;
    FSenserTime: string;
    FSenserType: string;
    FDeviceType: string;
    FDeviceVer: string;
    FRcvDeviceVer: string;
    FDeviceName: string;
    FBuildingAreaCode: string;
    FBuildingCode: string;
    FRcvTimeSync: string;
    FOnAccessEvent: TAccessEvent;
    FOnNodeConnected: TNodeConnected;
    FOnDoorState: TDeviceState;
    FOnNodePacketEvent: TNodePacketEvent;
    FOnCardRegEvent: TCardRegEvent;
    FOnCardLoding: TDeviceState;
    FOnDoorLockSetting: TDoorLockSetting;
    FDeviceID: string;
    FRcvCardCount: string;
    FRcvCardUpload: string;
    FRcvCardUploadPacket: string;
    FOnCardUpLoadEvent: TCardUploadEvent;
    FDeviceUploadCardCount: integer;
    FDeviceCardCount: integer;
    FOnCardUploadProcess: TCardUploadProcess;
    FOldLockMode: string;
    FOnFireEvent: TDeviceState;
    FDoorFire: Boolean;
    FRcvDoorFireEvent: string;
    FOnPasswordEvent: TPassWordEvent;
    FRealConnected: Boolean;
    FSendTimerStart: Boolean;
    FCardDownLoadStart: Boolean;
    FDeviceStateRcvStop: Boolean;
    function GetHandle: THandle;
    procedure SetSocketOpen(const Value: Boolean);
    procedure SetNodeConnected(const Value: TConnectedState);
    procedure SetNodeIP(const Value: string);
    procedure SetNodePort(const Value: integer);
    procedure SetLockPortType(const Value: string);
    procedure SetLockMode(const Value: string);
    procedure SetLockControlTime(const Value: integer);
    procedure SetDeviceType(const Value: string);
    procedure SetDeviceVer(const Value: string);
    procedure SetDeviceCardCount(const Value: integer);
    procedure SetDeviceUploadCardCount(const Value: integer);
    procedure SetDoorFire(const Value: Boolean);
    procedure SetRcvDoorFireEvent(const Value: string);
    procedure SetRealConnected(const Value: Boolean);
    procedure SetSendTimerStart(const Value: Boolean);
    procedure SetCardDownLoadStart(const Value: Boolean);
  protected
    procedure WndProc ( var Message : TMessage ); virtual;
  public
    function AceessEventSearch : Boolean;
    function CardDataDownLoad(aCardNo,aPermit,aAddr:string):Boolean;
    function CardDataLoading(aCardNo,aPermit,aAddr:string):Boolean;
    function DeviceCardInit:Boolean;
    function DeviceCardSearch:Boolean;
    function DeviceIDSearch:Boolean;
    function DeviceReset:Boolean;
    function DeviceVersionSearch:Boolean;
    function ExecSendPacket : Boolean;
    function FireEvent : Boolean;
    function FireRecovery : Boolean;
    function GetCardDownLoadCount:integer;
    function LockPortSearch:Boolean;
    function LockPortSetting(aLockPortType,aLockMode,aLockControlTime:string):Boolean;
    function PasswordApply(aPasswordWork,aPasswd:string):Boolean;
    function SendCardPermitDownLoad(aCardNo,aPermit,aAddr:string):Boolean;
    function TimeSync:Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HandleAllocated : Boolean;
    procedure HandleNeeded;
    procedure handle_fd_close_notification(p_socket: Integer);
    procedure handle_fd_connect_notification(p_socket: Integer);
    procedure handle_fd_read_notification(p_socket: tSocket);
    procedure handle_fd_write_notification(p_socket: Integer);
    procedure handle_wm_async_select(var Msg: TMessage); message wm_asynch_select;
    procedure WinSockError(Sender: TObject; SocketError: Integer);
    procedure WinSockReceive(Sender: TObject; Buf: PAnsiChar;var DataLen: Integer);
  published
    property BuildingCode : string read FBuildingCode write FBuildingCode; //동코드
    property BuildingAreaCode : string read FBuildingAreaCode write FBuildingAreaCode; //구역코드
    property CardDownLoadStart : Boolean read FCardDownLoadStart write SetCardDownLoadStart;
    property DeviceName : string read FDeviceName write FDeviceName; //출입문명
    property DeviceID : string read FDeviceID write FDeviceID;
    property DeviceType : string read FDeviceType write SetDeviceType; //01.로비폰,02.MSR-7000,03.화재수신용,10.독립형
    property DeviceVer : string read FDeviceVer write SetDeviceVer; //
    property DeviceStateRcvStop : Boolean read FDeviceStateRcvStop write FDeviceStateRcvStop;
    property DoorFire : Boolean read FDoorFire write SetDoorFire;
    property LockControlTime : integer read FLockControlTime write SetLockControlTime; //1~15초
    property LockMode : string read FLockMode write SetLockMode; //00.사용안함,21.강제열기,22.포트정상,23.강제닫기
    property LockPortType : string read FLockPortType write SetLockPortType; //01.Normal Open,02.Normal Close
    property OldLockMode : string read FOldLockMode write FOldLockMode; //00.사용안함,21.강제열기,22.포트정상,23.강제닫기
    property SendTimerStart : Boolean read FSendTimerStart write SetSendTimerStart;
    property SenserType : string read FSenserType write FSenserType; //00.사용안함,01.사용
    property SenserMode : string read FSenserMode write FSenserMode; //01.NormalOpen,02.NormalClose(default 01)
    property SenserTime : string read FSenserTime write FSenserTime; //0x0000 ~ 0x9999
    property RcvCardCount : string read FRcvCardCount write FRcvCardCount;
    property RcvCardUpload : string read FRcvCardUpload write FRcvCardUpload;
    property RcvCardUploadPacket : string read FRcvCardUploadPacket write FRcvCardUploadPacket;
    property RcvDeviceVer : string read FRcvDeviceVer write FRcvDeviceVer;
    property RcvDoorFireEvent : string read FRcvDoorFireEvent write SetRcvDoorFireEvent;
    property RcvLockPort : string read FRcvLockPort write FRcvLockPort;
    property RcvTimeSync : string read FRcvTimeSync write FRcvTimeSync;
  published
    property Handle : THandle read GetHandle;
    property DeviceCardCount : integer read FDeviceCardCount write SetDeviceCardCount;
    property DeviceUploadCardCount : integer read FDeviceUploadCardCount write SetDeviceUploadCardCount;
    property NodeConnected : TConnectedState read FNodeConnected write SetNodeConnected;
    property RealConnected : Boolean read FRealConnected write SetRealConnected;
    property NodeIP : string read FNodeIP write SetNodeIP;
    property NodePort : integer read FNodePort write SetNodePort;
    property NodeSeq : integer read FNodeSeq write FNodeSeq;
    property LastReceiveTime : TDateTime read FLastReceiveTime write FLastReceiveTime;
    property ReaderNo : integer read FReaderNo write FReaderNo;
    property SocketOpen : Boolean read FSocketOpen write SetSocketOpen;
    property WinSocket : tSocket read FWinSocket write FWinSocket;
  published
    property OnAccessEvent: TAccessEvent read FOnAccessEvent write FOnAccessEvent;
    property OnCardLoding : TDeviceState read FOnCardLoding write FOnCardLoding;
    property OnCardRegEvent : TCardRegEvent read FOnCardRegEvent write FOnCardRegEvent;
    property OnCardUpLoadEvent : TCardUploadEvent read FOnCardUpLoadEvent write FOnCardUpLoadEvent;
    property OnCardUploadProcess : TCardUploadProcess read FOnCardUploadProcess write FOnCardUploadProcess;
    property OnDoorLockSetting : TDoorLockSetting read FOnDoorLockSetting write FOnDoorLockSetting;
    property OnDoorState : TDeviceState read FOnDoorState write FOnDoorState;
    property OnFireEvent : TDeviceState read FOnFireEvent write FOnFireEvent;
    property OnNodeConnected : TNodeConnected read FOnNodeConnected write FOnNodeConnected;
    property OnNodePacketEvent : TNodePacketEvent read FOnNodePacketEvent write FOnNodePacketEvent;
    property OnPasswordEvent : TPassWordEvent read FOnPasswordEvent write FOnPasswordEvent;
  End;


  TdmNode = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmNode: TdmNode;

implementation
uses
  uCommonFunction,
  uCommonVariable;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TNode }

function TNode.AceessEventSearch: Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  SendHexPacket(Ascii2Hex(cmd_AccessEventSearch),stSendData,1);
end;

function TNode.CardDataDownLoad(aCardNo, aPermit,aAddr: string): Boolean;
var
  nIndex : integer;
  oCardPermit : TCardPermit;
  oCardPermit1 : TCardPermit;
begin
  //CardDownLoadTimer.Enabled := True;
  nIndex := CardDownLoadList.IndexOf(aCardNo);
  if nIndex > -1 then
  begin
    TCardPermit(CardDownLoadList.Objects[nIndex]).Free; //다운로드 할 메모리에 데이터가 있으면
    CardDownLoadList.Delete(nIndex);
  end;
  oCardPermit := TCardPermit.Create(nil);
  oCardPermit.CardNo := aCardNo;
  oCardPermit.Addr := aAddr;
  oCardPermit.Permit := aPermit;
  CardDownLoadList.AddObject(aCardNo,oCardPermit);

  nIndex := CardPermitList.IndexOf(aCardNo);
  if nIndex < 0 then
  begin
    oCardPermit1 := TCardPermit.Create(nil);
    oCardPermit1.CardNo := aCardNo;
    oCardPermit1.Addr := aAddr;
    oCardPermit1.Permit := aPermit;
    CardPermitList.AddObject(aCardNo,oCardPermit1);
  end else
  begin
    TCardPermit(CardPermitList.Objects[nIndex]).Addr := aAddr;
    TCardPermit(CardPermitList.Objects[nIndex]).Permit := aPermit;
  end;
end;

function TNode.CardDataLoading(aCardNo, aPermit,aAddr: string): Boolean;
var
  nIndex : integer;
  oCardPermit1 : TCardPermit;
begin
  nIndex := CardPermitList.IndexOf(aCardNo);
  if nIndex < 0 then
  begin
    oCardPermit1 := TCardPermit.Create(nil);
    oCardPermit1.CardNo := aCardNo;
    oCardPermit1.Addr := aAddr;
    oCardPermit1.Permit := aPermit;
    CardPermitList.AddObject(aCardNo,oCardPermit1);
  end else
  begin
    TCardPermit(CardPermitList.Objects[nIndex]).Addr := aAddr;
    TCardPermit(CardPermitList.Objects[nIndex]).Permit := aPermit;
  end;
end;

procedure TNode.CardDownLoadTimerTimer(Sender: TObject);
var
  FirstTickCount : double;
begin
  if G_bApplicationTerminate then Exit;
  if L_bSocketWriting then Exit; //전송 중에는 보내지 말자.  => 전송 완료 메시지 이벤트가 발생 안되어 무용지물
  if L_bSocketDestroy then Exit;
  if L_bCardDownLoad then Exit; //카드 다운로드 중에는 보내지 말자.

  if L_nCardDownLoadFailCount > 10 then CardDownLoadStart := False;   //카드 다운로드가 연속으로 10회 이상 실패 하면 빠져 나가자.
  if RcvDeviceVer <> 'Y' then
  begin
    CardDownLoadStart := False;
    inc(L_nCardDownLoadFailCount);
    Exit; //버젼 조회까지 끝나지 않았으면 전송하지 말자.
  end;
  if L_nSendStopCount > 0 then
  begin
    CardDownLoadStart := False;
    Exit;  //접속 실패이면 전송하지 말자.
  end;


  L_bCardDownLoad := True;
  Try
    if CardDownLoadList.Count < 1 then
    begin
      CardDownLoadStart := False;
      Exit;
    end;

    if CardDownLoadList.Count -1 < L_nCardDownLoadSeq then L_nCardDownLoadSeq := 0;

    L_bCardDownLoadAck := False;
    SendCardPermitDownLoad(TCardPermit(CardDownLoadList.Objects[L_nCardDownLoadSeq]).CardNo,TCardPermit(CardDownLoadList.Objects[L_nCardDownLoadSeq]).Permit,TCardPermit(CardDownLoadList.Objects[L_nCardDownLoadSeq]).Addr);

    FirstTickCount := GetTickCount + 3000;
    While Not L_bCardDownLoadAck do
    begin
      if L_bSocketDestroy then Exit;
      sleep(1);
      //Application.ProcessMessages;
      MyProcessMessage;
      if GetTickCount > FirstTickCount then Break;
    end;

    if L_bCardDownLoadAck then
    begin
      L_nCardDownLoadFailCount := 0;
      if Assigned(FOnCardRegEvent) then
      begin
        OnCardRegEvent(Self,NodeSeq,TCardPermit(CardDownLoadList.Objects[L_nCardDownLoadSeq]).CardNo,TCardPermit(CardDownLoadList.Objects[L_nCardDownLoadSeq]).Permit);
      end;

      TCardPermit(CardDownLoadList.Objects[L_nCardDownLoadSeq]).Free;
      CardDownLoadList.Delete(L_nCardDownLoadSeq);
    end else
    begin
      inc(L_nCardDownLoadFailCount);
    end;
    L_nCardDownLoadSeq := L_nCardDownLoadSeq + 1;


  Finally
    L_bCardDownLoad := False;
  End;
end;

procedure TNode.CardSearchTimerTimer(Sender: TObject);
begin
  if L_bSocketDestroy then Exit;
  if L_bCardSearching then Exit;
  Try
    L_bCardSearching := True;
    if RcvCardCount = 'N' then
    begin
      DeviceCardCountSearch;
      Exit;
    end;
    if RcvCardUpload <> 'Y' then
    begin
      inc(L_nCardUpLoadPacketSeq);
      DeviceCardUpLoadPacket(L_nCardUpLoadPacketSeq);
    end;

  Finally
    L_bCardSearching := False;
  End;
end;

function TNode.CardUploadPacketProcess(aCardData: string): Boolean;
var
  stCardType : string;
  stCardData : string;
  stAddr : string;
begin
  stCardType := copy(aCardData,1,2);
  Delete(aCardData,1,2);
  stCardData := copy(aCardData,1,10 * 2);
  Delete(aCardData,1,10 * 2);
  stAddr := aCardData;
  //카드타입 01.4Byte,02.7Byte,03.10Byte,04.티머니
  if stCardType = '01' then
  begin
    Delete(stCardData,1,6*2);
  end else if stCardType = '02' then
  begin
    Delete(stCardData,1,3*2);
  end else if stCardType = '03' then
  begin
    //전체가 카드데이터 이다.
  end else if stCardType = '02' then
  begin
    Delete(stCardData,1,2*2);
  end else
  begin
    //알수없는 카드타입 포맷이다.
    Exit;
  end;

  if Assigned(FOnCardUpLoadEvent) then
  begin
    OnCardUpLoadEvent(Self,NodeSeq,BuildingCode,BuildingAreaCode,stCardData,stCardType,stAddr);
  end;


end;

constructor TNode.Create(AOwner: TComponent);
begin
  inherited;
  FHandle := 0;
  NodeConnected := csNothing;
  RealConnected := False;
  WinSocket := Invalid_Socket;
  L_bSocketDestroy := False;
  L_nTimeSyncCount := 0;
  L_nCardDownLoadSeq := 0;
  L_nCardDownLoadFailCount := 0;
  L_nSendStopCount := 0;
  L_n1stCount := 0;
  L_n2ndCount := 0;
  L_n3rdCount := 0;
  L_n4thCount := 0;

  DeviceID := '';
  RcvCardCount := 'N';
  RcvDeviceVer := 'N';
  RcvLockPort := 'N';
  RcvTimeSync := 'N';
  SenserType := '01';
  SenserMode := '01';
  SenserTime := '0101';

  l_c_reception_buffer:= c_byte_buffer.create_byte_buffer('reception_buffer', k_buffer_max);

  CardDownLoadList := TStringList.Create;
  CardDownLoadList.Clear;
  CardPermitList := TStringList.Create;
  CardPermitList.Clear;

  Send1stDataList := TStringList.Create;
  Send1stDataList.Clear;
  Send2ndDataList := TStringList.Create;
  Send2ndDataList.Clear;
  Send3rdDataList := TStringList.Create;
  Send3rdDataList.Clear;
  Send4thDataList := TStringList.Create;
  Send4thDataList.Clear;

  CardDownLoadTimer := TTimer.Create(nil);
  CardDownLoadTimer.Interval := 30;
  CardDownLoadTimer.OnTimer := CardDownLoadTimerTimer;
  CardDownLoadTimer.Enabled := False;

  CardSearchTimer := TTimer.Create(nil);
  CardSearchTimer.Interval := 1000;
  CardSearchTimer.OnTimer := CardSearchTimerTimer;
  CardSearchTimer.Enabled := False;

  DeviceReceiveTimer := TTimer.Create(nil);
  DeviceReceiveTimer.Interval := 10 * 1000;
  DeviceReceiveTimer.OnTimer := DeviceReceiveTimerTimer;
  DeviceReceiveTimer.Enabled := False;

  NodeSendPacketTimer := TTimer.Create(nil);
  NodeSendPacketTimer.Interval := 20;
  NodeSendPacketTimer.OnTimer := NodeSendPacketTimerTimer;

  FireSendTimer := TTimer.Create(nil);
  FireSendTimer.Interval := 1000;
  FireSendTimer.OnTimer := FireSendTimerTimer;
  FireSendTimer.Enabled := False;

  ReConnectedTimer := TTimer.Create(nil);
  ReConnectedTimer.Interval := 10;
  ReConnectedTimer.OnTimer := ReConnectedTimerTimer;
  ReConnectedTimer.Enabled := False;

  SendTimerStart := False;
  CardDownLoadStart := False;
  DeviceStateRcvStop := False;
end;

destructor TNode.Destroy;
var
  i :integer;
begin
  L_bSocketDestroy := True;

  if CardDownLoadList.Count > 0 then
  begin
    for i := CardDownLoadList.Count - 1 downto 0 do TCardPermit(CardDownLoadList.Objects[i]).Free;
    CardDownLoadList.Clear;
  end;
  if CardPermitList.Count > 0 then
  begin
    for i := CardPermitList.Count - 1 downto 0 do TCardPermit(CardPermitList.Objects[i]).Free;
    CardPermitList.Clear;
  end;
  NodeSendPacketTimer.Enabled := False;
  DeviceReceiveTimer.Enabled := False;
  CardDownLoadTimer.Enabled := False;
  CardSearchTimer.Enabled := False;
  ReConnectedTimer.Enabled := False;

  Send1stDataList.Free;
  Send2ndDataList.Free;
  Send3rdDataList.Free;
  Send4thDataList.Free;

  CardDownLoadList.Free;
  CardPermitList.Free;

  l_c_reception_buffer.Free;

  inherited;
end;

function TNode.DeviceCardCountSearch: Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  SendHexPacket(Ascii2Hex(cmd_CardCountSearch),stSendData,1);
end;

function TNode.DeviceCardInit: Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  SendHexPacket(Ascii2Hex(cmd_DeviceCardInit),stSendData,1);
end;

function TNode.DeviceCardSearch: Boolean;
begin
  RcvCardCount := 'N';
  L_nCardUpLoadPacketSeq := 0;
  RcvCardUpload := 'N';
  DeviceUploadCardCount := 0;
  CardSearchTimer.Enabled := True;
end;

function TNode.DeviceCardUpLoadPacket(aCardUpLoadPacketSeq: integer): Boolean;
var
  stSendData : string;
  FirstTickCount : double;
begin
  RcvCardUploadPacket := 'N';
  stSendData := Dec2Hex(aCardUpLoadPacketSeq,4);
  SendHexPacket(Ascii2Hex(cmd_CardSearch),stSendData,1);

  FirstTickCount := GetTickCount + 3000;
  while RcvCardUploadPacket = 'N' do   //데이터 수신될때까지 대기 하자.
  begin
    if L_bSocketDestroy then Exit;
    sleep(1);
    Application.ProcessMessages;
    if GetTickCount > FirstTickCount then Break;
  end;
end;

function TNode.DeviceIDSearch: Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  SendHexPacket(Ascii2Hex(cmd_DeviceIDSearch),stSendData,1);
end;

procedure TNode.DeviceReceiveTimerTimer(Sender: TObject);
begin
  if L_bSocketWriting then
  begin
     L_bSocketWriting := False;
     Exit; //전송 중에는 보내지 말자.  => 전송 완료 메시지 이벤트가 발생 안되어 무용지물
  end;
  if L_bSocketDestroy then Exit;
  if Send1stDataList.Count > 0 then Exit;   //전송 건수가 하나라도 있으면 빠져 나가자...
//  if Send2ndDataList.Count > 0 then Exit;
  if G_bDebuging then
     LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':DeviceReceiveTimerTimer');

  if DeviceID = '' then    //기기 아이디를 가져 오지 못하면 가져올때까지 시도
  begin
    DeviceIDSearch;
    Exit;
  end;

  if RcvTimeSync <> 'Y' then
  begin
    TimeSync;
    inc(L_nTimeSyncCount);
    if L_nTimeSyncCount > 0 then RcvTimeSync := 'Y';
    Exit;
  end;

  if RcvLockPort <> 'Y' then   //락 상태 수신이 안되었으면 락 상태 수신하자.
  begin
    LockPortSearch;
    Exit;
  end;

  if RcvDeviceVer <> 'Y' then    //버젼 조회 안되었으면 버젼 조회 하자.
  begin
    DeviceVersionSearch;
    Exit;
  end;

  if DeviceStateRcvStop then Exit; //카드 데이터 다운로드 중에는 빠져 나가자.
  DeviceReceiveTimer.Interval := G_nEnqTime * 1000;
  AceessEventSearch;   //출입이력 수신
end;

function TNode.DeviceReset: Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  SendHexPacket(Ascii2Hex(cmd_DeviceReset),stSendData,1);
end;

function TNode.DeviceVersionSearch: Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  SendHexPacket(Ascii2Hex(cmd_DeviceVerSearch),stSendData,2);
end;

function TNode.ExecSendPacket: Boolean;
var
  stPacket : string;
  nCardDelayCount : integer;
  nStep : integer;
begin
  if L_bSocketWriting then
  begin
    L_bSocketWriting := False;
    Exit; //전송 중에는 보내지 말자.  => 전송 완료 메시지 이벤트가 발생 안되어 무용지물
  end;
  if L_bSocketDestroy then Exit;
  if L_nSendStopCount > 0 then
  begin
    L_nSendStopCount := L_nSendStopCount - 1;
    Exit;
  end;
  if L_bPacketSending then Exit;

  L_bPacketSending := True;
  Try
    nCardDelayCount := 2;   //카드데이터 다운로드시 200ms 에 하나씩 전송 하기 위해서 400ms 안된 경우 전송 하지 말자.

    nStep := 0;
    L_nSendDelayCount := L_nSendDelayCount + 1;
    stPacket := '';
    if (Send1stDataList.Count > 0) and (L_n1stCount < 5) then
    begin
      if L_nSendDelayCount > nCardDelayCount then L_nSendDelayCount := 0;
      stPacket := Send1stDataList.Strings[0];
      inc(L_n1stCount);
      nStep := 1;
    end else if (Send2ndDataList.Count > 0) and (L_n2ndCount < 5) then
    begin
      L_n1stCount := 0;
      if L_nSendDelayCount > nCardDelayCount then L_nSendDelayCount := 0;
      stPacket := Send2ndDataList.Strings[0];
      Send2ndDataList.Delete(0);
      inc(L_n2ndCount);
      nStep := 2;
    end else if (Send3rdDataList.Count > 0) and (L_n3rdCount < 5) then
    begin
      L_n1stCount := 0;
      L_n2ndCount := 0;
      if L_nSendDelayCount > nCardDelayCount then L_nSendDelayCount := 0;
      stPacket := Send3rdDataList.Strings[0];
      inc(L_n3rdCount);
      nStep := 3;
    end else if (Send4thDataList.Count > 0) and (L_n4thCount < 5) then
    begin
      L_n1stCount := 0;
      L_n2ndCount := 0;
      L_n3rdCount := 0;
      if L_nSendDelayCount < nCardDelayCount then Exit;       //카드데이터 다운로드시 200ms 에 하나씩 전송 하기 위해서 400ms 안된 경우 전송 하지 말자.
      L_nSendDelayCount := 0;
      stPacket := Send4thDataList.Strings[0];
      inc(L_n4thCount);
      nStep := 4;
    end else
    begin
      L_n1stCount := 0;
      L_n2ndCount := 0;
      L_n3rdCount := 0;
      L_n4thCount := 0;
    end;

    if stPacket <> '' then
    begin
      if G_bDebuging then
         LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':Send' + stPacket );
      //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','TX' + stPacket);   //20151015TEST
      //L_bSocketWriting := True;   //Send 후 이벤트가 발생하지 않네...ㅠ.ㅠ
      if Not PutHexString(stPacket) then
      begin
        //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','TX(ERR)' + stPacket); //20151015TEST
        if nStep <> 2 then inc(L_nSendErrCount);
        if L_nSendErrCount > 10 then
        begin
          NodeConnected := csDisConnected;
        end;
        Exit; //소켓에 전송
      end;
      L_nSendErrCount := 0;
    end;

    case nStep of
      1 : begin
        Send1stDataList.Delete(0);
      end;
      2 : begin
        //Send2ndDataList.Delete(0);
      end;
      3 : begin
        Send3rdDataList.Delete(0);
      end;
      4 : begin
        Send4thDataList.Delete(0);
      end;

    end;
  Finally
    L_bPacketSending := False;
  End;
end;

function TNode.FireEvent: Boolean;
var
  stSendData : string;
begin
  stSendData := '01'; //강제개방
  SendHexPacket(Ascii2Hex(cmd_Fire),stSendData,1);
end;

function TNode.FireRecovery: Boolean;
var
  stSendData : string;
begin
  stSendData := '02'; //정상복구
  SendHexPacket(Ascii2Hex(cmd_Fire),stSendData,1);
end;

procedure TNode.FireSendTimerTimer(Sender: TObject);
var
  bTest : Boolean;
begin
  if L_bSocketWriting then Exit; //전송 중에는 보내지 말자.  => 전송 완료 메시지 이벤트가 발생 안되어 무용지물
  if L_bSocketDestroy then Exit;
  if RcvDoorFireEvent = 'Y' then Exit;

  if DoorFire then FireEvent
  else FireRecovery;

end;

function TNode.GetCardDownLoadCount: integer;
begin
  result := CardDownLoadList.Count;
end;

function TNode.GetHandle: THandle;
begin
  Try
    HandleNeeded;
    Result := FHandle;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.GetHandle');
  End;
end;

function TNode.HandleAllocated: Boolean;
begin
  Try
    Result := ( FHandle <> 0 );
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.HandleAllocated');
  End;
end;

procedure TNode.HandleNeeded;
begin
  Try
    if not HandleAllocated
     then FHandle := AllocateHWND ( WndProc );
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.HandleNeeded');
  End;
end;

procedure TNode.handle_fd_close_notification(p_socket: Integer);
var l_status: Integer;
    l_linger: TLinger;
    l_absolute_linger: array[0..3] of char absolute l_linger;
begin
  Try
    if WSAIsBlocking
      then
        begin
          WSACancelBlockingCall;
        end;

    ShutDown(p_socket, 2);
    l_linger.l_onoff:= 1;
    l_linger.l_linger:= 0;

    SetSockOpt(p_socket, Sol_Socket, So_Linger, pAnsichar(AnsiString(l_absolute_linger)), sizeof(l_linger));  //l_absolute_linger[0] -> AnsiString(l_absolute_linger) 으로 변경

    l_status:= CloseSocket(p_socket);
    RealConnected := False;
    if G_bDebuging  then
    begin
      LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':Socket Close');
    end;
    //NodeConnected := csDisConnected;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','handle_fd_close_notification');
  End;
end;

procedure TNode.handle_fd_connect_notification(p_socket: Integer);
begin
  NodeConnected := csConnected;
  RealConnected := True;
end;

procedure TNode.handle_fd_read_notification(p_socket: tSocket);
var l_remaining: Integer;
    l_pt_start_reception: Pointer;
    l_packet_bytes: Integer;
    l_eol_position: Integer;
begin
  Try
    if l_c_reception_buffer = nil then Exit;
    if L_bSocketDestroy then Exit;

    LastReceiveTime := Now;

    with l_c_reception_buffer do
    begin
      l_remaining:= m_buffer_size- m_write_index;

      // -- if not at least a tcp-ip chunk, increase the room
      if l_remaining < k_tcp_ip_chunk then
      begin
        // -- reallocate
        double_the_capacity;
        l_remaining:= m_buffer_size- m_write_index;
      end;

      // -- add the received data to the current buffer
      l_pt_start_reception:= @ m_oa_byte_buffer[m_write_index];

      // -- get the data from the client socket
      l_packet_bytes:= Recv(WinSocket, l_pt_start_reception^, l_remaining, 0);
      if l_packet_bytes < 0 then WinSockError(self,WSAGetLastError)
      else
      begin
        m_write_index:= m_write_index+ l_packet_bytes;
        WinSockReceive(self, l_pt_start_reception, l_packet_bytes);
      end;
    end; // with g_c_reception_buffer
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','handle_fd_read_notification');
  End;
end;

procedure TNode.handle_fd_write_notification(p_socket: Integer);
begin
  L_bSocketWriting := False; //전송 완료
  //LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','SocketWriting=False'); //20151015TEST
end;

procedure TNode.handle_wm_async_select(var Msg: TMessage);
var
    l_param: Integer;
    l_error, l_notification: Integer;
    l_socket_handle: Integer;
begin
  Try
    l_param:= Msg.lParam;
    l_socket_handle:= Msg.wParam;

    // -- extract the error and the notification code from l_param
    l_error:= wsaGetSelectError(l_param);
    l_notification:= wsaGetSelectEvent(l_param);

    if l_error <= wsaBaseErr then
    begin
        case l_notification of
          FD_CONNECT: handle_fd_connect_notification(l_socket_handle);
          FD_ACCEPT: {display_bug_stop('no_client_accept')} ;
          FD_WRITE: handle_fd_write_notification(l_socket_handle);
          FD_READ: handle_fd_read_notification(l_socket_handle);
          FD_CLOSE: handle_fd_close_notification(l_socket_handle);
        end // case
    end else
    begin
      if l_notification= FD_CLOSE then handle_fd_close_notification(l_socket_handle)
      else WinSockError(self,l_error) ;//TcpClientError(self,WSAGetLastError);
    end;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.handle_wm_async_select');
  End;
end;


function TNode.LockPortSearch: Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  SendHexPacket(Ascii2Hex(cmd_LockPortSearch),stSendData,1);
end;

function TNode.LockPortSetting(aLockPortType, aLockMode,
  aLockControlTime: string): Boolean;
var
  stSendData : string;
begin
  stSendData := '';
  stSendData := aLockPortType + aLockMode + aLockControlTime + SenserType + SenserMode + SenserType;
  SendHexPacket(Ascii2Hex(cmd_LockPortRegist),stSendData,1);
end;

function TNode.MakeHexCheckSum(aData: string;aLength:integer): string;
var
  i : integer;
  aBcc: Byte;
begin
  aBcc := Ord(aData[1]);
  if aLength > 1 then
  begin
    for i := 2 to aLength do
    begin
      aBcc := aBcc xor Ord(aData[i]);
    end;
  end;
  result := Dec2Hex(Ord(aBCC),2);
end;

function TNode.NodeDataHexPacketProcess(aPacketData: string): Boolean;
var
  stCmd : string;
  stReceiveStatus : string;
  stReceiveData : string;
  stLength : string;
  nLength : integer;
  stData : string;
  stCardType : string;
  stCardData : string;
  nIndex : integer;
begin
  NodeConnected := csConnected;
  stLength := copy(aPacketData,1*2 + 1,4);
  nLength := Hex2Dec64(stLength);
  stCmd := copy(aPacketData,4*2 + 1,2); //copy(aPacketData,4*2 + 1,2)  홀렸나?
  stReceiveStatus := copy(aPacketData,6*2 + 1,2);
  if (nLength * 2 - 10 > 0) then
     stData := copy(aPacketData,7*2 + 1,nLength * 2 - 10)
  else stData := '';

  if stCmd = '06' then   //기기 아이디 조회
  begin
    ReceiveDeviceID(stData);
  end else if stCmd = '11' then   //시간동기화
  begin
    RcvTimeSync := 'Y';
  end else if stCmd = '15' then  //출입문 설정 정보 조회
  begin
    ReceiveLockPortSetting(stData);
  end else if stCmd = '22' then  //버젼조회
  begin
    ReceiveDeviceVerSearch(stData);
  end else if stCmd = '31' then  //카드등록
  begin
    L_bCardDownLoadAck := True;
  end else if stCmd = '34' then  //카드삭제
  begin
    L_bCardDownLoadAck := True;
  end else if stCmd = '37' then  //카드건수조회
  begin
    ReceiveDeviceCardCount(stData);
  end else if stCmd = '38' then  //등록카드조회
  begin
    ReceiveDeviceCardUpload(stData);
  end else if stCmd = '40' then  //출입이벤트조회
  begin
    ReceiveAccessEventSearch(stData);
  end else if stCmd = '49' then  //화재전송
  begin
    RcvDoorFireEvent := 'Y';
  end else if stCmd = '80' then  //화재 이벤트 발생
  begin
    SendHexPacket(Ascii2Hex(cmd_FireEvent),'',1); //Ack 주고
    //화재발생 신호 생성하자...
    if Assigned(FOnFireEvent) then
    begin
      OnFireEvent(Self,NodeSeq,'');
    end;
  end else if stCmd = '90' then  //비밀번호
  begin
    ReceivePassWord(stData);
  end;

  if Assigned(FOnNodePacketEvent) then
  begin
    OnNodePacketEvent(Self,NodeSeq,'RX',DeviceName,stCmd,aPacketData);
  end;

end;

procedure TNode.NodeDataReadingProcessing;
var
  nFormat : integer;
  bLoop : Boolean;
  stLeavePacketData : string;
  stPacketData : string;
  bDecoderFormat : Boolean;
begin
  Try
    bLoop := False;
    repeat
      if Trim(L_stComBuffer) = '' then Exit;
      nFormat := PacketFormatCheck(L_stComBuffer,stLeavePacketData,stPacketData);
      if nFormat < 0 then
      begin
        if L_stComBuffer = '' then break;
        if nFormat = -1 then  //비정상 전문 인경우
        begin
           Delete(L_stComBuffer,1,2);
           continue;
        end else break;   //포맷 길이가 작게 들어온 경우
      end;
      L_stComBuffer:= stLeavePacketData;
      bDecoderFormat := False;
      if stPacketData <> '' then
      begin
        NodeDataHexPacketProcess(stPacketData);
      end;

      if pos('03',L_stComBuffer) = 0 then bLoop := True
      else bLoop := False;
      Application.ProcessMessages;
    until bLoop;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.NodeDataReadingProcessing');
  End;
end;

procedure TNode.NodeSendPacketTimerTimer(Sender: TObject);
var
  stPacket : string;
  nCardDelayCount : integer;
  nStep : integer;
begin
  if L_bSocketDestroy then Exit;
  NodeSendPacketTimer.Enabled := False;
  Try
    ExecSendPacket;
  Finally
    NodeSendPacketTimer.Enabled := Not L_bSocketDestroy;
  End;
  Exit; //Server에서 전송하자.
  if L_bSocketWriting then
  begin
    L_bSocketWriting := False;
    Exit; //전송 중에는 보내지 말자.  => 전송 완료 메시지 이벤트가 발생 안되어 무용지물
  end;
  NodeSendPacketTimer.Enabled := False;
  Try
    nCardDelayCount := 2;   //카드데이터 다운로드시 200ms 에 하나씩 전송 하기 위해서 400ms 안된 경우 전송 하지 말자.

    nStep := 0;
    L_nSendDelayCount := L_nSendDelayCount + 1;
    stPacket := '';
    if (Send1stDataList.Count > 0) and (L_n1stCount < 5) then
    begin
      if L_nSendDelayCount > nCardDelayCount then L_nSendDelayCount := 0;
      stPacket := Send1stDataList.Strings[0];
      inc(L_n1stCount);
      nStep := 1;
    end else if (Send2ndDataList.Count > 0) and (L_n2ndCount < 5) then
    begin
      L_n1stCount := 0;
      if L_nSendDelayCount > nCardDelayCount then L_nSendDelayCount := 0;
      stPacket := Send2ndDataList.Strings[0];
      Send2ndDataList.Delete(0);
      inc(L_n2ndCount);
      nStep := 2;
    end else if (Send3rdDataList.Count > 0) and (L_n3rdCount < 5) then
    begin
      L_n1stCount := 0;
      L_n2ndCount := 0;
      if L_nSendDelayCount > nCardDelayCount then L_nSendDelayCount := 0;
      stPacket := Send3rdDataList.Strings[0];
      inc(L_n3rdCount);
      nStep := 3;
    end else if (Send4thDataList.Count > 0) and (L_n4thCount < 5) then
    begin
      L_n1stCount := 0;
      L_n2ndCount := 0;
      L_n3rdCount := 0;
      if L_nSendDelayCount < nCardDelayCount then Exit;       //카드데이터 다운로드시 200ms 에 하나씩 전송 하기 위해서 400ms 안된 경우 전송 하지 말자.
      L_nSendDelayCount := 0;
      stPacket := Send4thDataList.Strings[0];
      inc(L_n4thCount);
      nStep := 4;
    end else
    begin
      L_n1stCount := 0;
      L_n2ndCount := 0;
      L_n3rdCount := 0;
      L_n4thCount := 0;
    end;

    if stPacket <> '' then
    begin
      //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','TX' + stPacket);   //20151015TEST
      //L_bSocketWriting := True;   //Send 후 이벤트가 발생하지 않네...ㅠ.ㅠ
      if Not PutHexString(stPacket) then
      begin
        //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','TX(ERR)' + stPacket); //20151015TEST
        if nStep <> 2 then inc(L_nSendErrCount);
        if L_nSendErrCount > 10 then NodeConnected := csDisConnected;
        Exit; //소켓에 전송
      end;
      L_nSendErrCount := 0;
    end;

    case nStep of
      1 : begin  
        Send1stDataList.Delete(0);
      end;
      2 : begin  
        //Send2ndDataList.Delete(0);
      end;
      3 : begin  
        Send3rdDataList.Delete(0);
      end;
      4 : begin  
        Send4thDataList.Delete(0);
      end;

    end;

  Finally
    NodeSendPacketTimer.Enabled := Not L_bSocketDestroy;
  End;
end;

function TNode.PacketFormatCheck(aData: RawByteString; var aLeavePacketData,
  aPacketData: String): integer;
var
  stLength : string;
  nLength : int64;
begin
  aPacketData := '';
  result := -1; //비정상 전문

  if copy(aData,1,2) <> '02' then    //1번째 자리가 STX 가 아니면 첫번째 자리 삭제 하자
  begin
    aLeavePacketData := aData;
    Exit;
  end;
  stLength := copy(aData,3,4);//Ascii2Hex(copy(aData,3,4));
  nLength := Hex2Dec64(stLength);

  if copy(aData,(3 + nLength) * 2 + 1,2) <> '03' then //[4 + nLength]//ETX 자리에 ETX 가 없으면 잘못된 데이터 이다.
  begin
    nLength := nLength + 2;
    if copy(aData,(3 + nLength) * 2 + 1,2) <> '03' then
    begin
      aLeavePacketData := aData;
      Exit;
    end;
  end;
  aPacketData := copy(aData,1,(4 + nLength) * 2);
  Delete(aData,1,(4 + nLength) * 2);
  aLeavePacketData := aData;
  result := 1;
end;

function TNode.PasswordApply(aPasswordWork, aPasswd: string): Boolean;
var
  stSendData : string;
begin

  stSendData := aPasswordWork + inttostr(Length(aPasswd)) + aPasswd;
  stSendData := AsciiRawByte2Hex(stSendData);
  SendHexPacket(AsciiRawByte2Hex(cmd_Password),stSendData,1);

end;

function TNode.PutHexString(aHexData: string): Boolean;
var
  l_result: Integer;
  buf: TBytes;
  nLen : integer;
  FirstTickCount : double;
begin
  if L_bSocketDestroy then Exit;
  Try
    Try
      result := False;
      if L_bSocketSending then Exit;
      L_bSocketSending := True;

      //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','ReSocketConnected1'); //20151015TEST
      ReSocketConnected;
      //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','ReSocketConnected2'); //20151015TEST
      //ReConnectedTimer.Enabled := True;
 (*     FirstTickCount := GetTickCount + 3000;  //전송 후 3초 동안 대기 해도 응답 없으면 끊고 빠져 나가자.
      while Not RealConnected do
      begin
        sleep(1);
        MyProcessMessage;
        //Application.ProcessMessages;
        if GetTickCount > FirstTickCount then
        begin
          Break;
        end;
      end;
 *)

      if Not RealConnected then
      begin
        L_nSendStopCount := 30; //3초 후에 다시 전송 해 보자.
        Exit;
      end;

      L_bSocketAckReceive := False;
      result := True;
      nLen := Length(aHexData) div 2;
      Try
        if G_bDebuging then
           LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':PutHexStart');

        Ascii2Bytes(Hex2Ascii(aHexData),nLen,buf);
        l_result:= Send(WinSocket,buf[0], nLen, 0);
        if G_bDebuging  then
        begin
          LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':PutStringSTART');
        end;

        if l_result < 0 then
        begin
          if l_result = wsaEWouldBlock  then
          begin
            result := False;
            L_bSocketWriting := True;  //Socket에 Full 나면 Write
            LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','SocketWriting=TRUE');
          end else
          begin
            WinSockError(self,WSAGetLastError);
          end;
        end;

        //여기에서 데이터 수신 기다리자.

        FirstTickCount := GetTickCount + 3000;  //전송 후 1초 동안 대기 해도 응답 없으면 끊고 빠져 나가자.
        while Not L_bSocketAckReceive do
        begin
          sleep(1);
          MyProcessMessage;
          //Application.ProcessMessages;
          if GetTickCount > FirstTickCount then
          begin
            result := False;
            Break;
          end;
        end;
        if G_bDebuging then
           LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':PutHexEnd');

      Except
        LogSave(G_stLogDirectory + '\Err' + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':PutString');
        Exit;
      End;
      
    Finally
      L_bSocketSending := False;
    End;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.PutString');
  End;
end;

function TNode.ReceiveAccessEventSearch(aData: string): Boolean;
var
  stAccessTime : string;
  stAccessResult : string;
  stCardType : string;
  stCardNo : string;
  nIndex : integer;
begin

  if Length(aData) < 17 then Exit;

  stAccessTime := copy(aData,1,14);
  stAccessTime := FillZeroNumber(Hex2Dec(copy(aData,1,2)),2) +
                  FillZeroNumber(Hex2Dec(copy(aData,3,2)),2) +
                  FillZeroNumber(Hex2Dec(copy(aData,5,2)),2) +
                  FillZeroNumber(Hex2Dec(copy(aData,7,2)),2) +
                  FillZeroNumber(Hex2Dec(copy(aData,9,2)),2) +
                  FillZeroNumber(Hex2Dec(copy(aData,11,2)),2) +
                  FillZeroNumber(Hex2Dec(copy(aData,13,2)),2);
  stAccessResult := copy(aData,15,2);   //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  stCardType := copy(aData,17,2);
  //stCardNo := copy(aData,17,22);

  if stCardType = '01' then
  begin
    if Length(aData) > 38 then
    begin
      stCardNo := copy(aData,31,8);
    end;
  end else if stCardType = '02' then
  begin
    if Length(aData) > 38 then
    begin
      stCardNo := copy(aData,25,14);
    end;
  end else if stCardType = '03' then
  begin
    if Length(aData) > 38 then
    begin
      stCardNo := copy(aData,19,20);
    end;
  end else if stCardType = '04' then
  begin
    if Length(aData) > 38 then
    begin
      stCardNo := copy(aData,23,16);
    end;
  end else if stCardType = '0A' then
  begin
    if Length(aData) > 38 then
    begin
      stCardNo := copy(aData,31,8);
      stCardNo := Hex2Ascii(stCardNo);
    end;
  end;
  if Assigned(FOnAccessEvent) then
  begin
    OnAccessEvent(Self,NodeSeq,DeviceName,BuildingCode,BuildingAreaCode,stAccessTime,stAccessResult,LockMode,stCardNo,stCardType);
  end;

  nIndex := CardPermitList.IndexOf(stCardNo);
  if nIndex < 0 then
  begin
    if Assigned(FOnCardLoding) then
    begin
      OnCardLoding(Self,NodeSeq,stCardNo);
    end;
    nIndex := CardPermitList.IndexOf(stCardNo);
  end;

  if nIndex < 0 then
  begin
    //카드 권한이 없는 거다.
    if stAccessResult = '10' then
    begin
      // CardDataDownLoad(stCardNo,'0','0000'); //카드권한 삭제 하자. --- 삭제하면 안된다.
    end;
  end else
  begin
    if TCardPermit(CardPermitList.Objects[nIndex]).Permit = '1' then
    begin
      if stAccessResult <> '10' then
      begin
        CardDataDownLoad(stCardNo,'1',TCardPermit(CardPermitList.Objects[nIndex]).Addr); //카드권한 재전송 하자.
      end;
    end;
  end;
  DeviceReceiveTimer.Interval := 500; //이벤트가 있으면 500미리에 한번씩 확인 하자...

end;

function TNode.ReceiveDeviceCardCount(aData: string): Boolean;
begin
  DeviceCardCount := Hex2Dec(aData);
  RcvCardCount := 'Y';
end;

function TNode.ReceiveDeviceCardUpload(aData: string): Boolean;
var
  stCardCount : string;
  nCardCount : integer;
  i : integer;
begin
  Try
    stCardCount := copy(aData,1,4);
    nCardCount := Hex2Dec64(stCardCount);
    if nCardCount = 0 then
    begin
      RcvCardUpload := 'Y';
      Exit;
    end;
    Delete(aData,1,4); //등록건수 삭제
    Delete(aData,1,4); //패킷번호 삭제
    Delete(aData,1,4); //알수 없는 데이터 삭제


    DeviceUploadCardCount := DeviceUploadCardCount + nCardCount;
    if DeviceUploadCardCount >= DeviceCardCount then
    begin
      RcvCardUpload := 'Y';  //수신완료
    end;

    for i := 0 to nCardCount - 1 do
    begin
      CardUploadPacketProcess(copy(aData,(13 * 2) * i + 1,(13 * 2))); //카드 패킷은 13 패킷이다.
    end;

  Finally
    RcvCardUploadPacket := 'Y'; //패킷은 수신했다.
  End;
end;

function TNode.ReceiveDeviceID(aData: string): Boolean;
begin
  DeviceID := aData;
end;

function TNode.ReceiveDeviceVerSearch(aData: string): Boolean;
begin
  if Length(aData) < 2 then Exit;
  DeviceType := copy(aData,1,2);
  if Length(aData) < 4 then Exit;
  DeviceVer := copy(aData,3,2);

  RcvDeviceVer := 'Y';
end;

function TNode.ReceiveLockPortSetting(aData: string): Boolean;
var
  stTemp : string;
begin
  if Length(aData) < 2 then Exit;
  LockPortType := copy(aData,1,2);
  if Length(aData) < 4 then Exit;
  LockMode := copy(aData,3,2);
  if Length(aData) < 6 then Exit;
  stTemp := copy(aData,5,2);

  LockControlTime := Hex2Dec(stTemp);
  RcvLockPort := 'Y';

  if Assigned(FOnDoorLockSetting) then
  begin
    OnDoorLockSetting(Self,NodeSeq,LockPortType,LockMode,LockControlTime);
  end;

end;

function TNode.ReceivePassWord(aData: string): Boolean;
var
  stCmd : string;
  stLength : string;
  stPassword : string;
begin
  if Length(aData) < 2 then Exit;
  aData := Hex2Ascii(aData);
  stCmd := aData[1];
  stLength := aData[2];
  if Not isDigit(stLength) then Exit;

  if Length(aData) < (strtoint(stLength) + 2) then Exit;
  if strtoint(stLength) > 0 then
     stPassword := copy(aData,3,strtoint(stLength));

  if Assigned(FOnPasswordEvent) then
  begin
    OnPasswordEvent(Self,NodeSeq,stCmd,stPassword);
  end;
end;

procedure TNode.ReConnectedTimerTimer(Sender: TObject);
begin
  ReConnectedTimer.Enabled := False;
  ReConnectedTimer.Enabled := Not ReSocketConnected;
  if G_bDebuging then
     LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':ReConnectedTimerTimer');

end;

function TNode.ReSocketConnected: Boolean;
var
  FirstTickCount : double;
begin
  result := False;
  if (DeviceType <> '02') and (DeviceType <> '03') then
  begin
    if SocketOpen then
    begin
      //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','SocketClose');//TEST20151015
      SocketOpen := False;
      sleep(500);
    end;
    if G_bDebuging  then
    begin
      LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':ReSocketConnected');
    end;
    SocketOpen := True;
  end else
  begin
    if Not RealConnected then SocketOpen := True;
  end;
  //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log','SocketOPEN'); //TEST20151015
  result := True;
  FirstTickCount := GetTickCount + 1000;  //전송 후 200미리 동안 대기 해도 접속 없으면 빠져 나가자.
  while Not RealConnected do
  begin
    sleep(1); //TEST20151015
    //LogSave(G_stLogDirectory + '\log' + NodeIP + FormatDateTime('yyyymmdd',now) + '.log',floattostr(FirstTickCount) + '/' + floattostr(GetTickCount) );
    //Application.ProcessMessages;
    MyProcessMessage;
    if GetTickCount > FirstTickCount then 
    begin
      result := False;
      break;
    end;
  end;
  if G_bDebuging  then
  begin
    if RealConnected then
       LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':SocketConnected')
    else LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':SocketNotConnected');
  end;
end;

function TNode.SendCardPermitDownLoad(aCardNo, aPermit,aAddr: string): Boolean;
var
  stSendData : string;
  stCardType : string;
begin
  if Length(aCardNo) = 8 then stCardType := '01'        //4byte
  else if Length(aCardNo) = 14 then stCardType := '02'  //7byte
  else if Length(aCardNo) = 20 then stCardType := '03'  //10byte
  else stCardType := '04';//tmoney

  stSendData := FillZeroStrNum(aCardNo,20) + aAddr;
  stSendData := stCardType + stSendData;
  if aPermit = '1' then
     SendHexPacket(Ascii2Hex(cmd_CardAdd),stSendData,1)
  else SendHexPacket(Ascii2Hex(cmd_CardDelete),stSendData,1);
end;

function TNode.SendHexPacket(aHexCmd, aHexSendData: string;aPriority:integer=0): Boolean;
var
  nDataLength : integer;
  stSendData : string;
  stBCC : string;
begin
  Try
    //if Not (NodeConnected = csConnected) then Exit;
    //if Not RealConnected then Exit;


    nDataLength := Length(aHexSendData) div 2 + 4; //ReaderID 1,Cmd 1,Division 1,BCC 1
    //stSendData := Dec2Hex(ReaderNo,2) + aHexCmd + '2D' + aHexSendData;
    if DeviceID = '' then
      stSendData := '01' + aHexCmd + '2D' + aHexSendData
    else stSendData := DeviceID + aHexCmd + '2D' + aHexSendData;

    stBCC := MakeHexCheckSum(Hex2Ascii(stSendData),nDataLength - 1);
    stSendData := '02' + Dec2Hex(nDataLength,4) + stSendData + stBCC + '03';
    if aPriority = 0 then    //ack 와 같이 최우선 순위 데이터
    begin
      PutHexString(stSendData);
    end else if aPriority = 1 then   //제어,조회 명령과 같이 우선 순위 데이터
    begin
      if Send1stDataList.IndexOf(stSendData) < 0 then Send1stDataList.Add(stSendData);
    end else if aPriority = 2 then   //AccessEvent 에서 권한 데이터 불일치
    begin
      if Send2ndDataList.IndexOf(stSendData) < 0 then Send2ndDataList.Add(stSendData);
    end else if aPriority = 3 then
    begin
      if Send3rdDataList.IndexOf(stSendData) < 0 then Send3rdDataList.Add(stSendData);
    end else if aPriority = 4 then   //Auto CardData DownLoad
    begin
      if Send4thDataList.IndexOf(stSendData) < 0 then Send4thDataList.Add(stSendData);
    end;

    if Assigned(FOnNodePacketEvent) then
    begin
      OnNodePacketEvent(Self,NodeSeq,'TX',DeviceName,aHexCmd,stSendData);
    end;

  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.SendPacket');
  End;
end;

procedure TNode.SetCardDownLoadStart(const Value: Boolean);
begin
  FCardDownLoadStart := Value;
  CardDownLoadTimer.Enabled := Value;
end;

procedure TNode.SetDeviceCardCount(const Value: integer);
begin
  if FDeviceCardCount = Value then Exit;
  FDeviceCardCount := Value;
  if Value <> 0 then
  begin
    if Assigned(FOnCardUploadProcess) then
    begin
      OnCardUploadProcess(Self,NodeSeq,BuildingCode,BuildingAreaCode,DeviceCardCount,DeviceUploadCardCount);
    end;
  end;
end;

procedure TNode.SetDeviceType(const Value: string);
begin
  FDeviceType := Value;
end;

procedure TNode.SetDeviceUploadCardCount(const Value: integer);
begin
  if FDeviceUploadCardCount = Value then Exit;
  FDeviceUploadCardCount := Value;
  if Value <> 0 then
  begin
    if Assigned(FOnCardUploadProcess) then
    begin
      OnCardUploadProcess(Self,NodeSeq,BuildingCode,BuildingAreaCode,DeviceCardCount,DeviceUploadCardCount);
    end;
  end;
end;

procedure TNode.SetDeviceVer(const Value: string);
begin
  FDeviceVer := Value;
end;

procedure TNode.SetDoorFire(const Value: Boolean);
begin
  if FDoorFire = Value then Exit;

  FDoorFire := Value;
  if Assigned(FOnDoorState) then
  begin
    OnDoorState(Self,NodeSeq,LockMode);  //락상태를 다시 한번 전송한다.
  end;
end;

procedure TNode.SetLockControlTime(const Value: integer);
begin
  FLockControlTime := Value;
end;

procedure TNode.SetLockMode(const Value: string);
begin
  FLockMode := Value;
  if Assigned(FOnDoorState) then
  begin
    OnDoorState(Self,NodeSeq,Value);
  end;

end;

procedure TNode.SetLockPortType(const Value: string);
begin
  FLockPortType := Value;
end;

procedure TNode.SetNodeConnected(const Value: TConnectedState);
begin
  if FNodeConnected = Value then Exit;

  FNodeConnected := Value;

  if Value = csConnected then
  begin
    //DeviceReceiveTimer.Enabled := True;
  end else
  begin
    LockMode := '00'; //상태 모름으로 표시
    //DeviceReceiveTimer.Enabled := False;

    RcvCardCount := 'N';
    RcvCardUpload := 'N';
    RcvCardUploadPacket := 'N';
    RcvDeviceVer := 'N';
    RcvDoorFireEvent := 'N';
    RcvLockPort := 'N';
    RcvTimeSync := 'N';
  end;

  if Assigned(FOnNodeConnected) then
  begin
    OnNodeConnected(Self,NodeSeq,Value);
  end;

end;

procedure TNode.SetNodeIP(const Value: string);
begin
  FNodeIP := Value;
end;

procedure TNode.SetNodePort(const Value: integer);
begin
  FNodePort := Value;
end;


procedure TNode.SetRcvDoorFireEvent(const Value: string);
begin
  FRcvDoorFireEvent := Value;
  if Value = 'Y' then FireSendTimer.Enabled := False
  else if Value = 'S' then FireSendTimer.Enabled := True;
end;

procedure TNode.SetRealConnected(const Value: Boolean);
begin
  FRealConnected := Value;
end;

procedure TNode.SetSendTimerStart(const Value: Boolean);
begin
  if FSendTimerStart = Value then Exit;
  
  FSendTimerStart := Value;
  //if DeviceID = '' then DeviceIDSearch;  //락 아이디 조회
  NodeSendPacketTimer.Enabled := Value;
  DeviceReceiveTimer.Enabled := Value;
end;

procedure TNode.SetSocketOpen(const Value: Boolean);
var
  l_result : Integer;
  l_error: Integer;
  l_version : Word;
  l_socket_address_in: tSockAddrIn;
  l_ip_z: array[0..255] of char;
  rset: TFDSet;
  t: TTimeVal;
  rslt: integer;
begin
  Try
    if FSocketOpen = Value then Exit;
    if NodeIP = '' then Exit;

    FSocketOpen := Value;
    if Value then
    begin
      l_version:= $0101;
      l_result := wsaStartup(l_version, l_wsa_data);
      if l_result <> 0 then
      begin
        SocketOpen := False;
        LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.SetSocketwsaStartup Faile');
        Exit;  //소켓생성 실패 시에 Open False
      end;
      WinSocket:= Socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
      if WinSocket = INVALID_SOCKET then
      begin
        SocketOpen := False;
        LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.SetINVALID_SOCKET Faile');
        Exit;  //소켓생성 실패 시에 Open False
      end;
      l_result:= wsaAsyncSelect(WinSocket, Handle,
          wm_asynch_select,
          FD_CONNECT+ FD_READ+ FD_WRITE+ FD_CLOSE);

      FillChar(l_socket_address_in, sizeof(l_socket_address_in), 0);
      with l_socket_address_in do
      begin
        sin_family:= pf_Inet;
        // -- the requested service
        sin_port:= hToNs(NodePort);
        // -- the server IP address
        StrPCopy(l_ip_z, NodeIP);
        sin_addr.s_Addr:= inet_addr(PAnsichar(AnsiString(l_ip_z)));
      end; // with m_socket_address_in
    if G_bDebuging  then
    begin
      LogSave(G_stLogDirectory + '\' + NODEIP + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':' + inttostr(NodePort) + ':Connect Try');
    end;
      l_result:= Connect(WinSocket, l_socket_address_in,
          sizeof(l_socket_address_in));
      if l_result<> 0 then
      begin
        l_error:= WSAGetLastError;
        if l_error <> wsaEWouldBlock then
        begin
          SocketOpen := False;
          LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.SetSocketConnect Faile');
          Exit;  //소켓생성 실패 시에 Open False
        end else
        begin
        end;
      end;
  {    t.tv_sec:=5;
      t.tv_usec:=0;
      FD_Zero(rset);
      FD_Set(l_client_socket_handle,rset);
      rslt := select(-1, @rset, nil, nil, @t);
      if (rslt = 0) then
      begin
        SocketOpen := False;
        Exit;  //소켓생성 실패 시에 Open False
      end; }

    end else
    begin
      if WinSocket <> INVALID_SOCKET then
      begin
        shutdown(WinSocket,SD_BOTH);
        l_result:= CloseSocket(WinSocket);
        if l_result = 0 then
        begin
          WinSocket:= INVALID_SOCKET;
  //        l_c_reception_buffer.Free;
  //        l_c_reception_buffer:= Nil;
        end else
        begin
          WinSocket:= INVALID_SOCKET;
          LogSave(G_stLogDirectory + '\Err' + FormatDateTime('yyyymmdd',now) + '.log',NodeIP + ':SocketCloseError');
        end;
        WSACleanup;
      end;
      //NodeConnected := csDisConnected;
      RealConnected := False;
    end;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.SetSocketOpen');
  End;
end;

function TNode.TimeSync: Boolean;
var
  stSendData : string;
begin
  stSendData := formatDateTime('yyyymmddhhnnss',now);
  stSendData := Dec2Hex(strtoint(copy(stSendData,1,2)),2) +
                Dec2Hex(strtoint(copy(stSendData,3,2)),2) +
                Dec2Hex(strtoint(copy(stSendData,5,2)),2) +
                Dec2Hex(strtoint(copy(stSendData,7,2)),2) +
                Dec2Hex(strtoint(copy(stSendData,9,2)),2) +
                Dec2Hex(strtoint(copy(stSendData,11,2)),2) +
                Dec2Hex(strtoint(copy(stSendData,13,2)),2) ;

  SendHexPacket(Ascii2Hex(cmd_TimeSync),stSendData,2);
end;

procedure TNode.WinSockError(Sender: TObject; SocketError: Integer);
begin
  Try
    if (SocketError = WSAEWOULDBLOCK) or (SocketError = 10038) then Tag := 0
    else begin
      //NodeConnected := csDisConnected;
      RealConnected := False;
      Tag := SocketError;
    end;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.TcpClientError');
  End;
end;

procedure TNode.WinSockReceive(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
var
  stTemp : RawByteString;
begin
  Try
    stTemp := ByteCopy(Buf,DataLen);   //FD -> 3F 로 변하는 부분때문에...
    LastReceiveTime := Now;
    L_stComBuffer := L_stComBuffer + AsciiRawByte2Hex(stTemp,False,False,30,DataLen);
    L_bSocketAckReceive := True;
    if (DeviceType <> '02') and (DeviceType <> '03') then SocketOpen := False;
    NodeDataReadingProcessing;
  Except
    LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','Node.TcpClientReceive');
  End;
end;

procedure TNode.WndProc(var Message: TMessage);
begin
  Dispatch ( Message );
end;

end.
