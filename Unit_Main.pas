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
        // ��������� ������ � ����.
    procedure SaveLog(FileName:string;Mess:string);


  end;

var
  MainForm: TMainForm;
  Nominal,NoNominal:TNominal;  // ������ ��� ������������ ����������� ��� ������ �����
  Pay: integer;  // ���������� ��� ������������ ���������� ������������ ��� ������
  Sum,DaySum,AllSum :integer;  // ����� ����������� �����������, ������� ����� � ����� ����� � ���������������
  NumberCOM :integer;  //  ����� ����� ������� �� ����� ����� ����� ��������������
  TimeOut : integer; // ����� ����� �������� ������� � ��������, ��� ������ �����
  // ����� ������� ����������� ������ ��������, ���� ������ ���� ���-�� ������� � ��������������
  // ������ ������, � ���� ��?

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
    // �������� ������ ������������� ����� ������������
    If FileExists('config.xml') then
      Begin
        // ����� ������� ��������� ����������� �������� xml �����, �� ������ ���� ���
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

          //ShowMessage(IntToStr(NumberCOM) + ' ' + IntToStr(TimeOut));    //  ��� ������ �������� �� ������ ...

        end;

      end
     else
      Begin
        Showmessage('�������� ���� � ������������� "config.xml" c ������� ������� config.exe');
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
  Pay := 200;  // ��������� �������� �������
  Sum := 0;    // ������� ���������� ���������� �����
  SaveLog('work.log',DateTimeToStr(Now) + ' ��������� ' + IntToStr(Pay) + '�.');
  // �������� ����� ��� ������ �������
  FormPay.ShowModal;

end;



end.
