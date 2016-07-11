unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, UCashCode, printers;

type
  TMainForm = class(TForm)
    GBMainInput: TGroupBox;
    BtnPay1: TButton;
    XMLDoc: TXMLDocument;
    procedure FormCreate(Sender: TObject);
    procedure BtnPay1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
        // Процедура записи в файл.
    procedure SaveLog(FileName:string;Mess:string);  //Процедура для записи лога
    procedure PrintCheck(Sum:integer;SumPerevod:integer); //Процедура для распечатки чека


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

implementation

uses Unit_Receiving;

{$R *.dfm}

// Распечатываем чек...
procedure TMainForm.PrintCheck(Sum:integer;SumPerevod:Integer);
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
    writeln(f,'Адрес: арзамас , короленко, 2');
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
    writeln(f,'В.В Петрович');
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


procedure TMainForm.FormCreate(Sender: TObject);
var x,y:integer;

begin
    // Сделаем окно во весь экран
    MainForm.BorderStyle:= bsNone;
    MainForm.WindowState:= wsMaximized;

    //Выровняем Бокс с кнопками по центру
    y:=(MainForm.ClientHeight - GBMainInput.Height) div 2;
    x:=(MainForm.ClientWidth - GBMainInput.Width) div 2;
    GBMainInput.Left := x;
    GBMainInput.Top := y;

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
  Pay := 450;  // Установим величину платежа
  Sum := 0;    // обнулим количество полученных денег
  SumPerevod := 390; // Сумма перевода (да!!!!)
  SaveLog('work.log',DateTimeToStr(Now) + ' Принимаем ' + IntToStr(Pay) + 'р.');
  // Вызываем форму для приема платежа
  FormPay.ShowModal;

  if sum <> 0 then
    begin
       PrintCheck(Sum,SumPerevod);
    end


end;



end.
