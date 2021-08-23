program Hw7;

uses
  System.SysUtils;

type
  Tcountry = string[15];
  Tcontinent = string[15];
  T�ount = string[15];
  TrecBook = record
              Country: Tcountry;
              Continent: Tcontinent;
              Count: T�ount;
             end;

  TBookFile = file of TrecBook;


  var k,nm:integer;

procedure open_file_read(var f:textfile);        //�������� ��� ������
var name:string;
    ok:boolean;
begin
  repeat
    write('������� ��� �������� �����: ');
    readln(name);
    AssignFile(f,name);
    ok:=FileExists(name);
    if not ok
    then
      writeln('������ ����� �� ����������');
  until ok;
  Reset(f);
end;


procedure open_file_write(var f:textfile);      //�������� ��� ������
var name:string;
    ok:boolean;
    c:char;
begin
   repeat
     ok:=true;
     write('������� ��� ��������� �����: ');
     readln(name);
     AssignFile(f,name);
     if FileExists(name)
     then
       begin
         writeln('����� ���� ����������! ������ ������������? �� -Y, ��� - ����� �������');
         readln(c);
         ok:=c in ['y','Y'];
       end;
   until ok;
   Rewrite(f);
end;

procedure open_file_read_TP(var f:TBookFile); // ��������� ��� ������ ��� �����
var name:string;
    ok:boolean;
begin
  repeat
    write('������� ��� �������� �����: ');
    readln(name);
    AssignFile(f,name);
    ok:=FileExists(name);
    if not ok
    then
      writeln('������ ����� �� ����������');
  until ok;
  Reset(f);
end;


procedure open_file_write_TP(var f:TBookFile); // ��������� ��� ������ ��� �����
var name:string;
    ok:boolean;
    c:char;
begin
   repeat
     ok:=true;
     write('������� ��� ��������� �����: ');
     readln(name);
     AssignFile(f,name);
     if FileExists(name)
     then
       begin
         writeln('����� ���� ����������! ������ ������������? �� -Y, ��� - ����� �������');
         readln(c);
         ok:=c in ['y','Y'];
       end;
   until ok;
   Rewrite(f);
end;

function nomber_zapis():integer;
var i,n:integer;
begin
  write('������� ���-�� ����������� �������: ');
  readln(n);
  nomber_zapis := n;
end;

procedure read_rec_from_kb(var rec:TrecBook); // ������ � ����������    1
var n,i:integer;
begin
  writeln('***���� ������***');
  with rec do
  begin
     write('�������  ���: ');
     readln(Country);
     write('������� ����� ������:');
     readln(Continent);
     write('�����������: ');
     readln(Count);
     writeln;
  end;
end;

procedure createfile_from_keybord;       // �������� � ���������� 1
var i,n:integer;
    fTp:TBookFile;
    rec:TrecBook;
    c:char;
begin
  open_file_write_TP(ftp);
  repeat
  n:= nomber_zapis;
    for i := 1 to n do
    begin
      read_rec_from_kb(rec);
      write(fTp,rec);
    end;
    writeln('����� ������������? �� -Y, ��� - ����� �������');
    readln(c);
  until not(c in ['y','Y']);
  closefile(fTp);
end;

procedure read_rec_from_txt(var f:textfile; var rec:TrecBook);      //������ 2
begin
  readln(f,rec.Country);
  readln(f,rec.Continent);
  readln(f,rec.Count);
end;

procedure createfile_from_txt;                   //            �� ����� � ����� 2
var n,i:integer;
    ftxt:textfile;
    FTp:TBookFile;
    rec:TrecBook;
begin

  open_file_read(ftxt);
  open_file_write_TP(FTp);

  while not eof(ftxt) do
    begin
      read_rec_from_txt(ftxt,rec);
      write(FTp,rec);
      if not eof(ftxt)  then
        readln(ftxt);
    end;
  closefile(ftxt);
  closefile(FTp);
end;

procedure print_rec(var f:textfile; var rec:TrecBook);      // ����� � ����     3
var n,i:integer;
begin

    writeln(f,rec.Country);
    writeln(f,rec.Continent);
    writeln(f,rec.Count);
    writeln(f);
end;

procedure view;             // �������� �����
var fTp:TBookFile;
    rec:TrecBook;
begin
  open_file_read_TP(fTp);
  while not eof(fTp) do
    begin
      read(fTp,rec);
      print_rec(output,rec);
    end;
  closefile(fTp);
end;


procedure process_TP;             // 4
var fInt: TBookFile;
    fOut:TBookFile;
    rec:TrecBook;
    sc,count: T�ount;
begin
  open_file_read_TP(fInt);
  open_file_write_TP(fOut);

  while not eof(fInt) do
    begin
      read(fInt,rec);
      if rec.Count <> 'yes'   then
        write(fOut,rec);
    end;
  closefile(fInt);
  closefile(FOut);
end;


procedure Changing;     //        5
var num:longint;
    rec:TrecBook;
    f:TBookFile;
begin
  open_file_read_TP(f);
  writeln('����� ���������� ������: ');
  readln(num);
  Seek(f,num-1);
  writeln('������');
  read(f,rec);
  print_rec(output,rec);
  writeln('������� ����� ������. ');
  read_rec_from_kb(rec);
  Seek(f,num-1);
  write(f,rec);
  closefile(f);
end;


procedure print_TP_to_txt;        // ��� � �����
var fTxt:textfile;
    fTp:TBookFile;
    rec:TrecBook;
begin
  open_file_read_TP(fTp);
  open_file_write(fTxt);
  while not eof(fTp) do
    begin
      read(fTp,rec);
      print_rec(fTxt,rec);
    end;
  closefile(fTxt);
  closefile(fTp);
end;


begin

  repeat

    writeln('1)�� ������� � ���. ����.');
    writeln('2)�� ���������� ����� � ���. ����.');
    writeln('3)�������� ����� �����.');
    writeln('4)����� �� ���-��: ');
    writeln('5)��������� ������.');
    writeln('6)����� � �����.');
    writeln('7)�����.');
      repeat
          write('������� �����: ');
          readln(k);
          if (k<1) or (k>7)
          then
             writeln('������');
        until k in [1..7];
      case k of
        1:createfile_from_keybord;
        2:createfile_from_txt;
        3:view;
        4:process_TP;
        5:Changing;
        6:print_TP_to_txt;
      end;
      writeln('��������� ���������');
      writeln;
  until k=7;
end.
