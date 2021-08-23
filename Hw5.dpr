program Hw5;
uses
  SysUtils;
const
  n = 3;
type
  TTest = array[1..n] of integer;
  TStr = array [1..n] of integer;
  TMatr = array [1..n] of TStr;
  Tvect = array [1..n] of boolean;
var
  Matr:TMatr;
  T:TTest;
  v:Tvect;
  f_in,f_out:textfile;

procedure open_file_for_write(var Ts:textfile);  // запись
var name:string; ok:boolean; c:char;
begin
  repeat
    ok:=true;
    write('Введите имя файла: ');
    readln(name);
    AssignFile(Ts, name);
    if FileExists (name) then
    begin
      writeln('Файл уже существует, хотите перезаписать?: y - да');
      readln(c);
      ok:=c in ['y', 'Y'];
    end;
  until ok;
  rewrite(Ts);
end;

procedure open_file_for_read(var Ts:textfile);     //        чтение
var name:string; ok:boolean;
begin
  repeat
    write('Введите имя файла: ');
    readln(name);
    AssignFile(Ts, name);
    ok:=FileExists(name);
    if not ok then
      writeln('Файл не существует, хотите перезаписать?: y - да');
  until ok;
  reset(Ts);
end;

procedure Read_Matr(var Ts: textfile; var Matr: TMatr);
var i,j: integer;
begin
i:=1;
while not eof (Ts) and (i<=n) do
  begin
    j:=1;
    while not eof (Ts)and (j<=n) do
    begin
      Read(Ts,Matr[i,j]);
      inc(j);
    end;
  inc(i);
  readln(Ts);
  end;
end;


procedure Init (var Test: TTest);
  var c:integer;
  begin
    for c := 1 to n do
      Test[c]:=0;
  end;

procedure Make_Set(var Matr:TMatr; var Test: TTest);
  var i,j: integer;
  begin
    Init(Test);
    for i := 1 to n do
      for j := 1 to n do
        Test[Matr[i,j]]:=Test[Matr[i,j]]+1;
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


procedure make_vect(var mt:TMatr; var vt:Tvect);
var i:integer;
begin
  for i:=1 to n do
    vt[i]:=equal_two(mt[i]);
end;


procedure print_vect(var vt:Tvect; var Ts: textfile);
var i:integer;
begin
  for i := 1 to n do
    write(Ts,vt[i]:8);
  writeln;
end;

procedure print_matr(var Matr: TMatr; var Ts: textfile);
var i,j: integer;
begin
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(Ts,Matr[i,j]:3);
    writeln(Ts);
  end;
end;


begin

  open_file_for_read(f_in);   // чтение
  writeln;
  open_file_for_write(f_out);  // запись




  while not eof(f_in) do
  begin
    Read_Matr(f_in,Matr);
    Make_set(Matr,T);
    writeln(f_out,'Матрица:');
    print_matr(Matr,f_out);
    make_vect(Matr,v);
    write(f_out,'Результат:');
    print_vect(v,f_out);
    writeln(f_out);
    if not eof(f_in) then
    begin
      readln(f_in);

      writeln(f_out);

    end;
  end;
  closefile(f_in);
  closefile(f_out);
  writeln('обработка закончена! ');
  readln;
end.
