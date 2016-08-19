unit Unit_Receiving;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UCashCode;

type
  TFormPay = class(TForm)
    PInput: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    PReceive: TPanel;
    PLeftover: TPanel;
    PPay: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    
    // ������� �� �������, ���� �� ���� ��� ��� �������
    procedure MessagessFormCC(CodeMess:integer;mess:string);
    procedure PolingBillCC(Nominal:word;var CanLoop:boolean);

  end;

var
  FormPay: TFormPay;
  CashCode:TCashCodeBillValidatorCCNET; // ������ ��������������

implementation

uses Unit_Main;

{$R *.dfm}

procedure TFormPay.MessagessFormCC(CodeMess: integer; mess: string);
begin

  if (CodeMess>=100) and (CodeMess<=199) then
  Begin   // ����� � ��� ������ � ���������������� � ��������� ������.
    MainForm.SaveLog('error.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);
    ShowMessage(inttostr(CodeMess)+' : '+mess); //������� ������ �� �����
    Application.Terminate;
  end
  // ����� � ��� ������ � ����������������
  else MainForm.SaveLog('work.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);

  Application.ProcessMessages; //   ���� �� �������� �����  (����� �����, ����� ����� ��������)

end;


// ���������� ������� �� �������, � ��� ����� �������������� ��� ����� ������
procedure TFormPay.PolingBillCC(Nominal: word; var CanLoop: boolean);
begin
  Sum:=Sum+Nominal;
  FormPay.PReceive.Caption:= IntTostr(Sum);
  FormPay.PLeftover.Caption:= IntToStr(Pay-Sum);
  Application.ProcessMessages; // ����� �� �������� �����
end;

procedure TFormPay.FormCreate(Sender: TObject);
var x,y:integer;
begin
    // ������� ���� �� ���� �����
    FormPay.BorderStyle:= bsNone;
    FormPay.WindowState:= wsMaximized;

    //��������� ���� � �������� �� ������
    y:=(FormPay.ClientHeight - PInput.Height) div 2;
    x:=(FormPay.ClientWidth - PInput.Width) div 2;
    PInput.Left := x;
    PInput.Top := y;

    // ������� ������ ��� ������ � ����������������
    CashCode:=TCashCodeBillValidatorCCNET.Create;

    //  ��������� �������
    CashCode.OnProcessMessage:=MessagessFormCC;
    CashCode.OnPolingBill:=PolingBillCC;


end;

procedure TFormPay.Button1Click(Sender: TObject);
begin
  MainForm.SaveLog('work.log',DateTimeToStr(Now) + ' ������ ��������. ������� ' + IntToStr(Sum));
  CashCode.CanPollingLoop:=false;
  //ShowMessage('������ ������ ���������');
end;


procedure TFormPay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      CashCode.CloseComPort;
end;

procedure TFormPay.FormActivate(Sender: TObject);
begin

    PPay.Caption:=IntToStr(Pay);
    PLeftover.Caption:= IntToStr(Pay);
    PReceive.Caption:= IntTostr(Sum);

    // ��������� ���������� �������������� �� COM1
    CashCode.NamberComPort := NumberCOM;
    If CashCode.OpenComPort then
     Begin
       CashCode.Reset;
       CashCode.EnableBillTypes(Nominal);
       Sum:=CashCode.PollingLoop(Pay,TimeOut);   //������ ������ �����
       CashCode.EnableBillTypes(NoNominal);
       CashCode.Poll;
       PostMessage(FormPay.Handle,WM_CLOSE,0,0);
     end
    else
      Begin
        MainForm.SaveLog('error.log',DateTimeToStr(Now) + ' ������ �������� ');
        ShowMessage('������ ��������'); //������� ������ �� �����
        Application.Terminate;
      end;

end;

end.
