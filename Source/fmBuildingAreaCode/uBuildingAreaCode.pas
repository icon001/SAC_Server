﻿unit uBuildingAreaCode;

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
  TfmBuildingAreaCode = class(TfmASubForm)
    BodyPanel: TAdvSmoothPanel;
    lb_SearchName: TAdvSmoothLabel;
    ed_SearchName: TAdvEdit;
    sg_List: TAdvStringGrid;
    btn_Search: TAdvGlassButton;
    Add: TAdvSmoothPanel;
    lb_AddBuildingName: TAdvSmoothLabel;
    ed_BuildingAreaName: TAdvEdit;
    ed_BuildingCode: TAdvEdit;
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
    AdvSmoothLabel1: TAdvSmoothLabel;
    cmb_SearchBuilding: TAdvComboBox;
    AdvSmoothLabel2: TAdvSmoothLabel;
    cmb_AddBuilding: TAdvComboBox;
    ed_BuildingAreaCode: TAdvEdit;
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
    procedure ed_BuildingAreaNameKeyPress(Sender: TObject; var Key: Char);
    procedure cmb_SearchBuildingChange(Sender: TObject);
  private
    L_nPageListMaxCount : integer;
    L_nCheckCount : integer;
    L_nProgress : integer;
    L_stMenuID : string;
    L_stButtonCloseCaption : string;
    L_stButtonPreCaption : string;
    L_stAddCaption : string;
    L_stUpdateCaption : string;
    L_stWork : string;
    SearchBuildingCodeList : TStringList;
    AddBuildingCodeList : TStringList;
    { Private declarations }
    Function FormNameSetting:Boolean;
    Function SearchList(aCurrentCode:string;aTopRow:integer = 0):Boolean;
    Function AddBuildingAreaCode : Boolean;
    Function UpdateBuildingAreaCode : Boolean;
  private
    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);

  public
    { Public declarations }
    procedure FormChangeEvent(aFormName:integer);
  end;

var
  fmBuildingAreaCode: TfmBuildingAreaCode;

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
  uComboBoxCodeLoad,
  uFormVariable,
  uMain;
{$R *.dfm}

function TfmBuildingAreaCode.AddBuildingAreaCode: Boolean;
var
  stBuildingCode : string;
  stBuildingAreaCode : string;
  stMessage : string;
  i,j,k : integer;
  stDate : string;
begin
  inherited;
  result := False;
  if cmb_AddBuilding.ItemIndex > -1 then
    stBuildingCode := AddBuildingCodeList.Strings[cmb_AddBuilding.ItemIndex];
  stBuildingAreaCode := dmDBFunction.GetNextBuildingAreaCode(stBuildingCode);
  ed_BuildingCode.Text := stBuildingCode;
  ed_BuildingAreaCode.Text := stBuildingAreaCode;

  if Not dmDBInsert.InsertIntoTB_BUILDINGAREACODE_Value(stBuildingCode,stBuildingAreaCode,ed_BuildingAreaName.Text) then
  begin
    stMessage := stringReplace('저장 실패','$WORK',btn_Save.Caption,[rfReplaceAll]);
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;
  result := True;
end;


procedure TfmBuildingAreaCode.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;
end;

procedure TfmBuildingAreaCode.btn_AddClick(Sender: TObject);
begin
  inherited;
  pm_CodeAddClick(pm_CodeAdd);
end;

procedure TfmBuildingAreaCode.btn_CancelClick(Sender: TObject);
begin
  inherited;
  Add.Visible := False;
end;

procedure TfmBuildingAreaCode.btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmBuildingAreaCode.btn_DeleteClick(Sender: TObject);
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
        dmDBDelete.DeleteTB_BUILDINGAREACODE_Value(cells[3,i],cells[4,i]);
        Application.ProcessMessages;
      end;
    end;
  end;
  SearchList('');
end;

procedure TfmBuildingAreaCode.btn_minimizeClick(Sender: TObject);
begin
  inherited;
  windowState := wsNormal;
end;

procedure TfmBuildingAreaCode.btn_SaveClick(Sender: TObject);
var
  stMessage : string;
  i,j,k : integer;
  bResult : Boolean;
