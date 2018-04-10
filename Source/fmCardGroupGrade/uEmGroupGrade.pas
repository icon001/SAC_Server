﻿unit uEmGroupGrade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uSubForm, CommandArray, AdvGlassButton,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.StdCtrls, AdvEdit, AdvSmoothLabel,
  AdvSmoothPanel, AdvOfficeTabSet, W7Classes, W7Panels,ActiveX,ADODB,
  Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls, AdvSmoothTabPager, Vcl.ImgList,
  AdvSplitter, AdvOfficeTabSetStylers, AdvToolBar, AdvToolBarStylers,
  AdvGlowButton, AdvOfficePager, AdvAppStyler, AdvOfficePagerStylers,
  Vcl.Imaging.pngimage;

const
  con_LocalCompanyImageIndex = 0;
  con_LocalEmployeeImageIndex = 1;
  con_LocalBuildingImageIndex = 2;
  con_LocalGroupImageIndex = 3;

type
  TfmEmGroupGrade = class(TfmASubForm)
    BodyPanel: TW7Panel;
    List: TAdvSmoothPanel;
    tv_EmGroupList: TTreeView;
    tv_EmGroupCode: TTreeView;
    pm_Work: TPopupMenu;
    pm_EmGroupGrade: TMenuItem;
    pan_emPermitAdmin: TAdvSmoothPanel;
    tv_buildingCode: TTreeView;
    MenuImageList16: TImageList;
    pm_ParentEmGroupGrade: TMenuItem;
    N2: TMenuItem;
    AdvSplitter1: TAdvSplitter;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePage1: TAdvOfficePage;
    btn_minimize: TAdvGlowButton;
    btn_Close: TAdvGlowButton;
    lb_List: TLabel;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvFormStyler1: TAdvFormStyler;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    lb_EmployeeList: TLabel;
    lb_EmGradePositionName: TAdvSmoothLabel;
    ed_SelectBuildingName: TAdvEdit;
    lb_EmGradeName: TAdvSmoothLabel;
    ed_GradeEmGroupName: TAdvEdit;
    ed_GradeEmGroupCode: TAdvEdit;
    ed_SelectBuildingCode: TAdvEdit;
    btn_emGradeComplete: TAdvGlassButton;
    tp_Grade: TPageControl;
    tab_Doorgrade: TTabSheet;
    pan_NotPermitDoor: TAdvSmoothPanel;
    pan_NotPermitDoorCount: TAdvSmoothPanel;
    sg_NotPermitDoor: TAdvStringGrid;
    pan_PermitAction: TAdvSmoothPanel;
    pan_PermitDoor: TAdvSmoothPanel;
    pan_DoorPermitCount: TAdvSmoothPanel;
    sg_PermitDoor: TAdvStringGrid;
    tab_ArmAreagrade: TTabSheet;
    pan_NotPermitAlarmArea: TAdvSmoothPanel;
    AdvSmoothPanel5: TAdvSmoothPanel;
    sg_NotPermitAlarm: TAdvStringGrid;
    AdvSmoothPanel6: TAdvSmoothPanel;
    pan_PermitAlarmArea: TAdvSmoothPanel;
    AdvSmoothPanel8: TAdvSmoothPanel;
    sg_PermitAlarm: TAdvStringGrid;
    btn_BuildingNameSelect: TAdvGlowButton;
    tv_buildingName: TTreeView;
    lb_NotDoorPermit: TLabel;
    lb_PermitDoor: TLabel;
    lb_NotPermitAlarmArea: TLabel;
    lb_PermitAlarmArea: TLabel;
    btn_PermitDoorAdd: TAdvGlowButton;
    btn_PermitDoorDelete: TAdvGlowButton;
    btn_PermitArmAreaDelete: TAdvGlowButton;
    btn_PermitArmAreaAdd: TAdvGlowButton;
    lb_DoorNotPermitCountName: TAdvSmoothLabel;
    lb_Count1: TAdvSmoothLabel;
    lb_NotPermitDoorCount: TAdvSmoothLabel;
    lb_DoorPermitCountName: TAdvSmoothLabel;
    lb_PermitDoorCount: TAdvSmoothLabel;
    lb_Count2: TAdvSmoothLabel;
    lb_ArmAreaNotPermitCountName: TAdvSmoothLabel;
    lb_NotPermitArmAreaCount: TAdvSmoothLabel;
    lb_Count3: TAdvSmoothLabel;
    lb_ArmAreaPermitCountName: TAdvSmoothLabel;
    lb_PermitArmAreaCount: TAdvSmoothLabel;
    lb_Count4: TAdvSmoothLabel;
    pan_progress: TAdvSmoothPanel;
    lb_ProgressCount: TAdvSmoothLabel;
    ProgressBar1: TProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tv_EmGroupListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tv_EmGroupListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btn_emGradeCompleteClick(Sender: TObject);
    procedure tv_buildingNameDblClick(Sender: TObject);
    procedure btn_BuildingNameSelectClick(Sender: TObject);
    procedure sg_NotPermitDoorCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure sg_PermitDoorCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure sg_NotPermitAlarmCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure sg_PermitAlarmCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure btn_PermitDoorAddClick(Sender: TObject);
    procedure btn_PermitArmAreaAddClick(Sender: TObject);
    procedure btn_PermitArmAreaDeleteClick(Sender: TObject);
    procedure btn_PermitDoorDeleteClick(Sender: TObject);
    procedure pm_ParentEmGroupGradeClick(Sender: TObject);
    procedure ListResize(Sender: TObject);
    procedure pan_emPermitAdminResize(Sender: TObject);
    procedure tp_GradeResize(Sender: TObject);
    procedure pm_EmGroupGradeClick(Sender: TObject);
    procedure btn_minimizeClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
  private
    BuildingArmAreaCodeList : TStringList; //빌딩별 방범구역 코드 리스트를 가지고 있자.
    BuildingDoorCodeList : TStringList; //빌딩별 출입문 코드 리스트를 가지고 있자.
    GradeArmAreaCodeList : TStringList;
    GradeDoorCodeList : TStringList;
    NotGradeArmAreaCodeList : TStringList; //방범권한이 없는 방범리스트
    NotGradeDoorCodeList : TStringList;  //출입권한이 없는 리스트
    L_nPermitArmAreaCheckCount : integer;           //삭제시 방범구역 선택 갯수
    L_nNotPermitArmAreaCheckCount : integer;        //등록시 방범구역 선택 갯수
    L_nPermitDoorCheckCount : integer;           //삭제시 출입문 선택 갯수
    L_nNotPermitDoorCheckCount : integer;        //등록시 출입문 선택 갯수
    L_stMenuID : string;
    L_stButtonCloseCaption : string;
    L_stWork : string;
  private
    procedure EmGroupGradeToEmployeeGrade;
    Function EmGroupGradeToEmployeeEachApply(aEmGroupCode:string):Boolean;

    procedure LoadBuildingAlarmAll(aBuildingCode:string;sgList:TAdvStringGrid); //전체 출입문을 리스트에 추가 하자
    procedure LoadBuildingDoorAll(aBuildingCode:string;sgList:TAdvStringGrid); //전체 출입문을 리스트에 추가 하자
    procedure LoadPermitAlarm(aBuildingCode,aEmGroupCode:string);
    procedure LoadPermitEmGroupArmArea(aBuildingCode,aEmGroupCode:string);
    procedure LoadPermitEmGroupDoor(aBuildingCode,aEmGroupCode:string);
    procedure LoadPermitDoor(aBuildingCode,aEmGroupCode:string);

    procedure NotPermitArmAreaListAdd(aArmAreaName,aNodeNo,aEcuID,aExtendID,aArmAreaNo,aArmAreaCode,aArmAreaView:string);
    procedure NotPermitArmAreaListDelete(aArmAreaCode:string);
    procedure NotPermitDoorListAdd(aDoorName,aNodeNo,aEcuID,aExtendID,aDoorNo,aDoorCode,aDoorView:string);
    procedure NotPermitDoorListDelete(aDoorCode:string);

    procedure PermitArmAreaListAdd(aArmAreaName,aNodeNo,aEcuID,aExtendID,aArmAreaNo,aArmAreaCode,aArmAreaView:string);
    procedure PermitArmAreaListDelete(aArmAreaCode:string);
    procedure PermitDoorListAdd(aDoorName,aNodeNo,aEcuID,aExtendID,aDoorNo,aDoorCode,aDoorView:string);
    procedure PermitDoorListDelete(aDoorCode:string);

    procedure FormNameSetting;
    procedure FontSetting;
    procedure SearchList(aCode:string);
    function ChangeEmGroupCode(aOrgCode,aCode,aDeepSeq,aViewSeq:string):Boolean;
    procedure AdvStrinGridSetAllCheck(Sender: TObject;bchkState:Boolean);
    { Private declarations }
  public
    { Public declarations }
    procedure Form_Close;
    procedure FormChangeEvent(aNumber:integer);
    procedure FormGradeRefresh;
    procedure FormIDSetting(aID:string);
  end;

