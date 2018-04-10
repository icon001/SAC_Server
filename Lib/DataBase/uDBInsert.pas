unit uDBInsert;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmDBInsert = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function InsertIntoTB_ACCESSEVENT_StringValue(aDate,aTime,aDoorSeq,aCardNo,aResultCode,aLockMode,aUserID,aInserTime,aCardType:string):String;
    Function InsertIntoTB_ACCESSEVENT_Value(aDate,aTime,aDoorSeq,aCardNo,aResultCode,aLockMode,aUserID,aInserTime,aCardType:string):Boolean;
    Function InsertIntoTB_ACCESSEVENTCODE_Value(aCode,aName:string):Boolean;
    Function InsertIntoTB_ADMIN_All(aUserID,aUserPw,aUserName,aMaster,aAdminClassCode,aCompanyCode,aBuildingCode,aBuildingType:string):Boolean;
    Function InsertIntoTB_BUILDINGAREACODE_Value(aBuildingCode,aBuildingAreaCode,aBuildingAreaName:string):Boolean;
    Function InsertIntoTB_BUILDINGCODE_Value(aBuildingCode,aBuildingName,aDongCode:string):Boolean;
    Function InsertIntoTB_BUILDINGFLOORCODE_Value(aFloorCode,aFloorName:string):Boolean;
    Function InsertIntoTB_CARD_Value(aCardNo,aCardState,aCardName,aCardGubun,aBuildingCode,aBuildingAreaCode,aBuildingFloorCode,aAddr,aGradeType,aGroupCode,aStartDate,aEndDate,aStartSend,aEndSend:string):Boolean;
    Function InsertIntoTB_CARDGROUPCODE_Value(aCode,aName:string):Boolean;
    Function InsertIntoTB_CARDGUBUNCODE_Value(aCode,aName:string):Boolean;
    Function InsertIntoTB_CARDPERMITGROUP_Value(aGroupCode,aDoorSeq,aPermit,aApply:string):Boolean;
    Function InsertIntoTB_CARDTYPE_Value(aCode,aValue:string):Boolean;
    Function InsertIntoTB_CONFIG_All(aCONFIGGROUP,aCONFIGCODE,aCONFIGVALUE:string;aDetail:string=''):Boolean;
    Function InsertIntoTB_DEVICE_Value(aDoorCode,aBuildingCode,aBuildingAreaCode,aBuildingFloorCode,aNodeIP,aNodePort,aReaderID,aDeviceName,aLockType,aLockMode,aLockTime,aSenserType,aSenserMode,aSenerTime:string):Boolean;
    Function InsertIntoTB_DEVICECARDNO_Value(aDeviceSeq,aCardNo,aPermit,aSend:string):Boolean;
    Function InsertIntoTB_DEVICETYPE_Value(aCode,aName:string):Boolean;
    Function InsertIntoTB_DOORCONTROLTYPE_Value(aCode,aName:string):Boolean;
    Function InsertIntoTB_DOORLOCKPORT_Value(aCode,aName:string):Boolean;
  end;

var
  dmDBInsert: TdmDBInsert;

implementation
uses
  uCommonFunction,
  uCommonVariable,
  uDataBase;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDBInsert }

function TdmDBInsert.InsertIntoTB_ACCESSEVENTCODE_Value(aCode,
  aName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_ACCESSEVENTCODE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' AE_EVENTCODE,';
  stSql := stSql + ' AE_EVENTCODENAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_ACCESSEVENT_StringValue(aDate, aTime,
  aDoorSeq, aCardNo, aResultCode, aLockMode, aUserID, aInserTime,
  aCardType: string): String;
var
  stSql : string;
