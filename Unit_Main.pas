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
    CashCode:TCashCodeBillValidatorCCNET; // Обьект купюроприемник

    // События из примера, пока не знаю как они юзаются
    procedure MessagessFormCC(CodeMess:integer;mess:string);
    procedure PolingBillCC(Nominal:word;var CanLoop:boolean);

  public
    { Public declarations }
    Sum,DaySum : integer;  // Нужно отслеживать принимаемую сумму, и общую сумму в купюроприемнике.
  end;

var
  MainForm: TMainForm;
  Nominal:TNominal;  // Обьект для отслеживания разрешенных для приема купюр
  Pay: integer;  // Переменная для отслеживания количества необходимого для оплаты

implementation

uses Unit_Receiving;

{$R *.dfm}

procedure TMainForm.MessagessFormCC(CodeMess: integer; mess: string);
begin
  {if (CodeMess>100) and (CodeMess<=199)
  then Memo1.Lines.Add('?????? : '+inttostr(CodeMess)+' : '+mess)
  else Memo1.Lines.Add(inttostr(CodeMess)+' : '+mess);
  Application.ProcessMessages; // ???? ?? ???????? ????? }
end;

procedure TMainForm.PolingBillCC(Nominal: word; var CanLoop: boolean);
begin
  {FSum:=FSum+Nominal;
  Memo1.Lines.Add('??????? '+intToStr(Nominal)+' ??????');
  RefreshSum();
  Application.ProcessMessages; // ???? ?? ???????? ?????}
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
    XMLDoc.LoadFromFile('config.xml');
    XMLDoc.Active := true;
    Nominal.B10 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox10rub'].NodeValue;
    Nominal.B50 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox50rub'].NodeValue;
    Nominal.B100 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox100rub'].NodeValue;
    Nominal.B500 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox500rub'].NodeValue;
    Nominal.B1000 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox1000rub'].NodeValue;
    Nominal.B5000 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox5000rub'].NodeValue;

    // Создаем обьект для работы с купюроприемником
      CashCode:=TCashCodeBillValidatorCCNET.Create;

    //  ????????? ???????    Установим события??????????
  CashCode.OnProcessMessage:=MessagessFormCC;
  CashCode.OnPolingBill:=PolingBillCC;

    // Попробуем подключить купюроприемник на COM1
    CashCode.NamberComPort := 1;
    if CashCode.OpenComPort then
    Begin
      ShowMessage('Не подключен купюроприемник');
      MainForm.Close;
    end;



end;

procedure TMainForm.BtnPay1Click(Sender: TObject);
begin
  // Установим величину платежа
  Pay := 500;
  FormPay.LPay.Caption:=IntToStr(Pay);
  FormPay.LLeftover.Caption:= IntToStr(Pay);
  // Вызываем форму для приема платежа
  FormPay.ShowModal;
end;

end.
