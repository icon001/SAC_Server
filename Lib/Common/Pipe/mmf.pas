//---------------------------------------------------------------------------
{ // ������ �� ���α׷����� �޸� ����
  MMF (Memory Mapped File I/O) ����� �̿��� �� ���α׷��� �޸� ����
  CreateFileMapping ()  : �����޸� ����
  CloseHandle ()        : �����޸� ����
  MapViewOfFile ()      : �����޸𸮸� ����Ű�� ������ ���
    ����� �����͸� �̿�, �ش� �����Ͱ� ����Ű�� ���� ���� �аų� ������ ó��
}

unit mmf;

//---------------------------------------------------------------------------
// �ܺ� ����
interface
uses
  Windows, SysUtils;

const
  k_max_info_size = 4096;           // �����޸� ũ��
  k_mmf_name = 'messenger_test';    // �����޸� �̸�, �����ϰ��� �ϴ� ���α׷������� ���ƾ� ��

// �ܺ� �Լ� ----------------------------------
function CreateMMF_Info () : boolean;               // �����޸� ����
procedure CloseMMF_Info ();                         // �����޸� ����

function Read_Info (mmf_data : pChar) : boolean;    // ����޸� �б��Լ�
function Write_Info (mmf_data : pChar) : boolean;   // ����޸� �����Լ�

//---------------------------------------------------------------------------
// ���� ����
implementation

var
g_mmf_handle  : THandle;
//g_mmf_name    : ^char;
//HANDLE   gMMF_EditInfo := NULL;


//---------------------------------------------------------------------------
function CreateMMF_Info () : boolean;
begin
  g_mmf_handle := CreateFileMapping (THandle ($FFFFFFFF),
                                     nil, PAGE_READWRITE, 0,
                                     k_max_info_size, k_mmf_name);
  if g_mmf_handle = THandle (nil) then
    g_mmf_handle := CreateFileMapping (THandle ($FFFFFFFF),
                                       nil, PAGE_READWRITE, 0,
                                       k_max_info_size, k_mmf_name);

  if g_mmf_handle <> THandle (nil) then result := true
  else                                  result := false;
end;

procedure CloseMMF_Info ();
begin
  CloseHandle (g_mmf_handle);
end;

//-------------------------------------------------------
function Read_Info (mmf_data : pChar) : boolean;
var
  p_data : pChar;
begin
  p_data := nil;
  result := false;
  if mmf_data = nil then                exit;
  if g_mmf_handle = THandle (nil) then  exit;

  try
  begin
    p_data := MapViewOfFile (g_mmf_handle, FILE_MAP_WRITE, 0, 0, 0);
    if p_data <> nil then
    begin
      StrCopy (mmf_data, p_data);   // mmf_data <- p_data (�����޸�)
      if integer (mmf_data [0]) <> 0 then result := true;
    end;
  end;
  finally
    UnmapViewOfFile (p_data);
  end;
end;

function Write_Info (mmf_data : pChar) : boolean;
var
  p_data : pChar;
begin
  p_data := nil;
  result := false;
  if mmf_data = nil then                exit;
  if g_mmf_handle = THandle (nil) then  exit;

  try
  begin
    p_data := MapViewOfFile (g_mmf_handle, FILE_MAP_WRITE, 0, 0, 0);
    if p_data <> nil then
    begin
      StrCopy (p_data, mmf_data);   // mmf_data -> p_data (�����޸�)
      if integer (mmf_data [0]) <> 0 then result := true;
    end;
  end;
  finally
    UnmapViewOfFile (p_data);
  end;
end;

end.