var
  fmEmGroupGrade: TfmEmGroupGrade;

implementation
uses
  uComboBoxCodeLoad,
  uCommonFunction,
  uCommonVariable,
  uFormFunction,
  uFormVariable,
  uDataBase,
  uDBCardPermit,
  uDBDelete,
  uDBVariable,
  uDBFormMessage,
  uDBFunction,
  uDBInsert,
  uDBSelect,
  uDBUpdate,
  uFormUtil,
  uMain;
{$R *.dfm}

procedure TfmEmGroupGrade.AdvStrinGridSetAllCheck(Sender: TObject;
  bchkState: Boolean);
var
  i : integer;
begin
    for i:= 1 to (Sender as TAdvStringGrid).RowCount - 1  do
    begin
      (Sender as TAdvStringGrid).SetCheckBoxState(0,i,bchkState);
    end;
end;

procedure TfmEmGroupGrade.btn_BuildingNameSelectClick(Sender: TObject);
begin
  inherited;
  tv_buildingName.Visible := Not tv_buildingName.Visible;
  tv_buildingName.Left := btn_BuildingNameSelect.Left;
  tv_buildingName.Top := btn_BuildingNameSelect.Top + btn_BuildingNameSelect.Height;
end;

procedure TfmEmGroupGrade.btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmEmGroupGrade.btn_emGradeCompleteClick(Sender: TObject);
begin
  inherited;
  pan_emPermitAdmin.Visible := False;
end;

procedure TfmEmGroupGrade.btn_minimizeClick(Sender: TObject);
begin
  inherited;
  windowState := wsNormal;
end;

procedure TfmEmGroupGrade.btn_PermitArmAreaAddClick(Sender: TObject);
var
  stMessage : string;
  i : integer;
  bCheckState : Boolean;
  stTime : string;
  stClientIP : string;
begin
  inherited;
  stClientIP:= GetLocalIPAddr;
  stTime := FormatDateTime('yyyymmddhhnnsszzz',now);

  stMessage := stringReplace(dmFormMessage.GetMessage('NOTSELECTDATA'),'$WORK',btn_PermitArmAreaAdd.Caption,[rfReplaceAll]);
  if L_nNotPermitArmAreaCheckCount = 0 then
  begin
    Application.MessageBox(PChar(stMessage),'Information',MB_OK);
    Exit;
  end;
  Try
    tv_EmGroupList.Enabled := False;
    btn_Close.Enabled := False;
    pan_progress.Visible := True;
    with sg_NotPermitAlarm do
    begin
      ProgressBar1.Max := RowCount - 1;
      ProgressBar1.Position := 0;
      for i := RowCount - 1 downto 1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        GetCheckBoxState(0,i, bCheckState);
        if bCheckState then
        begin
          dmDBCardPermit.EmGroupArmAreaPermitAdd(ed_GradeEmGroupCode.Text,Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i]);
          dmDBInsert.InsertIntoTB_SYSTEMLOG_All(copy(stTime,1,8),copy(stTime,9,6),stClientIP,G_stAdminUserID,Cells[2,i],Cells[3,i],'G' + ed_GradeEmGroupCode.Text,Cells[5,i],con_ComLogTYPE_ARMAREA,L_stMenuID + '(' + Caption + '):Permit Add');

          PermitArmAreaListAdd(Cells[1,i],Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i],Cells[6,i],Cells[7,i]);
          NotPermitArmAreaListDelete(Cells[6,i]);
        end;
        lb_ProgressCount.Caption.Text := inttostr(ProgressBar1.Position) + '/' + inttostr(ProgressBar1.Max);
        application.ProcessMessages;
      end;
    end;
    lb_ProgressCount.Caption.Text := 'Setting PRIVILEGE...' ;
    dmDBUpdate.UpdateTB_CARDPERMITEMPLOYEEGROUP_EmGroupLikeApply(ed_GradeEmGroupCode.Text,'N'); //자식 코드의 데이터도 모두 적용 'N' 상태로 해야 됨
    EmGroupGradeToEmployeeGrade;
    fmMain.FORMCARDDOWNLOADExecute;
  Finally
    pan_progress.Visible := False;
    tv_EmGroupList.Enabled := True;
    btn_Close.Enabled := True;
  End;
end;

procedure TfmEmGroupGrade.btn_PermitArmAreaDeleteClick(Sender: TObject);
var
  stMessage : string;
  i : integer;
  bCheckState : Boolean;
  stTime : string;
  stClientIP : string;
begin
  inherited;
  stClientIP:= GetLocalIPAddr;
  stTime := FormatDateTime('yyyymmddhhnnsszzz',now);

  stMessage := stringReplace(dmFormMessage.GetMessage('NOTSELECTDATA'),'$WORK',btn_PermitArmAreaDelete.Caption,[rfReplaceAll]);
  if L_nPermitArmAreaCheckCount = 0 then
  begin
    Application.MessageBox(PChar(stMessage),'Information',MB_OK);
    Exit;
  end;
  Try
    tv_EmGroupList.Enabled := False;
    btn_Close.Enabled := False;
    pan_progress.Visible := True;
    with sg_PermitAlarm do
    begin
      ProgressBar1.Max := RowCount - 1;
      ProgressBar1.Position := 0;
      for i := RowCount - 1 downto 1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        GetCheckBoxState(0,i, bCheckState);
        if bCheckState then
        begin
          dmDBCardPermit.EmGroupArmAreaPermitDelete(ed_GradeEmGroupCode.Text,Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i]);
          dmDBInsert.InsertIntoTB_SYSTEMLOG_All(copy(stTime,1,8),copy(stTime,9,6),stClientIP,G_stAdminUserID,Cells[2,i],Cells[3,i],'G' + ed_GradeEmGroupCode.Text,Cells[5,i],con_ComLogTYPE_ARMAREA,L_stMenuID + '(' + Caption + '):Permit Delete');

          NotPermitArmAreaListAdd(Cells[1,i],Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i],Cells[6,i],Cells[7,i]);
          PermitArmAreaListDelete(Cells[6,i]);
        end;
        lb_ProgressCount.Caption.Text := inttostr(ProgressBar1.Position) + '/' + inttostr(ProgressBar1.Max);
        application.ProcessMessages;
      end;
    end;
    lb_ProgressCount.Caption.Text := 'Setting PRIVILEGE...' ;
    dmDBUpdate.UpdateTB_CARDPERMITEMPLOYEEGROUP_EmGroupLikeApply(ed_GradeEmGroupCode.Text,'N'); //자회사 코드의 데이터도 모두 적용 'N' 상태로 해야 됨
    EmGroupGradeToEmployeeGrade;
    fmMain.FORMCARDDOWNLOADExecute;
  Finally
    pan_progress.Visible := False;
    tv_EmGroupList.Enabled := True;
    btn_Close.Enabled := True;
  End;
end;

procedure TfmEmGroupGrade.btn_PermitDoorAddClick(Sender: TObject);
var
  stMessage : string;
  i : integer;
  bCheckState : Boolean;
  stTime : string;
  stClientIP : string;
begin
  inherited;
  stClientIP:= GetLocalIPAddr;
  stTime := FormatDateTime('yyyymmddhhnnsszzz',now);

  stMessage := stringReplace(dmFormMessage.GetMessage('NOTSELECTDATA'),'$WORK',btn_PermitDoorAdd.Caption,[rfReplaceAll]);
  if L_nNotPermitDoorCheckCount = 0 then
  begin
    Application.MessageBox(PChar(stMessage),'Information',MB_OK);
    Exit;
  end;
  Try
    tv_EmGroupList.Enabled := False;
    btn_Close.Enabled := False;
    pan_progress.Visible := True;
    with sg_NotPermitDoor do
    begin
      ProgressBar1.Max := RowCount - 1;
      ProgressBar1.Position := 0;
      for i := RowCount - 1 downto 1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        GetCheckBoxState(0,i, bCheckState);
        if bCheckState then
        begin
          dmDBCardPermit.EmGroupDoorPermitAdd(ed_GradeEmGroupCode.Text,Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i]);
          dmDBInsert.InsertIntoTB_SYSTEMLOG_All(copy(stTime,1,8),copy(stTime,9,6),stClientIP,G_stAdminUserID,Cells[2,i],Cells[3,i],'G' + ed_GradeEmGroupCode.Text,Cells[5,i],con_ComLogTYPE_DOOR,L_stMenuID + '(' + Caption + '):Permit Add');

          PermitDoorListAdd(Cells[1,i],Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i],Cells[6,i],Cells[7,i]);
          NotPermitDoorListDelete(Cells[6,i]);
        end;
        lb_ProgressCount.Caption.Text := inttostr(ProgressBar1.Position) + '/' + inttostr(ProgressBar1.Max);
        application.ProcessMessages;
      end;
    end;
    lb_ProgressCount.Caption.Text := 'Setting PRIVILEGE...' ;
    dmDBUpdate.UpdateTB_CARDPERMITEMPLOYEEGROUP_EmGroupLikeApply(ed_GradeEmGroupCode.Text,'N'); //자회사 코드의 데이터도 모두 적용 'N' 상태로 해야 됨
    EmGroupGradeToEmployeeGrade;
    fmMain.FORMCARDDOWNLOADExecute;
  Finally
    pan_progress.Visible := False;
    tv_EmGroupList.Enabled := True;
    btn_Close.Enabled := True;
  End;

