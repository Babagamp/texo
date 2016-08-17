unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, UCashCode, printers,
  Buttons;

type
  TMainForm = class(TForm)
    GBMainInput: TGroupBox;
    XMLDoc: TXMLDocument;
    SpeedButton01: TSpeedButton;
    SpeedButton02: TSpeedButton;
    SpeedButton03: TSpeedButton;
    SpeedButton04: TSpeedButton;
    SpeedButton05: TSpeedButton;
    SpeedButton06: TSpeedButton;
    SpeedButton07: TSpeedButton;
    SpeedButton08: TSpeedButton;
    SpeedButton09: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnPay1Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
        // Процедура записи в файл.
    procedure SaveLog(FileName:string;Mess:string);  //Процедура для записи лога
    procedure PrintCheck(Sum:integer;SumPerevod:integer; FullName: String); //Процедура для распечатки чека
    procedure ReadPrice();

  end;
  TVariantPay = record
    Name: string[126];
    Pay: integer;
    Plat: integer;
  end;


var
  MainForm: TMainForm;
  Nominal,NoNominal:TNominal;  // Обьект для отслеживания разрешенных для приема купюр
  Pay: integer;  // Переменная для отслеживания количества необходимого для оплаты
  Sum,DaySum,AllSum :integer;  // Нужно отслеживать принимаемую, дневную сумму и общую сумму в купюроприемнике
  NumberCOM :integer;  //  Здесь будет указано на каком порту висит купюроприемник
  TimeOut : integer; // Здесь будет ожидания клиента с секундах, для приема денег
  // Очень хочется реализовать отмену ожидания, если клиент хоть что-то засунул в купюроприемник
  // Только вопрос, а надо ли?
  Price : array[1..20] of TVariantPay = (
    (Name: 'Легковые автомобили'; Pay: 450; Plat: 390),
    (Name: 'Автобусы до 5 тонн'; Pay: 750; Plat: 700),
    (Name: 'Автобусы свыше 5 тонн'; Pay: 900; Plat: 840),
    (Name: 'Грузовые автомобили до 3,5 тонн'; Pay: 450; Plat: 410),
    (Name: 'Грузовые автомобили до 12 тонн'; Pay: 850; Plat: 810),
    (Name: 'Грузовые автомобили свыше 12 тонн'; Pay: 950; Plat: 880),
    (Name: 'Мотоциклы'; Pay: 200; Plat: 180),
    (Name: 'Прицепы до 3,5 тонн'; Pay: 350; Plat: 320),
    (Name: 'Прицепы свыше 3,5 тонн'; Pay: 600; Plat: 570),
    (Name: 'Грузовой автомобиль + прицеп'; Pay: 1550; Plat: 1450),
    (Name: 'Диагностика подвески, тормозов'; Pay: 300; Plat: 250),
    (Name: 'Регулировка фар'; Pay: 200; Plat: 150),
    (Name: 'Деффектация мототехники'; Pay: 500; Plat: 450),
    (Name: 'Клепка накладок на 1 ось'; Pay: 800; Plat: 750),
    (Name: 'Замер СО и СН, Дымность'; Pay: 100; Plat: 80),
    (Name: 'Произвольная сумма'; Pay: 0; Plat: 0),
    (Name: ''; Pay: 0; Plat: 0),
    (Name: ''; Pay: 0; Plat: 0),
    (Name: ''; Pay: 0; Plat: 0),
    (Name: ''; Pay: 0; Plat: 0)
  );

implementation

uses Unit_Receiving,Unit_InputName,Unit_InputNum;

{$R *.dfm}

// Забьем массив с ценами
procedure TMainForm.ReadPrice();
Begin
  //Price[1]:=('Легковые автомобили'),(450),(390);
End;

// Распечатываем чек...
procedure TMainForm.PrintCheck(Sum:integer;SumPerevod:Integer; FullName: String);
  var f : TextFile;
  today : TDateTime;

