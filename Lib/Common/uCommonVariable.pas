unit uCommonVariable;

interface
uses System.Classes,Vcl.Graphics,Winapi.Messages;

const
  SOH = #$1;
  STX = #$2;
  ETX = #$3;
  EOH = #$4;
  ENQ = #$5;
  ACK = #$6;
  NAK = #$15;
  EOT = #$04;
  CR  = #13;

const
  MDB = 1;
  MSSQL = 2;
  POSTGRESQL = 3;
  FireBird = 4;

const
  WM_SERVERMANAGERMESSAGE = WM_USER + 1;
  SM_ALIVE = 1024; //SeverManage Alive
  SM_DIE = 1025; //Server Die

const
  con_ComLogTYPE_PROGRAM = '0';
  con_ComLogTYPE_DOOR = '1';
  con_ComLogTYPE_ARMAREA = '2';
  con_ComLogTYPE_DEVICE = '3';
  con_ComLogTYPE_ZONE = '4';

const
  con_ComWorkType_INSERT = '1';
  con_ComWorkType_UPDATE = '2';
  con_ComWorkType_DELETE = '3';

const
  con_MaxDoorCount = 8;

const
  con_DoorNothing = 0;
  con_DoorPMC = 3;
  con_DoorPMO = 4;
  con_DoorPMT = 5;
  con_DoorPMD = 5;
  con_DoorPMU = 6;
  con_DoorPML = 7;
  con_DoorNMC = 9;
  con_DoorNMO = 8;
  con_DoorNMT = 5;
  con_DoorNMD = 5;
  con_DoorNMU = 6;
  con_DoorNML = 7;
  con_DoorPOC = 1;
  con_DoorPOO = 2;
  con_DoorPOT = 5;
  con_DoorPOD = 5;
  con_DoorPOU = 6;
  con_DoorPOL = 7;
  con_DoorNOC = 1;
  con_DoorNOO = 2;
  con_DoorNOT = 5;
  con_DoorNOD = 5;
  con_DoorNOU = 6;
  con_DoorNOL = 7;
  con_DoorPCC = 10;
  con_DoorPCO = 11;
  con_DoorPCT = 5;
  con_DoorPCD = 5;
  con_DoorPCU = 6;
  con_DoorPCL = 7;
  con_DoorNCC = 10;
  con_DoorNCO = 11;
  con_DoorNCT = 5;
  con_DoorNCD = 5;
  con_DoorNCU = 6;
  con_DoorNCL = 7;

type

TAccessResultCode = class(TComponent)
  private
    FAccessResultName: string;
    FAccessResultCode: string;
  public
    property AccessResultCode : string read FAccessResultCode write FAccessResultCode;
    property AccessResultName : string read FAccessResultName write FAccessResultName;
end;

TBuildingAreaCode = class(TComponent)
  private
    FBuildingAreaName: string;
    FBuildingAreaCode: string;
  public
    property BuildingAreaCode : string read FBuildingAreaCode write FBuildingAreaCode;
    property BuildingAreaName : string read FBuildingAreaName write FBuildingAreaName;
end;

TBuildingCode = class(TComponent)
  private
    BuildingAreaList : TStringList;
    FBuildingName: string;
    FBuildingCode: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure AddBuildingAreaCode(aCode,aName:string);
    function GetBuildingAreaName(aCode:string):string;
  public
    property BuildingCode : string read FBuildingCode write FBuildingCode;
    property BuildingName : string read FBuildingName write FBuildingName;
end;

TCard = class(TComponent)
  private
    FCardName: string;
    FCardNo: string;
  public
    property CardNo : string read FCardNo write FCardNo;
    property CardName : string read FCardName write FCardName;
end;

TLockMode = class(Tcomponent)
  private
    FLockModeName: string;
    FLockModeCode: string;    
  public
    property LockModeCode : string read FLockModeCode write FLockModeCode;
    property LockModeName : string read FLockModeName write FLockModeName;
