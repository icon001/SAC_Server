unit uDeviceVariable;

interface

uses  System.Classes;

const
  MAXNODERCVCOUNT = 100;

//DeviceType
const NONETYPE = '0';
      KTT811 = '1';
      KTT812 = '2';
      ICU100 = '3';
      ICU200 = '4';
      ACC100 = '5'; //출입전용
      SKT100 = '6'; //SK텔레콤

//CARDType
const
  NOTHINGTYPE = '0';
  AUTOKT811 = '1'; //무인국사
  COMMON811 = '2'; //범용
  KT811     = '3'; //KT사옥용
  UNIVER811 = '4'; //대학교용
  MERGECARD = '5'; //통합 16자리

//메인
const
    con_DelayTime = 5000;
    con_NODESOCKETDELAYTIME = 60;  //30초 인 경우 811G 가 시간 오버 되는 경우가 있는듯

//이벤트 명령어
const
    //컨트롤러
    con_DeviceCmdInfoInitialize = 0;
    con_DeviceCmdArmAreaCount = 1;
    con_DeviceCmdArmAreaSKill = 2;     //방범구역 기능 유무
    con_DeviceCmdArmAreaState = 3;     //방범구역 상태 조회시...
    con_DeviceCmdArmAreaUse = 4;
    con_DeviceCmdARMEXTENTIONGUBUN = 5;
    con_DeviceCmdARMEXTENTIONMAINFROMLOCAL = 6;
    con_DeviceCmdARMEXTENTIONMAINTOLOCAL = 7;
    con_DeviceCmdARMEXTENTIONSKILL = 8;
    con_DeviceCmdArmInDelay = 9;
    con_DeviceCmdArmOutDelay = 10;
    con_DeviceCmdArmRelay = 11;
    con_DeviceCmdCardReaderCount = 12;
    con_DeviceCmdCardReaderNetwork = 13;      //카드리더 통신체크
    con_DeviceCmdCardReaderType = 14;
    con_DeviceCmdDeviceCode = 15;
    con_DeviceCmdDeviceConnected = 16;
    con_DeviceCmdDeviceName = 17;
    con_DeviceCmdDeviceID = 18;
    con_DeviceCmdDeviceType = 19;
    con_DeviceCmdDeviceUSE = 20;              //컨트롤러 사용유무
    con_DeviceCmdDeviceVersion = 21;
    con_DeviceCmdDeviceDoor2RelayType = 22;
    con_DeviceCmdDeviceDoor2Skill = 23;
    con_DeviceCmdDeviceDoorArmArea = 24;
    con_DeviceCmdDoorCount = 25;
    con_DeviceCmdDoorScheduleSkill = 26;
    con_DeviceCmdDVRIP = 27;
    con_DeviceCmdDVRPORT = 28;
    con_DeivceCmdDVRSKILL = 29;
    con_DeivceCmdDVRUSE = 30;
    con_DeviceCmdEMZONELAMP = 31;
    con_DeviceCmdEMZONESIREN = 32;
    con_DeviceCmdExtentionNetwork = 33;     //존확장기 통신 체크
    con_DeviceCmdExtentionSkill = 34;       //존확장기 추가 가능 여부
    con_DeviceCmdExtentionUse = 35;
    con_DeviceCmdFTPCardDownLoadEnd = 36;   //FTP 카드 다운로드 완료
    con_DeviceCmdJaeJungDelaySkill = 37;
    con_DeviceCmdJaeJungDelayUse = 38;
    con_DeviceCmdJAVARAARMCLOSE = 39;
    con_DeviceCmdJAVARAAUTOCLOSE = 40;
    con_DeviceCmdJAVARADISARMOPEN = 41;
    con_DeviceCmdJAVARASERVERARMCLOSE = 42;
    con_DeviceCmdJAVARASERVERDISARMOPEN = 43;
    con_DeviceCmdJAVARATYPEUSE = 44;
    con_DeviceCmdKttCDMACHECKTIME = 45;
    con_DeviceCmdKttCDMADATA = 46;
    con_DeviceCmdKttCDMAIP = 47;
    con_DeviceCmdKTTCDMAMIN = 48;
    con_DeviceCmdKttCDMAMUX = 49;
    con_DeviceCmdKttCDMAPORT = 50;
    con_DeviceCmdKttCDMARSSI = 51;
    con_DeviceCmdKttCdmaUse = 52;
    con_DeviceCmdKTTREMOTEARMRINGCOUNT = 53;
    con_DeviceCmdKTTREMOTEDisARMRINGCOUNT = 54;
    con_DeviceCmdKTTSystemID = 55;
    con_DeviceCmdKTTTelNumber1 = 56;
    con_DeviceCmdKTTTelNumber2 = 57;
    con_DeviceCmdLAMPONTIME = 58;
    con_DeviceCmdNetworkState = 59;
    con_DeviceCmdSIRENONTIME = 60;
    con_DeviceCmdSystemInformation = 61;
    con_DeviceCmdTimeCodeSend = 62;
    con_DeviceCmdTimeCodeSkill = 63;
    con_DeviceCmdTimeCodeUse = 64;
    con_DeviceCmdType = 65;
    con_DeviceCmdUseState = 66;
    con_DeviceCmdVER = 67;
    con_DeviceCmdWATCHACPOWER = 68;
    con_DeviceCmdZoneExtentionCount = 69;
    con_DeviceControlTimeSync = 70;             //제어 시간동기화
    con_DeviceDoorStateRCV = 71;

    //노드
    con_NodeCmdDeviceCount = 81;
    con_NodeCmdDeviceRegState = 82;   //확장기 등록 상태
    con_NodeCmdEcuMaxCount = 83;