begin
  inherited;
  if cmb_AddBuilding.ItemIndex < 0 then
  begin
    showmessage('빌딩을 선택 하셔야 합니다.');
    Exit;
  end;
  if ed_BuildingAreaName.Text = '' then
  begin
    showmessage('출구명을 입력 하여 주세요.');
    Exit;
  end;

  btn_Add.Enabled := False;
  btn_Save.Enabled := False;
  pan_Progress.Visible := True;

  L_nProgress := 0;
  TimerProgress.Enabled := True;
  Lb_SaveMessage.Caption.Text := '데이터 저장중입니다.';
  if L_stWork = 'ADD' then bResult := AddBuildingAreaCode
  else if L_stWork = 'UPDATE' then bResult := UpdateBuildingAreaCode;

  TimerProgress.Enabled := False;

  if Not bResult then Exit;


  btn_Save.Enabled := True;
  btn_Add.Enabled := True;
  pan_Progress.Visible := False;
  Add.Visible := False;
  SearchList(ed_BuildingCode.Text + ed_BuildingAreaCode.Text,sg_List.TopRow);
  fmMain.FORMCHANGE(con_FormBuildingAreaCode,'TRUE');
end;

procedure TfmBuildingAreaCode.btn_SearchClick(Sender: TObject);
begin
  inherited;
  SearchList('');
end;

procedure TfmBuildingAreaCode.btn_UpdateClick(Sender: TObject);
begin
  inherited;
  sg_ListDblClick(sg_List);
end;

procedure TfmBuildingAreaCode.cmb_SearchBuildingChange(Sender: TObject);
begin
  inherited;
  SearchList('');
end;

procedure TfmBuildingAreaCode.CommandArrayCommandsTFORMNAMEExecute(Command: TCommand;
  Params: TStringList);
begin
  inherited;
  Caption := Params.Values['CAPTION'];

end;

