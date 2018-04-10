unit uDBDelete;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmDBDelete = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Function DeleteTB_ADMIN_UserID(aUserID:string):Boolean;
    Function DeleteTB_BUILDINGAREACODE_Value(aBuildingCode,aBuildingAreaCode:string):Boolean;
    Function DeleteTB_BUILDINGCODE_Value(aBuildingCode:string):Boolean;
    Function DeleteTB_BUILDINGFLOORCODE_Value(aFloorCode:string):Boolean;
    Function DeleteTB_CARD_Value(aCardNo:string):Boolean;
    Function DeleteTB_CARDGUBUNCODE_Value(aCode:string):Boolean;
    Function DeleteTB_CARDGROUPCODE_Value(aCode:string):Boolean;
    Function DeleteTB_DEVICECARD_Device(aDoorSeq:string):Boolean;
    Function DeleteTB_DEVICECARD_DeviceCardNo(aDoorSeq,aCardNo:string):Boolean;
    Function DeleteTB_DEVICECARD_CARDNO(aCardNo:string):Boolean;
    Function DeleteTB_DEVICE_Value(aDoorSeq:string):Boolean;
  end;

var
  dmDBDelete: TdmDBDelete;

implementation

uses
  uDataBase;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDBDelete }

function TdmDBDelete.DeleteTB_ADMIN_UserID(aUserID: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_ADMIN ';
  stSql := stSql + ' Where AD_USERID = ''' + aUserID + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

end;

function TdmDBDelete.DeleteTB_BUILDINGAREACODE_Value(aBuildingCode,
  aBuildingAreaCode: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_BUILDINGAREACODE ';
  stSql := stSql + ' Where BC_BUILDINGCODE = ' + aBuildingCode + ' ';
  stSql := stSql + ' AND BC_BUILDINGAREACODE = ' + aBuildingAreaCode + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_BUILDINGCODE_Value(
  aBuildingCode: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_BUILDINGCODE ';
  stSql := stSql + ' Where BC_BUILDINGCODE = ' + aBuildingCode + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_BUILDINGFLOORCODE_Value(
  aFloorCode: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_BUILDINGFLOORCODE ';
  stSql := stSql + ' Where BC_BUILDINGFLOORCODE = ' + aFloorCode + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_CARDGROUPCODE_Value(aCode: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_CARDGROUPCODE ';
  stSql := stSql + ' Where CA_GROUPCODE = ' + aCode + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_CARDGUBUNCODE_Value(aCode: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_CARDGUBUNCODE ';
  stSql := stSql + ' Where CA_GUBUN = ' + aCode + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_CARD_Value(aCardNo: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_CARD ';
  stSql := stSql + ' Where CA_CARDNO = ''' + aCardNo + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_DEVICECARD_CARDNO(aCardNo: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_DEVICECARDNO ';
  stSql := stSql + ' Where CA_CARDNO = ''' + aCardNo + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_DEVICECARD_Device(aDoorSeq: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_DEVICECARDNO ';
  stSql := stSql + ' Where DE_SEQ = ' + aDoorSeq + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_DEVICECARD_DeviceCardNo(aDoorSeq,
  aCardNo: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_DEVICECARDNO ';
  stSql := stSql + ' Where DE_SEQ = ' + aDoorSeq + ' ';
  stSql := stSql + ' AND CA_CARDNO = ''' + aCardNo + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

function TdmDBDelete.DeleteTB_DEVICE_Value(aDoorSeq: string): Boolean;
var
  stSql : string;
begin
  stSql := ' Delete From TB_DEVICE ';
  stSql := stSql + ' Where DE_SEQ = ' + aDoorSeq + ' ';

  result := dmDataBase.ProcessExecSQL(stSql);
end;

end.
