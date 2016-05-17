unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCashCode, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TMainForm = class(TForm)
    GBMainInput: TGroupBox;
    BtnPay1: TButton;
    XMLDoc: TXMLDocument;
    procedure FormCreate(Sender: TObject);
    procedure BtnPay1Click(Sender: TObject);
  private
    { Private declarations }

    // События из примера, пока не знаю как они юзаются
    procedure MessagessFormCC(CodeMess:integer;mess:string);
    procedure PolingBillCC(Nominal:word;var CanLoop:boolean);


  public
    { Public declarations }
        // Процедура записи в файл.
    procedure SaveLog(FileName:string;Mess:string);


  end;

var
  MainForm: TMainForm;
  Nominal:TNominal;  // Обьект для отслеживания разрешенных для приема купюр
  Pay: integer;  // Переменная для отслеживания количества необходимого для оплаты
  Sum,DaySum : integer;  // Нужно отслеживать принимаемую сумму, и общую сумму в купюроприемнике
  CashCode:TCashCodeBillValidatorCCNET; // Обьект купюроприемник

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

procedure TMainForm.MessagessFormCC(CodeMess: integer; mess: string);
begin

  if (CodeMess>=100) and (CodeMess<=199) then
  Begin   // Пишем в лог ошибки с купюроприемником и завершаем работу.
    SaveLog('error.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);
    ShowMessage(inttostr(CodeMess)+' : '+mess); //Выведем ошибку на экран
    Application.Terminate;
  end
  // Пишем в лог работу с купюроприемником
  else SaveLog('work.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);

  Application.ProcessMessages; //   Чтоб не залипала форма  (Здесь нужна, иначе форма залипает)

end;

procedure TMainForm.PolingBillCC(Nominal: word; var CanLoop: boolean);
begin
  Sum:=Sum+Nominal;
  FormPay.LReceive.Caption:= IntTostr(Sum);
  FormPay.LLeftover.Caption:= IntToStr(Pay-Sum);
  Application.ProcessMessages; // Чтобы не залипала форма
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
    If FileExists('config.xml') then
      Begin
        XMLDoc.LoadFromFile('config.xml');
        XMLDoc.Active := true;
        Nominal.B10 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox10rub'].NodeValue;
        Nominal.B50 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox50rub'].NodeValue;
        Nominal.B100 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox100rub'].NodeValue;
        Nominal.B500 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox500rub'].NodeValue;
        Nominal.B1000 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox1000rub'].NodeValue;
        Nominal.B5000 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox5000rub'].NodeValue;
      end
     else
      Begin
        Showmessage('Создайте файл с конфигурацией "config.xml" c помощью утилиты config.exe');
        Application.Terminate;
      end;

    // Создаем обьект для работы с купюроприемником
      CashCode:=TCashCodeBillValidatorCCNET.Create;

    //  Установим события
    CashCode.OnProcessMessage:=MessagessFormCC;
    CashCode.OnPolingBill:=PolingBillCC;

    // Попробуем подключить купюроприемник на COM1
    CashCode.NamberComPort := 1;
    CashCode.OpenComPort; //

    end;

procedure TMainForm.BtnPay1Click(Sender: TObject);
begin
  // Установим величину платежа
  Pay := 500;
  Sum := 0;
  FormPay.LPay.Caption:=IntToStr(Pay);
  FormPay.LLeftover.Caption:= IntToStr(Pay);
  SaveLog('work.log',DateTimeToStr(Now) + ' Принимаем ' + IntToStr(Pay) + 'р.');
  CashCode.Reset;
  CashCode.EnableBillTypes(Nominal);
  // Вызываем форму для приема платежа
  FormPay.ShowModal;
end;



end.