procedure TfmBuildingAreaCode.CommandArrayCommandsTGRADEREFRESHExecute(
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

procedure TfmBuildingAreaCode.CommandArrayCommandsTMENUIDExecute(Command: TCommand;
  Params: TStringList);
begin
  inherited;
  L_stMenuID := Params.Values['ID'];
end;

procedure TfmBuildingAreaCode.ed_BuildingAreaNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = Char(VK_RETURN) then
  begin
    btn_SaveClick(btn_Save);
  end;

end;

procedure TfmBuildingAreaCode.ed_SearchNameChange(Sender: TObject);
begin
  inherited;
  SearchList('');
end;

procedure TfmBuildingAreaCode.FormChangeEvent(aFormName: integer);
var
  stOldData : string;
  nIndex : integer;
begin
  case aFormName of
    con_FormBuildingCode : begin
      if cmb_SearchBuilding.ItemIndex > -1 then
         stOldData := SearchBuildingCodeList.Strings[cmb_SearchBuilding.ItemIndex];
      dmComboBoxCodeLoad.LoadBuildingCode(SearchBuildingCodeList,TComboBox(cmb_SearchBuilding),True,'전체');
      nIndex := SearchBuildingCodeList.IndexOf(stOldData);
      cmb_SearchBuilding.ItemIndex := nIndex;

      stOldData := '';
      if cmb_AddBuilding.ItemIndex > -1 then
         stOldData := AddBuildingCodeList.Strings[cmb_AddBuilding.ItemIndex];
      dmComboBoxCodeLoad.LoadBuildingCode(AddBuildingCodeList,TComboBox(cmb_AddBuilding),False,'전체');
      nIndex := AddBuildingCodeList.IndexOf(stOldData);
      cmb_AddBuilding.ItemIndex := nIndex;
    end;
  end;
end;

procedure TfmBuildingAreaCode.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fmMain.FORMENABLE(con_FormBuildingAreaCode,'FALSE');

  SearchBuildingCodeList.Free;
  AddBuildingCodeList.Free;

  Action := caFree;
end;

procedure TfmBuildingAreaCode.FormCreate(Sender: TObject);
begin
  inherited;
  SearchBuildingCodeList := TStringList.Create;
  AddBuildingCodeList := TStringList.Create;

  L_nPageListMaxCount := 17;
  pan_Progress.Left := 10;
end;

function TfmBuildingAreaCode.FormNameSetting: Boolean;
begin

  AdvOfficePage1.Caption := '관리';
  L_stAddCaption := '추가';
  L_stUpdateCaption := '수정';

end;

procedure TfmBuildingAreaCode.FormResize(Sender: TObject);
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

procedure TfmBuildingAreaCode.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

  FormNameSetting;
//  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['NAME'] := inttostr(conFORMNODEADMIN);
//  self.FindSubForm('Main').FindCommand('FORMENABLE').Params.Values['VALUE'] := 'TRUE';
//  self.FindSubForm('Main').FindCommand('FORMENABLE').Execute;
  dmComboBoxCodeLoad.LoadBuildingCode(SearchBuildingCodeList,TComboBox(cmb_SearchBuilding),True,'전체');
  dmComboBoxCodeLoad.LoadBuildingCode(AddBuildingCodeList,TComboBox(cmb_AddBuilding),False,'');
  SearchList('');
  fmMain.FORMENABLE(con_FormBuildingAreaCode,'TRUE');
end;

procedure TfmBuildingAreaCode.pm_CodeAddClick(Sender: TObject);
begin
  inherited;
  if cmb_AddBuilding.Items.Count < 1 then
  begin
    showmessage('빌딩을 추가 하신 후 출구를 등록 하실 수 있습니다.');
    Exit;
  end;
  lb_WorkType.Caption := L_stAddCaption;
  Add.Visible := True;
  L_stWork := 'ADD';
  if cmb_SearchBuilding.ItemIndex > 0 then cmb_AddBuilding.ItemIndex := cmb_SearchBuilding.ItemIndex - 1
  else cmb_AddBuilding.ItemIndex := 0;
  cmb_AddBuilding.Enabled := True;
  ed_BuildingAreaName.Text := '';
  ed_BuildingAreaName.SetFocus;
end;

procedure TfmBuildingAreaCode.pm_UpdateCodeClick(Sender: TObject);
begin
  inherited;
  sg_ListDblClick(sg_List);
end;

function TfmBuildingAreaCode.SearchList(aCurrentCode:string;aTopRow:integer = 0): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
  stBuildingCode : string;
begin
  GridInit(sg_List,3,2,true);
  if cmb_SearchBuilding.ItemIndex > -1 then
    stBuildingCode := SearchBuildingCodeList.Strings[cmb_SearchBuilding.ItemIndex];
  stSql := dmDBSelect.SelectTB_BUILDINGAREACODE_Name(stBuildingCode,ed_SearchName.Text);
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
          cells[1,nRow] := FindField('BC_BUILDINGNAME').AsString;
          cells[2,nRow] := FindField('BC_BUILDINGAREANAME').AsString;
          cells[3,nRow] := FindField('BC_BUILDINGCODE').AsString;
          cells[4,nRow] := FindField('BC_BUILDINGAREACODE').AsString;
          if (cells[3,nRow] + cells[4,nRow])  = aCurrentCode then
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


procedure TfmBuildingAreaCode.sg_ListCheckBoxClick(Sender: TObject; ACol,
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

procedure TfmBuildingAreaCode.sg_ListDblClick(Sender: TObject);
var
  nIndex : integer;
begin
  inherited;
  L_stWork := 'UPDATE';
  with sg_List do
  begin
    if Not isDigit(cells[3,Row]) then Exit;
    if Not isDigit(cells[4,Row]) then Exit;

    ed_BuildingCode.Text := cells[3,Row];
    ed_BuildingAreaCode.Text := cells[4,Row];
    nIndex := AddBuildingCodeList.IndexOf(cells[3,Row]);
    cmb_AddBuilding.ItemIndex := nIndex;
    cmb_AddBuilding.Enabled := False;

    ed_BuildingAreaName.Text := cells[2,Row];
  end;
  lb_WorkType.Caption := L_stUpdateCaption;
  Add.Visible := True;
  ed_BuildingAreaName.SetFocus;
end;

procedure TfmBuildingAreaCode.TimerProgressTimer(Sender: TObject);
begin
  inherited;
  L_nProgress := L_nProgress + 1;
  if L_nProgress > 10 then L_nProgress := 0;

  AdvSmoothProgressBar1.Maximum := 10;
  AdvSmoothProgressBar1.Position := L_nProgress;

end;

function TfmBuildingAreaCode.UpdateBuildingAreaCode: Boolean;
var
  stBuildingCode : string;
  stBuildingAreaCode : string;
  stMessage : string;
  stDate : string;
begin
  inherited;
  result := False;
  stBuildingCode := ed_BuildingCode.Text;
  stBuildingAreaCode := ed_BuildingAreaCode.Text;

  if Not dmDBUpdate.UpdateTB_BUILDINGAREACODE_Name(stBuildingCode,stBuildingAreaCode,ed_BuildingAreaName.Text) then
  begin
    stMessage := stringReplace('저장 실패','$WORK',btn_Save.Caption,[rfReplaceAll]);
    Application.MessageBox(PChar(stMessage),'Error',MB_OK);
    Exit;
  end;
  result := True;
end;


initialization
  RegisterClass(TfmBuildingAreaCode);
Finalization
  UnRegisterClass(TfmBuildingAreaCode);

end.
