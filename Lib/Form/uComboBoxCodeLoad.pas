unit uComboBoxCodeLoad;

interface

uses
  System.SysUtils, System.Classes,Vcl.StdCtrls,ADODB,ActiveX,AdvCombo;

type
  TdmComboBoxCodeLoad = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadBuildingAreaCode(aBuildingCode:string;aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadBuildingCode(aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadBuildingFloorCode(aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadCardGubunCode(aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadCardGroupCode(aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadDoorCode(aBuildingCode,aBuildingAreaCode:string;aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadLockModeCode(aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadLockTimeCode(aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadLockTypeCode(aStringList:TStringList;cmb_Box:TComboBox;aAll:Boolean=True;aAllData:string = '');
    procedure LoadTimeHH(cmb_Box:TAdvComboBox);
    procedure LoadTimeMM(cmb_Box:TAdvComboBox);
  end;

var
  dmComboBoxCodeLoad: TdmComboBoxCodeLoad;

implementation

uses
  uCommonFunction,
  uCommonVariable,
  uDataBase;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmComboBoxCodeLoad }

procedure TdmComboBoxCodeLoad.LoadBuildingAreaCode(aBuildingCode: string;
  aStringList: TStringList; cmb_Box: TComboBox; aAll: Boolean;
  aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  if aBuildingCode = '' then Exit;

  stSql := 'select * from TB_BUILDINGAREACODE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' AND BC_BUILDINGCODE = ' + aBuildingCode + ' ';
  stSql := stSql + ' order by BC_BUILDINGAREACODE ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('BC_BUILDINGAREANAME').AsString);
        aStringList.Add(FindField('BC_BUILDINGAREACODE').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmComboBoxCodeLoad.LoadBuildingCode(aStringList: TStringList;
  cmb_Box: TComboBox; aAll: Boolean; aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  stSql := 'select * from TB_BUILDINGCODE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' order by BC_BUILDINGCODE ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('BC_BUILDINGNAME').AsString);
        aStringList.Add(FindField('BC_BUILDINGCODE').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmComboBoxCodeLoad.LoadBuildingFloorCode(aStringList: TStringList;
  cmb_Box: TComboBox; aAll: Boolean; aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  stSql := 'select * from TB_BUILDINGFLOORCODE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' order by BC_BUILDINGFLOORCODE ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('BC_BUILDINGFLOORNAME').AsString);
        aStringList.Add(FindField('BC_BUILDINGFLOORCODE').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmComboBoxCodeLoad.LoadCardGroupCode(aStringList: TStringList;
  cmb_Box: TComboBox; aAll: Boolean; aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  stSql := 'select * from TB_CARDGROUPCODE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' order by CA_GROUPCODE ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('CA_GROUPCODENAME').AsString);
        aStringList.Add(FindField('CA_GROUPCODE').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmComboBoxCodeLoad.LoadCardGubunCode(aStringList: TStringList;
  cmb_Box: TComboBox; aAll: Boolean; aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  stSql := 'select * from TB_CARDGUBUNCODE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' order by CA_GUBUN ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('CA_GUBUNNAME').AsString);
        aStringList.Add(FindField('CA_GUBUN').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;


procedure TdmComboBoxCodeLoad.LoadDoorCode(aBuildingCode,
  aBuildingAreaCode: string; aStringList: TStringList; cmb_Box: TComboBox;
  aAll: Boolean; aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  stSql := 'select * from TB_DEVICE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  if isdigit(aBuildingCode) then stSql := stSql + ' AND BC_BUILDINGCODE = ' + aBuildingCode + ' ';
  if isdigit(aBuildingAreaCode) then stSql := stSql + ' AND BC_BUILDINGAREACODE = ' + aBuildingAreaCode + ' ';
  stSql := stSql + ' order by DE_DEVICENAME ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('DE_DEVICENAME').AsString);
        aStringList.Add(FindField('DE_SEQ').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmComboBoxCodeLoad.LoadLockModeCode(aStringList: TStringList;
  cmb_Box: TComboBox; aAll: Boolean; aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  stSql := 'select * from TB_DOORLOCKPORT ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' order by DE_LOCKMODE ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('DE_LOCKMODENAME').AsString);
        aStringList.Add(FindField('DE_LOCKMODE').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmComboBoxCodeLoad.LoadLockTimeCode(aStringList: TStringList;
  cmb_Box: TComboBox; aAll: Boolean; aAllData: string);
var
  i : integer;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;

  for i := 1 to 15 do
  begin
    cmb_Box.Items.Add(inttostr(i) + '��');
    aStringList.Add(Dec2Hex(i,2));
  end;

end;

procedure TdmComboBoxCodeLoad.LoadLockTypeCode(aStringList: TStringList;
  cmb_Box: TComboBox; aAll: Boolean; aAllData: string);
var
  stSql :string;
  TempAdoQuery : TADOQuery;
begin
  cmb_Box.Clear;
  aStringList.Clear;
  if aAll then
  begin
    cmb_Box.Items.Add(aAllData);
    aStringList.Add('');
    cmb_Box.ItemIndex := 0;
  end;
  stSql := 'select * from TB_DOORCONTROLTYPE ';
  stSql := stSql + ' Where GROUP_CODE = ''' + G_stGroupCode + ''' ';
  stSql := stSql + ' order by DE_LOCKTYPE ';

  Try
    CoInitialize(nil);
    TempAdoQuery := TADOQuery.Create(nil);
    TempAdoQuery.Connection := dmDataBase.ADOConnection;

    with TempAdoQuery do
    begin
      Close;
      Sql.Clear;
      Sql.Text := stSql;

      Try
        Open;
      Except
        Exit;
      End;

      if RecordCount < 1 then  Exit;

      First;

      While Not Eof do
      begin
        cmb_Box.Items.Add(FindField('DE_LOCKTYPENAME').AsString);
        aStringList.Add(FindField('DE_LOCKTYPE').AsString);
        Next;
      end;
      cmb_Box.ItemIndex := 0;
    end;
  Finally
    TempAdoQuery.Free;
    CoUninitialize;
  End;
end;

procedure TdmComboBoxCodeLoad.LoadTimeHH(cmb_Box: TAdvComboBox);
var
  i : integer;
begin
  cmb_Box.Clear;
  for i := 0 to 24 do
  begin
    cmb_Box.Items.Add(FillZeroNumber(i,2));
  end;
  cmb_Box.ItemIndex := 0;
end;

procedure TdmComboBoxCodeLoad.LoadTimeMM(cmb_Box: TAdvComboBox);
var
  i : integer;
begin
  cmb_Box.Clear;
  for i := 0 to 6 do
  begin
    cmb_Box.Items.Add(FillZeroNumber(i * 10,2));
  end;
  cmb_Box.ItemIndex := 0;
end;

end.
