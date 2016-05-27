unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, UCashCode;

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
    procedure SaveLog(FileName:string;Mess:string);


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

procedure TMainForm.SaveLog(FileName:string;Mess:string);    //Вспомогательная процедура для записи в лог
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
begin
  Pay := 200;  // Установим величину платежа
  Sum := 0;    // обнулим количество полученных денег
  SaveLog('work.log',DateTimeToStr(Now) + ' Принимаем ' + IntToStr(Pay) + 'р.');
  // Вызываем форму для приема платежа
  FormPay.ShowModal;

end;



end.
