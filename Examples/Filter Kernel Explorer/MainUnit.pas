unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList,
  Vcl.StdActns, Vcl.Menus, Vcl.ExtCtrls,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series,
  Fftw3_Common, Fftw3_64, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFormFilterKernelExplorer = class(TForm)
    ActionDomainFilterKernel: TAction;
    ActionDomainMagnitude: TAction;
    ActionDomainPhase: TAction;
    ActionDomainComplex: TAction;
    ActionFileExit: TFileExit;
    ActionList: TActionList;
    Chart: TChart;
    MainMenu: TMainMenu;
    MenuItemDomain: TMenuItem;
    MenuItemDomainFilterKernel: TMenuItem;
    MenuItemDomainFrequencyDomain: TMenuItem;
    MenuItemDomainPhase: TMenuItem;
    MenuItemDomainReal: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemFile: TMenuItem;
    N1: TMenuItem;
    PanelControl: TPanel;
    LabelLow: TLabel;
    LabelHigh: TLabel;
    TrackBarLow: TTrackBar;
    TrackBarHigh: TTrackBar;
    procedure ActionDomainFilterKernelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionDomainMagnitudeExecute(Sender: TObject);
    procedure ActionDomainPhaseExecute(Sender: TObject);
    procedure ActionDomainComplexExecute(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
  private
    FFftwPlan: TFftw64Plan;
    FKernelSize: Integer;
    FFilterKernel: PFftw64Real;
    FFrequencyDomain: PFftw64Complex;
    FSeriesFilterKernel: TFastLineSeries;
    FSeriesReal: TFastLineSeries;
    FSeriesImaginary: TFastLineSeries;
    FSeriesMagnitude: TFastLineSeries;
    FSeriesPhase: TFastLineSeries;
    FWisdomFileName: TFileName;

    procedure BuildFilterKernel;
  end;

var
  FormFilterKernelExplorer: TFormFilterKernelExplorer;

implementation

uses
  Math;

{$R *.dfm}

procedure TFormFilterKernelExplorer.FormCreate(Sender: TObject);
begin
  FKernelSize := 512;

  // allocate memory
  FFilterKernel := Fftw64AllocReal(FKernelSize);
  FFrequencyDomain := Fftw64AllocComplex(FKernelSize);

  // create FFTW plan
  FFftwPlan := Fftw64PlanDftReal2Complex1D(FKernelSize, FFilterKernel, FFrequencyDomain, []);

  // create series and add to chart
  FSeriesFilterKernel := TFastLineSeries.Create(Chart);
  FSeriesReal := TFastLineSeries.Create(Chart);
  FSeriesImaginary := TFastLineSeries.Create(Chart);
  FSeriesMagnitude := TFastLineSeries.Create(Chart);
  FSeriesPhase := TFastLineSeries.Create(Chart);
  Chart.AddSeries(FSeriesFilterKernel);
  Chart.AddSeries(FSeriesReal);
  Chart.AddSeries(FSeriesImaginary);
  Chart.AddSeries(FSeriesMagnitude);
  Chart.AddSeries(FSeriesPhase);

  FSeriesReal.Active := False;
  FSeriesImaginary.Active := False;
  FSeriesMagnitude.Active := False;
  FSeriesPhase.Active := False;

  FWisdomFileName := ChangeFileExt(ParamStr(0), '.wsd');
end;

procedure TFormFilterKernelExplorer.FormDestroy(Sender: TObject);
begin
  // free memory
  Fftw64Free(FFilterKernel);
  Fftw64Free(FFrequencyDomain);
end;

procedure TFormFilterKernelExplorer.FormShow(Sender: TObject);
begin
  BuildFilterKernel;

  Fftw64ImportWisdomFromFilename(PAnsiChar(AnsiString(FWisdomFileName)));
end;

procedure TFormFilterKernelExplorer.TrackBarChange(Sender: TObject);
begin
  BuildFilterKernel;
end;

procedure TFormFilterKernelExplorer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Fftw64ExportWisdomToFilename(PAnsiChar(AnsiString(FWisdomFileName)));
end;

procedure TFormFilterKernelExplorer.ActionDomainComplexExecute(Sender: TObject);
begin
  FSeriesFilterKernel.Active := False;
  FSeriesReal.Active := True;
  FSeriesImaginary.Active := True;
  FSeriesMagnitude.Active := False;
  FSeriesPhase.Active := False;
end;

procedure TFormFilterKernelExplorer.ActionDomainFilterKernelExecute(
  Sender: TObject);
begin
  FSeriesFilterKernel.Active := True;
  FSeriesReal.Active := False;
  FSeriesImaginary.Active := False;
  FSeriesMagnitude.Active := False;
  FSeriesPhase.Active := False;
end;

procedure TFormFilterKernelExplorer.ActionDomainMagnitudeExecute(
  Sender: TObject);
begin
  FSeriesFilterKernel.Active := False;
  FSeriesReal.Active := False;
  FSeriesImaginary.Active := False;
  FSeriesMagnitude.Active := True;
  FSeriesPhase.Active := False;
end;

procedure TFormFilterKernelExplorer.ActionDomainPhaseExecute(Sender: TObject);
begin
  FSeriesFilterKernel.Active := False;
  FSeriesReal.Active := False;
  FSeriesImaginary.Active := False;
  FSeriesMagnitude.Active := False;
  FSeriesPhase.Active := True;
end;

procedure TFormFilterKernelExplorer.BuildFilterKernel;
var
  Index: Integer;
  Data: PFftw64Real;
  Complex: PFftw64Complex;
  Temp, Scale: Double;
  CutOff: array [0 .. 1] of Double;
begin
  // build sinc filter kernel
  Data := FFilterKernel;

  CutOff[0] := 0.01 * TrackBarLow.Position;
  CutOff[1] := 0.01 * TrackBarHigh.Position;

  Scale := 2 * Pi / (FKernelSize - 1);

  for Index := 0 to FKernelSize - 1 do
  begin
    // calculate sinc function
    if (Index = FKernelSize div 2) then
      Data^ := 2.0 * (CutOff[0] - CutOff[1])
    else
    begin
      Temp := PI * (Index - FKernelSize div 2);
      Data^ := (Sin(2 * CutOff[0] * Temp) - Sin(2 * CutOff[1] * Temp)) / Temp;
    end;

    // apply Blackman-Harris window
    Data^ := Data^ * (0.35875 - 0.48829 * Cos(Index * Scale) +
      0.14128 * Cos(2 * Index * Scale) - 0.01168 * Cos(3 * Index * Scale));

    Inc(Data);
  end;

  Fftw64ExecuteDftReal2Complex(FFftwPlan, FFilterKernel, FFrequencyDomain);

  FSeriesFilterKernel.Clear;
  Data := FFilterKernel;
  for Index := 0 to FKernelSize - 1 do
  begin
    FSeriesFilterKernel.Add(Data^);
    Inc(Data);
  end;

  FSeriesReal.Clear;
  FSeriesImaginary.Clear;
  FSeriesMagnitude.Clear;
  FSeriesPhase.Clear;
  Complex := FFrequencyDomain;
  for Index := 0 to FKernelSize div 2 - 1 do
  begin
    FSeriesReal.Add(Complex^.Re);
    FSeriesImaginary.Add(Complex^.Im);
    FSeriesMagnitude.Add(Hypot(Complex^.Re, Complex^.Im));
    FSeriesPhase.Add(ArcTan2(Complex^.Re, Complex^.Im));
    Inc(Complex);
  end;
end;

end.
