program Homework12;
uses
  SysUtils;

const n = 3;
      m = 3;

type
  TStr = array [1..n] of integer;
  TMatr = array [1..m] of TStr;

var
  Matr : TMatr;
  temp,temp2,temp3,temp_i2,temp_j2,temp_i3,temp_j3,max1: integer;
   i,max2:integer;


//1
procedure read_Matr (var mt:TMatr);
var
   i,j : integer;
begin
  for i := 1 to n do
    for j := 1 to m do
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
    for j := 1 to m do
      write(mt[i,j]:3);
    writeln;
  end;
end;

procedure main_dioganal(var mt:TMatr; var i2:integer);
var i,max:integer;
begin
 max := mt[1,1];
 for i:=2 to n do
     if mt[i,i] > max then
       begin
        max :=mt[i,i];
        i2:=i;
       end;
end;

procedure other_dioganal(var mt:TMatr; var i3,j3:integer);
var i,j,max:integer;
begin
 max:=mt[1,1];
 for i:=1 to n do
     for j:=1 to m do
      if (n=i+j-1) then
        if (mt[i,j] >= max) then
        begin
         max := mt[i,j];
         i3:=i;
         j3:=j;
        end;
end;

begin
writeln('������� �������: ');
read_Matr(Matr);

main_dioganal(Matr,temp_i2);


other_dioganal(Matr,temp_i3,temp_j3);


writeln(max1,max2);

if Matr[temp_i2,temp_i2] > Matr[2,2] then
  begin
    temp3:=Matr[temp_i2,temp_i2];
    Matr[temp_i2,temp_i2]:=Matr[2,2];
    Matr[2,2]:=temp3
  end
else
  begin
    temp3:=Matr[temp_i3,temp_j3];
    Matr[temp_i3,temp_j3]:=Matr[2,2];
    Matr[2,2]:=temp3;
  end;


writeln(' ����� ���������� �������');
//writeln('����� ');
write_Matr(Matr);
readln;

end.
