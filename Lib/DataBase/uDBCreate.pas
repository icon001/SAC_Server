unit uDBCreate;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmDBCreate = class(TDataModule)
  private
    { Private declarations }
  public
    Function AlterTB_ACCESSEVENT_CARDTYPE_ADD : Boolean;
  public
    { Public declarations }
    Function CreateTB_ACCESSEVENT:Boolean;
    Function CreateTB_ACCESSEVENTCODE:Boolean;
    Function CreateTB_ADMIN:Boolean;
    Function CreateTB_BUILDINGCODE:Boolean;
    Function CreateTB_BUILDINGAREACODE:Boolean;
    Function CreateTB_BUILDINGFLOORCODE:Boolean;
    Function CreateTB_CARD:Boolean;
    Function CreateTB_CARDGROUPCODE:Boolean;
    Function CreateTB_CARDGUBUNCODE:Boolean;
    Function CreateTB_CARDPERMITGROUP:Boolean;
    Function CreateTB_CARDTYPE:Boolean;
    Function CreateTB_CONFIG:Boolean;
    Function CreateTB_DEVICE:Boolean;
    Function CreateTB_DEVICECARDNO:Boolean;
    Function CreateTB_DEVICETYPE:Boolean;
    Function CreateTB_DOORCONTROLTYPE : Boolean;
    Function CreateTB_DOORLOCKPORT : Boolean;
  end;

var
  dmDBCreate: TdmDBCreate;

implementation

uses
  uDataBase,
  uCommonFunction,
  uCommonVariable;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDBCreate }

function TdmDBCreate.AlterTB_ACCESSEVENT_CARDTYPE_ADD: Boolean;
var
  stSql : string;
begin
  stSql := 'ALTER TABLE TB_ACCESSEVENT ADD CA_TYPE varchar(2) ';
  if G_nDBTYPE = MDB then
  begin
    stSql := 'ALTER TABLE TB_ACCESSEVENT ADD COLUMN CA_TYPE text(2) ';
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'CHAR','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessEventExecSQL(stSql);

end;