end;

var
  G_bACMonitorEventSoundOnUse : Boolean; //출입 전용 모니터링 알람 발생
  G_bAlarmEventLengthUse : Boolean; //알람이벤트 처리시 가변 길이 사용
  G_bAlarmEventMessageUse : Boolean; //알람이벤트 발생시 메시지 박스 출력
  G_bAlarmEventSoundOnUse : Boolean; //알람이벤트 발생시 알람 사운드 사용
  G_bAlarmMonitoringUse : Boolean;   //알람 모니터링 사용 유무
//  G_bAlarmRefreshStart : Boolean;    //QUERY 타입에서 알람 리프레쉬 수행중인 동안 알람 발생 시키지 말자
  G_bApplicationTerminate : Boolean;
  G_bAttendDedicateDoorUse : Boolean;         //근태전용출입문 사용유무 사용시 근태 사용자를 해당 출입문에 모든 권한을 부여 한다.
  G_bBuildingMonitoringShow : Boolean; //모니터링시 빌딩 표시 유무
  G_bCardModeShow : Boolean; //카드운영모드 표시 유무
  G_bDataBaseAutoBackup : Boolean; //데이터베이스 자동 백업 사용 유무
  G_bCardAutoDownLoadUse : Boolean; //카드 자동 다운로드
  G_bCardPositionUse : Boolean; //카드 위치정보 사용유무
  G_bDebuging : Boolean = False;
  G_bDeviceCommLogSave : Boolean; //기기의 통신데이터 저장유무
  G_bDeviceServerUse : Boolean;  //기기가 서버 모드로 동작하는가?
  G_bDoorAccessEventSoundOnUse : Boolean; //미승인 출입 이벤트 발생시 알람발생
  G_bDoorColseModeUse : Boolean;  //출입문 폐쇄 모드 사용유무
  G_bDoorLongTimeOpenAlarmUse : Boolean; //장시간 열림 발생시 알람 발생
  G_bDoorLongTimeOpenAlarmEventUse : Boolean; //장시간 열림 발생시 이벤트 발생 - 데몬에서 처리
//  G_bDoorLongTimeOpenMessageUse : Boolean; //장시간 열림 발생시 알람 메시지
//  G_bDoorFireMessageView : Boolean; //화재시 메지지 박스 보이기
  G_bDoorFireRecoveryUse : Boolean; //화재복구 사용유무
  G_bDoorFireRelayUse : Boolean;    //화재시 타 시스템 연동 사용 유무
  G_bDoorLongTimeOpenEventUse : Boolean = False; //장시간 열림시 알람 이벤트 발생 유무
  G_bDoorOpenModeOpenStateUse : Boolean;  //개방모드시 출입문 열림 표시
  G_bExitButtonEventUse : Boolean;              //퇴실버튼 이력을 남길것인지 유무
  G_bFingerRelayUse : Boolean;       //지문 연동유무
  G_bFingerDeleteUse : Boolean = False; //지문 체크 해제시 지문 삭제
  G_bFireAlarmUse : Boolean = False; //화재발생시 알람 사용유무
  G_bFireDoorOpenUse : Boolean = False; //화재발생시 출입문 열림사용