begin

  stSql := 'Insert Into TB_ACCESSEVENT (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' AE_DATE,';
  stSql := stSql + ' AE_TIME, ';
  stSql := stSql + ' DE_SEQ, ';
  stSql := stSql + ' CA_CARDNO, ';
  stSql := stSql + ' AE_EVENTCODE, ';
  stSql := stSql + ' DE_LOCKMODE, ';
  stSql := stSql + ' AD_USERID, ';
  stSql := stSql + ' AE_INSERTTIME, ';
  stSql := stSql + ' CA_TYPE) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aDate + ''', ';
  stSql := stSql + '''' + aTime + ''', ';
  stSql := stSql + '' + aDoorSeq + ', ';
  stSql := stSql + '''' + aCardNo + ''', ';
  stSql := stSql + '''' + aResultCode + ''', ';
  stSql := stSql + '''' + aLockMode + ''', ';
  stSql := stSql + '''' + aUserID + ''', ';
  stSql := stSql + '''' + aInserTime + ''', ';
  stSql := stSql + '''' + aCardType + ''') ';

  result := stSql;
end;

function TdmDBInsert.InsertIntoTB_ACCESSEVENT_Value(aDate, aTime, aDoorSeq,
  aCardNo, aResultCode, aLockMode, aUserID, aInserTime,aCardType: string): Boolean;
var
  stSql : string;
