unit uComPort;

interface

uses
  System.SysUtils, System.Classes, CPort,
  uDeviceVariable;

type
  TdmComPort = class(TDataModule)
    ComPort1: TComPort;
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure ComPort1AfterOpen(Sender: TObject);
  private
    FOnCardReadEvent: TCardReadingEvent;
    FComPort: integer;
    FPortOpen: Boolean;
    L_stBuffer : string;
    { Private declarations }
    procedure CardDataReadingProcessing;
    procedure CardReaderFormatChange(aType:string);
    procedure SetComPort(const Value: integer);
    procedure SetPortOpen(const Value: Boolean);
  public
    { Public declarations }
    property SERIALPORT : integer read FComPort write SetComPort;
    property PortOpen : Boolean read FPortOpen write SetPortOpen;
  public
    ProPerty OnCardReadEvent : TCardReadingEvent read FOnCardReadEvent write FOnCardReadEvent;
  end;

var
  dmComPort: TdmComPort;

implementation

uses
  uCommonFunction,
  uCommonVariable;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmComPort.CardDataReadingProcessing;
var
  nIndex: Integer;
  aCardNo:String;
  bCardNo: int64;
  stMsg : string;
  stReaderType : string;
  stData : string;
begin
  nIndex:= Pos(ETX,L_stBuffer);
  if nIndex = 0 then Exit;
  stData := copy(L_stBuffer,1,nIndex);
  Delete(L_stBuffer,1,nIndex);

  //STX 삭제
  nIndex:= Pos(STX,stData);
  if nIndex > 0 then Delete(stData,1,nIndex);
  //ETX삭제
  nIndex:= Pos(ETX,stData);
  if nIndex > 0 then Delete(stData,nIndex,1);

  if stData = 'F' then    //포맷 요청
  begin
    stReaderType := 'C';
    CardReaderFormatChange(stReaderType);
    Exit;
  end;
  if (stData = 'Y') OR (stData = 'N') then Exit;

  aCardNo := stData;

  //aCardNo := FillCharString(aCardNo,'*',16,False);
  if Trim(aCardNo) <> '' then
  begin
    if Assigned(FOnCardReadEvent) then
    begin
      OnCardReadEvent(Self,aCardNo);
    end;

  end;
  nIndex:= Pos(ETX,L_stBuffer);
  if nIndex > 0 then CardDataReadingProcessing; //다음 ETX

end;

procedure TdmComPort.CardReaderFormatChange(aType: string);
begin
  if ComPort1.Connected then
     ComPort1.WriteStr(STX + aType + ETX);
end;

procedure TdmComPort.ComPort1AfterOpen(Sender: TObject);
var
  stType : string;
begin
  stType := 'C';
  CardReaderFormatChange(stType);
end;

procedure TdmComPort.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  stBuffer:string;
begin
  TComPort(Sender).ReadStr(stBuffer, Count);
  L_stBuffer := L_stBuffer + stBuffer;
  CardDataReadingProcessing;

end;

procedure TdmComPort.SetComPort(const Value: integer);
begin
  if FComPort = Value then Exit;
  FComPort := Value;
  ComPort1.Port := 'COM' + inttostr(Value);
  ComPort1.BaudRate := br9600;

end;

procedure TdmComPort.SetPortOpen(const Value: Boolean);
begin
  FPortOpen := Value;

  if Value then ComPort1.Open
  else ComPort1.Close;

end;

end.