//  G_bFireMessageUse : Boolean = False; //화재발생시 메시지 사용유무  화재알람 발생시에는 무조건 메시지 보여주자
  G_bFoodDupEvent : Boolean = True;     //식수이벤트 중복 허용
  G_bFoodDedicateDoorUse : Boolean;             //식수전용출입문 사용유무 사용시 식수 사용자를 해당 출입문에 모든 권한을 부여 한다.
  G_bFoodUse : Boolean;                 //식수사용유무
  G_bFTPCardDownLoading : Boolean;  //FTP Card DownLoading 한개씩만 다운로드 하자 부하 많이 먹음
  G_bFTPZeronServerUse : Boolean;
  G_bInOutCountUse : Boolean;       //재실보고서 사용 유무
  G_bIsMaster : Boolean;  //Master 유무
  G_bKeyCheck : Boolean;
  G_bKTDupCardReg : Boolean;    // KT 카드 발급시 두장 이상 카드 발급
  G_bMonitorIntroView : Boolean;  //모니터링 범례 표시
  G_bNodeFree : Boolean;          //노드 Free
  G_bTypeAccessUse : Boolean; //출입 사용유무
  G_bTypeAttendUse : Boolean; //근태 사용유무
  G_bTypeFoodUse : Boolean;   //식수 사용유무
  G_bTypePatrolUse : Boolean; //방범 사용유무
  G_bTypeSensorUse : Boolean; //센서 사용유무

  G_nACAMVersion : integer = 1;
  G_nAccessEventSearch : integer = 1; //0:버튼,퇴실 이벤트 조회,1:카드이벤트만 조회
  G_nAccessSoundCount : integer = 1;
  G_nAckSendType : integer;           //ACK 바로 전송(-1),First 전송(0)
  G_nAdminBuildingType : integer;     //0:빌딩,1:출입문단위
  G_nAdminCompanyGrade : integer;     //0.전체권한
  G_nAdminClassCodeLength : integer = 3;  //관리자 등급코드길이
  G_nAlarmEventLength : integer;      //방범 이벤트 카드 길이
  G_nAlarmRefreshDate : integer = 2;  //QUERY 타입의 알람 이벤트 조회시 2일전 데이터 까지만 조회 하자.
  G_nAlarmSoundCount : integer = 1;   //알람발생 횟수
  G_nAntiGroupCodeLength : integer = 3;
  G_nAntiFreeTimeUse : integer = 0;     //Anti Free 타임 사용유무
  G_nAntiLog : integer = 0;             //Anti Log 남김 유무
  G_nBMSType : integer = 2;        //2.출입,3.근태,4.식수
  G_nBuildingCodeLength : integer = 3;
  G_nBuildingStep : integer = 1;      //빌딩별 모니터링시 빌딩스텝 1:빌딩,2:층,3:구역
  G_nCardCreatePort : integer;         // 발급기 포트
  G_nCardDefaultArmPermitType : integer = 2;     //1.전체권한을 가지고 시작,2.전체권한 없이 시작
  G_nCardDefaultGroupType : integer = 1;     //1.회사별권한,2.그룹별권한,3.개인별권한
  G_nCardDefaultDOORPermitType : integer = 1;     //1.전체권한을 가지고 시작,2.전체권한 없이 시작
  G_nCardNoType : integer = 1;                //'0.4Byte,1.16BYTE,2.KT사옥'
  G_nCardRegisterPort : integer;   //등록기포트
  G_nCardRegisterType : integer;   //등록기종류 0.일반,1.슈프리마
  G_nCompanyCodeLength : integer = 3;
  G_nColorCompany : integer = clWhite;
  G_nColorEmGroup : integer = clSkyBlue;
  G_nColorEmployee : integer = clYellow;
  G_nDaemonGubun : integer;             //데몬구분 향후 n개의 데몬과 통합시
  G_nDaemonServerVersion : integer = 0; //통신데몬 버젼
  G_nDataBaseACEventdeleteDay :integer; //출입데이터 남기는 기간
  G_nDataBaseBackupCycle : integer; //데이터베이스 백업
  G_nDataBasePTEventdeleteDay :integer; //방범데이터 남기는 기간
  G_nDBTYPE : integer;
  G_nDebugMode : integer = 0;             //디버그 모드
  G_nDefaultArmAreaCount : integer = 8;  //초기생성 디폴트 방범구역 갯수
  G_nDefaultDoorCount : integer = 4;  //초기생성 디폴트 출입문 갯수
  G_nDefaultECUCount : integer = 63;
  G_nDefaultExtentionCount : integer = 8;  //초기생성 디폴트 컨트롤러확장기 갯수
  G_nDefaultReaderCount : integer = 8; //초기생성 디폴트 리더갯수
  G_nDefaultZoneCount : integer = 8; //초기생성 디폴트 존갯수