end;

procedure TfmEmGroupGrade.btn_PermitDoorDeleteClick(Sender: TObject);
var
  stMessage : string;
  i : integer;
  bCheckState : Boolean;
  stTime : string;
  stClientIP : string;
begin
  inherited;
  stClientIP:= GetLocalIPAddr;
  stTime := FormatDateTime('yyyymmddhhnnsszzz',now);

  stMessage := stringReplace(dmFormMessage.GetMessage('NOTSELECTDATA'),'$WORK',btn_PermitDoorDelete.Caption,[rfReplaceAll]);
  if L_nPermitDoorCheckCount = 0 then
  begin
    Application.MessageBox(PChar(stMessage),'Information',MB_OK);
    Exit;
  end;

  Try
    tv_EmGroupList.Enabled := False;
    btn_Close.Enabled := False;
    pan_progress.Visible := True;
    with sg_PermitDoor do
    begin
      ProgressBar1.Max := RowCount - 1;
      ProgressBar1.Position := 0;
      for i := RowCount - 1 downto 1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        GetCheckBoxState(0,i, bCheckState);
        if bCheckState then
        begin
          dmDBCardPermit.EmGroupDoorPermitDelete(ed_GradeEmGroupCode.Text,Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i]);
          dmDBInsert.InsertIntoTB_SYSTEMLOG_All(copy(stTime,1,8),copy(stTime,9,6),stClientIP,G_stAdminUserID,Cells[2,i],Cells[3,i],'G' + ed_GradeEmGroupCode.Text,Cells[5,i],con_ComLogTYPE_DOOR,L_stMenuID + '(' + Caption + '):Permit Delete');

          NotPermitDoorListAdd(Cells[1,i],Cells[2,i],Cells[3,i],Cells[4,i],Cells[5,i],Cells[6,i],Cells[7,i]);
          PermitDoorListDelete(Cells[6,i]);
        end;
        lb_ProgressCount.Caption.Text := inttostr(ProgressBar1.Position) + '/' + inttostr(ProgressBar1.Max);
        application.ProcessMessages;
      end;
    end;
    lb_ProgressCount.Caption.Text := 'Setting PRIVILEGE...' ;
    dmDBUpdate.UpdateTB_CARDPERMITEMPLOYEEGROUP_EmGroupLikeApply(ed_GradeEmGroupCode.Text,'N'); //자회사 코드의 데이터도 모두 적용 'N' 상태로 해야 됨
    EmGroupGradeToEmployeeGrade;
    fmMain.FORMCARDDOWNLOADExecute;
  Finally
    pan_progress.Visible := False;
    tv_EmGroupList.Enabled := True;
    btn_Close.Enabled := True;
  End;
end;

function TfmEmGroupGrade.ChangeEmGroupCode(aOrgCode, aCode, aDeepSeq,
  aViewSeq: string): Boolean;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  stChildCode,stDeepSeq,stViewSeq : string;
  stOrgDeepSeq : string;
begin
  stOrgDeepSeq := dmDBFunction.GetTB_EMPLOYEEGROUPCODE_CurrentDeepSeq(aOrgCode);
  stSql := ' Update TB_EMPLOYEEGROUPCODE Set ';
  stSql := stSql + ' EM_GROUPCODE = ''' + aCode + ''',';
  stSql := stSql + ' EM_DEEPSEQ = ' + aDeepSeq + ',';
  stSql := stSql + ' EM_VIEWSEQ = ' + aViewSeq + ' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND EM_GROUPCODE = ''' + aOrgCode + ''' ';

  result := dmDataBase.ProcessExecSQL(stSql);

  //여기서 그룹코드별 카드권한 테이블 변경
  stSql := ' Update TB_CARDPERMITEMPLOYEEGROUP set EM_GROUPCODE = ''' + aCode + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND EM_GROUPCODE = ''' + aOrgCode + ''' ';
  result := dmDataBase.ProcessExecSQL(stSql);

  //여기서 사원테이블 정보를 변경 하자
  stSql := ' Update TB_EMPLOYEE set EM_GROUPCODE = ''' + aCode + ''' ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND EM_GROUPCODE = ''' + aOrgCode + ''' ';
  result := dmDataBase.ProcessExecSQL(stSql);

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    stSql := 'Select * from TB_EMPLOYEEGROUPCODE ';
    stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
    stSql := stSql + ' AND EM_GROUPCODE Like ''' + aOrgCode + '%'' ';
    stSql := stSql + ' AND EM_DEEPSEQ = ' + inttostr(strtoint(stOrgDeepSeq) + 1) + '';
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
      while Not Eof do
      begin
        dmDBFunction.GetNextTB_EMPLOYEEGROUPCODE_ChildEmGroupCode(aCode,stChildCode,stDeepSeq,stViewSeq); //신규 코드가 부모가 됨
        ChangeEmGroupCode(FindField('EM_GROUPCODE').AsString,stChildCode,stDeepSeq,stViewSeq);
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

function TfmEmGroupGrade.EmGroupGradeToEmployeeEachApply(
  aEmGroupCode: string): Boolean;
var
  stSql : string;
  TempAdoQuery :TADOQuery;
begin
  result := False;
  stSql := ' Select * from tb_employee ';
  stSql := stSql + ' where EM_GROUPCODE Like ''' + aEmGroupCode + '%'' ';
  stSql := stSql + ' AND EM_ACUSE = ''1'' ';
  stSql := stSql + ' AND EM_GRADETYPE = 2 ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        LogSave(G_stLogDirectory + '\err' + FormatDateTime('yyyymmdd',now) + '.log','EmGroupGradeToEmployeeEachApply');
        result := False;
        Exit;
      End;
      result := True;
      if Recordcount < 1 then Exit;

      ProgressBar1.Max := Recordcount;
      ProgressBar1.Position := 0;
      While Not Eof do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        lb_ProgressCount.Caption.Text := inttostr(ProgressBar1.Position) + '/' + inttostr(ProgressBar1.Max);
        dmDBCardPermit.EmSeqEmGroupGradeToEmployeeCopyLikeUpdate(FindField('EM_SEQ').asstring,aEmGroupCode);
        dmDBCardPermit.EmSeqEmGroupGradeToEmployeeCopyLikeAdd(FindField('EM_SEQ').asstring,aEmGroupCode);
        Application.ProcessMessages;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

procedure TfmEmGroupGrade.EmGroupGradeToEmployeeGrade;
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  stEmGroupCode : string;
begin
  stSql := ' Select EM_DEEPSEQ,EM_GROUPCODE ';
  stSql := stSql + ' from TB_CARDPERMITEMPLOYEEGROUP ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND CP_APPLY <> ''Y'' ';
  stSql := stSql + ' GROUP BY EM_DEEPSEQ,EM_GROUPCODE ';
  stSql := stSql + ' Order by EM_DEEPSEQ,EM_GROUPCODE ';
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;
    TempAdoQuery.DisableControls;
    with TempAdoQuery  do
    begin
      Close;
      //SQL.Clear;
      SQL.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then Exit;
      while Not Eof do
      begin
        stEmGroupCode := FindField('EM_GROUPCODE').AsString;
        //if dmDBCardPermit.EmGroupGradeToEmployeeEachApply(stEmGroupCode) then
        if EmGroupGradeToEmployeeEachApply(stEmGroupCode) then
           dmDBUpdate.UpdateTB_CARDPERMITEMPLOYEEGROUP_EmGroupCodeApply(stEmGroupCode,'Y');
        Application.ProcessMessages;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;

end;

procedure TfmEmGroupGrade.FontSetting;
begin
(*  dmFormUtil.TravelFormFontSetting(self,G_stFontName,inttostr(G_nFontSize));
  dmFormUtil.TravelAdvOfficeTabSetOfficeStylerFontSetting(AdvOfficeTabSetOfficeStyler1, G_stFontName,inttostr(G_nFontSize));
  dmFormUtil.FormAdvOfficeTabSetOfficeStylerSetting(AdvOfficeTabSetOfficeStyler1,G_stFormStyle);
  dmFormUtil.FormAdvToolBarOfficeStylerSetting(AdvToolBarOfficeStyler1,G_stFormStyle);
  dmFormUtil.FormStyleSetting(self,AdvToolBarOfficeStyler1);
*)
end;

