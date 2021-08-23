program Hw6;

uses
  System.SysUtils;

type
  Tcountry = string[15];
  Tcontinent = string[15];
  Tсount = string[20];
  TrecBook = record
              Country: Tcountry;
              Continent: Tcontinent;
              Count: Tсount;
             end;

  TBookFile = file of TrecBook;

var
  BookF: TBookFile;
  i,n:longint;
  f_out: TBookFile;

  //вывод на экран
procedure print_Rec(var BookFile: TBookFile; var f:textfile);
var rec:TrecBook;
begin
  read(BookFile,rec);
  with rec do
    writeln(f,'Страна: ',Country:4,'   Континент: ',Continent:3,'    Населениие: ',Count:8);
end;

 // вывод всех записей файла на экран
procedure print_ALL_rec(var BookFile: TBookFile; var f:textfile);
begin
  Seek(BookFile,0);
  writeln(f,'Справочник: ');
  while (not eof (BookFile)) do
    print_Rec(BookFile, f);
end;

  // чтение с клавы
procedure read_rec_from_kb(var rec: TrecBook);
begin
  writeln('***Ввод записи***');
  with rec do
  begin
    write('Введите страну: ');
    readln(Country);
    write('Введите континент (Азия, Америка, Европа, Африка, Австралия, Антарктида) :');
    readln(Continent);
    write('Население: ');
    readln(Count);
    writeln;
  end;
end;

  // чтение с клавы и добав. в файл
procedure Add_Rec_from_kb(var BookFile: TBookFile);
var
  rec:TrecBook;
begin
  read_rec_from_kb(rec);
  write(BookFile,rec);
end;

//procedure Update_Rec(var BookFile: TBookFile; num_Rec: LongInt);
//begin
//  Seek(BookFile, num_Rec); // установка файлов. позиции по номеру
//  writeln('старое знач. записи: ');
//  print_rec(BookFile, output); //  вывод  записи и перевод на след запись
//  Seek(BookFile, num_rec);     // возврат на прежн. позицию
//  writeln('новое знач: ');
//  Add_Rec_from_kb(BookFile);    // вывод изм. значения записи
//end;

procedure open_file_for_read(var BookFile: TBookFile);     //        чтение     Book.txt
var name:string; ok:boolean;
begin
  repeat
    write('Введите имя файла для чтения: ');
    readln(name);
    AssignFile(BookFile, name);
    ok:=FileExists(name);
    if not ok then
      writeln('Файл не существует, хотите перезаписать?: y - да');
  until ok;
  reset(BookFile);
end;

procedure open_file_for_write(var BookFile: TBookFile);  // запись          DBook.txt
var name:string; ok:boolean; c:char;
begin
  repeat
    ok:=true;
    write('Введите имя файла: ');
    readln(name);
    AssignFile(BookFile, name);
    if FileExists (name) then
    begin
      writeln('Файл уже существует, хотите перезаписать?: y - да');
      readln(c);
      ok:=c in ['y', 'Y'];
    end;
  until ok;
  rewrite(BookFile);
end;

procedure read_rec_from_file (var BookFile:TBookFile);        // чтение записи  из текст файла
var rec:TrecBook;
begin
  with rec do
  begin
     readln(BookFile,rec);
  end;

end;


begin
  Assignfile(BookF, 'Book.txt');
  rewrite(BookF);     // запись
  write('Введите кол-во создаваемых записей: ');
  readln(n);
  writeln('Создание записей файла: ');
  for i := 1 to n do
    Add_Rec_from_kb(BookF);
  writeln('Создание файла завершено. Нажмите Enter...');
  readln;
  print_ALL_rec(BookF, output);


  open_file_for_read(BookF);     // чтение

  open_file_for_write(f_out);  // запись

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