//  G_nDoorFireMessageTime : integer;  //화재시 메시지 박스 조회 시간
  G_nEncrypt : integer = 0; //0 : 암호화 안함,1:암호화 함
  G_nEmployeeSearchType : integer = 1;  //1.즉시검색,2이벤트발생시 검색(대용량)
  G_nEmployeeGroupLength : integer = 3; //사원그룹코드 길이
  G_nEmployeeRelayType : integer = 0; //0.미사용,1.충남
  G_nEnqTime : integer = 30;
  G_nFireRelayNumber : integer = 6; //화재복구시 릴레이 번호
  G_nFireRelayTime : integer = 2;    //화재복구시 릴레이 제어 시간(초)
  G_nFoodGradePosition : integer = 0; //식수권한점검 0:기기,1:서버
  G_nFormLanguageType : integer = 1;  //1.KOR,2.ENG,3.CHINA
  G_nFPMSLength : integer = 4;        //지문번호 길이
  G_nFontSize : integer;
  G_nFoodCodeLength : integer = 3;    //식수코드 길이
  G_nIDLength : integer = 7;          //컨트롤러 ID 길이
  G_nMaxComPort : integer = 40;
  G_nMultiDaemon : integer = 0;     //데몬동작형태 0: 데몬 단독 동작 1:멀티데몬(구현 안됨)
  G_nMultiSocket : integer = 0;
  G_nMonitorGubun : integer;        //모니터링 띄울때 타입
  G_nMoitorLoginStart : integer;    //로그인시 모니터링 화면 띄울지 유무  0 띄움,1 안띄움
  G_nMonitorMapBuilding : integer;      //0.빌딩맵포함,1.빌딩맵미포함
  G_nMonitorMapType : integer;      //0.알람이벤트,1.알람+출입이벤트
  G_nNodeCodeLength : integer = 3;
  G_nPCComType : integer = 0;        //0.TCPIP타입,1.DB타입
  G_nPersonRelayType : integer = 0; //가져오는 사원연동형태 0:연동안함,1:삼육대 연동,2:KT서초사옥,3:경희대 ,4:LOMOS,5:명지대
  G_nProgramGrade : integer = 1;    //0.권한 없는 경우 미입력,1.권한 없는 경우 입력
  G_nProgramType : integer = 0; //0 : KTTelecop,1:S-TEC,2:SKT
  G_nReportSearchType : integer = 1; // 보고서 조회시 1.바로검색,2.검색버튼 클릭시 조회
  G_nScheduleDevice : integer;    //스케줄 0:컨트롤러자체동작,1:PC스케줄
  G_nSocketReciveTime : integer = 100; //소켓 리딩 타임
  G_nSystmRelayCustomerNo : integer = 0;
  G_nSystmRelayCyle :integer = 5;  //연동주기
  G_nSystmRelayUse : integer = 0;  //0.연동미사용,1.연동사용

  G_stACAMVer : string; //ACamVersion
  G_stAccessEventAlaramFile : string; //출입알람파일
  G_stACMonitorAlaramFile : string; //출입전용 알람파일
  G_stACMonitorEventCode : string; //출입전용 모니터링에서 알람발생코드
  G_stAdminBuildingCode : string; //관리 위치코드
  G_stAdminCompanyCode : string; //관리 회사코드
  G_stAdminUserID : string; //관리자 로그인 아이디
  G_stAdminUserName : string; //관리자 명
  G_stAlarmEventAlaramFile : string; //알람이벤트 발생 파일
  G_stAlarmViewType : string; //REAL:실시간 알람,QUERY:DB Type
  G_stAntiFreeTime : string;   //AntiPassFree 시간
  G_stDaemonControlServerIP : string; //통신데몬 서버 IP
  G_stDaemonControlPort : string;
  G_stDaemonDeviceServerPort : string; //컨트롤러 서버 포트
  G_stDaemonEventPort : string;
  G_stDaemonFTPPort : string;
  G_stDaemonStatePort : string;
  G_stDataBaseBackupDir : string; //데이터베이스 자동 백업 디렉토리
  G_stDebugIP : string = '10.201.0.161';
  G_stDefaultRelayCode : string;   //디폴트 연동 코드
  G_stExeFolder : string;
  G_stEventDataDir : string;       //이벤트 로그 데이터 보관 장소
  G_stFileServerIP : string; //이미지 파일 서버
  G_stFileServerDir : string;
  G_stFireStateCode : string = 'FI';
  G_stFontName : string;
  G_stFoodDeviceType : string;  //DOOR/READER 구분
  G_stFormStyle : string;
  G_stGroupCode : string;
  G_stLogDirectory : string;
  G_stLongTimeStateCode : string;
  G_stMapBuildingAlarmEventIconFile : string;
  G_stMapBuildingArmModeIconFile : string;
  G_stMapBuildingDisArmModeIconFile : string;
  G_stMapBuildingNormalEventIconFile : string;
  G_stMenuCaption : string;
  G_stCardRegisterIP : string;//RawByteString; //등록기IP
  G_stSystmRelayDB1Type : string;
  G_stSystmRelayDB1IP : string;
  G_stSystmRelayDB1PORT : string;
  G_stSystmRelayDB1USERID : string;
  G_stSystmRelayDB1USERPW : string;
  G_stSystmRelayDB1NAME : string;
  G_stSystmRelayDB2Type : string;
  G_stSystmRelayDB2IP : string;
  G_stSystmRelayDB2PORT : string;
  G_stSystmRelayDB2USERID : string;
  G_stSystmRelayDB2USERPW : string;
  G_stSystmRelayDB2NAME : string;


  AccessResultCodeNameList : TStringList;
  BuildingCodeNameList : TStringList;
  CardNameList : TStringList;
  NodeList : TStringList;
  LockModeNameList : TStringList;