//출입문 이벤트
    con_DoorCmdInfoInitialize = 0;
    con_DoorCmdAntiNo = 1;
    con_DoorCmdAntiGROUPCODE = 2;
    con_DoorCmdArmArea = 3;
    con_DoorCmdArmAreaNo = 4;
    con_DoorCmdArmAreaUse = 5;
    con_DoorCmdARMDSCHECK = 6;
    con_DoorCmdCONTROLTIME = 10;
    con_DoorCmdDeadBoltDSCHECKTIME = 20;
    con_DoorCmdDeadBoltDSCHECKUSE = 21;
    con_DoorCmdDSOPENSTATE = 22;        //출입문열림상태 DS OPEN/CLOSE
    con_DoorCmdHOLIDAY = 30;              //공휴일 전송여부
    con_DoorCmdFIREDOOROPEN = 35;
    con_DoorCmdLOCKSTATE = 40;         //출입문상태전송
    con_DoorCmdLOCKTYPE = 41;
    con_DoorCmdLONGOPENALARM = 42;
    con_DoorCmdLONGOPENTIME = 43;
    con_DoorCmdName = 45;
    con_DoorCmdREMOTEDISARMDOOROPEN = 50;
    con_DoorCmdSCHEDULEDATA = 55;
    con_DoorCmdSCHEDULEUSE = 56;  //출입문 스케줄 사용유무
    con_DoorCmdSettingInfo = 57;
    con_DOORCmdSTATE = 58;
    con_DoorCmdTimeCodeUse = 60;
    con_DoorCmdType = 61;
    con_DoorCmdUse = 65;
    con_DoorCmdView = 70;
    con_DoorControlStateCheck = 80; //원격 출입문상태조회 컨트롤
    con_DoorCurrentDSState = 81; //현재 DS상태
    con_DoorCurrentCARDMode = 82; //현재 카드모드
    con_DoorCurrentManagerMode = 83; //현재 운영모드
    con_DoorCurrentRcvState = 84;  //현재 상태 수신 유무


//카드리더 이벤트
    con_CardReaderCmdInfoInitialize = 0;
    con_CardReaderCmdArmAreaNo = 1;
    con_CardReaderCmdBuildingPositionCode = 2;
    con_CardReaderCmdCallTime = 3; //
    con_CardReaderCmdDoorNo = 4;
    con_CardReaderCmdDoorPosition = 5;
    con_CardReaderCmdSettingInfo = 6;
    con_CardReaderCmdTelNumber0 = 7; //
    con_CardReaderCmdTelNumber1 = 8; //
    con_CardReaderCmdTelNumber2 = 9; //
    con_CardReaderCmdTelNumber3 = 10; //
    con_CardReaderCmdTelNumber4 = 11; //
    con_CardReaderCmdTelNumber5 = 12; //
    con_CardReaderCmdTelNumber6 = 13; //
    con_CardReaderCmdTelNumber7 = 14; //
    con_CardReaderCmdTelNumber8 = 15; //
    con_CardReaderCmdTelNumber9 = 16; //
    con_CardReaderCmdType = 17;
    con_CardReaderCmdUse = 18;
    con_CardReaderCmdVERSION = 19; //

