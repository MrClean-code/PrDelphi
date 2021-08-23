program Hw6;

uses
  System.SysUtils;

type
  Tcountry = string[15];
  Tcontinent = string[15];
  T�ount = string[20];
  TrecBook = record
              Country: Tcountry;
              Continent: Tcontinent;
              Count: T�ount;
             end;

  TBookFile = file of TrecBook;

var
  BookF: TBookFile;
  i,n:longint;
  f_out: TBookFile;

  //����� �� �����
procedure print_Rec(var BookFile: TBookFile; var f:textfile);
var rec:TrecBook;
begin
  read(BookFile,rec);
  with rec do
    writeln(f,'������: ',Country:4,'   ���������: ',Continent:3,'    ����������: ',Count:8);
end;

 // ����� ���� ������� ����� �� �����
procedure print_ALL_rec(var BookFile: TBookFile; var f:textfile);
begin
  Seek(BookFile,0);
  writeln(f,'����������: ');
  while (not eof (BookFile)) do
    print_Rec(BookFile, f);
end;

  // ������ � �����
procedure read_rec_from_kb(var rec: TrecBook);
begin
  writeln('***���� ������***');
  with rec do
  begin
    write('������� ������: ');
    readln(Country);
    write('������� ��������� (����, �������, ������, ������, ���������, ����������) :');
    readln(Continent);
    write('���������: ');
    readln(Count);
    writeln;
  end;
end;

  // ������ � ����� � �����. � ����
procedure Add_Rec_from_kb(var BookFile: TBookFile);
var
  rec:TrecBook;
begin
  read_rec_from_kb(rec);
  write(BookFile,rec);
end;

//procedure Update_Rec(var BookFile: TBookFile; num_Rec: LongInt);
//begin
//  Seek(BookFile, num_Rec); // ��������� ������. ������� �� ������
//  writeln('������ ����. ������: ');
//  print_rec(BookFile, output); //  �����  ������ � ������� �� ���� ������
//  Seek(BookFile, num_rec);     // ������� �� �����. �������
//  writeln('����� ����: ');
//  Add_Rec_from_kb(BookFile);    // ����� ���. �������� ������
//end;

procedure open_file_for_read(var BookFile: TBookFile);     //        ������     Book.txt
var name:string; ok:boolean;
begin
  repeat
    write('������� ��� ����� ��� ������: ');
    readln(name);
    AssignFile(BookFile, name);
    ok:=FileExists(name);
    if not ok then
      writeln('���� �� ����������, ������ ������������?: y - ��');
  until ok;
  reset(BookFile);
end;

procedure open_file_for_write(var BookFile: TBookFile);  // ������          DBook.txt
var name:string; ok:boolean; c:char;
begin
  repeat
    ok:=true;
    write('������� ��� �����: ');
    readln(name);
    AssignFile(BookFile, name);
    if FileExists (name) then
    begin
      writeln('���� ��� ����������, ������ ������������?: y - ��');
      readln(c);
      ok:=c in ['y', 'Y'];
    end;
  until ok;
  rewrite(BookFile);
end;

procedure read_rec_from_file (var BookFile:TBookFile);        // ������ ������  �� ����� �����
var rec:TrecBook;
begin
  with rec do
  begin
     readln(BookFile,rec);
  end;

end;


begin
  Assignfile(BookF, 'Book.txt');
  rewrite(BookF);     // ������
  write('������� ���-�� ����������� �������: ');
  readln(n);
  writeln('�������� ������� �����: ');
  for i := 1 to n do
    Add_Rec_from_kb(BookF);
  writeln('�������� ����� ���������. ������� Enter...');
  readln;
  print_ALL_rec(BookF, output);


  open_file_for_read(BookF);     // ������

  open_file_for_write(f_out);  // ������

  while not eof(BookF) do
  begin
    read_rec_from_file(BookF);
    write(f_out,BookF);

  end;



    closefile(f_out);
    closefile(BookF);
    closefile(BookF);
  readln;
end.
