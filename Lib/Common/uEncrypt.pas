unit uEncrypt;

interface

uses
  System.SysUtils, System.Classes;

const
  HexaChar: array [0..15] of Char=('0','1','2','3','4','5','6','7','8','9',
                                   'A','B','C','D','E','F');

type
  TdmEncrypt = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function Decrypt(const S: String; Key1, Key2, Key3: WORD): String; // 암호풀기
    function Encrypt(const S: String; Key1, Key2, Key3: WORD): String; // 암호걸기
    function HexToValue(const S: String) : String;  // Hexadecimal로 구성된 문자열을 Byte 데이터로 변환
    function ValueToHex(const S: String): String;   // Byte로 구성된 데이터를 Hexadecimal 문자열로 변환
  end;

var
  dmEncrypt: TdmEncrypt;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmEncrypt }

function TdmEncrypt.Decrypt(const S: String; Key1, Key2, Key3: WORD): String;
var
  i: Byte;
  FirstResult: String;
begin
  FirstResult:=HexToValue(S);
  SetLength(Result, Length(FirstResult));
  for i:=1 to Length(FirstResult) do begin
    Result[i]:=Char(Byte(FirstResult[i]) xor (Key1 shr 8));
    Key1     :=(Byte(FirstResult[i])+Key1)*Key2+Key3;
  end;
end;

function TdmEncrypt.Encrypt(const S: String; Key1, Key2, Key3: WORD): String;
var
  i: Byte;
  FirstResult: String;
begin
  SetLength(FirstResult, Length(S));
  for i:=1 to Length(S) do begin
    FirstResult[i]:=Char(Byte(S[i]) xor (Key1 shr 8));
    Key1          :=(Byte(FirstResult[i])+Key1)*Key2+Key3;
  end;
  Result:=ValueToHex(FirstResult);
end;

function TdmEncrypt.HexToValue(const S: String): String;
var i: Integer;
begin
  SetLength(Result, Length(S) div 2);
  for i:=0 to (Length(S) div 2)-1 do begin
    Result[i+1] := Char(StrToInt('$'+Copy(S,(i*2)+1, 2)));
  end;
end;

function TdmEncrypt.ValueToHex(const S: String): String;
var i: Integer;
begin
  SetLength(Result, Length(S)*2); // 문자열 크기를 설정
  for i:=0 to Length(S)-1 do begin
    Result[(i*2)+1]:=HexaChar[Integer(S[i+1]) shr 4];
    Result[(i*2)+2]:=HexaChar[Integer(S[i+1]) and $0f];
  end;
end;

end.
