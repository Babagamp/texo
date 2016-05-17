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

    // ������� �� �������, ���� �� ���� ��� ��� �������
    procedure MessagessFormCC(CodeMess:integer;mess:string);
    procedure PolingBillCC(Nominal:word;var CanLoop:boolean);


  public
    { Public declarations }
        // ��������� ������ � ����.
    procedure SaveLog(FileName:string;Mess:string);


  end;

var
  MainForm: TMainForm;
  Nominal:TNominal;  // ������ ��� ������������ ����������� ��� ������ �����
  Pay: integer;  // ���������� ��� ������������ ���������� ������������ ��� ������
  Sum,DaySum : integer;  // ����� ����������� ����������� �����, � ����� ����� � ���������������
  CashCode:TCashCodeBillValidatorCCNET; // ������ ��������������

implementation

uses Unit_Receiving;

{$R *.dfm}

procedure TMainForm.SaveLog(FileName:string;Mess:string);    //��������������� ��������� ��� ������ � ���
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
  Begin   // ����� � ��� ������ � ���������������� � ��������� ������.
    SaveLog('error.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);
    ShowMessage(inttostr(CodeMess)+' : '+mess); //������� ������ �� �����
    Application.Terminate;
  end
  // ����� � ��� ������ � ����������������
  else SaveLog('work.log',DateTimeToStr(Now) + ' ' + inttostr(CodeMess)+' : ' + mess);

  Application.ProcessMessages; //   ���� �� �������� �����  (����� �����, ����� ����� ��������)

end;

procedure TMainForm.PolingBillCC(Nominal: word; var CanLoop: boolean);
begin
  Sum:=Sum+Nominal;
  FormPay.LReceive.Caption:= IntTostr(Sum);
  FormPay.LLeftover.Caption:= IntToStr(Pay-Sum);
  Application.ProcessMessages; // ����� �� �������� �����
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
        Showmessage('�������� ���� � ������������� "config.xml" c ������� ������� config.exe');
        Application.Terminate;
      end;

    // ������� ������ ��� ������ � ����������������
      CashCode:=TCashCodeBillValidatorCCNET.Create;

    //  ��������� �������
    CashCode.OnProcessMessage:=MessagessFormCC;
    CashCode.OnPolingBill:=PolingBillCC;

    // ��������� ���������� �������������� �� COM1
    CashCode.NamberComPort := 1;
    CashCode.OpenComPort; //

    end;

procedure TMainForm.BtnPay1Click(Sender: TObject);
begin
  // ��������� �������� �������
  Pay := 500;
  Sum := 0;
  FormPay.LPay.Caption:=IntToStr(Pay);
  FormPay.LLeftover.Caption:= IntToStr(Pay);
  SaveLog('work.log',DateTimeToStr(Now) + ' ��������� ' + IntToStr(Pay) + '�.');
  CashCode.Reset;
  CashCode.EnableBillTypes(Nominal);
  // �������� ����� ��� ������ �������
  FormPay.ShowModal;
end;



end.
