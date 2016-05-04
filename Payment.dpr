program Payment;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {Mainform},
  Unit_Receiving in 'Unit_Receiving.pas' {FormPay};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainform, Mainform);
  Application.CreateForm(TFormPay, FormPay);
  Application.Run;
end.
