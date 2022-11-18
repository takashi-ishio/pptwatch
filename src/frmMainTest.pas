unit frmMainTest;

interface

uses
    frmMain,
    TestFrameWork; // TTestCase Ç»Ç«ÇéQè∆Ç∑ÇÈÇÃÇ…ïKóv

type
    TMainFormTest = class(TTestCase)
    private
        Form: TPptWatchMainForm;
    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure TestMakeLogString;
    end;

implementation

procedure TMainFormTest.TestMakeLogString;
begin
    CheckEqualsString('TEST         100      1:40', Form.makeLogString('TEST', 100));
end;

procedure TMainFormTest.SetUp;
begin
    Form := TPptWatchMainForm.Create(nil);
end;

procedure TMainFormTest.TearDown;
begin
    Form.Free;
end;


initialization
  TestFramework.RegisterTest(TMainFormTest.Suite);


end.
 