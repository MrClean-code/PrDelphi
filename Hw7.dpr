program Hw7;

uses
  System.SysUtils;

type
  Tcountry = string[15];
  Tcontinent = string[15];
  Tсount = string[15];
  TrecBook = record
              Country: Tcountry;
              Continent: Tcontinent;
              Count: Tсount;
             end;

  TBookFile = file of TrecBook;


  var k,nm:integer;

procedure open_file_read(var f:textfile);        //Открытие для чтения
var name:string;
    ok:boolean;
begin
  repeat
    write('Введите имя ВХОДНОГО файла: ');
    readln(name);
    AssignFile(f,name);
    ok:=FileExists(name);
    if not ok
    then
      writeln('Такого файла не существует');
  until ok;
  Reset(f);
end;


procedure open_file_write(var f:textfile);      //Открытие для записи
var name:string;
    ok:boolean;
    c:char;
begin
   repeat
     ok:=true;
     write('Введите имя ВЫХОДНОГО файла: ');
     readln(name);
     AssignFile(f,name);
     if FileExists(name)
     then
       begin
         writeln('Такой файл существует! Хотите перезаписать? Да -Y, Нет - любая клавиша');
         readln(c);
         ok:=c in ['y','Y'];
       end;
   until ok;
   Rewrite(f);
end;

procedure open_file_read_TP(var f:TBookFile); // открываем для чтения тип файла
var name:string;
    ok:boolean;
begin
  repeat
    write('Введите имя ВХОДНОГО файла: ');
    readln(name);
    AssignFile(f,name);
    ok:=FileExists(name);
    if not ok
    then
      writeln('Такого файла не существует');
  until ok;
  Reset(f);
end;


procedure open_file_write_TP(var f:TBookFile); // открываем для записи тип файла
var name:string;
    ok:boolean;
    c:char;
begin
   repeat
     ok:=true;
     write('Введите имя ВЫХОДНОГО файла: ');
     readln(name);
     AssignFile(f,name);
     if FileExists(name)
     then
       begin
         writeln('Такой файл существует! Хотите перезаписать? Да -Y, Нет - любая клавиша');
         readln(c);
         ok:=c in ['y','Y'];
       end;
   until ok;
   Rewrite(f);
end;

function nomber_zapis():integer;
var i,n:integer;
begin
  write('Введите кол-во создаваемых записей: ');
  readln(n);
  nomber_zapis := n;
end;

procedure read_rec_from_kb(var rec:TrecBook); // чтение с клавиатуры    1
var n,i:integer;
begin
  writeln('***Ввод записи***');
  with rec do
  begin
     write('Введите  ФИО: ');
     readln(Country);
     write('Введите номер группы:');
     readln(Continent);
     write('Задолжности: ');
     readln(Count);
     writeln;
  end;
end;

procedure createfile_from_keybord;       // создание с клавиатуры 1
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
    writeln('Снова перезаписать? Да -Y, Нет - любая клавиша');
    readln(c);
  until not(c in ['y','Y']);
  closefile(fTp);
end;

procedure read_rec_from_txt(var f:textfile; var rec:TrecBook);      //чтение 2
begin
  readln(f,rec.Country);
  readln(f,rec.Continent);
  readln(f,rec.Count);
end;

procedure createfile_from_txt;                   //            из текст в типиз 2
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

procedure print_rec(var f:textfile; var rec:TrecBook);      // вывод в файл     3
var n,i:integer;
begin

    writeln(f,rec.Country);
    writeln(f,rec.Continent);
    writeln(f,rec.Count);
    writeln(f);
end;

procedure view;             // просмотр файла
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
    sc,count: Tсount;
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
  writeln('Номер изменяемой записи: ');
  readln(num);
  Seek(f,num-1);
  writeln('Старое');
  read(f,rec);
  print_rec(output,rec);
  writeln('Введите новую запись. ');
  read_rec_from_kb(rec);
  Seek(f,num-1);
  write(f,rec);
  closefile(f);
end;


procedure print_TP_to_txt;        // тип в текст
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

    writeln('1)Из консоли в тип. файл.');
    writeln('2)из текстового файла в тип. файл.');
    writeln('3)Просмотр файла типиз.');
    writeln('4)Отбор по кол-ву: ');
    writeln('5)Изменение записи.');
    writeln('6)Типиз в текст.');
    writeln('7)Выход.');
      repeat
          write('введите номер: ');
          readln(k);
          if (k<1) or (k>7)
          then
             writeln('Ошибка');
        until k in [1..7];
      case k of
        1:createfile_from_keybord;
        2:createfile_from_txt;
        3:view;
        4:process_TP;
        5:Changing;
        6:print_TP_to_txt;
      end;
      writeln('ОБРАБОТКА ЗАВЕРШЕНА');
      writeln;
  until k=7;
end.
