program PptWatchTest;

uses
  Forms,
  TestFrameWork,
  GUITestRunner,
  PresenTimer in 'PresenTimer.pas',
  FormatSeconds in 'FormatSeconds.pas',
  frmMain in 'frmMain.pas' {PptWatchMainForm},
  FormatSecondsTest in 'FormatSecondsTest.pas',
  PresenTimerTest in 'PresenTimerTest.pas',
  frmMainTest in 'frmMainTest.pas';

// ここにテスト対象のユニットも並べる

begin
  Application.Initialize;
  GUITestRunner.RunRegisteredTests; // テストインタフェース表示
end.