function TdmDBCreate.CreateTB_ACCESSEVENT: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_ACCESSEVENT (';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' AE_INSERTTIME varchar(17) NOT NULL,';
  stSql := stSql + ' DE_SEQ integer NOT NULL,';      //기기 코드 관리 순번
  stSql := stSql + ' CA_CARDNO varchar(30) NOT NULL,';
  stSql := stSql + ' AE_DATE varchar(8) ,';
  stSql := stSql + ' AE_TIME varchar(6) ,';
  stSql := stSql + ' AE_EVENTCODE char(2) ,'; //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  stSql := stSql + ' DE_LOCKMODE varchar(2) NULL,'; //락 포트 00:사용안함,21:강제열기,22:포트정상,23:강제닫기(폐쇄)
  stSql := stSql + ' AD_USERID varchar(30),';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,AE_INSERTTIME,DE_SEQ,CA_CARDNO) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessEventExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_ACCESSEVENTCODE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_ACCESSEVENTCODE (';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' AE_EVENTCODE char(2) ,'; //21.강제열림,22.정상,23.강제닫힘,10.정상출입,11.미등록카드,14.비밀번호출입
  stSql := stSql + ' AE_EVENTCODENAME varchar(100) ,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,AE_EVENTCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBCreate.CreateTB_ADMIN: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_ADMIN (';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' AD_USERID varchar(30) NOT NULL,';
  stSql := stSql + ' AD_USERPW varchar(30) ,';
  stSql := stSql + ' AD_USERNAME varchar(100),';
  stSql := stSql + ' AD_MASTER char(1),';
  stSql := stSql + ' AG_GRADECODE varchar(3),';
  stSql := stSql + ' CO_COMPANYCODE varchar(50) DEFAULT ''0'' NOT NULL,';
  stSql := stSql + ' BC_BUILDINGCODE varchar(50) DEFAULT ''0'' NOT NULL,';
  stSql := stSql + ' AD_BUILDINGTYPE char(1) DEFAULT ''1'' NOT NULL,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,AD_USERID) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_BUILDINGAREACODE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_BUILDINGAREACODE (';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' BC_BUILDINGCODE integer NOT NULL,';
  stSql := stSql + ' BC_BUILDINGAREACODE integer NOT NULL,';
  stSql := stSql + ' BC_BUILDINGAREANAME varchar(100),';
  stSql := stSql + ' BC_CODEUSE char(1),';
  stSql := stSql + ' BC_DEEPSEQ integer,';
  stSql := stSql + ' BC_VIEWSEQ integer,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,BC_BUILDINGCODE,BC_BUILDINGAREACODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_BUILDINGCODE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_BUILDINGCODE (';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' BC_BUILDINGCODE integer NOT NULL,';
  stSql := stSql + ' BC_BUILDINGNAME varchar(100),';
  stSql := stSql + ' BC_DONGCODE varchar(4) NULL,';
  stSql := stSql + ' BC_CODEUSE char(1),';
  stSql := stSql + ' BC_DEEPSEQ integer,';
  stSql := stSql + ' BC_VIEWSEQ integer,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,BC_BUILDINGCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_BUILDINGFLOORCODE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_BUILDINGFLOORCODE (';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' BC_BUILDINGFLOORCODE integer NOT NULL,';
  stSql := stSql + ' BC_BUILDINGFLOORNAME varchar(100),';
  stSql := stSql + ' BC_CODEUSE char(1),';
  stSql := stSql + ' BC_DEEPSEQ integer,';
  stSql := stSql + ' BC_VIEWSEQ integer,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,BC_BUILDINGFLOORCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_CARD: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_CARD (';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' CA_CARDNO varchar(30) NOT NULL,';
  stSql := stSql + ' CA_STATECODE char(1),';
  stSql := stSql + ' CA_NAME varchar(100),';
  stSql := stSql + ' CA_GUBUN integer,';   //카드구분,입주자,관리사무소,경비실
  stSql := stSql + ' BC_BUILDINGCODE integer,'; //동코드
  stSql := stSql + ' BC_BUILDINGAREACODE integer,';     //출구코드
  stSql := stSql + ' BC_BUILDINGFLOORCODE integer,';     //층 코드
  stSql := stSql + ' CA_ADDR varchar(100),';     //호수
  stSql := stSql + ' CA_GRADETYPE integer DEFAULT 0,';  //0.개인별 권한,1.그룹별권한
  stSql := stSql + ' CA_GROUPCODE integer DEFAULT 0,';  //
  stSql := stSql + ' CA_STARTYMDHMS varchar(14),';     //유효기간 시작
  stSql := stSql + ' CA_ENDYMDHMS varchar(14),';     //유효기간 종료
  stSql := stSql + ' CA_STARTSEND varchar(1),';     //시작 적용유무
  stSql := stSql + ' CA_ENDSEND varchar(1),';     //종료 적용유무
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,CA_CARDNO) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_CARDGROUPCODE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_CARDGROUPCODE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' CA_GROUPCODE integer NOT NULL,';
  stSql := stSql + ' CA_GROUPCODENAME varchar(100),';
  stSql := stSql + ' CA_VIEWSEQ integer DEFAULT 1 NOT NULL,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,CA_GROUPCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'image','OLEObject',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'image','oid',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_CARDGUBUNCODE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_CARDGUBUNCODE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' CA_GUBUN integer NOT NULL,';
  stSql := stSql + ' CA_GUBUNNAME varchar(100),';
  stSql := stSql + ' CA_VIEWSEQ integer DEFAULT 1 NOT NULL,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,CA_GUBUN) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'image','OLEObject',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'image','oid',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_CARDPERMITGROUP: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_CARDPERMITGROUP(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' CA_GROUPCODE integer NOT NULL,';
  stSql := stSql + ' DE_SEQ integer NOT NULL,';      //기기 코드 관리 순번
  stSql := stSql + ' CP_PERMIT char(1) ,';
  stSql := stSql + ' CP_APPLY char(1),';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,CA_GROUPCODE,DE_SEQ) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_CARDTYPE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_CARDTYPE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' CA_TYPE varchar(2) NOT NULL,';
  stSql := stSql + ' CA_TYPENAME varchar(100) NULL,';      //기기 코드 관리 순번
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,CA_TYPE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_CONFIG: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_CONFIG(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' CO_CONFIGGROUP varchar(20) NOT NULL,';
  stSql := stSql + ' CO_CONFIGCODE varchar(30) NOT NULL,';
  stSql := stSql + ' CO_CONFIGVALUE varchar(50),';
  stSql := stSql + ' CO_CONFIGDETAIL varchar(100),';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,CO_CONFIGGROUP,CO_CONFIGCODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_DEVICE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_DEVICE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' DE_SEQ integer NOT NULL,';      //기기 코드 관리 순번
  stSql := stSql + ' DE_NODEIP varchar(30) NULL,'; //기기 아이피
  stSql := stSql + ' DE_NODEPORT integer NULL,'; //기기 포트
  stSql := stSql + ' DE_DEVICEID integer NULL,'; //기기 아이디
  stSql := stSql + ' DE_DEVICENAME varchar(100) NULL,'; //기기 명
  stSql := stSql + ' DE_LOCKTYPE varchar(2) NULL,'; //접점타입 01 : Normal Open 02 : Normal Close
  stSql := stSql + ' DE_LOCKMODE varchar(2) NULL,'; //락 포트 00:사용안함,21:강제열기,22:포트정상,23:강제닫기(폐쇄)
  stSql := stSql + ' DE_LOCKTIME varchar(2) NULL,'; //락 제어 시간 초단위 01~0F
  stSql := stSql + ' DE_READERID integer NULL,'; //리더 번호
  stSql := stSql + ' DE_SENSERTYPE varchar(2) NULL,'; //센서타입 00:사용안함,01:사용
  stSql := stSql + ' DE_SENSERMODE varchar(2) NULL,'; //센서모드 01 : Normal Open(Default) 02 : Normal Close
  stSql := stSql + ' DE_SENSERTIME varchar(4) NULL,'; //센서시간 0000 ~ 9999(단위100ms)
  stSql := stSql + ' DE_TYPE varchar(2) NULL,'; //01:로비폰,10:독립형
  stSql := stSql + ' DE_VER varchar(2) NULL,';  //
  stSql := stSql + ' BC_BUILDINGCODE integer NULL,';
  stSql := stSql + ' BC_BUILDINGAREACODE integer NULL,';
  stSql := stSql + ' BC_BUILDINGFLOORCODE integer NULL,';
  stSql := stSql + ' DE_SEND char(1) NULL,';    //설정정보 전송유무
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,DE_SEQ) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_DEVICECARDNO: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_DEVICECARDNO(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' DE_SEQ integer NOT NULL,';      //기기 코드 관리 순번
  stSql := stSql + ' CA_CARDNO varchar(30) NOT NULL,';
  stSql := stSql + ' CP_PERMIT char(1) NOT NULL,';  //0.삭제,1.등록
  stSql := stSql + ' CA_SEND char(1) NULL,';  //'N'.미전송,'R'.준비,'S'.전송중,'Y'.전송완료
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,DE_SEQ,CA_CARDNO) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_DEVICETYPE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_DEVICETYPE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' DE_TYPE varchar(2) NOT NULL,'; //01:로비폰,10:독립형
  stSql := stSql + ' DE_TYPENAME varchar(100) NULL,';  //
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,DE_TYPE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_DOORCONTROLTYPE: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_DOORCONTROLTYPE(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' DE_LOCKTYPE varchar(2) NOT NULL,';      //접점타입 01 : Normal Open 02 : Normal Close
  stSql := stSql + ' DE_LOCKTYPENAME varchar(100) NULL,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,DE_LOCKTYPE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBCreate.CreateTB_DOORLOCKPORT: Boolean;
var
  stSql : string;
begin
  stSql := 'Create Table TB_DOORLOCKPORT(';
  stSql := stSql + ' GROUP_CODE varchar(10) DEFAULT ''1234567890'' NOT NULL,';
  stSql := stSql + ' DE_LOCKMODE varchar(2) NOT NULL,'; //락 포트 00:사용안함,21:강제열기,22:포트정상,23:강제닫기(폐쇄)
  stSql := stSql + ' DE_LOCKMODENAME varchar(100) NULL,';
  stSql := stSql + ' PRIMARY KEY (GROUP_CODE,DE_LOCKMODE) ';
  stSql := stSql + ' ) ';

  if G_nDBTYPE = MDB then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','COUNTER',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varchar','text',[rfReplaceAll]);
    stSql := StringReplace(stSql,'char','text',[rfReplaceAll]);
  end else if G_nDBTYPE = POSTGRESQL then
  begin
    stSql := StringReplace(stSql,'int IDENTITY','serial',[rfReplaceAll]);
  end else if G_nDBTYPE = FireBird then
  begin
    stSql := StringReplace(stSql,'image','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'varbinary(MAX)','BLOB',[rfReplaceAll]);
    stSql := StringReplace(stSql,'int IDENTITY','integer',[rfReplaceAll]);
  end;
  result := dmDataBase.ProcessExecSQL(stSql);
end;


end.