implementation

{ TBuildingCode }

procedure TBuildingCode.AddBuildingAreaCode(aCode, aName: string);
var
  nIndex : integer;
  oBuildingArea : TBuildingAreaCode;
begin
  nIndex := BuildingAreaList.IndexOf(aCode);
  if nIndex < 0 then
  begin
    oBuildingArea := TBuildingAreaCode.Create(nil);
    oBuildingArea.BuildingAreaCode := aCode;
    oBuildingArea.BuildingAreaName := aName;
    BuildingAreaList.AddObject(aCode,oBuildingArea);
  end else
  begin
    TBuildingAreaCode(BuildingAreaList.Objects[nIndex]).BuildingAreaCode := aCode;
    TBuildingAreaCode(BuildingAreaList.Objects[nIndex]).BuildingAreaName := aName;
  end;
end;

constructor TBuildingCode.Create(AOwner: TComponent);
begin
  inherited;
  BuildingAreaList := TStringList.Create;
end;

destructor TBuildingCode.Destroy;
var
  i : integer;
begin
  if BuildingAreaList.Count > 0 then
  begin
    for i  := BuildingAreaList.Count - 1 downto 0 do TBuildingAreaCode(BuildingAreaList.Objects[i]).Free;
    BuildingAreaList.Clear;
  end;
  BuildingAreaList.Free;
  inherited;
end;

function TBuildingCode.GetBuildingAreaName(aCode: string): string;
var
  nIndex : integer;
begin
  result := '';
  nIndex := BuildingAreaList.IndexOf(aCode);
  if nIndex < 0 then Exit;
  result := TBuildingAreaCode(BuildingAreaList.Objects[nIndex]).BuildingAreaName;    
end;

end.
