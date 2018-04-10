unit uFloorCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uSubForm, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, CommandArray, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  Vcl.StdCtrls, AdvEdit, Vcl.Buttons, AdvSmoothLabel, AdvSmoothPanel, W7Classes,
  W7Panels, AdvGlassButton,ADODB,ActiveX, frmshape, Vcl.Mask, AdvSpin,
  DBAdvSmoothLabel, AdvSmoothProgressBar, Vcl.ExtCtrls, AdvCombo, AdvGlowButton,
  AdvOfficePager, Vcl.Imaging.pngimage, Vcl.Menus, AdvOfficePagerStylers,
  AdvAppStyler;

type
  TfmFloorCode = class(TfmASubForm)
    BodyPanel: TAdvSmoothPanel;
    lb_SearchName: TAdvSmoothLabel;
    ed_SearchName: TAdvEdit;
    sg_List: TAdvStringGrid;
    btn_Search: TAdvGlassButton;
    Add: TAdvSmoothPanel;
    lb_AddBuildingName: TAdvSmoothLabel;
    ed_FloorName: TAdvEdit;
    ed_FloorCode: TAdvEdit;
    TimerProgress: TTimer;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePage1: TAdvOfficePage;
    btn_minimize: TAdvGlowButton;
    btn_Close: TAdvGlowButton;
    lb_List: TLabel;
    btn_Add: TAdvGlowButton;
    btn_Update: TAdvGlowButton;
    btn_Delete: TAdvGlowButton;
    pm_Work: TPopupMenu;
    pm_CodeAdd: TMenuItem;
    pm_UpdateCode: TMenuItem;
    pm_DeleteCode: TMenuItem;
    lb_WorkType: TLabel;
    btn_Save: TAdvGlowButton;
    btn_Cancel: TAdvGlowButton;
    AdvFormStyler1: TAdvFormStyler;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    pan_Progress: TPanel;
    Lb_SaveMessage: TDBAdvSmoothLabel;
    AdvSmoothProgressBar1: TAdvSmoothProgressBar;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_AddClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sg_ListCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure sg_ListDblClick(Sender: TObject);
    procedure ed_SearchNameChange(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure CommandArrayCommandsTGRADEREFRESHExecute(Command: TCommand;
      Params: TStringList);
    procedure CommandArrayCommandsTMENUIDExecute(Command: TCommand;
      Params: TStringList);
    procedure TimerProgressTimer(Sender: TObject);
    procedure CommandArrayCommandsTFORMNAMEExecute(Command: TCommand;
      Params: TStringList);
    procedure pm_CodeAddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure pm_UpdateCodeClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_minimizeClick(Sender: TObject);
    procedure ed_FloorNameKeyPress(Sender: TObject; var Key: Char);
  private
    L_nPageListMaxCount : integer;
    L_nCheckCount : integer;
    L_nProgress : integer;
    L_stMenuID : string;
    L_stButtonCloseCaption : string;
    L_stButtonPreCaption : string;
    L_stNodeAddCaption : string;
    L_stNodeUpdateCaption : string;
    L_stWork : string;
    FireGroupCodeList : TStringList;
    NodeDeviceTypeCodeList : TStringList;
    { Private declarations }
    Function FormNameSetting:Boolean;
    Function SearchList(aCurrentCode:string;aTopRow:integer = 0):Boolean;
    Function AddFloorCode : Boolean;
    Function UpdateFloorCode : Boolean;
  private
    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);

  public
    { Public declarations }
    procedure FormChangeEvent(aFormName:integer);
  end;

var
  fmFloorCode: TfmFloorCode;

implementation
uses
  uCommonFunction,
  uCommonVariable,
  uDataBase,
  uDBDelete,
  uDBFunction,
  uDBInsert,
  uDBUpdate,
  uDBSelect,
  uDBVariable,
  uComboBoxCodeLoad;
{$R *.dfm}

function TfmFloorCode.AddFloorCode: Boolean;
var
  stFloorCode : string;
  stMessage : string;
  i,j,k : integer;
  stDate : string;
  stDeviceID : string;
begin
  inherited;
  result := False;
  stFloorCode := dmDBFunction.GetNextBuildingFloorCode;
  ed_FloorCode.Text := stFloorCode;

  if Not dmDBInsert.InsertIntoTB_BUILDINGFLOORCODE_Value(stFloorCode,ed_FloorName.Text) then
  begin
    stMessage := stringReplace('저장 실패','$WORK',btn_Save.Caption,[rfReplaceAll]);
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;
  result := True;
end;

procedure TfmFloorCode.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;
end;

procedure TfmFloorCode.btn_AddClick(Sender: TObject);
begin
  inherited;
  pm_CodeAddClick(pm_CodeAdd);
end;

