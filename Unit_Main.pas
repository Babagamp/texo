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
        // ��������� ������ � ����.
    procedure SaveLog(FileName:string;Mess:string);  //��������� ��� ������ ����
    procedure PrintCheck(Sum:integer;SumPerevod:integer); //��������� ��� ���������� ����


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

uses Unit_Receiving,Unit_InputName;

{$R *.dfm}

// ������������� ���...
procedure TMainForm.PrintCheck(Sum:integer;SumPerevod:Integer);
  var f : TextFile;
  today : TDateTime;

begin
  AssignPrn(f);
  today := now();
  try
    rewrite(f);
    writeln(f,'������.RU');
    writeln(f,'���� "�����������" (���) ��� 5245004890');
    writeln(f,'�������� �� �� �1277 �� 23.08.2012�.');
    writeln(f,'������� ������ ����������: 85202327');
    writeln(f,'�����: ������� , ���������, 2');
    writeln(f,'"���"');
    writeln(f,'����: ' + DateToStr(today) + '  �����: ' + TimeToStr(today));
    writeln(f,'���/���������: 000000000');
    writeln(f,'***************************************************************');
    writeln(f,'����������: �� �������� �������� �������������');
    writeln(f,'��� 520200114474');
    writeln(f,'�����');
    writeln(f,'���');
    writeln(f,'�/� 40802810200000000457  � ��� ������� "�������" �.�������');
    writeln(f,'��� 042202001');
    writeln(f,'----------------------------------------------------------------------');
    writeln(f,'������������:');
    writeln(f,'����������� ������');
    writeln(f,'');
    writeln(f,'��� �����������:');
    writeln(f,'�.� ��������');
    writeln(f,'');
    writeln(f,'***************************************************************');
    writeln(f,'������� ���������: ' + IntToStr(Sum));
    writeln(f,'����� ��������: ' + IntToStr(SumPerevod));
    writeln(f,'����� �� �������: ' + IntToStr(Sum-SumPerevod));
    writeln(f,'***************************************************************');
    writeln(f,'�������, ��������� ���!');
    writeln(f,'������� ������ ������������');
    writeln(f,'� 8:00 �� 18:00 �� ����������� �������)');
    writeln(f,'+7 831 268-22-22,+7 920 019 44-44');
    writeln(f,' ');
    writeln(f,' ');
  finally
    closeFile(f);
  end;

end;


//��������������� ��������� ��� ������ � ���
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
var SumPerevod: integer;

begin
  Pay := 450;  // ��������� �������� �������
  Sum := 0;    // ������� ���������� ���������� �����
  SumPerevod := 390; // ����� �������� (��!!!!)
  SaveLog('work.log',DateTimeToStr(Now) + ' ��������� ' + IntToStr(Pay) + '�.');
  // �������� ����� ��� ����� ���
  FormInputName.ShowModal;


  // �������� ����� ��� ������ �������
  // FormPay.ShowModal;

  if sum <> 0 then
    begin
       PrintCheck(Sum,SumPerevod);
    end


end;



end.
