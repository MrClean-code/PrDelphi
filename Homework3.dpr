program Homework3;

var
  str1_length,str2_length,temp: integer;
  str1,str2:string;

function find_number_equal(str1:string; str2:string):integer;
var i,j,s,p,ps:integer;
  begin
    ps:=0;
    p:= pos(str1,str2);
    while p<>0 do
      begin
        ps:=p+ps;
        delete(str2,1,p);
        p:=pos(str1,str2);
      end;
      find_number_equal:=ps;
  end;

begin
  writeln('������� ������ �����');
  readln(str2);
  writeln('������� ������ �����, ������� ���� �����');
  readln(str1);
  str2_length := Length(str2);
 // str1_length := Length(str1);
  writeln('�����');
  temp:=find_number_equal(str1,str2);
  if temp > 0 then
    writeln(temp)
  else
    writeln(' ��� ������ ��������!');

  readln;


end.