//방범구역 이벤트
    con_ArmAreaCmdInfoInitialize = 0;
    con_ArmAreaCmdName = 1;
    con_ArmAreaCmdUse = 2;
    con_ArmAreaCmdView = 3;

//존확장기
    con_ExtentionCmdInfoInitialize = 0;
    con_ExtentionCmdName = 1;
    con_ExtentionCmdType = 2;
    con_ExtentionCmdZoneCount = 3;  //존 확장기별 존 갯수
    con_ExtentionCmdZoneInfoSetting = 4;
    con_ExtentionCmdZoneUse = 5;

//존
    con_ZoneCmdInfoInitialize = 0;
    con_ZoneCmdArmArea = 1;
    con_ZoneCmdAlarmEventType = 2;
    con_ZoneCmdDelayUse = 3;
    con_ZoneCmdEventStateCode = 4;
    con_ZoneCmdName = 5;
    con_ZoneCmdRecovery = 6;
    con_ZoneCmdSenseTime = 7;
    con_ZoneCmdSetting = 8;
    con_ZoneCmdType = 9;
    con_ZoneCmdUse = 10;


//노드서버 이벤트
    con_NodeServerCmdDeviceID = 1;

//기기타입
    con_DeviceTypeArmArea = 1;
    con_DeviceTypeDoor = 2;
    con_DeviceTypeCardReader = 3;
    con_DeviceTypeExtention = 4;  //존확장기
    con_DeviceTypeZone = 5;  //존

const
  con_cmdManagerToServerAccessEvent = 1;
  con_cmdManagerToServerACK = 2;
  con_cmdManagerToServerAlarmEvent = 3;
  con_cmdManagerToServerCardSend = 4;    //즉시전송
  con_cmdManagerToServerCardUpdate = 5;  //변경
  con_cmdManagerToServerDeviceHoliday = 10;        //공휴일 전송
  con_cmdManagerToServerDoorScheduleChange = 11;   //출입문스케줄 변경
  con_cmdManagerToServerDoorSettingRegist = 12;    //출입문 설정 정보 셋팅
  con_cmdManagerToServerDoorSettingSearch = 13;    //출입문 설정 정보 조회
  con_cmdManagerToServerDoorTimeCodeUseChange = 14; //출입문 타임코드 사용유무 변경
  con_cmdManagerToServerNodeChange = 20;        //노드 변경
  con_cmdManagerToServerReaderTelNumber = 30;  //카드리더전화번호변경
  con_cmdManagerToServerTimeDeviceCodeChange=40;   //타임코드 변경

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
  LINEEND = #13;  //클라이언트에서 한문장의 끝을 알리는 데이터값
  BROADSERVERPORT = 5001;
  BROADCLIENTPORT = 1460;
  TCPCLIENTPORT = 1461;

  DATADELIMITER = '^';

  WSAEWOULDBLOCK = 10035;  //비동기 에러 메시지

type
  TAlarmEventState = (aeNothing,aeNormal,aeNormalEvent,aeAlarmEvent);
  TCardReadingEvent = procedure(Sender: TObject;  aCardNo:string) of object;
  TConnectedState = (csNothing,csDisConnected,csConnected);
  TDoorManageMode = (dmNothing,dmManager,dmOpen,dmLock);   //운영/개방 모드 /폐쇄
  TDoorLockEvent = (deNothing,deLongTime,deFire,deOpenErr,deCloseErr); //출입문 에러 이벤트
  TDoorLockMode = (lsNothing,lsClose,lsOpen);              //잠김/열림 상태
  TDoorLockState = (dsNothing,dsPMO,dsPMC,dsPOO,dsPOC,dsPLO,dsPLC,dsNMO,dsNMC,dsNOO,dsNOC,dsNLO,dsNLC);        //열림/닫힘 상태
  TDoorOpenState = (doNothing,doClose,doOpen,doLongTime,doOpenErr,doCloseErr);        //열림/닫힘 상태
  TDoorPNMode = (pnNothing,pnPositive,pnNegative);   //Positive/Negative 상태
  TNodeConnectedState = (ncNothing,ncDisConnected,ncNodeConnected,ncAllConnected);
  TWatchMode = (cmNothing,cmArm, cmDisarm,cmPatrol,cmInit,cmTest,cmJaejung);