procedure TfmEmGroupGrade.FormChangeEvent(aNumber: integer);
begin
  case aNumber of
    con_FormBMOSBUILDINGCODE : begin
      LoadBuildingTreeView('',tv_buildingName,tv_buildingCode,con_LocalBuildingImageIndex);
    end;
  end;

end;

procedure TfmEmGroupGrade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  BuildingDoorCodeList.Free;
  BuildingArmAreaCodeList.Free;
  GradeArmAreaCodeList.Free;
  GradeDoorCodeList.Free;
  NotGradeArmAreaCodeList.Free; //방범권한이 없는 방범리스트
  NotGradeDoorCodeList.Free;  //출입권한이 없는 리스트

  fmMain.FORMENABLE(con_FormBMOSEMGROUPGRADE,'FALSE');

  Action := caFree;
end;

procedure TfmEmGroupGrade.FormCreate(Sender: TObject);
begin
  inherited;
  BuildingDoorCodeList := TStringList.Create;
  BuildingArmAreaCodeList := TStringList.Create;
  GradeArmAreaCodeList := TStringList.Create;
  GradeDoorCodeList := TStringList.Create;
  NotGradeArmAreaCodeList := TStringList.Create; //방범권한이 없는 방범리스트
  NotGradeDoorCodeList := TStringList.Create;  //출입권한이 없는 리스트
  FontSetting;
end;

procedure TfmEmGroupGrade.FormGradeRefresh;
begin
  if IsInsertGrade or IsUpdateGrade or IsDeleteGrade then PopupMenu := pm_Work;
  pm_EmGroupGrade.Enabled := IsInsertGrade;
  pm_ParentEmGroupGrade.Enabled := IsDeleteGrade;
end;

procedure TfmEmGroupGrade.FormIDSetting(aID: string);
begin
  L_stMenuID := aID;
end;

procedure TfmEmGroupGrade.FormNameSetting;
var
  stSql : string;
  nCommonLength : integer;
  nButtonLength : integer;
  nMenuLength : integer;
  TempAdoQuery : TADOQuery;
begin
  AdvOfficePage1.Caption := dmFormFunction.GetFormName('0','2','BUTTONMENU002');
  lb_List.Caption := dmFormFunction.GetFormName('0','2','COMMONGROUPLIST');//dmFormFunction.GetFormName('0','2','COMMONLIST01');
  lb_EmployeeList.Caption := dmFormFunction.GetFormName('2','2','BM3_018_01');
  L_stButtonCloseCaption := dmFormFunction.GetFormName('0','2','BUTTONMENU001');
  sg_NotPermitDoor.Cells[1,0] := dmFormFunction.GetFormName('0','2','COMMONDOORNAME');
  sg_PermitDoor.Cells[1,0] := dmFormFunction.GetFormName('0','2','COMMONDOORNAME');
  sg_NotPermitAlarm.Cells[1,0] := dmFormFunction.GetFormName('0','2','COMMONARMAREANAME');
  sg_PermitAlarm.Cells[1,0] := dmFormFunction.GetFormName('0','2','COMMONARMAREANAME');
  lb_EmGradePositionName.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONBUILDINGNAME');
  btn_BuildingNameSelect.Caption := dmFormFunction.GetFormName('0','2','BUTTONSEARCH002');
  lb_EmGradeName.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONGROUP');

  tab_Doorgrade.Caption := dmFormFunction.GetFormName('0','2','COMMONDOORPERMITADMIN');
  tab_ArmAreagrade.Caption := dmFormFunction.GetFormName('0','2','COMMONARMAREAPERMITADMIN');
  lb_DoorPermitCountName.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONSEARCHCOUNT01');
  lb_DoorNotPermitCountName.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONSEARCHCOUNT01');
  lb_ArmAreaNotPermitCountName.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONSEARCHCOUNT01');
  lb_ArmAreaPermitCountName.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONSEARCHCOUNT01');
  lb_Count1.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONCOUNT');
  lb_Count2.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONCOUNT');
  lb_Count3.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONCOUNT');
  lb_Count4.Caption.Text := dmFormFunction.GetFormName('0','2','COMMONCOUNT');
  lb_NotDoorPermit.Caption := dmFormFunction.GetFormName('0','2','COMMONDOORNOTPERMIT');
  lb_PermitDoor.Caption := dmFormFunction.GetFormName('0','2','COMMONDOORREGPERMIT');
  lb_NotPermitAlarmArea.Caption := dmFormFunction.GetFormName('0','2','COMMONARMAREANOTPERMIT');
  lb_PermitAlarmArea.Caption := dmFormFunction.GetFormName('0','2','COMMONARMAREAREPERMIT');
  btn_PermitDoorAdd.Caption := dmFormFunction.GetFormName('0','2','BUTTONPERMITADD001');
  btn_PermitArmAreaAdd.Caption := dmFormFunction.GetFormName('0','2','BUTTONPERMITADD001');
  btn_PermitDoorDelete.Caption := dmFormFunction.GetFormName('0','2','BUTTONPERMITDELETE001');
  btn_PermitArmAreaDelete.Caption := dmFormFunction.GetFormName('0','2','BUTTONPERMITDELETE001');

end;

procedure TfmEmGroupGrade.FormResize(Sender: TObject);
begin
  inherited;
  tv_EmGroupList.Height := List.Height - tv_EmGroupList.Top - 30;
  tv_EmGroupList.Width := List.Width - (tv_EmGroupList.Left * 2);

  btn_Close.Left := AdvOfficePager1.Width - btn_Close.Width - 10;
  btn_minimize.Left := btn_Close.Left - btn_minimize.Width - 2;

  if Windowstate = wsMaximized then
  begin
    btn_minimize.Visible := False;
    btn_Close.Visible := True;
  end else
  begin
    btn_minimize.Visible := False;
    btn_Close.Visible := False;
  end;
  pan_progress.Left := (Width div 2) - (pan_progress.Width div 2);
  pan_progress.Top := (Height div 2) - (pan_progress.Height div 2);
end;

procedure TfmEmGroupGrade.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

  FormNameSetting;
  fmMain.FORMENABLE(con_FormBMOSEMGROUPGRADE,'TRUE');

  SearchList('');
  LoadBuildingTreeView('',tv_buildingName,tv_buildingCode,con_LocalBuildingImageIndex);
  pm_EmGroupGradeClick(self);

end;

procedure TfmEmGroupGrade.Form_Close;
begin
  Close;
end;

procedure TfmEmGroupGrade.ListResize(Sender: TObject);
begin
  inherited;
  tv_EmGroupList.Width := List.Width - 40;

end;

procedure TfmEmGroupGrade.LoadBuildingAlarmAll(aBuildingCode: string;
  sgList: TAdvStringGrid);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
  stAlarmAreaCode : string;
begin
  GridInit(sgList,2,2,true);
  BuildingArmAreaCodeList.Clear;
  NotGradeArmAreaCodeList.Clear;
  GradeArmAreaCodeList.Clear;
  lb_NotPermitArmAreaCount.Caption.Text := FormatFloat('#,##0',0);

  stSql := dmDBSelect.SelectTB_ARMAREA_BuildingCode(aBuildingCode);
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sgList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('AR_ARMAREANAME').AsString;
          cells[2,nRow] := FindField('ND_NODENO').AsString;
          cells[3,nRow] := FindField('DE_ECUID').AsString;
          cells[4,nRow] := FindField('DE_EXTENDID').AsString;
          cells[5,nRow] := FindField('AR_ARMAREANO').AsString;
          stAlarmAreaCode := FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength) + FindField('DE_ECUID').AsString + FindField('DE_EXTENDID').AsString + FindField('AR_ARMAREANO').AsString;
          if BuildingArmAreaCodeList.IndexOf(stAlarmAreaCode) < 0 then BuildingArmAreaCodeList.Add(stAlarmAreaCode);
          if NotGradeArmAreaCodeList.IndexOf(stAlarmAreaCode) < 0 then NotGradeArmAreaCodeList.Add(stAlarmAreaCode);

          cells[6,nRow] := stAlarmAreaCode;
          cells[7,nRow] := FindField('AR_VIEWSEQ').AsString;

          nRow := nRow + 1;
          Next;
        end;
        lb_NotPermitArmAreaCount.Caption.Text := FormatFloat('#,##0',NotGradeArmAreaCodeList.Count);
      end;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmEmGroupGrade.LoadBuildingDoorAll(aBuildingCode: string;
  sgList: TAdvStringGrid);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
  stDoorCode : string;
