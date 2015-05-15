unit Fftw3_32;

{$I Fftw3.inc}

interface

uses
  SysUtils,
  Fftw3_Common;

const
  CLibFftw32 = 'libfftw3f-3.dll';

type
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
  TFftw32PlanGuruSplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64Dft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64SplitDft = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32ExecuteDft = procedure (const Plan: TFftw32Plan; &In, &Out: PFftw32Complex); cdecl;
  TFftw32ExecuteSplitDft = procedure (const Plan: TFftw32Plan; Ri, Ii, Ro, Io: PSingle); cdecl;

  TFftw32PlanManyDftReal2Complex = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PSingle; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex = function (Rank: Integer; const N: PInteger; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex1D = function (N: Integer; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex2D = function (N0, N1: Integer; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftReal2Complex3D = function (N0, N1, N2: Integer; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32PlanManyDftComplex2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PSingle; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real = function (Rank: Integer; const N: PInteger; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real1D = function (N: Integer; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real2D = function (N0, N1: Integer; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanDftComplex2Real3D = function (N0, N1, N2: Integer; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32PlanGuruDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruSplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruSplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32PlanGuru64DftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64DftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64SplitDftReal2Complex = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64SplitDftComplex2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl;

  TFftw32ExecuteDftReal2Complex = procedure (const Plan: TFftw32Plan; &In: PSingle; &Out: PFftw32Complex); cdecl;
  TFftw32ExecuteDftComplex2Real = procedure (const Plan: TFftw32Plan; &In: PFftw32Complex; &Out: PSingle); cdecl;
  TFftw32ExecuteSplitDftReal2Complex = procedure (const Plan: TFftw32Plan; &In, Ro, Io: PSingle); cdecl;
  TFftw32ExecuteSplitDftComplex2Real = procedure (const Plan: TFftw32Plan; Ri, Ii, &Out: PSingle); cdecl;

  TFftw32PlanManyReal2Real = function (Rank: Integer; const N: PInteger; HowMany: Integer; &In: PSingle; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PSingle; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real = function (Rank: Integer; const N: PInteger; &In, &Out: PSingle; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real1D = function (N: Integer; &In, &Out: PSingle; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real2D = function (N0, N1: Integer; &In, &Out: PSingle; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanReal2Real3D = function (N0, N1, N2: Integer; &In, &Out: PSingle; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuruReal2Real = function (Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PSingle; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32PlanGuru64Real2Real = function (Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PSingle; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl;
  TFftw32ExecuteReal2Real = procedure (const Plan: TFftw32Plan; &In, &Out: PSingle); cdecl;

  TFftw32DestroyPlan = procedure (Plan: TFftw32Plan); cdecl;
  TFftw32ForgetWisdom = procedure; cdecl;
  TFftw32Cleanup = procedure; cdecl;
  TFftw32SetTimelimit = procedure (TimeLimit: Double); cdecl;
  TFftw32PlanWithNthreads = procedure (ThreadCount: Integer); cdecl;
  TFftw32InitThreads = function : Integer; cdecl;
  TFftw32CleanupThreads = procedure; cdecl;

  TFftw32ExportWisdomToFilename = function (const FileName: PAnsiChar): Integer; cdecl;
  TFftw32ExportWisdomToFile = procedure (var OutputFile: file); cdecl;
  TFftw32ExportWisdomToString = function : PAnsiChar; cdecl;
  TFftw32ExportWisdom = procedure (WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl;

  TFftw32ImportSystemWisdom = function : Integer; cdecl;
  TFftw32ImportWisdomFromFilename = function (const FileName: PAnsiChar): Integer; cdecl;
  TFftw32ImportWisdomFromFile = function (var InputFile: file): Integer; cdecl;
  TFftw32ImportWisdomFromString = function (const InputString: PAnsiChar): Integer; cdecl;
  TFftw32ImportWisdom = function (ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl;

  TFftw32FPrintPlan = procedure (const Plan: TFftw32Plan; var OutputFile: file); cdecl;
  TFftw32PrintPlan = procedure (const Plan: TFftw32Plan); cdecl;
  TFftw32SPrintPlan = function (const Plan: TFftw32Plan): PAnsiChar; cdecl;

  TFftw32Malloc = function (N: NativeUInt): Pointer; cdecl;
  TFftw32AllocReal = function (N: NativeUInt): PSingle; cdecl;
  TFftw32AllocComplex = function (N: NativeUInt): PFftw32Complex; cdecl;
  TFftw32Free = procedure (Ptr: Pointer); cdecl;

  TFftw32Flops = procedure (const Plan: TFftw32Plan; Add, Mul, FMAs: PDouble); cdecl;
  TFftw32EstimateCost = function (const Plan: TFftw32Plan): Double; cdecl;
  TFftw32Cost = function (const Plan: TFftw32Plan): Double; cdecl;
  TFftw32AlignmentOf = function (Ptr: PSingle): Integer; cdecl;

(*
const
  fftw_version: AnsiString;
  fftw_cc: AnsiString;
  fftw_codelet_optim: AnsiString;

  fftwf_version: AnsiString;
  fftwf_cc: AnsiString;
  fftwf_codelet_optim: AnsiString;

  fftwl_version: AnsiString;
  fftwl_cc: AnsiString;
  fftwl_codelet_optim: AnsiString;
*)

var
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
  function Fftw32PlanGuruSplit_dft(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_split_dft';
  function Fftw32PlanGuru64Dft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PFftw32Complex; Sign: TFftwSign; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_dft';
  function Fftw32PlanGuru64SplitDft(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_split_dft';
  procedure Fftw32ExecuteDft(const Plan: TFftw32Plan; &In, &Out: PFftw32Complex); cdecl; external CLibFftw32 name 'fftwf_execute_dft';
  procedure Fftw32ExecuteSplitDft(const Plan: TFftw32Plan; Ri, Ii, Ro, Io: PSingle); cdecl; external CLibFftw32 name 'fftwf_execute_split_dft';

  function Fftw32PlanManyDftReal2Complex(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PSingle; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PFftw32Complex; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_many_dft_r2c';
  function Fftw32PlanDftReal2Complex(Rank: Integer; const N: PInteger; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c';
  function Fftw32PlanDftReal2Complex1D(N: Integer; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c_1d';
  function Fftw32PlanDftReal2Complex2D(N0, N1: Integer; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c_2d';
  function Fftw32PlanDftReal2Complex3D(N0, N1, N2: Integer; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_r2c_3d';

  function Fftw32PlanManyDftComple2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PFftw32Complex; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PSingle; const onembed: PInteger; OutputStride, OutputDist: Integer; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_many_dft_c2r';
  function Fftw32PlanDftComple2Real(Rank: Integer; const N: PInteger; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r';
  function Fftw32PlanDftComple2Real1D(N: Integer; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r_1d';
  function Fftw32PlanDftComple2Real2D(N0, N1: Integer; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r_2d';
  function Fftw32PlanDftComple2Real3D(N0, N1, N2: Integer; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_dft_c2r_3d';

  function Fftw32PlanGuruDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_dft_r2c';
  function Fftw32PlanGuruDftComple2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_dft_c2r';
  function Fftw32PlanGuruSplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_split_dft_r2c(';
  function Fftw32PlanGuruSplitDftComple2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; Ri, Ii, &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_split_dft_c2r(';

  function Fftw32PlanGuru64DftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PSingle; &Out: PFftw32Complex; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_dft_r2c';
  function Fftw32PlanGuru64DftComple2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In: PFftw32Complex; &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_dft_c2r';
  function Fftw32PlanGuru64SplitDftReal2Complex(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, Ro, Io: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_split_dft_r2c(';
  function Fftw32PlanGuru64SplitDftComple2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; Ri, Ii, &Out: PSingle; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_split_dft_c2r(';

  procedure Fftw32ExecuteDftReal2Complex(const Plan: TFftw32Plan; &In: PSingle; &Out: PFftw32Complex); cdecl; external CLibFftw32 name 'fftwf_execute_dft_r2c';
  procedure Fftw32ExecuteDftComple2Real(const Plan: TFftw32Plan; &In: PFftw32Complex; &Out: PSingle); cdecl; external CLibFftw32 name 'fftwf_execute_dft_c2r';
  procedure Fftw32ExecuteSplitDftReal2Complex(const Plan: TFftw32Plan; &In, Ro, Io: PSingle); cdecl; external CLibFftw32 name 'fftwf_execute_split_dft_r2c';
  procedure Fftw32ExecuteSplitDftComple2Real(const Plan: TFftw32Plan; Ri, Ii, &Out: PSingle); cdecl; external CLibFftw32 name 'fftwf_execute_split_dft_c2r';

  function Fftw32PlanManyReal2Real(Rank: Integer; const N: PInteger; HowMany: Integer; &In: PSingle; const inembed: PInteger; InputStride, InputDist: Integer; &Out: PSingle; const onembed: PInteger; OutputStride, OutputDist: Integer; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_many_r2r';
  function Fftw32PlanReal2Real(Rank: Integer; const N: PInteger; &In, &Out: PSingle; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r';
  function Fftw32PlanReal2Real1D(N: Integer; &In, &Out: PSingle; Kind: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r_1d';
  function Fftw32PlanReal2Real2D(N0, N1: Integer; &In, &Out: PSingle; Kind0, Kind1: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r_2d';
  function Fftw32PlanReal2Real3D(N0, N1, N2: Integer; &In, &Out: PSingle; Kind0, Kind1, Kind2: TFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_r2r_3d';
  function Fftw32PlanGuruReal2Real(Rank: Integer; const Dimensions: PFftwIoDim; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim; &In, &Out: PSingle; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru_r2r';
  function Fftw32PlanGuru64Real2Real(Rank: Integer; const Dimensions: PFftwIoDim64; HowManyRank: Integer; const HowManyDimensions: PFftwIoDim64; &In, &Out: PSingle; const Kind: PFftwReal2RealKind; Flags: TFftwFlags): TFftw32Plan; cdecl; external CLibFftw32 name 'fftwf_plan_guru64_r2r';
  procedure Fftw32ExecuteReal2Real(const Plan: TFftw32Plan; &In, &Out: PSingle); cdecl; external CLibFftw32 name 'fftwf_execute_r2r';

  procedure Fftw32DestroyPlan(Plan: TFftw32Plan); cdecl; external CLibFftw32 name 'fftwf_destroy_plan';
  procedure Fftw32ForgetWisdom; cdecl; external CLibFftw32 name 'fftwf_forget_wisdom;';
  procedure Fftw32Cleanup; cdecl; external CLibFftw32 name 'fftwf_cleanup;';
  procedure Fftw32SetTimelimit(TimeLimit: Double); cdecl; external CLibFftw32 name 'fftwf_set_timelimit';
  procedure Fftw32PlanWith_nthreads(ThreadCount: Integer); cdecl; external CLibFftw32 name 'fftwf_plan_with_nthreads';
  function Fftw32InitThreads: Integer; cdecl; external CLibFftw32 name 'fftwf_init_threads:';
  procedure Fftw32CleanupThreads; cdecl; external CLibFftw32 name 'fftwf_cleanup_threads;';

  function Fftw32ExportWisdomToFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw32 name 'fftwf_export_wisdom_to_filename';
  procedure Fftw32ExportWisdomToFile(var OutputFile: file); cdecl; external CLibFftw32 name 'fftwf_export_wisdom_to_file';
  function Fftw32ExportWisdomToString: PAnsiChar; cdecl; external CLibFftw32 name 'fftwf_export_wisdom_to_string:';
  procedure Fftw32ExportWisdom(WriteChar: TFftwWriteCharFunc; Data: Pointer); cdecl; external CLibFftw32 name 'fftwf_export_wisdom';

  function Fftw32ImportSystemWisdom: Integer; cdecl; external CLibFftw32 name 'fftwf_import_system_wisdom:';
  function Fftw32ImportWisdomFromFilename(const FileName: PAnsiChar): Integer; cdecl; external CLibFftw32 name 'fftwf_import_wisdom_from_filename';
  function Fftw32ImportWisdomFromFile(var InputFile: file): Integer; cdecl; external CLibFftw32 name 'fftwf_import_wisdom_from_file';
  function Fftw32ImportWisdomFromString(const InputString: PAnsiChar): Integer; cdecl; external CLibFftw32 name 'fftwf_import_wisdom_from_string';
  function Fftw32ImportWisdom(ReadChar: TFftwReadCharFunc; Data: Pointer): Integer; cdecl; external CLibFftw32 name 'fftwf_import_wisdom';

  procedure Fftw32FPrintPlan(const Plan: TFftw32Plan; var OutputFile: file); cdecl; external CLibFftw32 name 'fftwf_fprint_plan';
  procedure Fftw32PrintPlan(const Plan: TFftw32Plan); cdecl; external CLibFftw32 name 'fftwf_print_plan';
  function Fftw32SPrintPlan(const Plan: TFftw32Plan): PAnsiChar; cdecl; external CLibFftw32 name 'fftwf_sprint_plan';

  function Fftw32Malloc(N: NativeUInt): Pointer; cdecl; external CLibFftw32 name 'fftwf_malloc';
  function Fftw32AllocReal(N: NativeUInt): PSingle; cdecl; external CLibFftw32 name 'fftwf_alloc_real';
  function Fftw32AllocComplex(N: NativeUInt): PFftw32Complex; cdecl; external CLibFftw32 name 'fftwf_alloc_complex';
  procedure Fftw32Free(Ptr: Pointer); cdecl; external CLibFftw32 name 'fftwf_free';

  procedure Fftw32Flops(const Plan: TFftw32Plan; Add, Mul, FMAs: PDouble); cdecl; external CLibFftw32 name 'fftwf_flops';
  function Fftw32EstimateCost(const Plan: TFftw32Plan): Double; cdecl; external CLibFftw32 name 'fftwf_estimate_cost';
  function Fftw32Cost(const Plan: TFftw32Plan): Double; cdecl; external CLibFftw32 name 'fftwf_cost';
  function Fftw32AlignmentOf(Ptr: PSingle): Integer; cdecl; external CLibFftw32 name 'fftwf_alignment_of';
{$ENDIF}

type
  TFftw32 = class
  private
    FPlan: TFftw32Plan;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$IFDEF DynLink}
uses
  Windows;
{$ENDIF}

{ TFftw32 }

constructor TFftw32.Create;
begin

end;

destructor TFftw32.Destroy;
begin
  Fftw32DestroyPlan(FPlan);
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