procedure TfmFloorCode.btn_CancelClick(Sender: TObject);
begin
  inherited;
  Add.Visible := False;
end;

procedure TfmFloorCode.btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmFloorCode.btn_DeleteClick(Sender: TObject);
var
  i : integer;
  bChkState : Boolean;
  stMessage : string;
  stClientIP : string;
  stTime : string;
begin
  inherited;
  stClientIP:= GetLocalIPAddr;
  stTime := FormatDateTime('yyyymmddhhnnsszzz',now);
  stMessage := stringReplace('삭제할 데이터를 선택하세요','$WORK',btn_Delete.Caption,[rfReplaceAll]);
  if L_nCheckCount = 0 then
  begin
    Application.MessageBox(PChar(stMessage),'Information',MB_OK);
    Exit;
  end;
  stMessage := stringReplace('$COUNT건의 데이터를 $WORK 하시겠습니까?','$WORK',btn_Delete.Caption,[rfReplaceAll]);
  stMessage := stringReplace(stMessage,'$COUNT',inttostr(L_nCheckCount),[rfReplaceAll]);
  if (Application.MessageBox(PChar(stMessage),'Information',MB_OKCANCEL) = IDCANCEL)  then Exit;
  stMessage := stringReplace('정말 삭제 하시겠습니까?','$WORK',btn_Delete.Caption,[rfReplaceAll]);
  if (Application.MessageBox(PChar(stMessage),'Information',MB_OKCANCEL) = IDCANCEL)  then Exit;
  With sg_List do
  begin
    for i := 1 to RowCount - 1 do
    begin
      GetCheckBoxState(0,i, bChkState);
      if bChkState then
      begin
        dmDBDelete.DeleteTB_BUILDINGFLOORCODE_Value(cells[1,i]);
        Application.ProcessMessages;
      end;
    end;
  end;
  SearchList('');
end;

procedure TfmFloorCode.btn_minimizeClick(Sender: TObject);
begin
  inherited;
  windowState := wsNormal;
end;

procedure TfmFloorCode.btn_SaveClick(Sender: TObject);
var
  stMessage : string;
  i,j,k : integer;
  bResult : Boolean;
begin
  inherited;
  if ed_FloorName.Text = '' then
  begin
    showmessage('사용자구분명칭을 입력 하여 주세요.');
    Exit;
  end;

  btn_Add.Enabled := False;
  btn_Save.Enabled := False;
  pan_Progress.Visible := True;

  L_nProgress := 0;
  TimerProgress.Enabled := True;
  Lb_SaveMessage.Caption.Text := '데이터 저장중입니다.';
  if L_stWork = 'ADD' then bResult := AddFloorCode
  else if L_stWork = 'UPDATE' then bResult := UpdateFloorCode;

  TimerProgress.Enabled := False;

  if Not bResult then Exit;


  btn_Save.Enabled := True;
  btn_Add.Enabled := True;
  pan_Progress.Visible := False;
  Add.Visible := False;
  SearchList(ed_FloorCode.Text,sg_List.TopRow);
end;

procedure TfmFloorCode.btn_SearchClick(Sender: TObject);
begin
  inherited;
  SearchList('');
end;

procedure TfmFloorCode.btn_UpdateClick(Sender: TObject);
begin
  inherited;
  sg_ListDblClick(sg_List);
end;

procedure TfmFloorCode.CommandArrayCommandsTFORMNAMEExecute(Command: TCommand;
  Params: TStringList);
begin
  inherited;
  Caption := Params.Values['CAPTION'];

end;

procedure TfmFloorCode.CommandArrayCommandsTGRADEREFRESHExecute(
  Command: TCommand; Params: TStringList);
begin
  inherited;
(*  btn_Add.Enabled := IsInsertGrade;
  pm_CodeAdd.Enabled := IsInsertGrade;
  btn_Delete.Enabled := IsDeleteGrade;
  pm_DeleteCode.Enabled := IsDeleteGrade;
  btn_Update.Enabled
*)
end;

procedure TfmFloorCode.CommandArrayCommandsTMENUIDExecute(Command: TCommand;
  Params: TStringList);
begin
  inherited;
  L_stMenuID := Params.Values['ID'];
end;

procedure TfmFloorCode.ed_FloorNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = Char(VK_RETURN) then
  begin
    btn_SaveClick(btn_Save);
  end;

end;

procedure TfmFloorCode.ed_SearchNameChange(Sender: TObject);
begin
  inherited;
  SearchList('');
end;

procedure TfmFloorCode.FormChangeEvent(aFormName: integer);
begin
//  case aFormName of
//  end;
end;

procedure TfmFloorCode.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  NodeDeviceTypeCodeList.Free;
  FireGroupCodeList.Free;
  Action := caFree;
end;