begin
  AssignPrn(f);
  today := now();
  try
    rewrite(f);
    writeln(f,'ОПЛАТА.RU');
    writeln(f,'Банк "Богородский" (ООО) ИНН 5245004890');
    writeln(f,'Лицензия ЦБ РФ №1277 от 23.08.2012г.');
    writeln(f,'Перевод принят банкоматом: 85202327');
    writeln(f,'Адрес: Арзамас , ул. Короленко, д.2');
    writeln(f,'"СТО"');
    writeln(f,'Дата: ' + DateToStr(today) + '  Время: ' + TimeToStr(today));
    writeln(f,'Чек/квитанция: 000000000');
    writeln(f,'***************************************************************');
    writeln(f,'Получатель: ИП Молодкин Владимир Александрович');
    writeln(f,'ИНН 520200114474');
    writeln(f,'ОКТМО');
    writeln(f,'КБК');
    writeln(f,'Р/с 40802810200000000457  В ЗАО Комбанк "Арзамас" г.Арзамас');
    writeln(f,'БИК 042202001');
    writeln(f,'----------------------------------------------------------------------');
    writeln(f,'Наименование:');
    writeln(f,'Технический осмотр');
    writeln(f,'');
    writeln(f,'ФИО платильщика:');
    writeln(f,FullName);
    writeln(f,'');
    writeln(f,'***************************************************************');
    writeln(f,'Принято наличными: ' + IntToStr(Sum));
    writeln(f,'Сумма перевода: ' + IntToStr(SumPerevod));
    writeln(f,'Плата за перевод: ' + IntToStr(Sum-SumPerevod));
    writeln(f,'***************************************************************');
    writeln(f,'СПАСИБО, СОХРАНИТЕ ЧЕК!');
    writeln(f,'ТЕЛЕФОН ЦЕНТРА ОБСЛУЖИВАНИЯ');
    writeln(f,'С 8:00 ДО 18:00 ПО МОСКОВСКОМУ ВРЕМЕНИ)');
    writeln(f,'+7 831 268-22-22,+7 920 019 44-44');
    writeln(f,' ');
    writeln(f,' ');
  finally
    closeFile(f);
  end;

end;


//Вспомогательная процедура для записи в лог
procedure TMainForm.SaveLog(FileName:string;Mess:string);
var LogFile : TextFile;
Begin
    AssignFile(LogFile, FileName);
    if FileExists(FileName) then Append(LogFile)
      else Rewrite(LogFile);
    writeln(LogFile,Mess);
    CloseFile(LogFile);
end;


//Вызывается при создании формы, здесь все инициализируем и расставим по местам
procedure TMainForm.FormCreate(Sender: TObject);
var x,y,Count,d:integer;

begin

    // Сделаем окно во весь экран
    MainForm.BorderStyle:= bsNone;
    MainForm.WindowState:= wsMaximized;

    // Зададим размеры бокса в зависимости от размеров экрана
    GBMainInput.Height:= MainForm.ClientHeight - 40;
    GBMainInput.Width:= MainForm.ClientWidth - 40;

    //Выровняем Бокс с кнопками по центру
    y:=(MainForm.ClientHeight - GBMainInput.Height) div 2;
    x:=(MainForm.ClientWidth - GBMainInput.Width) div 2;
    GBMainInput.Left := x;
    GBMainInput.Top := y;

    // Вычисление размера кнопки
    // Пусть y единица измерения, тогда кнопку примем за 5y, так как кнопок 8
    // в стобце, то получим всего в клиенской части будет 8*5+9 = 49 единиц.
    //  Тогда единица будет
    d:= GBMainInput.ClientHeight div 49;
    y:=5*d;
    // А примем ка расстояние между стобцами тоже равным y, тогда размер кнопки
    // будет, учитывая что расстояний таких будет 3
    x := (GBMainInput.ClientWidth - 3*d) div 2;


    // Зададим название кнопка на панели и параметр tag в котором будет
    // указатель на строку в массиве Price, а так же зададим положение кнопок
    // и их размер
    For Count:=0 to GBMainInput.ControlCount-1 do
    begin
        (GBMainInput.Controls[Count] as TSpeedButton).Tag := Count+1;
        (GBMainInput.Controls[Count] as TSpeedButton).Caption := {IntToStr(Count+1) +'. ' + }Price[Count+1].Name ;
        (GBMainInput.Controls[Count] as TSpeedButton).Height := y;
        (GBMainInput.Controls[Count] as TSpeedButton).Width := x;
        (GBMainInput.Controls[Count] as TSpeedButton).Left := d + (d+x)*(Count div 8);
        (GBMainInput.Controls[Count] as TSpeedButton).Top := d + (d+y)*(Count mod 8);
        (GBMainInput.Controls[Count] as TSpeedButton).Font.Size:=d+d div 2;
    end;

    //Инициализируем переменную с принимаемыми купюрами
    // Проверка просто существования файла недостаточна
    If FileExists('config.xml') then
      Begin
        // Очень хочется проверить правльность загрузка xml файла, но незнаю пока как
        XMLDoc.LoadFromFile('config.xml');
        XMLDoc.Active := true;

        With  XMLDoc.ChildNodes['config'] do
        begin
          Nominal.B10 := ChildNodes['cash'].ChildNodes['CheckBox10rub'].NodeValue;
          Nominal.B50 := ChildNodes['cash'].ChildNodes['CheckBox50rub'].NodeValue;
          Nominal.B100 := ChildNodes['cash'].ChildNodes['CheckBox100rub'].NodeValue;
          Nominal.B500 := ChildNodes['cash'].ChildNodes['CheckBox500rub'].NodeValue;
          Nominal.B1000 := ChildNodes['cash'].ChildNodes['CheckBox1000rub'].NodeValue;
          Nominal.B5000 := ChildNodes['cash'].ChildNodes['CheckBox5000rub'].NodeValue;

          NumberCOM := ChildNodes['COM'].NodeValue;
          TimeOut := ChildNodes['TimeOut'].NodeValue;

          //ShowMessage(IntToStr(NumberCOM) + ' ' + IntToStr(TimeOut));    //  Это просто проверка на всякий ...

        end;

      end
     else
      Begin
        Showmessage('Создайте файл с конфигурацией "config.xml" c помощью утилиты config.exe');
        Application.Terminate;
      end;

      NoNominal.B10   :=   false;
      NoNominal.B50   :=   false;
      NoNominal.B100  :=   false;
      NoNominal.B500  :=   false;
      NoNominal.B1000  :=   false;
      NoNominal.B5000  :=   false;

    end;