type

  TAntiPassEvent = procedure(Sender: TObject;  aNodeNo : integer;aECUID,aSubCmd,aAntiGroup,aData: string ) of object;
  TAlarmEvent = procedure(Sender: TObject;  aNodeNo,aECUID,aCmd,aMsgNo,aTime,aSubCLass,aSubAddr,aArmArea,aMode,aAlarmStateCode,aLoop,aZoneState,aOper,
                                            aAlarmStateCodeName,aAlarmStatePCCode,aAlarmStatePCCodeName,aArmModeChange,aAlarmView,aAlarmSound,aAlarmColor:string) of object;   //알람이벤트
  TArmAreaPacket = procedure(Sender: TObject;  aCmd,aNodeNo : integer;aEcuID,aExtendID,aNumber:string; aData:string) of object;
  TCardPermitLoading = procedure(Sender: TObject;aCardNo:string) of object;
  TCardPermitPacket = procedure(Sender: TObject;  aNodeNo : integer;aEcuID,aCardNo,aPermit,aDoorPermit,aArmAreaPermit,aTimeCodeUse,aTimeCodeGroup,aTimeData,aWeekCode:string) of object;
  TCardRcvPacket = procedure(Sender: TObject;  aNodeNo : integer;aEcuID,aCardNo,aRcvAck:string) of object;
  TCardReaderPacket = procedure(Sender: TObject;  aCmd,aNodeNo : integer;aEcuID,aExtendID,aNumber:string; aData:string) of object;
  TDeviceCardAccessEvent = procedure(Sender: TObject; aNodeNo,aECUID,aDoorNo,aReaderNo,aInOut,aTime,aCardMode,aDoorMode,aChangeState,aAccessResult,aDoorState,aATButton,aCardNo,aType,aArmAreaNo,aAntiGroup:string) of object;
  TDeviceConnect = procedure(Sender: TObject;  aSocketNo,aNodeNo : integer;aEcuID:string; aConnected:TConnectedState;aAntiGroupCode:string) of object;
  TDeviceNodeServerPacket = procedure(Sender: TObject;  aCmd,aWinSock,aNodeNo : integer;aLanIp,aEcuID:string; aData:string) of object;
  TDevicePacket = procedure(Sender: TObject;  aCmd,aNodeNo : integer;aEcuID:string; aData:string) of object;
  TDoorPacket = procedure(Sender: TObject;  aCmd,aNodeNo : integer;aEcuID,aExtendID,aNumber:string; aData:string) of object;
  TDoorStatePacket = procedure(Sender: TObject;  aNodeNo : integer;aEcuID,aExtendID,aNumber:string; aCardMode,aDoorMode,aDoorState,aLockState,aDoorFire:string) of object;
  TDeviceUsed = procedure(Sender: TObject;  aNodeNo : integer;aType:string;aEcuID,aExtendID,aNumber:string; aUsed:Boolean) of object;
  TNodePacket = procedure(Sender: TObject;aNodeNo : integer; aNodeName,aDeviceID,aCmd,aMsgNo,aDeviceVer,aData,aType:string) of object;
  TNotifyReceive = procedure(Sender: TObject;  aNodeNo : integer; aData: string ) of object;
  TReceiveTypeChange = procedure(Sender: TObject;  aNodeNo : integer;aType:string;aEcuID,aExtendID,aNumber:string;aRcvInfoType:integer; aData: string) of object;
  TZoneExtentionPacket = procedure(Sender: TObject;  aNodeNo : integer;aEcuID,aExtendID,aNumber:string; aData:string) of object;
  TZonePacket = procedure(Sender: TObject; aCmd, aNodeNo : integer;aEcuID,aExtendID,aNumber:string; aData:string) of object;

implementation

end.