procedure TfmFloorCode.FormCreate(Sender: TObject);
begin
  inherited;
  FireGroupCodeList := TStringList.Create;
  NodeDeviceTypeCodeList := TStringList.Create;

  L_nPageListMaxCount := 17;
  pan_Progress.Left := 10;
end;

function TfmFloorCode.FormNameSetting: Boolean;
begin

  AdvOfficePage1.Caption := '관리';
  L_stNodeAddCaption := '추가';
  L_stNodeUpdateCaption := '수정';

end;

procedure TfmFloorCode.FormResize(Sender: TObject);
begin
  inherited;
  btn_Close.Left := AdvOfficePager1.Width - btn_Close.Width - 10;
  btn_minimize.Left := btn_Close.Left - btn_minimize.Width - 2;

  if Windowstate = wsMaximized then
  begin
    btn_minimize.Visible := True;
    btn_Close.Visible := True;
  end else
  begin
    btn_minimize.Visible := False;
    btn_Close.Visible := False;
  end;

  sg_List.Left := 10;
  sg_List.Width := BodyPanel.Width - (sg_List.Left * 2);
  sg_List.Height := BodyPanel.Height - (sg_List.Top + 10);
  sg_List.ColWidths[2] := sg_List.Width - (sg_List.ColWidths[0] + sg_List.ColWidths[1] );

  Add.Left := (BodyPanel.Width div 2) - (Add.Width div 2);
  Add.Top := (BodyPanel.Height div 2) - (Add.Height div 2);

end;

procedure TfmFloorCode.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

  FormNameSetting;
//  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(conFORMNODEADMIN);
//  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
//  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;
  SearchList('');
end;

procedure TfmFloorCode.pm_CodeAddClick(Sender: TObject);
begin
  inherited;
  lb_WorkType.Caption := L_stNodeAddCaption;
  Add.Visible := True;
  L_stWork := 'ADD';
  ed_FloorName.Text := '';
  ed_FloorName.SetFocus;
end;

procedure TfmFloorCode.pm_UpdateCodeClick(Sender: TObject);
begin
  inherited;
  sg_ListDblClick(sg_List);
end;

function TfmFloorCode.SearchList(aCurrentCode:string;aTopRow:integer = 0): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
begin
  GridInit(sg_List,3,2,true);
  stSql := dmDBSelect.SelectTB_BUILDINGFLOORCODE_Name(ed_SearchName.Text);
  L_nCheckCount := 0;

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
      with sg_List do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('BC_BUILDINGFLOORCODE').AsString;
          cells[2,nRow] := FindField('BC_BUILDINGFLOORNAME').AsString;
          if cells[1,nRow] = aCurrentCode then
          begin
            SelectRows(nRow,1);
          end;

          nRow := nRow + 1;
          Next;
        end;
        if aTopRow = 0 then
        begin
          if Row > (L_nPageListMaxCount - 1) then TopRow := Row - L_nPageListMaxCount;
        end else
        begin
          TopRow := aTopRow;
        end;
      end;

    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;


procedure TfmFloorCode.sg_ListCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nCheckCount := L_nCheckCount + 1
    else L_nCheckCount := L_nCheckCount - 1 ;
  end;
  if L_nCheckCount = 0 then  btn_Delete.Enabled := False
  else btn_Delete.Enabled := True;
end;

procedure TfmFloorCode.sg_ListDblClick(Sender: TObject);
var
  nIndex : integer;
begin
  inherited;
  L_stWork := 'UPDATE';
  with sg_List do
  begin
    if Not isDigit(cells[1,Row]) then Exit;
    ed_FloorName.Text := cells[1,Row];
    ed_FloorName.Text := cells[2,Row];
  end;
  lb_WorkType.Caption := L_stNodeUpdateCaption;
  Add.Visible := True;
  ed_FloorName.SetFocus;
end;

procedure TfmFloorCode.TimerProgressTimer(Sender: TObject);
begin
  inherited;
  L_nProgress := L_nProgress + 1;
  if L_nProgress > 10 then L_nProgress := 0;

  AdvSmoothProgressBar1.Maximum := 10;
  AdvSmoothProgressBar1.Position := L_nProgress;

end;


function TfmFloorCode.UpdateFloorCode: Boolean;
var
  stFloorCode : string;
  stMessage : string;
  stDate : string;
begin
  inherited;
  result := False;
  stFloorCode := ed_FloorCode.Text;

  if Not dmDBUpdate.UpdateTB_BUILDINGFLOORCODE_Name(stFloorCode,ed_FloorName.Text) then
  begin
    stMessage := stringReplace('저장 실패','$WORK',btn_Save.Caption,[rfReplaceAll]);
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;
  result := True;
end;

initialization
  RegisterClass(TfmFloorCode);
Finalization
  UnRegisterClass(TfmFloorCode);

end.
