program PptWatch;

uses
  Forms,
  frmMain in 'frmMain.pas' {PptWatchMainForm},
  PresenTimer in 'PresenTimer.pas',
  FormatSeconds in 'FormatSeconds.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PptWatch';
  Application.CreateForm(TPptWatchMainForm, PptWatchMainForm);
  Application.Run;
end.
