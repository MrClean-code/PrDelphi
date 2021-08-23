program Hw4;
type
  course = (north, south, west, east);
  order = (up, left, right, back);
const
  names:array [order] of string = ('north', 'south' , 'west', 'east');
var
  K1, K2: course;
  PR, PR2: order;
  c:integer;

function make_PR:order;
var k:integer;
begin
  writeln('������� ������: 1 - up, 2 - left, 3 - right, 4 - back');
  readln(k);
  case k of
    1: make_PR:=up;
    2: make_PR:=left;
    3: make_PR:=right;
    4: make_PR:=back;
  end;
end;

function make_CR:course;
var k:integer;
begin
  writeln('������� ����: 1 - north, 2 - south, 3 - west, 4 - east');
  readln(k);
  case k of
    1: make_CR:=north;
    2: make_CR:=south;
    3: make_CR:=west;
    4: make_CR:=east;
  end;
end;

function def_order_course(pr:order):order;
var k:integer;
begin
  writeln('������� ����� ������: ');
  readln(k);
  case k of
    1: def_order_course:=up;
    2: def_order_course:=left;
    3: def_order_course:=right;
    4: def_order_course:=back;
  end;

end;


begin
  writeln('��������� ������: ');
  PR:= make_PR;
  writeln('��������� ����: ');
  K1:= make_CR;
  PR2:=def_order_course(PR);
  writeln('���������� ����: ');
  writeln(names[PR2]);



  readln;
end.
