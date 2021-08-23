program Hw1;

uses
  SysUtils;

const n = 4;

type
  TStr = array [1..n] of integer;
  TMatr = array [1..n] of TStr;
  Tvect = array [1..n] of boolean;

var
  Matr : TMatr;
  v:Tvect;
//1
procedure read_Matr (var mt:TMatr);
var
   i,j : integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      read (mt[i,j]);
    readln;
end;

//2
procedure write_Matr(var mt: Tmatr);
var
   i, j: integer;
begin
  for i := 1 to n do
  begin
    for j := 1 to n do
    //write(UTF8ToConsole(mt[i,j]:3));
      write(mt[i,j]:3);
    writeln;
  end;
end;

function equal_two(var s:TStr):boolean;
var flag:boolean;
    i,j:integer;
begin
  flag := false;
  i:=1;
  while (i<n) and not flag do
  begin
    j:=i+1;
    while (j<=n) and not flag do
      if (s[i]=s[j]) then
        flag:=true
      else
        j:= j+1;
   i:= i+1;
  end;
    equal_two:=flag;
end;

procedure make_vect(var mt:Tmatr; var vt:Tvect);
var i:integer;
begin
  for i:=1 to n do
    vt[i]:=equal_two(mt[i]);
end;

procedure print_vect(var vt:Tvect);
var i:integer;
begin
  for i := 1 to n do
    write(vt[i]:6);
  writeln;
end;



begin

//  writeln(UTF8ToConsole('Введите матрицу: '));
  writeln('Read matr: ');
  read_Matr(Matr);

  make_vect(Matr,v);

  writeln('Результат:');
  print_vect(v);




readln;
end.