begin
  GridInit(sgList,2,2,true);
  BuildingDoorCodeList.Clear;
  NotGradeDoorCodeList.Clear;
  GradeDoorCodeList.Clear;
  lb_NotPermitDoorCount.Caption.Text := FormatFloat('#,##0',0);

  stSql := dmDBSelect.SelectTB_DOOR_BuildingCode(aBuildingCode,True);
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

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
      with sgList do
      begin
        nRow := 1;
        RowCount := RecordCount + 1;
        while Not Eof do
        begin
          AddCheckBox(0,nRow,False,False);
          cells[1,nRow] := FindField('DO_DOORNAME').AsString;
          cells[2,nRow] := FindField('ND_NODENO').AsString;
          cells[3,nRow] := FindField('DE_ECUID').AsString;
          cells[4,nRow] := FindField('DE_EXTENDID').AsString;
          cells[5,nRow] := FindField('DO_DOORNO').AsString;
          stDoorCode := FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength) + FindField('DE_ECUID').AsString + FindField('DE_EXTENDID').AsString + FindField('DO_DOORNO').AsString;
          if BuildingDoorCodeList.IndexOf(stDoorCode) < 0 then BuildingDoorCodeList.Add(stDoorCode);
          if NotGradeDoorCodeList.IndexOf(stDoorCode) < 0 then NotGradeDoorCodeList.Add(stDoorCode);

          cells[6,nRow] := stDoorCode;
          cells[7,nRow] := FindField('DO_VIEWSEQ').AsString;

          nRow := nRow + 1;
          Next;
        end;
        lb_NotPermitDoorCount.Caption.Text := FormatFloat('#,##0',NotGradeDoorCodeList.Count);
      end;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmEmGroupGrade.LoadPermitAlarm(aBuildingCode, aEmGroupCode: string);
var
  stEmGroupCode : string;
  i : integer;
begin
  GridInit(sg_PermitAlarm,2,2,true);

  if aEmGroupCode = '' then Exit;
  stEmGroupCode := '0';
  LoadPermitEmGroupArmArea(aBuildingCode,stEmGroupCode);    //전체 소속의 권한 조회
  if Length(aEmGroupCode) < 2  then  Exit;

  i := 1;
  while stEmGroupCode <> aEmGroupCode do
  begin
    if Length(stEmGroupCode) > Length(aEmGroupCode) then Exit; //혹시 무한 루프 도는것을 방지
    stEmGroupCode := copy(aEmGroupCode,1,1 + (G_nEmployeeGroupLength * i));
    LoadPermitEmGroupArmArea(aBuildingCode,stEmGroupCode);
    i := i + 1;
  end;

end;

procedure TfmEmGroupGrade.LoadPermitDoor(aBuildingCode, aEmGroupCode: string);
var
  stEmGroupCode : string;
  i : integer;
begin
  GridInit(sg_PermitDoor,2,2,true);

  if aEmGroupCode = '' then Exit;
  stEmGroupCode := '0';
  LoadPermitEmGroupDoor(aBuildingCode,stEmGroupCode);    //전체 소속의 권한 조회
  if Length(aEmGroupCode) < 2  then  Exit;

  i := 1;
  while stEmGroupCode <> aEmGroupCode do
  begin
    if Length(stEmGroupCode) > Length(aEmGroupCode) then Exit; //혹시 무한 루프 도는것을 방지
    stEmGroupCode := copy(aEmGroupCode,1,1 + (G_nEmployeeGroupLength * i));
    LoadPermitEmGroupDoor(aBuildingCode,stEmGroupCode);
    i := i + 1;
  end;
end;

procedure TfmEmGroupGrade.LoadPermitEmGroupArmArea(aBuildingCode,
  aEmGroupCode: string);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
  stArmAreaCode : string;
begin
  stSql := dmDBSelect.SelectTB_ARMAREA_EmGroupPermit(aEmGroupCode);
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then
      begin
        lb_PermitArmAreaCount.Caption.Text := FormatFloat('#,##0',GradeArmAreaCodeList.Count);
        Exit;
      end;
      nRow := 1;
      while Not Eof do
      begin
        stArmAreaCode := FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength) + FindField('DE_ECUID').AsString + FindField('DE_EXTENDID').AsString + FindField('AR_ARMAREANO').AsString;
        if BuildingArmAreaCodeList.IndexOf(stArmAreaCode) > -1 then   //해당 빌딩 구역이면서
        begin
          if FindField('CP_PERMIT').AsString = '1' then
          begin
            //권한 등록
            if GradeArmAreaCodeList.IndexOf(stArmAreaCode) < 0 then
            begin
              PermitArmAreaListAdd(FindField('AR_ARMAREANAME').AsString, FindField('ND_NODENO').AsString, FindField('DE_ECUID').AsString, FindField('DE_EXTENDID').AsString,
                                FindField('AR_ARMAREANO').AsString, stArmAreaCode, FindField('AR_VIEWSEQ').AsString);
            end;
            if NotGradeArmAreaCodeList.IndexOf(stArmAreaCode) > -1 then
            begin
              NotPermitArmAreaListDelete(stArmAreaCode);
            end;
          end else
          begin
            //권한 삭제
            if GradeArmAreaCodeList.IndexOf(stArmAreaCode) > -1 then
            begin
              //권한 리스트에서 삭제
              PermitArmAreaListDelete(stArmAreaCode);
            end;
            if NotGradeArmAreaCodeList.IndexOf(stArmAreaCode) < 0 then
            begin
              //미등록 권한 리스트에 Add
              NotPermitArmAreaListAdd(FindField('AR_ARMAREANAME').AsString, FindField('ND_NODENO').AsString, FindField('DE_ECUID').AsString, FindField('DE_EXTENDID').AsString,
                                FindField('AR_ARMAREANO').AsString, stArmAreaCode, FindField('AR_VIEWSEQ').AsString);
            end;

          end;
        end;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmEmGroupGrade.LoadPermitEmGroupDoor(aBuildingCode,
  aEmGroupCode: string);
var
  stSql : string;
  TempAdoQuery : TADOQuery;
  nRow : integer;
  stDoorCode : string;
begin
  stSql := dmDBSelect.SelectTB_Door_EmGroupPermit(aEmGroupCode);
  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      sql.Text := stSql;
      Try
        Open;
      Except
        Exit;
      End;
      if recordcount < 1 then
      begin
        lb_PermitDoorCount.Caption.Text := FormatFloat('#,##0',GradeDoorCodeList.Count);
        Exit;
      end;
      nRow := 1;
      while Not Eof do
      begin
        stDoorCode := FillZeroNumber(FindField('ND_NODENO').AsInteger,G_nNodeCodeLength) + FindField('DE_ECUID').AsString + FindField('DE_EXTENDID').AsString + FindField('DO_DOORNO').AsString;
        if BuildingDoorCodeList.IndexOf(stDoorCode) > -1 then   //해당 빌딩 구역이면서
        begin
          if FindField('CP_PERMIT').AsString = '1' then
          begin
            //권한 등록
            if GradeDoorCodeList.IndexOf(stDoorCode) < 0 then
            begin
              PermitDoorListAdd(FindField('DO_DOORNAME').AsString, FindField('ND_NODENO').AsString, FindField('DE_ECUID').AsString, FindField('DE_EXTENDID').AsString,
                                FindField('DO_DOORNO').AsString, stDoorCode, FindField('DO_VIEWSEQ').AsString);
            end;
            if NotGradeDoorCodeList.IndexOf(stDoorCode) > -1 then
            begin
              NotPermitDoorListDelete(stDoorCode);
            end;
          end else
          begin
            //권한 삭제
            if GradeDoorCodeList.IndexOf(stDoorCode) > -1 then
            begin
              //권한 리스트에서 삭제
              PermitDoorListDelete(stDoorCode);
            end;
            if NotGradeDoorCodeList.IndexOf(stDoorCode) < 0 then
            begin
              //미등록 권한 리스트에 Add
              NotPermitDoorListAdd(FindField('DO_DOORNAME').AsString, FindField('ND_NODENO').AsString, FindField('DE_ECUID').AsString, FindField('DE_EXTENDID').AsString,
                                FindField('DO_DOORNO').AsString, stDoorCode, FindField('DO_VIEWSEQ').AsString);
            end;

          end;
        end;
        Next;
      end;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TfmEmGroupGrade.NotPermitArmAreaListAdd(aArmAreaName, aNodeNo, aEcuID,
  aExtendID, aArmAreaNo, aArmAreaCode, aArmAreaView: string);
var
  i : integer;
  bAdd : Boolean;
  nRow : integer;
  nIndex : integer;
