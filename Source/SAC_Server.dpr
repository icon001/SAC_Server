program SAC_Server;

uses
  Vcl.Forms,
  uMain in 'fmMain\uMain.pas' {fmMain},
  uDataBase in '..\Lib\DataBase\uDataBase.pas' {dmDataBase: TDataModule},
  uDataBaseConfig in '..\Lib\DataBase\uDataBaseConfig.pas' {fmDataBaseConfig},
  uDBVariable in '..\Lib\DataBase\uDBVariable.pas',
  uCommonFunction in '..\Lib\Common\uCommonFunction.pas',
  uCommonVariable in '..\Lib\Common\uCommonVariable.pas',
  uDBCreate in '..\Lib\DataBase\uDBCreate.pas' {dmDBCreate: TDataModule},
  uDBFunction in '..\Lib\DataBase\uDBFunction.pas' {dmDBFunction: TDataModule},
  uDBInsert in '..\Lib\DataBase\uDBInsert.pas' {dmDBInsert: TDataModule},
  uDBUpdate in '..\Lib\DataBase\uDBUpdate.pas' {dmDBUpdate: TDataModule},
  uDBDelete in '..\Lib\DataBase\uDBDelete.pas' {dmDBDelete: TDataModule},
  uLogin in '..\Lib\Login\uLogin.pas' {fmLogin},
  uLoginVariable in '..\Lib\Login\uLoginVariable.pas',
  uSubForm in '..\Lib\Form\uSubForm.pas' {fmASubForm},
  uBuildingAreaCode in 'fmBuildingAreaCode\uBuildingAreaCode.pas' {fmBuildingAreaCode},
  uDBSelect in '..\Lib\DataBase\uDBSelect.pas' {dmDBSelect: TDataModule},
  uComboBoxCodeLoad in '..\Lib\Form\uComboBoxCodeLoad.pas' {dmComboBoxCodeLoad: TDataModule},
  uCardGubunCode in 'fmCardGubunCode\uCardGubunCode.pas' {fmCardGubunCode},
  uDoorAdmin in 'fmDoorAdmin\uDoorAdmin.pas' {fmDoorAdmin},
  uCardGroupCode in 'fmCardGroupCode\uCardGroupCode.pas' {fmCardGroupCode},
  uCardAdmin in 'fmCardAdmin\uCardAdmin.pas' {fmCardAdmin},
  uCardGroupGrade in 'fmCardGroupGrade\uCardGroupGrade.pas' {fmCardGroupGrade},
  uCardPermit in '..\Lib\Common\uCardPermit.pas' {dmCardPermit: TDataModule},
  uFloorCode in 'fmFloorCode\uFloorCode.pas' {fmFloorCode},
  uCardGradeReport in 'fmCardGradeReport\uCardGradeReport.pas' {fmCardGradeReport},
  uBuildingCode in 'fmBuildingCode\uBuildingCode.pas' {fmBuildingCode},
  uNode in '..\Lib\Device\uNode.pas' {dmNode: TDataModule},
  u_c_basic_object in '..\Lib\WinSocket\Winsockclasses\u_c_basic_object.pas',
  u_c_byte_buffer in '..\Lib\WinSocket\Winsockclasses\u_c_byte_buffer.pas',
  u_c_display in '..\Lib\WinSocket\Winsockclasses\u_c_display.pas',
  u_c_log in '..\Lib\WinSocket\Winsockclasses\u_c_log.pas',
  u_winsock in '..\Lib\WinSocket\Winsocket\u_winsock.pas',
  u_characters in '..\Lib\WinSocket\Winsockunits\u_characters.pas',
  u_dir in '..\Lib\WinSocket\Winsockunits\u_dir.pas',
  u_display_hex_2 in '..\Lib\WinSocket\Winsockunits\u_display_hex_2.pas',
  u_file in '..\Lib\WinSocket\Winsockunits\u_file.pas',
  u_strings in '..\Lib\WinSocket\Winsockunits\u_strings.pas',
  u_types_constants in '..\Lib\WinSocket\Winsockunits\u_types_constants.pas',
  uMonitoring in 'fmMonitoring\uMonitoring.pas' {fmMonitoring},
  uFormVariable in '..\Lib\Form\uFormVariable.pas',
  uDeviceComMonitoring in 'fmDeviceComMonitoring\uDeviceComMonitoring.pas' {fmDeviceComMonitoring},
  uAccessReport in 'fmAccessReport\uAccessReport.pas' {fmAccessReport},
  uAdminUserID in 'fmAdminUserID\uAdminUserID.pas' {fmAdminUserID},
  uComPort in '..\Lib\Device\uComPort.pas' {dmComPort: TDataModule},
  uDeviceVariable in '..\Lib\Device\uDeviceVariable.pas',
  uClientConfig in 'fmClientConfig\uClientConfig.pas' {fmClientConfig},
  uEncrypt in '..\Lib\Common\uEncrypt.pas' {dmEncrypt: TDataModule},
  systeminfos in '..\Lib\Common\systeminfos.pas';

{$R *.res}
{$R manifest.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmComPort, dmComPort);
  Application.CreateForm(TdmDataBase, dmDataBase);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TdmNode, dmNode);
  Application.CreateForm(TdmEncrypt, dmEncrypt);
  Application.Run;
end.
