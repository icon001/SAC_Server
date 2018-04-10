unit uClientConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,  ComCtrls, DB, ADODB,WinSpool, ExtCtrls,ActiveX, uSubForm, CommandArray,
  System.IniFiles, AdvPanel, FindFile, AdvCombo, Vcl.MPlayer, AdvToolBar,
  AdvToolBarStylers, AdvOfficeTabSet, AdvOfficeTabSetStylers, AdvOfficeButtons,
  AdvAppStyler,AdvStyleIF, Vcl.Imaging.pngimage, AdvGlowButton, AdvGroupBox;

type
  TfmClientConfig = class(TfmASubForm)
    RzOpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    fdmsADOQuery: TADOQuery;
    tab_regPort: TTabSheet;
    lb_cardPort: TLabel;
    cmb_Comport: TComboBox;
    FindFile: TFindFile;
    MediaPlayer1: TMediaPlayer;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvFormStyler1: TAdvFormStyler;
    btn_Save: TAdvGlowButton;
    btn_Close: TAdvGlowButton;
    Label1: TLabel;
    ed_ENQTime: TEdit;
    Label2: TLabel;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    L_bActive : Boolean;
    ComPortList : TStringList;
    { Private declarations }
    function GetSerialPortList(List : TStringList; const doOpenTest : Boolean = True) : LongWord;
    function EncodeCommportName(PortNum : WORD) : String;
    function DecodeCommportName(PortName : String) : WORD;

    procedure FontSetting;
    procedure FormNameSetting;
  public
    { Public declarations }
  end;

var
  fmClientConfig: TfmClientConfig;

implementation
uses
  uCommonFunction,
  uCommonVariable,
  uFormVariable,
  uMain;

{$R *.dfm}


procedure TfmClientConfig.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmClientConfig.btn_SaveClick(Sender: TObject);
var
  nComPort : integer;
  stWorkStartTime : string;
  stWorkEndTime : string;
  chkBox : TCheckBox;
  i : integer;
  ini_fun : TiniFile;
  nCount : integer;
begin
  nComPort := 0;
  Try
    ini_fun := TiniFile.Create(G_stExeFolder + '\SAC.INI');
    with ini_fun do
    begin
      if ComPortList.Count > 0 then
      begin
        if cmb_ComPort.ItemIndex > -1 then
        begin
          if cmb_ComPort.ItemIndex = 0 then nComPort := 0
          else
          begin
            nComPort := Integer(ComPortList.Objects[cmb_ComPort.ItemIndex - 1]);
          end;
          WriteInteger('Config','CardRegPort',nComPort);
          G_nCardRegisterPort := nComPort;
        end;
      end;
      if isDigit(ed_ENQTime.Text) then
      begin
        G_nEnqTime := strtoint(ed_ENQTime.Text);
        WriteInteger('Config','ENQTime',G_nEnqTime);
      end;
    end;
  Finally
    ini_fun.free;
  End;
  Close;
end;

procedure TfmClientConfig.FormCreate(Sender: TObject);
var
  nCount : integer;
  i : integer;
  stComPort : string;
  nIndex : integer;
  chkBox : TCheckBox;
  ini_fun : TiniFile;
begin
  ComPortList := TStringList.Create;
  nCount := GetSerialPortList(ComPortList,False);
  cmb_ComPort.Clear;
  cmb_ComPort.Items.add('Not Use');
  cmb_ComPort.ItemIndex := -1;
  if nCount = 0 then
  begin
    Exit;
  end;

  for i:= 0 to nCount - 1 do
  begin
    cmb_ComPort.items.Add(ComPortList.Strings[i])
  end;
  if G_nCardRegisterPort > 0 then
  begin
    stComPort := EncodeCommportName(G_nCardRegisterPort);
    nIndex := cmb_ComPort.Items.IndexOf(stComPort);
    if nIndex > -1 then cmb_ComPort.ItemIndex := nIndex;
  end else
    cmb_ComPort.ItemIndex := 0;

  ed_ENQTime.Text := inttostr(G_nEnqTime);
  FontSetting;
end;

procedure TfmClientConfig.FormNameSetting;
begin
end;

procedure TfmClientConfig.FontSetting;
begin

end;

procedure TfmClientConfig.FormActivate(Sender: TObject);
begin
  inherited;
  if L_bActive then Exit;
  L_bActive := True;

end;

procedure TfmClientConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ComPortList.Free;
end;

function TfmClientConfig.DecodeCommportName(PortName: String): WORD;
var
 Pt : Integer;
begin
 PortName := UpperCase(PortName);
 if (Copy(PortName, 1, 3) = 'COM') then begin
    Delete(PortName, 1, 3);
    Pt := Pos(':', PortName);
    if Pt = 0 then Result := 0
       else Result := StrToInt(Copy(PortName, 1, Pt-1));
 end
 else if (Copy(PortName, 1, 7) = '\\.\COM') then begin
    Delete(PortName, 1, 7);
    Result := StrToInt(PortName);
 end
 else Result := 0;

end;

function TfmClientConfig.EncodeCommportName(PortNum: WORD): String;
begin
 if PortNum < 10
    then Result := 'COM' + IntToStr(PortNum) + ':'
    else Result := '\\.\COM'+IntToStr(PortNum);

end;

function TfmClientConfig.GetSerialPortList(List: TStringList;
  const doOpenTest: Boolean): LongWord;
type
 TArrayPORT_INFO_1 = array[0..0] Of PORT_INFO_1;
 PArrayPORT_INFO_1 = ^TArrayPORT_INFO_1;
var
{$IF USE_ENUMPORTS_API}
 PL : PArrayPORT_INFO_1;
 TotalSize, ReturnCount : LongWord;
 Buf : String;
 CommNum : WORD;
{$IFEND}
 I : LongWord;
 CHandle : THandle;
begin
 List.Clear;
{$IF USE_ENUMPORTS_API}
 EnumPorts(nil, 1, nil, 0, TotalSize, ReturnCount);
 if TotalSize < 1 then begin
    Result := 0;
    Exit;
    end;
 GetMem(PL, TotalSize);
 EnumPorts(nil, 1, PL, TotalSize, TotalSize, Result);

 if Result < 1 then begin
    FreeMem(PL);
    Exit;
    end;

 for I:=0 to Result-1 do begin
    Buf := UpperCase(PL^[I].pName);
    CommNum := DecodeCommportName(PL^[I].pName);
    if CommNum = 0 then Continue;
    List.AddObject(EncodeCommportName(CommNum), Pointer(CommNum));
    end;
{$ELSE}
 for I:=1 to 255 do List.AddObject(EncodeCommportName(I), Pointer(I));
{$IFEND}
 // Open Test
 if List.Count > 0 then for I := List.Count-1 downto 0 do begin
    CHandle := CreateFile(PChar(List[I]), GENERIC_WRITE or GENERIC_READ,
     0, nil, OPEN_EXISTING,
     FILE_ATTRIBUTE_NORMAL,
     0);
    if CHandle = INVALID_HANDLE_VALUE then begin
if doOpenTest or (GetLastError() <> ERROR_ACCESS_DENIED) then List.Delete(I);
Continue;
end;
    CloseHandle(CHandle);
    end;

 Result := List.Count;
{$IF USE_ENUMPORTS_API}
 if Assigned(PL) then FreeMem(PL);
{$IFEND}

end;


end.