begin
  bAdd := False;
  with sg_NotPermitAlarm do
  begin
    if RowCount = 2 then
    begin
      if Cells[6,Row] = '' then
      begin
        nRow := 1;
        AddCheckBox(0,nRow,False,False);
        cells[1,nRow] := aArmAreaName;
        cells[2,nRow] := aNodeNo;
        cells[3,nRow] := aEcuID;
        cells[4,nRow] := aExtendID;
        cells[5,nRow] := aArmAreaNo;
        cells[6,nRow] := aArmAreaCode;
        cells[7,nRow] := aArmAreaView;
        bAdd := True;
      end;
    end;
    if Not bAdd then
    begin
      for i := 1 to RowCount - 1 do
      begin
        if strtoint(cells[7,i]) = strtoint(aArmAreaView) then
        begin
          if cells[6,i] > aArmAreaCode then
          begin
            InsertRows(i,1);
            AddCheckBox(0,i,False,False);
            cells[1,i] := aArmAreaName;
            cells[2,i] := aNodeNo;
            cells[3,i] := aEcuID;
            cells[4,i] := aExtendID;
            cells[5,i] := aArmAreaNo;
            cells[6,i] := aArmAreaCode;
            cells[7,i] := aArmAreaView;
            bAdd := True;
            break;
          end;
        end else if strtoint(cells[7,i]) > strtoint(aArmAreaView) then
        begin
          InsertRows(i,1);
          AddCheckBox(0,i,False,False);
          cells[1,i] := aArmAreaName;
          cells[2,i] := aNodeNo;
          cells[3,i] := aEcuID;
          cells[4,i] := aExtendID;
          cells[5,i] := aArmAreaNo;
          cells[6,i] := aArmAreaCode;
          cells[7,i] := aArmAreaView;
          bAdd := True;
          break;
         end;
      end;
    end;
    if Not bAdd then
    begin
      //중간에 삽입 하지 못한 경우 마지막에 추가
      AddRow;
      nRow := RowCount - 1;
      AddCheckBox(0,nRow,False,False);
      cells[1,nRow] := aArmAreaName;
      cells[2,nRow] := aNodeNo;
      cells[3,nRow] := aEcuID;
      cells[4,nRow] := aExtendID;
      cells[5,nRow] := aArmAreaNo;
      cells[6,nRow] := aArmAreaCode;
      cells[7,nRow] := aArmAreaView;
    end;
  end;
  if NotGradeArmAreaCodeList.IndexOf(aArmAreaCode) < 0 then NotGradeArmAreaCodeList.Add(aArmAreaCode);
  lb_NotPermitArmAreaCount.Caption.Text := FormatFloat('#,##0',NotGradeArmAreaCodeList.Count);
end;

procedure TfmEmGroupGrade.NotPermitArmAreaListDelete(aArmAreaCode: string);
var
  i : integer;
  nIndex : integer;
begin
  for i := 1 to sg_NotPermitAlarm.RowCount - 1 do
  begin
    if sg_NotPermitAlarm.Cells[6,i] = aArmAreaCode then
    begin
      if sg_NotPermitAlarm.RowCount > 2 then sg_NotPermitAlarm.RemoveRows(i,1)
      else GridInit(sg_NotPermitAlarm,2,2,True);
      break;
    end;
  end;

  nIndex := NotGradeArmAreaCodeList.IndexOf(aArmAreaCode);
  if nIndex > -1 then NotGradeArmAreaCodeList.Delete(nIndex);
  lb_NotPermitArmAreaCount.Caption.Text := FormatFloat('#,##0',NotGradeArmAreaCodeList.Count);
end;

procedure TfmEmGroupGrade.NotPermitDoorListAdd(aDoorName, aNodeNo, aEcuID, aExtendID,
  aDoorNo, aDoorCode, aDoorView: string);
var
  i : integer;
  bAdd : Boolean;
  nRow : integer;
begin
  bAdd := False;
  with sg_NotPermitDoor do
  begin
    if RowCount = 2 then
    begin
      if Cells[6,Row] = '' then
      begin
        nRow := 1;
        AddCheckBox(0,nRow,False,False);
        cells[1,nRow] := aDoorName;
        cells[2,nRow] := aNodeNo;
        cells[3,nRow] := aEcuID;
        cells[4,nRow] := aExtendID;
        cells[5,nRow] := aDoorNo;
        cells[6,nRow] := aDoorCode;
        cells[7,nRow] := aDoorView;
        bAdd := True;
      end;
    end;
    if Not bAdd then
    begin
      for i := 1 to RowCount - 1 do
      begin
        if strtoint(cells[7,i]) = strtoint(aDoorView) then
        begin
          if cells[6,i] > aDoorCode then
          begin
            InsertRows(i,1);
            AddCheckBox(0,i,False,False);
            cells[1,i] := aDoorName;
            cells[2,i] := aNodeNo;
            cells[3,i] := aEcuID;
            cells[4,i] := aExtendID;
            cells[5,i] := aDoorNo;
            cells[6,i] := aDoorCode;
            cells[7,i] := aDoorView;
            bAdd := True;
            break;
          end;
        end else if strtoint(cells[7,i]) > strtoint(aDoorView) then
        begin
          InsertRows(i,1);
          AddCheckBox(0,i,False,False);
          cells[1,i] := aDoorName;
          cells[2,i] := aNodeNo;
          cells[3,i] := aEcuID;
          cells[4,i] := aExtendID;
          cells[5,i] := aDoorNo;
          cells[6,i] := aDoorCode;
          cells[7,i] := aDoorView;
          bAdd := True;
          break;
         end;
      end;
    end;
    if Not bAdd then
    begin
      //중간에 삽입 하지 못한 경우 마지막에 추가
      AddRow;
      nRow := RowCount - 1;
      AddCheckBox(0,nRow,False,False);
      cells[1,nRow] := aDoorName;
      cells[2,nRow] := aNodeNo;
      cells[3,nRow] := aEcuID;
      cells[4,nRow] := aExtendID;
      cells[5,nRow] := aDoorNo;
      cells[6,nRow] := aDoorCode;
      cells[7,nRow] := aDoorView;
    end;
  end;
  if NotGradeDoorCodeList.IndexOf(aDoorCode) < 0 then NotGradeDoorCodeList.Add(aDoorCode);
  lb_NotPermitDoorCount.Caption.Text := FormatFloat('#,##0',NotGradeDoorCodeList.Count);
end;

procedure TfmEmGroupGrade.NotPermitDoorListDelete(aDoorCode: string);
var
  i : integer;
  nIndex : integer;
begin
  for i := 1 to sg_NotPermitDoor.RowCount - 1 do
  begin
    if sg_NotPermitDoor.Cells[6,i] = aDoorCode then
    begin
      if sg_NotPermitDoor.RowCount > 2 then sg_NotPermitDoor.RemoveRows(i,1)
      else GridInit(sg_NotPermitDoor,2,2,True);
      break;
    end;
  end;

  nIndex := NotGradeDoorCodeList.IndexOf(aDoorCode);
  if nIndex > -1 then NotGradeDoorCodeList.Delete(nIndex);
  lb_NotPermitDoorCount.Caption.Text := FormatFloat('#,##0',NotGradeDoorCodeList.Count);
end;

procedure TfmEmGroupGrade.pan_emPermitAdminResize(Sender: TObject);
begin
  inherited;
  tp_Grade.Height := pan_emPermitAdmin.Height - (lb_EmGradePositionName.Top + lb_EmGradePositionName.Height) - 20;
  tp_Grade.Width :=  pan_emPermitAdmin.Width - 20;

end;

procedure TfmEmGroupGrade.PermitArmAreaListAdd(aArmAreaName, aNodeNo, aEcuID,
  aExtendID, aArmAreaNo, aArmAreaCode, aArmAreaView: string);
var
  i : integer;
  bAdd : Boolean;
  nRow : integer;
  nIndex : integer;
begin
  bAdd := False;
  with sg_PermitAlarm do
  begin
    if RowCount = 2 then
    begin
      if Cells[6,Row] = '' then
      begin
        nRow := 1;
        AddCheckBox(0,nRow,False,False);
        cells[1,nRow] := aArmAreaName;
        cells[2,nRow] := aNodeNo;
        cells[3,nRow] := aEcuID;
        cells[4,nRow] := aExtendID;
        cells[5,nRow] := aArmAreaNo;
        cells[6,nRow] := aArmAreaCode;
        cells[7,nRow] := aArmAreaView;
        bAdd := True;
      end;
    end;
    if Not bAdd then
    begin
      for i := 1 to RowCount - 1 do
      begin
        if strtoint(cells[7,i]) = strtoint(aArmAreaView) then
        begin
          if cells[6,i] > aArmAreaCode then
          begin
            InsertRows(i,1);
            AddCheckBox(0,i,False,False);
            cells[1,i] := aArmAreaName;
            cells[2,i] := aNodeNo;
            cells[3,i] := aEcuID;
            cells[4,i] := aExtendID;
            cells[5,i] := aArmAreaNo;
            cells[6,i] := aArmAreaCode;
            cells[7,i] := aArmAreaView;
            bAdd := True;
            break;
          end;
        end else if strtoint(cells[7,i]) > strtoint(aArmAreaView) then
        begin
          InsertRows(i,1);
          AddCheckBox(0,i,False,False);
          cells[1,i] := aArmAreaName;
          cells[2,i] := aNodeNo;
          cells[3,i] := aEcuID;
          cells[4,i] := aExtendID;
          cells[5,i] := aArmAreaNo;
          cells[6,i] := aArmAreaCode;
          cells[7,i] := aArmAreaView;
          bAdd := True;
          break;
         end;
      end;
    end;
    if Not bAdd then
    begin
      //중간에 삽입 하지 못한 경우 마지막에 추가
      AddRow;
      nRow := RowCount - 1;
      AddCheckBox(0,nRow,False,False);
      cells[1,nRow] := aArmAreaName;
      cells[2,nRow] := aNodeNo;
      cells[3,nRow] := aEcuID;
      cells[4,nRow] := aExtendID;
      cells[5,nRow] := aArmAreaNo;
      cells[6,nRow] := aArmAreaCode;
      cells[7,nRow] := aArmAreaView;
    end;
  end;
  if GradeArmAreaCodeList.IndexOf(aArmAreaCode) < 0 then GradeArmAreaCodeList.Add(aArmAreaCode);
  lb_PermitArmAreaCount.Caption.Text := FormatFloat('#,##0',GradeArmAreaCodeList.Count);
