unit Fftw3_32;

{$I Fftw3.inc}

interface

uses
  SysUtils,
  Fftw3_Common;

const
  CLibFftw32 = 'libfftw3f-3.dll';

type
  PFftw32Real = ^Single;
  TFftw32Complex = packed record
    case Boolean of
      False: (Value: array [0..1] of Single);
      True: (Re: Single; Im: Single);
  end;
  PFftw32Complex = ^TFftw32Complex;

  TFftw32Plan = type Pointer;

{$IFDEF DynLink}
  TFftw32Execute = procedure (const Plan: TFftw32Plan); cdecl;
  TFftw32PlanDft = function (Rank: Integer; const N: PInteger; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDft1D = function (N: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDft2D = function (N0, N1: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDft3D = function (N0, N1, N2: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32PlanManyDft = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruSplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64Dft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64SplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32ExecuteDft = procedure (const Plan: TFftw32Plan; &In, &Out: PFftw32Complex); cdecl;
  TFftw32ExecuteSplitDft = procedure (const Plan: TFftw32Plan; Ri, Ii, Ro, Io: PFftw32Real); cdecl;

  TFftw32PlanManyDftReal2Complex = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex = function (Rank: Integer; const N: PInteger; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex1D = function (N: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex2D = function (N0, N1: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex3D = function (N0, N1, N2: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32PlanManyDftComplex2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real = function (Rank: Integer; const N: PInteger; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real1D = function (N: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real2D = function (N0, N1: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real3D = function (N0, N1, N2: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32PlanGuruDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruSplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruSplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32PlanGuru64DftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64DftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64SplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64SplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32ExecuteDftReal2Complex = procedure (const Plan: TFftw32Plan; &In: PFftw32Real; &Out: PFftw32Complex); cdecl;
  TFftw32ExecuteDftComplex2Real = procedure (const Plan: TFftw32Plan; &In: PFftw32Complex; &Out: PFftw32Real); cdecl;
  TFftw32ExecuteSplitDftReal2Complex = procedure (const Plan: TFftw32Plan; &In, Ro, Io: PFftw32Real); cdecl;
  TFftw32ExecuteSplitDftComplex2Real = procedure (const Plan: TFftw32Plan; Ri, Ii, &Out: PFftw32Real); cdecl;

  TFftw32PlanManyReal2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real = function (Rank: Integer; const N: PInteger; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real1D = function (N: Integer; &In, &Out: PFftw32Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real2D = function (N0, N1: Integer; &In, &Out: PFftw32Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real3D = function (N0, N1, N2: Integer; &In, &Out: PFftw32Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruReal2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64Real2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32ExecuteReal2Real = procedure (const Plan: TFftw32Plan; &In, &Out: PFftw32Real); cdecl;

  TFftw32DestroyPlan = procedure (Plan: TFftw32Plan); cdecl;
  TFftw32ForgetWisdom = procedure; cdecl;
  TFftw32Cleanup = procedure; cdecl;
  TFftw32SetTimelimit = procedure (TimeLimit: Double); cdecl;
  TFftw32PlanWithNthreads = procedure (ThreadCount: Integer); cdecl;
  TFftw32InitThreads = function : Integer; cdecl;
  TFftw32CleanupThreads = procedure; cdecl;

  TFftw32ExportWisdomToFilename = function (const FileName: PAnsiChar): Boolean; cdecl;
  TFftw32ExportWisdomToFile = procedure (var OutputFile: file); cdecl;
  TFftw32ExportWisdomToString = function : PAnsiChar; cdecl;
  TFftw32ExportWisdom = procedure (WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl;

  TFftw32ImportSystemWisdom = function : Integer; cdecl;
  TFftw32ImportWisdomFromFilename = function (const FileName: PAnsiChar): Boolean; cdecl;
  TFftw32ImportWisdomFromFile = function (var InputFile: file): Boolean; cdecl;
  TFftw32ImportWisdomFromString = function (const InputString: PAnsiChar): Boolean; cdecl;
  TFftw32ImportWisdom = function (ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl;

  TFftw32FPrintPlan = procedure (const Plan: TFftw32Plan; var OutputFile: file); cdecl;
  TFftw32PrintPlan = procedure (const Plan: TFftw32Plan); cdecl;
  TFftw32SPrintPlan = function (const Plan: TFftw32Plan): PAnsiChar; cdecl;

  TFftw32Malloc = function (N: NativeUInt): Pointer; cdecl;
  TFftw32AllocReal = function (N: NativeUInt): PFftw32Real; cdecl;
  TFftw32AllocComplex = function (N: NativeUInt): PFftw32Complex; cdecl;
  TFftw32Free = procedure (Ptr: Pointer); cdecl;

  TFftw32Flops = procedure (const Plan: TFftw32Plan; out Add, Mul, FMAs: Double); cdecl;
  TFftw32EstimateCost = function (const Plan: TFftw32Plan): Double; cdecl;
  TFftw32Cost = function (const Plan: TFftw32Plan): Double; cdecl;
  TFftw32AlignmentOf = function (Ptr: PFftw32Real): Integer; cdecl;

var
  Fftw32Version: AnsiString;
  Fftw32CC: AnsiString;
  Fftw32CodeletOptim: AnsiString;

  Fftw32Execute: TFftw32Execute;
  Fftw32PlanDft: TFftw32PlanDft;
  Fftw32PlanDft1D: TFftw32PlanDft1D;
  Fftw32PlanDft2D: TFftw32PlanDft2D;
  Fftw32PlanDft3D: TFftw32PlanDft3D;

  Fftw32PlanManyDft: TFftw32PlanManyDft;
  Fftw32PlanGuruDft: TFftw32PlanGuruDft;
  Fftw32PlanGuruSplitDft: TFftw32PlanGuruSplitDft;
  Fftw32PlanGuru64Dft: TFftw32PlanGuru64Dft;
  Fftw32PlanGuru64SplitDft: TFftw32PlanGuru64SplitDft;
  Fftw32ExecuteDft: TFftw32ExecuteDft;
  Fftw32ExecuteSplitDft: TFftw32ExecuteSplitDft;

  Fftw32PlanManyDftReal2Complex: TFftw32PlanManyDftReal2Complex;
  Fftw32PlanDftReal2Complex: TFftw32PlanDftReal2Complex;
  Fftw32PlanDftReal2Complex1D: TFftw32PlanDftReal2Complex1D;
  Fftw32PlanDftReal2Complex2D: TFftw32PlanDftReal2Complex2D;
  Fftw32PlanDftReal2Complex3D: TFftw32PlanDftReal2Complex3D;

  Fftw32PlanManyDftComplex2Real: TFftw32PlanManyDftComplex2Real;
  Fftw32PlanDftComplex2Real: TFftw32PlanDftComplex2Real;
  Fftw32PlanDftComplex2Real1D: TFftw32PlanDftComplex2Real1D;
  Fftw32PlanDftComplex2Real2D: TFftw32PlanDftComplex2Real2D;
  Fftw32PlanDftComplex2Real3D: TFftw32PlanDftComplex2Real3D;

  Fftw32PlanGuruDftReal2Complex: TFftw32PlanGuruDftReal2Complex;
  Fftw32PlanGuruDftComplex2Real: TFftw32PlanGuruDftComplex2Real;
  Fftw32PlanGuruSplitDftReal2Complex: TFftw32PlanGuruSplitDftReal2Complex;
  Fftw32PlanGuruSplitDftComplex2Real: TFftw32PlanGuruSplitDftComplex2Real;

  Fftw32PlanGuru64DftReal2Complex: TFftw32PlanGuru64DftReal2Complex;
  Fftw32PlanGuru64DftComplex2Real: TFftw32PlanGuru64DftComplex2Real;
  Fftw32PlanGuru64SplitDftReal2Complex: TFftw32PlanGuru64SplitDftReal2Complex;
  Fftw32PlanGuru64SplitDftComplex2Real: TFftw32PlanGuru64SplitDftComplex2Real;

  Fftw32ExecuteDftReal2Complex: TFftw32ExecuteDftReal2Complex;
  Fftw32ExecuteDftComplex2Real: TFftw32ExecuteDftComplex2Real;
  Fftw32ExecuteSplitDftReal2Complex: TFftw32ExecuteSplitDftReal2Complex;
  Fftw32ExecuteSplitDftComplex2Real: TFftw32ExecuteSplitDftComplex2Real;

  Fftw32PlanManyReal2Real: TFftw32PlanManyReal2Real;
  Fftw32PlanReal2Real: TFftw32PlanReal2Real;
  Fftw32PlanReal2Real1D: TFftw32PlanReal2Real1D;
  Fftw32PlanReal2Real2D: TFftw32PlanReal2Real2D;
  Fftw32PlanReal2Real3D: TFftw32PlanReal2Real3D;
  Fftw32PlanGuruReal2Real: TFftw32PlanGuruReal2Real;
  Fftw32PlanGuru64Real2Real: TFftw32PlanGuru64Real2Real;
  Fftw32ExecuteReal2Real: TFftw32ExecuteReal2Real;

  Fftw32DestroyPlan: TFftw32DestroyPlan;
  Fftw32ForgetWisdom: TFftw32ForgetWisdom;
  Fftw32Cleanup: TFftw32Cleanup;
  Fftw32SetTimelimit: TFftw32SetTimelimit;
  Fftw32PlanWithNthreads: TFftw32PlanWithNthreads;
  Fftw32InitThreads: TFftw32InitThreads;
  Fftw32CleanupThreads: TFftw32CleanupThreads;

  Fftw32ExportWisdomToFilename: TFftw32ExportWisdomToFilename;
  Fftw32ExportWisdomToFile: TFftw32ExportWisdomToFile;
  Fftw32ExportWisdomToString: TFftw32ExportWisdomToString;
  Fftw32ExportWisdom: TFftw32ExportWisdom;

  Fftw32ImportSystemWisdom: TFftw32ImportSystemWisdom;
  Fftw32ImportWisdomFromFilename: TFftw32ImportWisdomFromFilename;
  Fftw32ImportWisdomFromFile: TFftw32ImportWisdomFromFile;
  Fftw32ImportWisdomFromString: TFftw32ImportWisdomFromString;
  Fftw32ImportWisdom: TFftw32ImportWisdom;

  Fftw32FPrintPlan: TFftw32FprintPlan;
  Fftw32PrintPlan: TFftw32PrintPlan;
  Fftw32SPrintPlan: TFftw32SPrintPlan;

  Fftw32Malloc: TFftw32Malloc;
  Fftw32AllocReal: TFftw32AllocReal;
  Fftw32AllocComplex: TFftw32AllocComplex;
  Fftw32Free: TFftw32Free;

  Fftw32Flops: TFftw32Flops;
  Fftw32EstimateCost: TFftw32EstimateCost;
  Fftw32Cost: TFftw32Cost;
  Fftw32AlignmentOf: TFftw32AlignmentOf;
{$ELSE}
  procedure Fftw32Execute(const Plan: TFftw32Plan); cdecl; external CLibFftw32 name 'fftwf_execute';
  function Fftw32PlanDft(Rank: Integer; const N: PInteger; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft';
  function Fftw32PlanDft1D(N: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_1d';
  function Fftw32PlanDft2D(N0, N1: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_2d';
  function Fftw32PlanDft3D(N0, N1, N2: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_3d';

  function Fftw32PlanManyDft(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_many_dft';
  function Fftw32PlanGuruDft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_dft';
  function Fftw32PlanGuruSplitDft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_split_dft';
  function Fftw32PlanGuru64Dft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_dft';
  function Fftw32PlanGuru64SplitDft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_split_dft';
  procedure Fftw32ExecuteDft(const Plan: TFftw32Plan; &In, &Out: PFftw32Complex); cdecl; external CLibFftw32 name 'fftwf_execute_dft';
  procedure Fftw32ExecuteSplitDft(const Plan: TFftw32Plan; Ri, Ii, Ro, Io: PFftw32Real); cdecl; external CLibFftw32 name 'fftwf_execute_split_dft';

  function Fftw32PlanManyDftReal2Complex(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_many_dft_r2c';
  function Fftw32PlanDftReal2Complex(Rank: Integer; const N: PInteger; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c';
  function Fftw32PlanDftReal2Complex1D(N: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c_1d';
  function Fftw32PlanDftReal2Complex2D(N0, N1: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c_2d';
  function Fftw32PlanDftReal2Complex3D(N0, N1, N2: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c_3d';

  function Fftw32PlanManyDftComplex2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_many_dft_c2r';
  function Fftw32PlanDftComplex2Real(Rank: Integer; const N: PInteger; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r';
  function Fftw32PlanDftComplex2Real1D(N: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r_1d';
  function Fftw32PlanDftComplex2Real2D(N0, N1: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r_2d';
  function Fftw32PlanDftComplex2Real3D(N0, N1, N2: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r_3d';

  function Fftw32PlanGuruDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_dft_r2c';
  function Fftw32PlanGuruDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_dft_c2r';
  function Fftw32PlanGuruSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_split_dft_r2c';
  function Fftw32PlanGuruSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_split_dft_c2r';

  function Fftw32PlanGuru64DftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_dft_r2c';
  function Fftw32PlanGuru64DftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_dft_c2r';
  function Fftw32PlanGuru64SplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_split_dft_r2c';
  function Fftw32PlanGuru64SplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw32Real; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_split_dft_c2r';

  procedure Fftw32ExecuteDftReal2Complex(const Plan: TFftw32Plan; &In: PFftw32Real; &Out: PFftw32Complex); cdecl; external CLibFftw32 name 'fftwf_execute_dft_r2c';
  procedure Fftw32ExecuteDftComplex2Real(const Plan: TFftw32Plan; &In: PFftw32Complex; &Out: PFftw32Real); cdecl; external CLibFftw32 name 'fftwf_execute_dft_c2r';
  procedure Fftw32ExecuteSplitDftReal2Complex(const Plan: TFftw32Plan; &In, Ro, Io: PFftw32Real); cdecl; external CLibFftw32 name 'fftwf_execute_split_dft_r2c';
  procedure Fftw32ExecuteSplitDftComplex2Real(const Plan: TFftw32Plan; Ri, Ii, &Out: PFftw32Real); cdecl; external CLibFftw32 name 'fftwf_execute_split_dft_c2r';

  function Fftw32PlanManyReal2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_many_r2r';
  function Fftw32PlanReal2Real(Rank: Integer; const N: PInteger; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r';
  function Fftw32PlanReal2Real1D(N: Integer; &In, &Out: PFftw32Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r_1d';
  function Fftw32PlanReal2Real2D(N0, N1: Integer; &In, &Out: PFftw32Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r_2d';
  function Fftw32PlanReal2Real3D(N0, N1, N2: Integer; &In, &Out: PFftw32Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r_3d';
  function Fftw32PlanGuruReal2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_r2r';
  function Fftw32PlanGuru64Real2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_r2r';
  procedure Fftw32ExecuteReal2Real(const Plan: TFftw32Plan; &In, &Out: PFftw32Real); cdecl; external CLibFftw32 name 'fftwf_execute_r2r';

  procedure Fftw32DestroyPlan(Plan: TFftw32Plan); cdecl; external CLibFftw32 name 'fftwf_destroy_plan';
  procedure Fftw32ForgetWisdom; cdecl; external CLibFftw32 name 'fftwf_forget_wisdom';
  procedure Fftw32Cleanup; cdecl; external CLibFftw32 name 'fftwf_cleanup';
  procedure Fftw32SetTimelimit(TimeLimit: Double); cdecl; external CLibFftw32 name 'fftwf_set_timelimit';
  procedure Fftw32PlanWithNThreads(ThreadCount: Integer); cdecl; external CLibFftw32 name 'fftwf_plan_with_nthreads';
  function Fftw32InitThreads: Integer; cdecl; external CLibFftw32 name 'fftwf_init_threads';
  procedure Fftw32CleanupThreads; cdecl; external CLibFftw32 name 'fftwf_cleanup_threads';

  function Fftw32ExportWisdomToFilename(const FileName: PAnsiChar): Boolean; cdecl; external CLibFftw32 name 'fftwf_export_wisdom_to_filename';
  procedure Fftw32ExportWisdomToFile(var OutputFile: file); cdecl; external CLibFftw32 name 'fftwf_export_wisdom_to_file';
  function Fftw32ExportWisdomToString: PAnsiChar; cdecl; external CLibFftw32 name 'fftwf_export_wisdom_to_string';
  procedure Fftw32ExportWisdom(WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl; external CLibFftw32 name 'fftwf_export_wisdom';

  function Fftw32ImportSystemWisdom: Integer; cdecl; external CLibFftw32 name 'fftwf_import_system_wisdom';
  function Fftw32ImportWisdomFromFilename(const FileName: PAnsiChar): Boolean; cdecl; external CLibFftw32 name 'fftwf_import_wisdom_from_filename';
  function Fftw32ImportWisdomFromFile(var InputFile: file): Boolean; cdecl; external CLibFftw32 name 'fftwf_import_wisdom_from_file';
  function Fftw32ImportWisdomFromString(const InputString: PAnsiChar): Boolean; cdecl; external CLibFftw32 name 'fftwf_import_wisdom_from_string';
  function Fftw32ImportWisdom(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl; external CLibFftw32 name 'fftwf_import_wisdom';

  procedure Fftw32FPrintPlan(const Plan: TFftw32Plan; var OutputFile: file); cdecl; external CLibFftw32 name 'fftwf_fprint_plan';
  procedure Fftw32PrintPlan(const Plan: TFftw32Plan); cdecl; external CLibFftw32 name 'fftwf_print_plan';
  function Fftw32SPrintPlan(const Plan: TFftw32Plan): PAnsiChar; cdecl; external CLibFftw32 name 'fftwf_sprint_plan';

  function Fftw32Malloc(N: NativeUInt): Pointer; cdecl; external CLibFftw32 name 'fftwf_malloc';
  function Fftw32AllocReal(N: NativeUInt): PFftw32Real; cdecl; external CLibFftw32 name 'fftwf_alloc_real';
  function Fftw32AllocComplex(N: NativeUInt): PFftw32Complex; cdecl; external CLibFftw32 name 'fftwf_alloc_complex';
  procedure Fftw32Free(Ptr: Pointer); cdecl; external CLibFftw32 name 'fftwf_free';

  procedure Fftw32Flops(const Plan: TFftw32Plan; out Add, Mul, FMAs: Double); cdecl; external CLibFftw32 name 'fftwf_flops';
  function Fftw32EstimateCost(const Plan: TFftw32Plan): Double; cdecl; external CLibFftw32 name 'fftwf_estimate_cost';
  function Fftw32Cost(const Plan: TFftw32Plan): Double; cdecl; external CLibFftw32 name 'fftwf_cost';
  function Fftw32AlignmentOf(Ptr: PFftw32Real): Integer; cdecl; external CLibFftw32 name 'fftwf_alignment_of';
{$ENDIF}

type
  TCustomFftw32 = class abstract
  private
    function GetAsText: string;
    function GetEstimateCost: Double;
  protected
    FPlan: TFftw32Plan;
  public
    constructor Create; overload; virtual;
    destructor Destroy; override;

    procedure Execute; overload;

    procedure GetFlops(out Add, Mul, FMAs: Double);
    function GetCost: Double;

    property AsText: string read GetAsText;
    property EstimateCost: Double read GetEstimateCost;
  end;

  TFftw32Dft = class(TCustomFftw32)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags);

    procedure Execute(&In, &Out: PFftw32Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw32Real); overload;
  end;

  TFftw32DftReal2Complex = class(TCustomFftw32)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In: PFftw32Real; &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags);

    procedure Execute(&In: PFftw32Real; &Out: PFftw32Complex); overload;
    procedure Execute(&In, Ro, Io: PFftw32Real); overload;
  end;

  TFftw32DftComplex2Real = class(TCustomFftw32)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags);

    procedure Execute(&In: PFftw32Complex; &Out: PFftw32Real); overload;
    procedure Execute(Ri, Ii, &Out: PFftw32Real); overload;
  end;

  TFftw32Real2Real = class(TCustomFftw32)
  public
    constructor Create(Rank: Integer; const N: PInteger; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N: Integer; &In, &Out: PFftw32Real; Kind: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N0, N1: Integer; &In, &Out: PFftw32Real; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor Create(N0, N1, N2: Integer; &In, &Out: PFftw32Real; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateMany(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);

    procedure Execute(&In, &Out: PFftw32Real); overload;
  end;

  TFftw32Guru = class(TCustomFftw32)
  public
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw32Real; Flags: TFftwFlags); overload;
    constructor CreateSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw32Real; Flags: TFftwFlags); overload;

    procedure Execute(&In, &Out: PFftw32Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw32Real); overload;
  end;

  TFftw32Guru64 = class(TCustomFftw32)
  public
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Real; &Out: PFftw32Complex; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags); overload;
    constructor Create(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags); overload;
    constructor CreateSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw32Real; Flags: TFftwFlags); overload;
    constructor CreateSplitDftComplex2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw32Real; Flags: TFftwFlags); overload;

    procedure Execute(&In, &Out: PFftw32Complex); overload;
    procedure Execute(Ri, Ii, Ro, Io: PFftw32Real); overload;
  end;

  TFftw32Wisdom = class sealed
  public
    class procedure ForgetWisdom;
    class function ExportToFilename(const FileName: TFileName): Boolean;
    class procedure ExportToFile(var OutputFile: file);
    class function ExportToString: AnsiString;
    class procedure &Export(WriteChar: TFftwWriteCharFunc; Data: Pointer);

    class function ImportSystem: Integer;
    class function ImportFromFilename(const FileName: TFileName): Boolean;
    class function ImportFromFile(var InputFile: file): Boolean;
    class function ImportFromString(const InputString: AnsiString): Boolean;
    class function &Import(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer;
  end;

implementation

{$IFDEF DynLink}
uses
  Windows;
{$ENDIF}

{ TCustomFftw32 }

constructor TCustomFftw32.Create;
begin
  raise Exception.Create('Default constructor not supported!');
end;

destructor TCustomFftw32.Destroy;
begin
  Fftw32DestroyPlan(FPlan);
end;

procedure TCustomFftw32.Execute;
begin
  Fftw32Execute(FPlan);
end;

function TCustomFftw32.GetAsText: string;
begin
  Result := string(Fftw32SPrintPlan(FPlan));
end;

function TCustomFftw32.GetEstimateCost: Double;
begin
  Result := Fftw32EstimateCost(FPlan);
end;

procedure TCustomFftw32.GetFlops(out Add, Mul, FMAs: Double);
begin
  Fftw32Flops(FPlan, Add, Mul, FMAs);
end;

function TCustomFftw32.GetCost: Double;
begin
  Result := Fftw32Cost(FPlan);
end;


{ TFftw32Dft }

constructor TFftw32Dft.Create(Rank: Integer; const N: PInteger; &In,
  &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDft(Rank, N, &In, &Out, Sign, Flags);
end;

constructor TFftw32Dft.Create(N: Integer; &In, &Out: PFftw32Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDft1D(N, &In, &Out, Sign, Flags);
end;

constructor TFftw32Dft.Create(N0, N1: Integer; &In, &Out: PFftw32Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDft2D(N0, N1, &In, &Out, Sign, Flags);
end;

constructor TFftw32Dft.Create(N0, N1, N2: Integer; &In, &Out: PFftw32Complex;
  Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDft3D(N0, N1, N2, &In, &Out, Sign, Flags);
end;

constructor TFftw32Dft.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanManyDft(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Sign, Flags);
end;

procedure TFftw32Dft.Execute(&In, &Out: PFftw32Complex);
begin
  Fftw32ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw32Dft.Execute(Ri, Ii, Ro, Io: PFftw32Real);
begin
  Fftw32ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw32DftReal2Complex }

constructor TFftw32DftReal2Complex.Create(Rank: Integer; const N: PInteger;
  &In: PFftw32Real; &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftReal2Complex(Rank, N, &In, &Out, Flags);
end;

constructor TFftw32DftReal2Complex.Create(N: Integer; &In: PFftw32Real;
  &Out: PFftw32Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftReal2Complex1D(N, &In, &Out, Flags);
end;

constructor TFftw32DftReal2Complex.Create(N0, N1: Integer; &In: PFftw32Real;
  &Out: PFftw32Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftReal2Complex2D(N0, N1, &In, &Out, Flags);
end;

constructor TFftw32DftReal2Complex.Create(N0, N1, N2: Integer; &In: PFftw32Real;
  &Out: PFftw32Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftReal2Complex3D(N0, N1, N2, &In, &Out, Flags);
end;

constructor TFftw32DftReal2Complex.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanManyDftReal2Complex(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Flags);
end;

procedure TFftw32DftReal2Complex.Execute(&In: PFftw32Real; &Out: PFftw32Complex);
begin
  Fftw32ExecuteDftReal2Complex(FPlan, &In, &Out);
end;

procedure TFftw32DftReal2Complex.Execute(&In, Ro, Io: PFftw32Real);
begin
  Fftw32ExecuteSplitDftReal2Complex(FPlan, &In, Ro, Io);
end;


{ TFftw32DftComplex2Real }

constructor TFftw32DftComplex2Real.Create(Rank: Integer; const N: PInteger;
  &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftComplex2Real(Rank, N, &In, &Out, Flags);
end;

constructor TFftw32DftComplex2Real.Create(N: Integer; &In: PFftw32Complex; &Out: PFftw32Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftComplex2Real1D(N, &In, &Out, Flags);
end;

constructor TFftw32DftComplex2Real.Create(N0, N1: Integer; &In: PFftw32Complex; &Out: PFftw32Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftComplex2Real2D(N0, N1, &In, &Out, Flags);
end;

constructor TFftw32DftComplex2Real.Create(N0, N1, N2: Integer; &In: PFftw32Complex; &Out: PFftw32Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanDftComplex2Real3D(N0, N1, N2, &In, &Out, Flags);
end;

constructor TFftw32DftComplex2Real.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger;
  OutputStride, OutputDist: Integer; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanManyDftComplex2Real(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Flags);
end;

procedure TFftw32DftComplex2Real.Execute(&In: PFftw32Complex; &Out: PFftw32Real);
begin
  Fftw32ExecuteDftComplex2Real(FPlan, &In, &Out);
end;

procedure TFftw32DftComplex2Real.Execute(Ri, Ii, &Out: PFftw32Real);
begin
  Fftw32ExecuteSplitDftComplex2Real(FPlan, Ri, Ii, &Out);
end;


{ TFftw32Real2Real }

constructor TFftw32Real2Real.Create(Rank: Integer; const N: PInteger;
  &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanReal2Real(Rank, N, &In, &Out, Kind, Flags);
end;

constructor TFftw32Real2Real.Create(N: Integer; &In, &Out: PFftw32Real;
  Kind: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanReal2Real1D(N, &In, &Out, Kind, Flags);
end;

constructor TFftw32Real2Real.Create(N0, N1: Integer; &In, &Out: PFftw32Real;
  Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanReal2Real2D(N0, N1, &In, &Out, Kind0, Kind1, Flags);
end;

constructor TFftw32Real2Real.Create(N0, N1, N2: Integer; &In, &Out: PFftw32Real;
  Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanReal2Real3D(N0, N1, N2, &In, &Out, Kind0, Kind1, Kind2,
    Flags);
end;

constructor TFftw32Real2Real.CreateMany(Rank: Integer; const N: PInteger;
  HowMany: Integer; &In: PFftw32Real; const inembed: PInteger; InputStride,
  InputDist: Integer; &Out: PFftw32Real; const onembed: PInteger;
  OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind;
  Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanManyReal2Real(Rank, N, HowMany, &In, inembed, InputStride,
    InputDist, &Out, onembed, OutputStride, OutputDist, Kind, Flags);
end;

procedure TFftw32Real2Real.Execute(&In, &Out: PFftw32Real);
begin
  Fftw32ExecuteReal2Real(FPlan, &In, &Out);
end;


{ TFftw32Guru }

constructor TFftw32Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuruDft(Rank, Dimensions, HowManyRank, HowManyDimensions,
    &In, &Out, Sign, Flags);
end;

constructor TFftw32Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuruSplitDft(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, Ro, Io, Flags);
end;

constructor TFftw32Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Real;
  &Out: PFftw32Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuruDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw32Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim;
  &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuruDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw32Guru.Create(Rank: Integer; const Dimensions: PFftwIoDim;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PFftw32Real;
  const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuruReal2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Kind, Flags);
end;

constructor TFftw32Guru.CreateSplitDftReal2Complex(Rank: Integer;
  const Dimensions: PFftwIoDim; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PFftw32Real; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuruSplitDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, Ro, Io, Flags);
end;

constructor TFftw32Guru.CreateSplitDftComplex2Real(Rank: Integer;
  const Dimensions: PFftwIoDim; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PFftw32Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuruSplitDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, &Out, Flags);
end;

procedure TFftw32Guru.Execute(&In, &Out: PFftw32Complex);
begin
  Fftw32ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw32Guru.Execute(Ri, Ii, Ro, Io: PFftw32Real);
begin
  Fftw32ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw32Guru64 }

constructor TFftw32Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuru64Dft(Rank, Dimensions, HowManyRank, HowManyDimensions,
    &In, &Out, Sign, Flags);
end;

constructor TFftw32Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  Ri, Ii, Ro, Io: PFftw32Real; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuru64SplitDft(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, Ro, Io, Flags);
end;

constructor TFftw32Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Real;
  &Out: PFftw32Complex; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuru64DftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw32Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In: PFftw32Complex; &Out: PFftw32Real; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuru64DftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Flags);
end;

constructor TFftw32Guru64.Create(Rank: Integer; const Dimensions: PFftwIoDim64;
  HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64;
  &In, &Out: PFftw32Real; const Kind: PFftwReal2RealKind; Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuru64Real2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, &Out, Kind, Flags);
end;

constructor TFftw32Guru64.CreateSplitDftReal2Complex(Rank: Integer;
  const Dimensions: PFftwIoDim64; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PFftw32Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuru64SplitDftReal2Complex(Rank, Dimensions, HowManyRank,
    HowManyDimensions, &In, Ro, Io, Flags);
end;

constructor TFftw32Guru64.CreateSplitDftComplex2Real(Rank: Integer;
  const Dimensions: PFftwIoDim64; HowManyRank: Integer;
  const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PFftw32Real;
  Flags: TFftwFlags);
begin
  FPlan := Fftw32PlanGuru64SplitDftComplex2Real(Rank, Dimensions, HowManyRank,
    HowManyDimensions, Ri, Ii, &Out, Flags);
end;

procedure TFftw32Guru64.Execute(&In, &Out: PFftw32Complex);
begin
  Fftw32ExecuteDft(FPlan, &In, &Out);
end;

procedure TFftw32Guru64.Execute(Ri, Ii, Ro, Io: PFftw32Real);
begin
  Fftw32ExecuteSplitDft(FPlan, Ri, Ii, Ro, Io);
end;


{ TFftw32Wisdom }

class procedure TFftw32Wisdom.ForgetWisdom;
begin
  Fftw32ForgetWisdom;
end;

class function TFftw32Wisdom.ExportToFilename(const FileName: TFileName): Boolean;
begin
  Result := Fftw32ExportWisdomToFilename(PAnsiChar(AnsiString(FileName)));
end;

class procedure TFftw32Wisdom.ExportToFile(var OutputFile: file);
begin
  Fftw32ExportWisdomToFile(OutputFile);
end;

class function TFftw32Wisdom.ExportToString: AnsiString;
begin
  Result := Fftw32ExportWisdomToString;
end;

class procedure TFftw32Wisdom.&Export(WriteChar: TFftwWriteCharFunc; Data: Pointer);
begin
  Fftw32ExportWisdom(WriteChar, Data);
end;

class function TFftw32Wisdom.ImportSystem: Integer;
begin
  Result := Fftw32ImportSystemWisdom;
end;

class function TFftw32Wisdom.ImportFromFilename(const FileName: TFileName): Boolean;
begin
  Result := Fftw32ImportWisdomFromFilename(PAnsiChar(AnsiString(FileName)));
end;

class function TFftw32Wisdom.ImportFromFile(var InputFile: file): Boolean;
begin
  Result := Fftw32ImportWisdomFromFile(InputFile);
end;

class function TFftw32Wisdom.ImportFromString(const InputString: AnsiString): Boolean;
begin
  Result := Fftw32ImportWisdomFromString(PAnsiChar(AnsiString(InputString)));
end;

class function TFftw32Wisdom.&Import(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer;
begin
  Result := Fftw32ImportWisdom(ReadChar, Data);
end;


{$IFDEF DynLink}
var
  LibFftw3Handle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};

procedure InitializeLibrary;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(LibFftw3Handle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  if not FileExists(CLibFftw32) then
    raise Exception.CreateFmt('File not found (%s)', [CLibFftw32]);

  LibFftw3Handle := LoadLibrary(CLibFftw32);
  if LibFftw3Handle <> 0 then
    try
      Fftw32Version := PAnsiChar(GetProcAddress(LibFftw3Handle, PAnsiChar('fftwf_version')));
      Fftw32CC := PAnsiChar(GetProcAddress(LibFftw3Handle, PAnsiChar('fftwf_cc')));
      Fftw32CodeletOptim := PAnsiChar(GetProcAddress(LibFftw3Handle, PAnsiChar('fftwf_codelet_optim')));

      Fftw32Execute := BindFunction('fftwf_execute');
      Fftw32PlanDft := BindFunction('fftwf_plan_dft');
      Fftw32PlanDft1D := BindFunction('fftwf_plan_dft_1d');
      Fftw32PlanDft2D := BindFunction('fftwf_plan_dft_2d');
      Fftw32PlanDft3D := BindFunction('fftwf_plan_dft_3d');

      Fftw32PlanManyDft := BindFunction('fftwf_plan_many_dft');
      Fftw32PlanGuruDft := BindFunction('fftwf_plan_guru_dft');
      Fftw32PlanGuruSplitDft := BindFunction('fftwf_plan_guru_split_dft');
      Fftw32PlanGuru64Dft := BindFunction('fftwf_plan_guru64_dft');
      Fftw32PlanGuru64SplitDft := BindFunction('fftwf_plan_guru64_split_dft');
      Fftw32ExecuteDft := BindFunction('fftwf_execute_dft');
      Fftw32ExecuteSplitDft := BindFunction('fftwf_execute_split_dft');

      Fftw32PlanManyDftReal2Complex := BindFunction('fftwf_plan_many_dft_r2c');
      Fftw32PlanDftReal2Complex := BindFunction('fftwf_plan_dft_r2c');
      Fftw32PlanDftReal2Complex1D := BindFunction('fftwf_plan_dft_r2c_1d');
      Fftw32PlanDftReal2Complex2D := BindFunction('fftwf_plan_dft_r2c_2d');
      Fftw32PlanDftReal2Complex3D := BindFunction('fftwf_plan_dft_r2c_3d');

      Fftw32PlanManyDftComplex2Real := BindFunction('fftwf_plan_many_dft_c2r');
      Fftw32PlanDftComplex2Real := BindFunction('fftwf_plan_dft_c2r');
      Fftw32PlanDftComplex2Real1D := BindFunction('fftwf_plan_dft_c2r_1d');
      Fftw32PlanDftComplex2Real2D := BindFunction('fftwf_plan_dft_c2r_2d');
      Fftw32PlanDftComplex2Real3D := BindFunction('fftwf_plan_dft_c2r_3d');

      Fftw32PlanGuruDftReal2Complex := BindFunction('fftwf_plan_guru_dft_r2c');
      Fftw32PlanGuruDftComplex2Real := BindFunction('fftwf_plan_guru_dft_c2r');
      Fftw32PlanGuruSplitDftReal2Complex := BindFunction('fftwf_plan_guru_split_dft_r2c');
      Fftw32PlanGuruSplitDftComplex2Real := BindFunction('fftwf_plan_guru_split_dft_c2r');

      Fftw32PlanGuru64DftReal2Complex := BindFunction('fftwf_plan_guru64_dft_r2c');
      Fftw32PlanGuru64DftComplex2Real := BindFunction('fftwf_plan_guru64_dft_c2r');
      Fftw32PlanGuru64SplitDftReal2Complex := BindFunction('fftwf_plan_guru64_split_dft_r2c');
      Fftw32PlanGuru64SplitDftComplex2Real := BindFunction('fftwf_plan_guru64_split_dft_c2r');

      Fftw32ExecuteDftReal2Complex := BindFunction('fftwf_execute_dft_r2c');
      Fftw32ExecuteDftComplex2Real := BindFunction('fftwf_execute_dft_c2r');
      Fftw32ExecuteSplitDftReal2Complex := BindFunction('fftwf_execute_split_dft_r2c');
      Fftw32ExecuteSplitDftComplex2Real := BindFunction('fftwf_execute_split_dft_c2r');

      Fftw32PlanManyReal2Real := BindFunction('fftwf_plan_many_r2r');
      Fftw32PlanReal2Real := BindFunction('fftwf_plan_r2r');
      Fftw32PlanReal2Real1D := BindFunction('fftwf_plan_r2r_1d');
      Fftw32PlanReal2Real2D := BindFunction('fftwf_plan_r2r_2d');
      Fftw32PlanReal2Real3D := BindFunction('fftwf_plan_r2r_3d');
      Fftw32PlanGuruReal2Real := BindFunction('fftwf_plan_guru_r2r');
      Fftw32PlanGuru64Real2Real := BindFunction('fftwf_plan_guru64_r2r');
      Fftw32ExecuteReal2Real := BindFunction('fftwf_execute_r2r');

      Fftw32DestroyPlan := BindFunction('fftwf_destroy_plan');
      Fftw32ForgetWisdom := BindFunction('fftwf_forget_wisdom');
      Fftw32Cleanup := BindFunction('fftwf_cleanup');
      Fftw32SetTimelimit := BindFunction('fftwf_set_timelimit');
      Fftw32PlanWithNThreads := BindFunction('fftwf_plan_with_nthreads');
      Fftw32InitThreads := BindFunction('fftwf_init_threads');
      Fftw32CleanupThreads := BindFunction('fftwf_cleanup_threads');

      Fftw32ExportWisdomToFilename := BindFunction('fftwf_export_wisdom_to_filename');
      Fftw32ExportWisdomToFile := BindFunction('fftwf_export_wisdom_to_file');
      Fftw32ExportWisdomToString := BindFunction('fftwf_export_wisdom_to_string');
      Fftw32ExportWisdom := BindFunction('fftwf_export_wisdom');

      Fftw32ImportSystemWisdom := BindFunction('fftwf_import_system_wisdom');
      Fftw32ImportWisdomFromFilename := BindFunction('fftwf_import_wisdom_from_filename');
      Fftw32ImportWisdomFromFile := BindFunction('fftwf_import_wisdom_from_file');
      Fftw32ImportWisdomFromString := BindFunction('fftwf_import_wisdom_from_string');
      Fftw32ImportWisdom := BindFunction('fftwf_import_wisdom');

      Fftw32FPrintPlan := BindFunction('fftwf_fprint_plan');
      Fftw32PrintPlan := BindFunction('fftwf_print_plan');
      Fftw32SPrintPlan := BindFunction('fftwf_sprint_plan');

      Fftw32Malloc := BindFunction('fftwf_malloc');
      Fftw32AllocReal := BindFunction('fftwf_alloc_real');
      Fftw32AllocComplex := BindFunction('fftwf_alloc_complex');
      Fftw32Free := BindFunction('fftwf_free');

      Fftw32Flops := BindFunction('fftwf_flops');
      Fftw32EstimateCost := BindFunction('fftwf_estimate_cost');
      Fftw32Cost := BindFunction('fftwf_cost');
      Fftw32AlignmentOf := BindFunction('fftwf_alignment_of');
    except
      FreeLibrary(LibFftw3Handle);
      LibFftw3Handle := 0;
    end;
end;

procedure FinalizeLibrary;
begin
  if LibFftw3Handle <> 0 then
    FreeLibrary(LibFftw3Handle);
end;

initialization
  InitializeLibrary;

finalization
  FinalizeLibrary;
{$ENDIF}

end.