begin

  stSql := 'Insert Into TB_ACCESSEVENT (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' AE_DATE,';
  stSql := stSql + ' AE_TIME, ';
  stSql := stSql + ' DE_SEQ, ';
  stSql := stSql + ' CA_CARDNO, ';
  stSql := stSql + ' AE_EVENTCODE, ';
  stSql := stSql + ' DE_LOCKMODE, ';
  stSql := stSql + ' AD_USERID, ';
  stSql := stSql + ' AE_INSERTTIME, ';
  stSql := stSql + ' CA_TYPE) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aDate + ''', ';
  stSql := stSql + '''' + aTime + ''', ';
  stSql := stSql + '' + aDoorSeq + ', ';
  stSql := stSql + '''' + aCardNo + ''', ';
  stSql := stSql + '''' + aResultCode + ''', ';
  stSql := stSql + '''' + aLockMode + ''', ';
  stSql := stSql + '''' + aUserID + ''', ';
  stSql := stSql + '''' + aInserTime + ''', ';
  stSql := stSql + '''' + aCardType + ''') ';

  result := dmDataBase.ProcessEventExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_ADMIN_All(aUserID, aUserPw, aUserName,
  aMaster, aAdminClassCode, aCompanyCode, aBuildingCode,
  aBuildingType: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_ADMIN (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' AD_USERID,';
  stSql := stSql + ' AD_USERPW, ';
  stSql := stSql + ' AD_USERNAME, ';
  stSql := stSql + ' AD_MASTER, ';
  stSql := stSql + ' AG_GRADECODE, ';
  stSql := stSql + ' CO_COMPANYCODE, ';
  stSql := stSql + ' BC_BUILDINGCODE, ';
  stSql := stSql + ' AD_BUILDINGTYPE) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aUserID + ''', ';
  stSql := stSql + '''' + aUserPw + ''', ';
  stSql := stSql + '''' + aUserName + ''', ';
  stSql := stSql + '''' + aMaster + ''', ';
  stSql := stSql + '''' + aAdminClassCode + ''', ';
  stSql := stSql + '''' + aCompanyCode + ''', ';
  stSql := stSql + '''' + aBuildingCode + ''', ';
  stSql := stSql + '''' + aBuildingType + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_BUILDINGAREACODE_Value(aBuildingCode,
  aBuildingAreaCode, aBuildingAreaName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_BUILDINGAREACODE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' BC_BUILDINGCODE,';
  stSql := stSql + ' BC_BUILDINGAREACODE,';
  stSql := stSql + ' BC_BUILDINGAREANAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '' + aBuildingCode + ', ';
  stSql := stSql + '' + aBuildingAreaCode + ', ';
  stSql := stSql + '''' + aBuildingAreaName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_BUILDINGCODE_Value(aBuildingCode,
  aBuildingName,aDongCode: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_BUILDINGCODE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' BC_BUILDINGCODE,';
  stSql := stSql + ' BC_DONGCODE,';
  stSql := stSql + ' BC_BUILDINGNAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '' + aBuildingCode + ', ';
  stSql := stSql + '''' + aDongCode + ''', ';
  stSql := stSql + '''' + aBuildingName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_BUILDINGFLOORCODE_Value(aFloorCode,
  aFloorName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_BUILDINGFLOORCODE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' BC_BUILDINGFLOORCODE,';
  stSql := stSql + ' BC_BUILDINGFLOORNAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '' + aFloorCode + ', ';
  stSql := stSql + '''' + aFloorName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_CARDGROUPCODE_Value(aCode,
  aName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_CARDGROUPCODE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' CA_GROUPCODE,';
  stSql := stSql + ' CA_GROUPCODENAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_CARDGUBUNCODE_Value(aCode,
  aName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_CARDGUBUNCODE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' CA_GUBUN,';
  stSql := stSql + ' CA_GUBUNNAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_CARDPERMITGROUP_Value(aGroupCode, aDoorSeq,
  aPermit, aApply: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_CARDPERMITGROUP (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' CA_GROUPCODE,';
  stSql := stSql + ' DE_SEQ,';
  stSql := stSql + ' CP_PERMIT,';
  stSql := stSql + ' CP_APPLY) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '' + aGroupCode + ', ';
  stSql := stSql + '' + aDoorSeq + ', ';
  stSql := stSql + '''' + aPermit + ''', ';
  stSql := stSql + '''' + aApply + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_CARDTYPE_Value(aCode,
  aValue: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_CARDTYPE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' CA_TYPE,';
  stSql := stSql + ' CA_TYPENAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aValue + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_CARD_Value(aCardNo, aCardState, aCardName,
  aCardGubun, aBuildingCode, aBuildingAreaCode, aBuildingFloorCode, aAddr,
  aGradeType, aGroupCode, aStartDate, aEndDate, aStartSend,
  aEndSend: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_CARD (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' CA_CARDNO,';
  stSql := stSql + ' CA_STATECODE,';
  stSql := stSql + ' CA_NAME,';
  stSql := stSql + ' CA_GUBUN,';
  stSql := stSql + ' BC_BUILDINGCODE,';
  stSql := stSql + ' BC_BUILDINGAREACODE,';
  stSql := stSql + ' BC_BUILDINGFLOORCODE,';
  stSql := stSql + ' CA_ADDR,';
  stSql := stSql + ' CA_GRADETYPE,';
  stSql := stSql + ' CA_GROUPCODE,';
  stSql := stSql + ' CA_STARTYMDHMS,';
  stSql := stSql + ' CA_ENDYMDHMS,';
  stSql := stSql + ' CA_STARTSEND,';
  stSql := stSql + ' CA_ENDSEND) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCardNo + ''', ';
  stSql := stSql + '''' + aCardState + ''', ';
  stSql := stSql + '''' + aCardName + ''', ';
  stSql := stSql + '' + aCardGubun + ', ';
  stSql := stSql + '' + aBuildingCode + ', ';
  stSql := stSql + '' + aBuildingAreaCode + ', ';
  stSql := stSql + '' + aBuildingFloorCode + ', ';
  stSql := stSql + '''' + aAddr + ''', ';
  stSql := stSql + '' + aGradeType + ', ';
  stSql := stSql + '' + aGroupCode + ', ';
  stSql := stSql + '''' + aStartDate + ''', ';
  stSql := stSql + '''' + aEndDate + ''', ';
  stSql := stSql + '''' + aStartSend + ''', ';
  stSql := stSql + '''' + aEndSend + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_CONFIG_All(aCONFIGGROUP, aCONFIGCODE,
  aCONFIGVALUE, aDetail: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_CONFIG (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' CO_CONFIGGROUP,';
  stSql := stSql + ' CO_CONFIGCODE,';
  stSql := stSql + ' CO_CONFIGVALUE,';
  stSql := stSql + ' CO_CONFIGDETAIL) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCONFIGGROUP + ''', ';
  stSql := stSql + '''' + aCONFIGCODE + ''', ';
  stSql := stSql + '''' + aCONFIGVALUE + ''',';
  stSql := stSql + '''' + aDetail + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_DEVICECARDNO_Value(aDeviceSeq, aCardNo,
  aPermit, aSend: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_DEVICECARDNO (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' DE_SEQ,';
  stSql := stSql + ' CA_CARDNO,';
  stSql := stSql + ' CP_PERMIT,';
  stSql := stSql + ' CA_SEND) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '' + aDeviceSeq + ', ';
  stSql := stSql + '''' + aCardNo + ''', ';
  stSql := stSql + '''' + aPermit + ''', ';
  stSql := stSql + '''' + aSend + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_DEVICETYPE_Value(aCode,
  aName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_DEVICETYPE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' DE_TYPE,';
  stSql := stSql + ' DE_TYPENAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_DEVICE_Value(aDoorCode, aBuildingCode,
  aBuildingAreaCode, aBuildingFloorCode, aNodeIP, aNodePort, aReaderID,
  aDeviceName,aLockType,aLockMode,aLockTime, aSenserType, aSenserMode, aSenerTime: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_DEVICE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' DE_SEQ,';
  stSql := stSql + ' DE_NODEIP,';
  stSql := stSql + ' DE_NODEPORT,';
  stSql := stSql + ' DE_READERID,';
  stSql := stSql + ' DE_DEVICENAME,';
  stSql := stSql + ' DE_LOCKTYPE,';
  stSql := stSql + ' DE_LOCKMODE,';
  stSql := stSql + ' DE_LOCKTIME,';
  stSql := stSql + ' DE_SENSERTYPE,';
  stSql := stSql + ' DE_SENSERMODE,';
  stSql := stSql + ' DE_SENSERTIME,';
  stSql := stSql + ' BC_BUILDINGCODE,';
  stSql := stSql + ' BC_BUILDINGAREACODE,';
  stSql := stSql + ' BC_BUILDINGFLOORCODE,';
  stSql := stSql + ' DE_SEND) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '' + aDoorCode + ', ';
  stSql := stSql + '''' + aNodeIP + ''', ';
  stSql := stSql + '' + aNodePort + ', ';
  stSql := stSql + '' + aReaderID + ', ';
  stSql := stSql + '''' + aDeviceName + ''', ';
  stSql := stSql + '''' + aLockType + ''', ';
  stSql := stSql + '''' + aLockMode + ''', ';
  stSql := stSql + '''' + aLockTime + ''', ';
  stSql := stSql + '''' + aSenserType + ''', ';
  stSql := stSql + '''' + aSenserMode + ''', ';
  stSql := stSql + '''' + aSenerTime + ''', ';
  stSql := stSql + '' + aBuildingCode + ', ';
  stSql := stSql + '' + aBuildingAreaCode + ', ';
  stSql := stSql + '' + aBuildingFloorCode + ', ';
  stSql := stSql + '''N'') ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBInsert.InsertIntoTB_DOORCONTROLTYPE_Value(aCode,
  aName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_DOORCONTROLTYPE (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' DE_LOCKTYPE,';
  stSql := stSql + ' DE_LOCKTYPENAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBInsert.InsertIntoTB_DOORLOCKPORT_Value(aCode,
  aName: string): Boolean;
var
  stSql : string;
begin
  stSql := 'Insert Into TB_DOORLOCKPORT (';
  stSql := stSql + ' GROUP_CODE,';
  stSql := stSql + ' DE_LOCKMODE,';
  stSql := stSql + ' DE_LOCKMODENAME) ';
  stSql := stSql + ' VALUES(';
  stSql := stSql + '''' + G_stGroupCode + ''', ';
  stSql := stSql + '''' + aCode + ''', ';
  stSql := stSql + '''' + aName + ''') ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

end.
