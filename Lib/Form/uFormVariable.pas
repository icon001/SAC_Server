unit uFormVariable;

interface

const
  MAXFORMCOUNT  = 200;

const
  con_FormACCESSREPORT = 1;
  con_FormADMINUSERID = 2;
  con_FormBuildingAreaCode = 10;
  con_FormBuildingCode = 11;
  con_FormCardAdmin = 20;
  con_FormCardGradeReport = 21;
  con_FormCardGroup = 22;
  con_FormCardGroupGrade = 23;
  con_FormCardGubunCode = 24;
  con_FormDeviceMONITOR = 30;
  con_FormDoorAdmin = 31;
  con_FormMONITOR =40;




var
  G_bFormEnabled: Array [0..MAXFORMCOUNT] of Boolean;     //폼 활성화 여부

implementation



end.
