unit Unit_Receiving;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UCashCode;

type
  TFormPay = class(TForm)
    PInput: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    LPay: TLabel;
    LReceive: TLabel;
    LLeftover: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    
    // События из примера, пока не знаю как они юзаются
    procedure MessagessFormCC(CodeMess:integer;mess:string);
    procedure PolingBillCC(Nominal:word;var CanLoop:boolean);

  end;

var
  FormPay: TFormPay;
  CashCode:TCashCodeBillValidatorCCNET; // Обьект купюроприемник

implementation

uses Unit_Main;

{$R *.dfm}

procedure TFormPay.MessagessFormCC(CodeMess: integer; mess: string);
begin

  if (CodeMess>=100) and (CodeMess<=199) then
  Begin   // Пишем в лог ошибки с купюроприемником и завершаем работу.
    MainForm.SaveLog('error.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);
    ShowMessage(inttostr(CodeMess)+' : '+mess); //Выведем ошибку на экран
    Application.Terminate;
  end
  // Пишем в лог работу с купюроприемником
  else MainForm.SaveLog('work.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);

  Application.ProcessMessages; //   Чтоб не залипала форма  (Здесь нужна, иначе форма залипает)

end;


// обработчик событий из примера, я так понял переобределяет что нужно делать
procedure TFormPay.PolingBillCC(Nominal: word; var CanLoop: boolean);
begin
  Sum:=Sum+Nominal;
  FormPay.LReceive.Caption:= IntTostr(Sum);
  FormPay.LLeftover.Caption:= IntToStr(Pay-Sum);
  Application.ProcessMessages; // Чтобы не залипала форма
end;

procedure TFormPay.FormCreate(Sender: TObject);
var x,y:integer;
begin
    // Сделаем окно во весь экран
    FormPay.BorderStyle:= bsNone;
    FormPay.WindowState:= wsMaximized;

    //Выровняем Бокс с кнопками по центру
    y:=(FormPay.ClientHeight - PInput.Height) div 2;
    x:=(FormPay.ClientWidth - PInput.Width) div 2;
    PInput.Left := x;
    PInput.Top := y;

    // Создаем обьект для работы с купюроприемником
    CashCode:=TCashCodeBillValidatorCCNET.Create;

    //  Установим события
    CashCode.OnProcessMessage:=MessagessFormCC;
    CashCode.OnPolingBill:=PolingBillCC;


end;

procedure TFormPay.Button1Click(Sender: TObject);
begin
  MainForm.SaveLog('work.log',DateTimeToStr(Now) + ' Нажали вернутся. Принято ' + IntToStr(Sum));
  CashCode.CanPollingLoop:=false;
  //ShowMessage('Нажали кнопку завершить');
end;


procedure TFormPay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      CashCode.CloseComPort;
end;

procedure TFormPay.FormActivate(Sender: TObject);
begin

    LPay.Caption:=IntToStr(Pay);
    LLeftover.Caption:= IntToStr(Pay);
    LReceive.Caption:= IntTostr(Sum);

    // Попробуем подключить купюроприемник на COM1
    CashCode.NamberComPort := NumberCOM;
    If CashCode.OpenComPort then
     Begin
       CashCode.Reset;
       CashCode.EnableBillTypes(Nominal);
       Sum:=CashCode.PollingLoop(Pay,TimeOut);   //запуск приема денег
       CashCode.EnableBillTypes(NoNominal);
       CashCode.Poll;
       PostMessage(FormPay.Handle,WM_CLOSE,0,0);
     end
    else
      Begin
        MainForm.SaveLog('error.log',DateTimeToStr(Now) + ' Ошибка компорта ');
        ShowMessage('Ошибка компорта'); //Выведем ошибку на экран
        Application.Terminate;
      end;

end;

end.