end;

procedure TfmEmGroupGrade.PermitArmAreaListDelete(aArmAreaCode: string);
var
  i : integer;
  nIndex : integer;
begin
  for i := 1 to sg_PermitAlarm.RowCount - 1 do
  begin
    if sg_PermitAlarm.Cells[6,i] = aArmAreaCode then
    begin
      if sg_PermitAlarm.RowCount > 2 then sg_PermitAlarm.RemoveRows(i,1)
      else GridInit(sg_PermitAlarm,2,2,True);
      break;
    end;
  end;

  nIndex := GradeArmAreaCodeList.IndexOf(aArmAreaCode);
  if nIndex > -1 then GradeArmAreaCodeList.Delete(nIndex);
  lb_PermitArmAreaCount.Caption.Text := FormatFloat('#,##0',GradeArmAreaCodeList.Count);
end;

procedure TfmEmGroupGrade.PermitDoorListAdd(aDoorName, aNodeNo, aEcuID, aExtendID,
  aDoorNo, aDoorCode, aDoorView: string);
var
  i : integer;
  bAdd : Boolean;
  nRow : integer;
begin
  bAdd := False;
  with sg_PermitDoor do
  begin
    if RowCount = 2 then
    begin
      if Cells[6,Row] = '' then
      begin
        nRow := 1;
        AddCheckBox(0,nRow,False,False);
        cells[1,nRow] := aDoorName;
        cells[2,nRow] := aNodeNo;
        cells[3,nRow] := aEcuID;
        cells[4,nRow] := aExtendID;
        cells[5,nRow] := aDoorNo;
        cells[6,nRow] := aDoorCode;
        cells[7,nRow] := aDoorView;
        bAdd := True;
      end;
    end;
    if Not bAdd then
    begin
      for i := 1 to RowCount - 1 do
      begin
        if strtoint(cells[7,i]) = strtoint(aDoorView) then
        begin
          if cells[6,i] > aDoorCode then
          begin
            InsertRows(i,1);
            AddCheckBox(0,i,False,False);
            cells[1,i] := aDoorName;
            cells[2,i] := aNodeNo;
            cells[3,i] := aEcuID;
            cells[4,i] := aExtendID;
            cells[5,i] := aDoorNo;
            cells[6,i] := aDoorCode;
            cells[7,i] := aDoorView;
            bAdd := True;
            break;
          end;
        end else if strtoint(cells[7,i]) > strtoint(aDoorView) then
        begin
          InsertRows(i,1);
          AddCheckBox(0,i,False,False);
          cells[1,i] := aDoorName;
          cells[2,i] := aNodeNo;
          cells[3,i] := aEcuID;
          cells[4,i] := aExtendID;
          cells[5,i] := aDoorNo;
          cells[6,i] := aDoorCode;
          cells[7,i] := aDoorView;
          bAdd := True;
          break;
         end;
      end;
    end;
    if Not bAdd then
    begin
      //중간에 삽입 하지 못한 경우 마지막에 추가
      AddRow;
      nRow := RowCount - 1;
      AddCheckBox(0,nRow,False,False);
      cells[1,nRow] := aDoorName;
      cells[2,nRow] := aNodeNo;
      cells[3,nRow] := aEcuID;
      cells[4,nRow] := aExtendID;
      cells[5,nRow] := aDoorNo;
      cells[6,nRow] := aDoorCode;
      cells[7,nRow] := aDoorView;
    end;
  end;
  if GradeDoorCodeList.IndexOf(aDoorCode) < 0 then GradeDoorCodeList.Add(aDoorCode);
  lb_PermitDoorCount.Caption.Text := FormatFloat('#,##0',GradeDoorCodeList.Count);
end;

procedure TfmEmGroupGrade.PermitDoorListDelete(aDoorCode: string);
var
  i : integer;
  nIndex : integer;
begin
  for i := 1 to sg_PermitDoor.RowCount - 1 do
  begin
    if sg_PermitDoor.Cells[6,i] = aDoorCode then
    begin
      if sg_PermitDoor.RowCount > 2 then sg_PermitDoor.RemoveRows(i,1)
      else GridInit(sg_PermitDoor,2,2,True);
      break;
    end;
  end;

  nIndex := GradeDoorCodeList.IndexOf(aDoorCode);
  if nIndex > -1 then GradeDoorCodeList.Delete(nIndex);
  lb_PermitDoorCount.Caption.Text := FormatFloat('#,##0',GradeDoorCodeList.Count);
end;

procedure TfmEmGroupGrade.pm_EmGroupGradeClick(Sender: TObject);
begin
  inherited;
  if tv_EmGroupList.Selected = nil then tv_EmGroupList.Items[0].Selected := True;

  pan_emPermitAdmin.Visible := True;
  ed_GradeEmGroupCode.Text := tv_EmGroupCode.Items.Item[tv_EmGroupList.Selected.AbsoluteIndex].Text;
  ed_GradeEmGroupName.Text := tv_EmGroupList.Selected.Text;
  tp_Grade.ActivePageIndex := 0;
  tv_buildingNameDblClick(self);

end;

procedure TfmEmGroupGrade.pm_ParentEmGroupGradeClick(Sender: TObject);
var
  stEmGroupCode : string;
  stParentEmGroupCode : string;
  stMessage : string;
begin
  inherited;
  stEmGroupCode := tv_EmGroupCode.Items.Item[tv_EmGroupList.Selected.AbsoluteIndex].Text;
  if stEmGroupCode = '0' then Exit;
  stMessage := dmFormMessage.GetMessage('PARENTGROUPGRADE');//'상위 그룹코드의 권한을 승계 받으시면 현재 권한 정보는 삭제 됩니다. 계속 하시겠습니까?';//stringReplace(dmFormMessage.GetMessage('WORKMESSAGE'),'$WORK',pm_DeleteCode.Caption,[rfReplaceAll]);
  if (Application.MessageBox(PChar(stMessage),'Information',MB_OKCANCEL) = IDCANCEL)  then Exit;
  stParentEmGroupCode := copy(stEmGroupCode,1,Length(stEmGroupCode) - G_nEmployeeGroupLength);
  dmDBDelete.DeleteTB_CARDPERMITEMPLOYEEGROUP_EmGroupCode(stEmGroupCode);
  dmDBUpdate.UpdateTB_CARDPERMITEMPLOYEEGROUP_EmGroupLikeApply(stParentEmGroupCode,'N'); //자회사 코드의 데이터도 모두 적용 'N' 상태로 해야 됨
  EmGroupGradeToEmployeeGrade;
end;


procedure TfmEmGroupGrade.SearchList(aCode: string);
var
  aTreeView : TTreeview;
  vTreeView : TTreeview;
  aNode,bNode,cNode,dNode : TTreeNode;
  vNode1,vNode2,vNode3 : TTreeNode;
  stSql : string;
  TempAdoQuery : TADOQuery;
  stParentCode : string;
  nDeepSeq : integer;
