//---------------------------------------------------------------------------
{ // 별개의 두 프로그램간의 메모리 공유
  MMF (Memory Mapped File I/O) 방식을 이용한 두 프로그램간 메모리 공유
  CreateFileMapping ()  : 공유메모리 생성
  CloseHandle ()        : 공유메모리 제거
  MapViewOfFile ()      : 공유메모리를 가르키는 포인터 얻기
    얻어진 포인터를 이용, 해당 포인터가 가리키는 곳에 값을 읽거나 씀으로 처리
}

unit mmf;

//---------------------------------------------------------------------------
// 외부 영역
interface
uses
  Windows, SysUtils;

const
  k_max_info_size = 4096;           // 공유메모리 크기
  k_mmf_name = 'messenger_test';    // 공유메모리 이름, 공유하고자 하는 프로그램끼리만 같아야 함

// 외부 함수 ----------------------------------
function CreateMMF_Info () : boolean;               // 공유메모리 생성
procedure CloseMMF_Info ();                         // 공유메모리 제거

function Read_Info (mmf_data : pChar) : boolean;    // 공통메모리 읽기함수
function Write_Info (mmf_data : pChar) : boolean;   // 공통메모리 쓰기함수

//---------------------------------------------------------------------------
// 내부 영역
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
      StrCopy (mmf_data, p_data);   // mmf_data <- p_data (공유메모리)
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
      StrCopy (p_data, mmf_data);   // mmf_data -> p_data (공유메모리)
      if integer (mmf_data [0]) <> 0 then result := true;
    end;
  end;
  finally
    UnmapViewOfFile (p_data);
  end;
end;

end.
