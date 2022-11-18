unit FormatSecondsTest;

interface

uses
    FormatSeconds,
    TestFrameWork; // TTestCase Ç»Ç«ÇéQè∆Ç∑ÇÈÇÃÇ…ïKóv

type
    TFormatSecondsTest = class(TTestCase)
    published
        procedure TestFormatSecondsToMinSec;
    end;



implementation

procedure TFormatSecondsTest.TestFormatSecondsToMinSec;
begin
    CheckEqualsString('0:00', FormatSecondsToMinSec(0), 'FormatSecondsToMinSec - 0');
    CheckEqualsString('0:01', FormatSecondsToMinSec(1), 'FormatSecondsToMinSec - 1');
    CheckEqualsString('0:10', FormatSecondsToMinSec(10), 'FormatSecondsToMinSec - 10');
    CheckEqualsString('0:59', FormatSecondsToMinSec(59), 'FormatSecondsToMinSec - 59');
    CheckEqualsString('1:00', FormatSecondsToMinSec(60), 'FormatSecondsToMinSec - 60');
    CheckEqualsString('6:15', FormatSecondsToMinSec(375), 'FormatSecondsToMinSec - 375');
    CheckEqualsString('10:00', FormatSecondsToMinSec(600), 'FormatSecondsToMinSec - 600');
    CheckEqualsString('100:00', FormatSecondsToMinSec(6000), 'FormatSecondsToMinSec - 6000');
end;


initialization
  TestFramework.RegisterTest(TFormatSecondsTest.Suite);


end.
 