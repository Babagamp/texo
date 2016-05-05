unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCashCode, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TMainform = class(TForm)
    GBMainInput: TGroupBox;
    BtnPay1: TButton;
    XMLDoc: TXMLDocument;
    procedure FormCreate(Sender: TObject);
    procedure BtnPay1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Mainform: TMainform;
  Nominal:TNominal;

implementation

uses Unit_Receiving;

{$R *.dfm}

procedure TMainform.FormCreate(Sender: TObject);
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
end;

procedure TMainform.BtnPay1Click(Sender: TObject);
begin
  FormPay.ShowModal;
end;

end.