begin
  aTreeView := tv_EmGroupList;
  aTreeView.ReadOnly:= True;
  aTreeView.Items.Clear;
  vTreeView := tv_EmGroupCode;
  vTreeView.ReadOnly := True;
  vTreeView.Items.Clear;

  stSql := ' Select * from TB_EMPLOYEEGROUPCODE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND EM_CODEUSE = ''1'' ';
  stSql := stSql + ' Order by EM_DEEPSEQ,EM_VIEWSEQ ';
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
      if RecordCount < 1 then Exit;
      First;
      While Not Eof do
      begin
        if FindField('EM_DEEPSEQ').AsInteger = 0 then
        begin
          aNode := aTreeView.Items.Add(nil,FindField('EM_GROUPCODENAME').AsString);
          vTreeView.Items.AddChild(nil,FindField('EM_GROUPCODE').AsString);
          aNode.ImageIndex := con_LocalGroupImageIndex;
          aNode.SelectedIndex := con_LocalGroupImageIndex;
          aNode.Expanded := True;
        end else
        begin
          nDeepSeq := FindField('EM_DEEPSEQ').AsInteger;
          stParentCode := copy(FindField('EM_GROUPCODE').AsString,1,1 + ((nDeepSeq - 1) * G_nEmployeeGroupLength) );
          vNode1:= GetNodeByText(vTreeView,stParentCode,True);
          if vNode1 <> nil then
          begin
            bNode := aTreeView.Items.Item[vNode1.AbsoluteIndex];
            if bNode <> nil then
            begin
              cNode:= aTreeView.Items.AddChild(bNode,FindField('EM_GROUPCODENAME').AsString);
            end;
            vNode2:= vTreeView.Items.Item[vNode1.AbsoluteIndex];
            if vNode2 <> nil then
            begin
              vNode3:= vTreeView.Items.AddChild(vNode2,FindField('EM_GROUPCODE').AsString);
            end;
            if cNode <> nil then
            begin
              cNode.ImageIndex := con_LocalGroupImageIndex;
              cNode.SelectedIndex := con_LocalGroupImageIndex;
            end;
            bNode.Expanded := True;
            vNode1.Expanded := True;
            if aCode = FindField('EM_GROUPCODE').AsString  then
            begin
              if cNode <> nil then cNode.Selected := True;
            end;

          end;
        end;
        Next;
      end;

    end;
  Finally
    TempAdoQuery.EnableControls;
    TempAdoQuery.Free;
    CoUninitialize;
  End;
  tv_EmGroupList.SetFocus;
end;

procedure TfmEmGroupGrade.sg_NotPermitAlarmCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nNotPermitArmAreaCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nNotPermitArmAreaCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nNotPermitArmAreaCheckCount := L_nNotPermitArmAreaCheckCount + 1
    else L_nNotPermitArmAreaCheckCount := L_nNotPermitArmAreaCheckCount - 1 ;
  end;

end;

procedure TfmEmGroupGrade.sg_NotPermitDoorCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nNotPermitDoorCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nNotPermitDoorCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nNotPermitDoorCheckCount := L_nNotPermitDoorCheckCount + 1
    else L_nNotPermitDoorCheckCount := L_nNotPermitDoorCheckCount - 1 ;
  end;

end;

procedure TfmEmGroupGrade.sg_PermitAlarmCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nPermitArmAreaCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nPermitArmAreaCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nPermitArmAreaCheckCount := L_nPermitArmAreaCheckCount + 1
    else L_nPermitArmAreaCheckCount := L_nPermitArmAreaCheckCount - 1 ;
  end;

end;

procedure TfmEmGroupGrade.sg_PermitDoorCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  inherited;
  if ARow = 0 then //전체선택 또는 해제
  begin
    if State then L_nPermitDoorCheckCount := (Sender as TAdvStringGrid).RowCount - 1
    else L_nPermitDoorCheckCount := 0;
    AdvStrinGridSetAllCheck(Sender,State);
  end else
  begin
    if State then L_nPermitDoorCheckCount := L_nPermitDoorCheckCount + 1
    else L_nPermitDoorCheckCount := L_nPermitDoorCheckCount - 1 ;
  end;

end;

procedure TfmEmGroupGrade.tp_GradeResize(Sender: TObject);
begin
  inherited;
  pan_NotPermitDoor.Width := (tp_Grade.Width - pan_PermitAction.Width) div 2;
  pan_NotPermitAlarmArea.Width := (tp_Grade.Width - AdvSmoothPanel6.Width) div 2;

  sg_NotPermitDoor.Width := pan_NotPermitDoor.Width - (sg_NotPermitDoor.Left * 2);
  sg_PermitDoor.Width := pan_NotPermitDoor.Width - (sg_PermitDoor.Left * 2);
  sg_NotPermitAlarm.Width := pan_NotPermitAlarmArea.Width - (sg_NotPermitAlarm.Left * 2);
  sg_PermitAlarm.Width := pan_NotPermitAlarmArea.Width - (sg_PermitAlarm.Left * 2);

  sg_NotPermitDoor.Height := pan_NotPermitDoor.Height - pan_NotPermitDoorCount.Height - sg_NotPermitDoor.top - 10;
  sg_PermitDoor.Height := pan_NotPermitDoor.Height - pan_NotPermitDoorCount.Height - sg_PermitDoor.top - 10;
  sg_NotPermitAlarm.Height := pan_NotPermitDoor.Height - pan_NotPermitDoorCount.Height - sg_NotPermitAlarm.top - 10;
  sg_PermitAlarm.Height := pan_NotPermitDoor.Height - pan_NotPermitDoorCount.Height - sg_PermitAlarm.top - 10;

  sg_NotPermitDoor.ColWidths[1] := sg_NotPermitDoor.Width - sg_NotPermitDoor.ColWidths[0] ;
  sg_PermitDoor.ColWidths[1] := sg_PermitDoor.Width - sg_PermitDoor.ColWidths[0] ;
  sg_NotPermitAlarm.ColWidths[1] := sg_NotPermitAlarm.Width - sg_NotPermitAlarm.ColWidths[0] ;
  sg_PermitAlarm.ColWidths[1] := sg_PermitAlarm.Width - sg_PermitAlarm.ColWidths[0] ;

  btn_PermitDoorAdd.Top := (pan_PermitAction.Height div 2) - btn_PermitDoorAdd.Height - 5;
  btn_PermitDoorDelete.Top := (pan_PermitAction.Height div 2) + 5;
  btn_PermitArmAreaAdd.Top := (pan_PermitAction.Height div 2) - btn_PermitArmAreaAdd.Height - 5;
  btn_PermitArmAreaDelete.Top := (pan_PermitAction.Height div 2) + 5;
end;

procedure TfmEmGroupGrade.tv_buildingNameDblClick(Sender: TObject);
begin
  inherited;
  if tv_buildingName.Selected = nil then tv_buildingName.Items[0].Selected := True;

  ed_SelectBuildingCode.Text := tv_buildingCode.Items.Item[tv_buildingName.Selected.AbsoluteIndex].Text;
  ed_SelectBuildingName.Text := tv_buildingName.Selected.Text;
  tv_buildingName.Visible := False;

  if ed_GradeEmGroupCode.Text = '' then Exit;
  L_nPermitArmAreaCheckCount := 0;           //삭제시 방범구역 선택 갯수
  L_nNotPermitArmAreaCheckCount := 0;        //등록시 방범구역 선택 갯수
  L_nPermitDoorCheckCount := 0;           //삭제시 출입문 선택 갯수
  L_nNotPermitDoorCheckCount := 0;        //등록시 출입문 선택 갯수

  GridInit(sg_NotPermitDoor,2,2,true);
  GridInit(sg_PermitDoor,2,2,true);
  GridInit(sg_NotPermitAlarm,2,2,true);   //그리드 초기화
  GridInit(sg_PermitAlarm,2,2,true);

  LoadBuildingDoorAll(ed_SelectBuildingCode.Text,sg_NotPermitDoor); //전체 출입문을 리스트에 추가 하자
  LoadBuildingAlarmAll(ed_SelectBuildingCode.Text,sg_NotPermitAlarm); //전체 방범구역을 리스트에 추가 하자

  LoadPermitDoor(ed_SelectBuildingCode.Text,ed_GradeEmGroupCode.Text);
  LoadPermitAlarm(ed_SelectBuildingCode.Text,ed_GradeEmGroupCode.Text);

end;

procedure TfmEmGroupGrade.tv_EmGroupListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  currentItem, dropItem : TTreeNode;
  stOrgCode : string;
  stTargetParentCode : string;
  stCode : string;
  stDeepSeq,stViewSeq : string;
  stSql : string;
begin
  inherited;
  if Sender = Source then
  begin
    with TTreeView(Sender) do
    begin
      dropItem :=GetNodeAt(X,Y);
      currentItem := Selected;
      if currentItem.AbsoluteIndex = 0 then Exit;
      stTargetParentCode := tv_EmGroupCode.Items[dropItem.AbsoluteIndex].Text;
      stOrgCode := tv_EmGroupCode.Items[currentItem.AbsoluteIndex].Text;
      if copy(stTargetParentCode,1,Length(stOrgCode)) = stOrgCode then Exit; //자신의 하위디렉토리로 갈수는 없다
      dmDBFunction.GetNextTB_EMPLOYEEGROUPCODE_ChildEmGroupCode(stTargetParentCode,stCode,stDeepSeq,stViewSeq);
      ChangeEmGroupCode(stOrgCode,stCode,stDeepSeq,stViewSeq);
    end;
  end;
  SearchList(stCode);
end;

procedure TfmEmGroupGrade.tv_EmGroupListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := Sender = tv_EmGroupList;

end;

initialization
  RegisterClass(TfmEmGroupGrade);
Finalization
  UnRegisterClass(TfmEmGroupGrade);

end.
