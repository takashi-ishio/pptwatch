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

// �����Ƀe�X�g�Ώۂ̃��j�b�g�����ׂ�

begin
  Application.Initialize;
  GUITestRunner.RunRegisteredTests; // �e�X�g�C���^�t�F�[�X�\��
end.
