unit Unit_Receiving;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPay: TFormPay;

implementation

uses Unit_Main;

{$R *.dfm}

procedure TFormPay.FormCreate(Sender: TObject);
var x,y:integer;
begin
    // Сделаем окно во весь экран
    FormPay.BorderStyle:= bsNone;
    FormPay.WindowState:= wsMaximized;
    MainForm.Hide;

    //Выровняем Бокс с кнопками по центру
    y:=(FormPay.ClientHeight - PInput.Height) div 2;
    x:=(FormPay.ClientWidth - PInput.Width) div 2;
    PInput.Left := x;
    PInput.Top := y;

end;

procedure TFormPay.Button1Click(Sender: TObject);
begin
  FormPay.Close;
end;

end.
