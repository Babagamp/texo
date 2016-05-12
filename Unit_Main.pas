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
    CashCode:TCashCodeBillValidatorCCNET; // ������ ��������������

    // ������� �� �������, ���� �� ���� ��� ��� �������
    procedure MessagessFormCC(CodeMess:integer;mess:string);
    procedure PolingBillCC(Nominal:word;var CanLoop:boolean);

  public
    { Public declarations }
    Sum,DaySum : integer;  // ����� ����������� ����������� �����, � ����� ����� � ���������������.
  end;

var
  MainForm: TMainForm;
  Nominal:TNominal;  // ������ ��� ������������ ����������� ��� ������ �����
  Pay: integer;  // ���������� ��� ������������ ���������� ������������ ��� ������

implementation

uses Unit_Receiving;

{$R *.dfm}

procedure TMainForm.MessagessFormCC(CodeMess: integer; mess: string);
var LogFile : TextFile;
begin
  AssignFile(LogFile, 'error.log');
  if FileExists('error.log') then Append(LogFile)
    else Rewrite(LogFile);

  writeln(LogFile,DateTimeToStr(Now) + inttostr(CodeMess)+' : '+mess);

  CloseFile(LogFile);
  ShowMessage(inttostr(CodeMess)+' : '+mess); //������� ������ �� �����
  Application.Terminate;
  Application.ProcessMessages; //   ���� �� �������� �����
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
    // ������� ���� �� ���� �����
    MainForm.BorderStyle:= bsNone;
    MainForm.WindowState:= wsMaximized;

    //��������� ���� � �������� �� ������
    y:=(MainForm.ClientHeight - GBMainInput.Height) div 2;
    x:=(MainForm.ClientWidth - GBMainInput.Width) div 2;
    GBMainInput.Left := x;
    GBMainInput.Top := y;

    //�������������� ���������� � ������������ ��������
    XMLDoc.LoadFromFile('config.xml');
    XMLDoc.Active := true;
    Nominal.B10 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox10rub'].NodeValue;
    Nominal.B50 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox50rub'].NodeValue;
    Nominal.B100 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox100rub'].NodeValue;
    Nominal.B500 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox500rub'].NodeValue;
    Nominal.B1000 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox1000rub'].NodeValue;
    Nominal.B5000 := XMLDoc.ChildNodes['config_cash'].ChildNodes['CheckBox5000rub'].NodeValue;

    // ������� ������ ��� ������ � ����������������
      CashCode:=TCashCodeBillValidatorCCNET.Create;

    //  ��������� �������??????????
  CashCode.OnProcessMessage:=MessagessFormCC;
  CashCode.OnPolingBill:=PolingBillCC;

    // ��������� ���������� �������������� �� COM1
    CashCode.NamberComPort := 1;
    if  CashCode.OpenComPort then
    Begin

    end

end;

procedure TMainForm.BtnPay1Click(Sender: TObject);
begin
  // ��������� �������� �������
  Pay := 500;
  FormPay.LPay.Caption:=IntToStr(Pay);
  FormPay.LLeftover.Caption:= IntToStr(Pay);
  // �������� ����� ��� ������ �������
  FormPay.ShowModal;
end;



end.