procedure TMainForm.BtnPay1Click(Sender: TObject);
var SumPerevod: integer;

begin

  //(Sender as TSpeedButton).Tag;
  Pay := Price[(Sender as TSpeedButton).Tag].Pay;  // Установим величину платежа
  Sum := 0;    // обнулим количество полученных денег
  SumPerevod := Price[(Sender as TSpeedButton).Tag].Plat; // Сумма перевода (да!!!!)
  FormInputName.EditInput.Text:=''; //Обнулим строку ввода ФИО

  // Зададим заголовок и цену на форму ввода ФИО
  FormInputName.Panel1.Caption := Price[(Sender as TSpeedButton).Tag].Name;
  FormInputName.Panel2.Caption := IntToStr(Price[(Sender as TSpeedButton).Tag].Pay) + ' р.';

  // Логируем навсякий
  SaveLog('work.log',DateTimeToStr(Now) + ' Принимаем ' + IntToStr(Pay) + 'р.');
  //
  // Вызываем форму для ввода ФИО
  If FormInputName.ShowModal = mrOk then
  begin
    SaveLog('work.log',DateTimeToStr(Now) + ' Принимаем от ' + FormInputName.EditInput.Text);
    // Вызываем форму для приема платежа
    FormPay.ShowModal;

    if sum <> 0 then
      begin
        PrintCheck(Sum,SumPerevod,FormInputName.EditInput.Text);
      end

  end;
//   else ShowMessage('Нажато Отмена');


end;



procedure TMainForm.SpeedButton16Click(Sender: TObject);

var SumPerevod: integer;

begin
  //ShowMessage('В стадии разработки');
  FormInputNum.PanelInput.Caption := '0';
  If FormInputNum.ShowModal = mrOk then
   begin
    Pay := StrToInt(FormInputNum.PanelInput.Caption);  // Установим величину платежа
    Sum := 0;    // обнулим количество полученных денег
    SumPerevod := Pay - 50; // Сумма перевода (да!!!!)

    FormInputName.EditInput.Text:=''; //Обнулим строку ввода ФИО

    // Зададим заголовок и цену на форму ввода ФИО
    FormInputName.Panel1.Caption := 'Введенная к оплате сумма';
    FormInputName.Panel2.Caption := FormInputNum.PanelInput.Caption + ' р.';

    // Логируем навсякий
    SaveLog('work.log',DateTimeToStr(Now) + ' Принимаем ' + IntToStr(Pay) + 'р.');

    // Вызываем форму для ввода ФИО
    If FormInputName.ShowModal = mrOk then
    begin

      SaveLog('work.log',DateTimeToStr(Now) + ' Принимаем от ' + FormInputName.EditInput.Text);

      // Вызываем форму для приема платежа
      FormPay.ShowModal;

      if sum <> 0 then
        begin
          PrintCheck(Sum,SumPerevod,FormInputName.EditInput.Text);
        end

    end;

   end;

end;

end.
