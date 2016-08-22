unit TestBigIntegers;

////////////////////////////////////////////////////////////////////////////////////////
//                                                                                    //
//  Delphi DUnit Test Case                                                            //
//  ----------------------                                                            //
//  This unit contains a skeleton test case class generated by the Test Case Wizard.  //
//  Modify the generated code to correctly setup and call the methods from the unit   //
//  being tested.                                                                     //
//                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////

interface

uses
  TestFramework,
  Velthuis.BigIntegers,
  Velthuis.RandomNumbers,
  Velthuis.Loggers,
  System.Types,
  System.Generics.Defaults,
  System.SysUtils,
  System.Math;

type
  // Test methods for BigInteger records.
  TTestBigInteger = class(TTestCase)
  strict private
    A, B, C, D, E, F: BigInteger;
  public
    procedure Error(const Msg: string);
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestParse;
    procedure TestCreateBytes;
    procedure TestCreateRandom;
    procedure TestCreateDouble;
    procedure TestIsZero;
    procedure TestIsPositive;
    procedure TestIsEven;
    procedure TestIsPowerOfTwo;
    procedure TestIsOne;
    procedure TestToString;
    procedure TestToHex;
    procedure TestTestBit;
//    procedure TestSetBit;
//    procedure TestClearBit;
//    procedure TestFlipBit;
    procedure TestAdd;
    procedure TestAddFunction;
    procedure TestInc;
    procedure TestDec;
    procedure TestSubtract;
    procedure TestMultiply;
    procedure TestMultiplyKaratsuba;
    procedure TestMultiplyToomCook3;
    procedure TestIntDivide;
    procedure TestIntDivide16;
    procedure TestIntDivide32;
    procedure TestModulus;
    procedure TestModulus16;
    procedure TestModulus32;
    procedure TestSquare;
    procedure TestNegative;
    procedure TestBitwiseAnd;
    procedure TestBitwiseOr;
    procedure TestBitwiseXor;
    procedure TestLogicalNot;
    procedure TestLeftShift;
    procedure TestRightShift;
    procedure TestEqual;
    procedure TestNotEqual;
    procedure TestGreaterThan;
    procedure TestGreaterThanOrEqual;
    procedure TestLessThan;
    procedure TestLessThanOrEqual;
    procedure TestAsDouble;
    procedure TestAsInteger;
    procedure TestAsCardinal;
    procedure TestAsInt64;
    procedure TestAsUInt64;
    procedure TestDivMod;
    procedure TestDivModKnuth;
    procedure TestDivModBurnikelZiegler;
    procedure TestDivMod16;
    procedure TestDivMod32;
//    procedure TestAbs;
    procedure TestBitLength;
    procedure TestGreatestCommonDivisor;
    procedure TestLn;
    procedure TestMax;
    procedure TestMin;
//    procedure TestModPow;
    procedure TestPow;
    procedure TestNthRoot;
    procedure TestSqrt;
    procedure TestToByteArray;
  end;

implementation

{$IFDEF MSWINDOWS}
uses
  Winapi.Windows;
{$ENDIF}

{$I 'BigIntegerTestResults.inc'}
{$I 'BigIntegerArithmeticResults.inc'}
{$I 'BigIntegerBitwiseResults.inc'}
{$I 'BigIntegerConvertResults.inc'}
{$I 'BigIntegerMathResults.inc'}

procedure TTestBigInteger.Error(const Msg: string);
begin
{$IFDEF MSWINDOWS}
  OutputDebugString(PChar(Msg));
{$ELSE}
  {$IFDEF CONSOLE}
    Writeln(ErrOutput, Msg);
  {$ENDIF}
{$ENDIF}
end;

procedure TTestBigInteger.SetUp;
begin
//  BigInteger.AvoidPartialFlagsStall(True);
end;

procedure TTestBigInteger.TearDown;
begin
end;

procedure TTestBigInteger.TestIsZero;
begin
  A := '-1';
  B := '1';
  C := '0';

  Check(not A.IsZero);
  Check(not B.IsZero);
  Check(C.IsZero);
end;

procedure TTestBigInteger.TestIsPositive;
begin
  A.FromString('-1');
  B := '1';
  C := '0';

  Check(not A.IsPositive);
  Check(B.IsPositive);
  Check(not C.IsPositive);
end;

procedure TTestBigInteger.TestIsEven;
begin
  A := -1234;
  B := -1233;
  C := 0;
  D := 1233;
  E := 1234;

  CheckTrue(A.IsEven);
  CheckFalse(B.IsEven);
  CheckTrue(C.IsEven);
  CheckFalse(D.IsEven);
  CheckTrue(E.IsEven);
end;

procedure TTestBigInteger.TestIsPowerOfTwo;
var
  I: Integer;

  function Msg(const S: string; const Int: BigInteger): string;
  begin
    Result := Format('(%d) Value = %s (hex), A = %s (hex), Info: %s', [I, Int.ToString(16), A.ToString(16), S]);
  end;

begin
  A := 4;
  for I := 4 to 100 do
  begin
    A := A shl 1;
    B := -A;
    C := A - BigInteger.One;
    D := A + BigInteger.One;
    E := B - BigInteger.One;
    F := B + BigInteger.One;

    CheckTrue(A.IsPowerOfTwo, Msg('A', A));
    CheckTrue(B.IsPowerOfTwo, Msg('-A', B));
    CheckFalse(C.IsPowerOfTwo, Msg('A - 1', C));
    CheckFalse(D.IsPowerOfTwo, Msg('A + 1', D));
    CheckFalse(E.IsPowerOfTwo, Msg('-A - 1', E));
    CheckFalse(F.IsPowerOfTwo, Msg('-A + 1', F));
  end;
end;

procedure TTestBigInteger.TestIsOne;
begin
  A := BigInteger.MinusOne;
  B := BigInteger.One;
  C := '0';

  CheckFalse(A.IsOne);
  CheckTrue(B.IsOne);
  CheckFalse(C.IsOne);
end;

procedure TTestBigInteger.TestToString;
var
  I: Integer;
  S1, S2: string;
begin
  for I := 0 to High(Arguments) do
  begin
    BigInteger.Decimal;
    A := Arguments[I];
    S1 := A.ToString;
    S2 := Arguments[I];
    Check(S1 = S2);
    BigInteger.Hexadecimal;
    S1 := A.ToString;
    S2 := HexResults[I].val;
    Check(S1 = S2);
    BigInteger.Decimal;
  end;
end;

procedure TTestBigInteger.TestToHex;
var
  I: Integer;
  S1, S2: string;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    S1 := A.ToHexString;
    S2 := HexResults[i].val;
    Check(S1 = S2);
  end;
end;

procedure TTestBigInteger.TestAdd;
var
  I, J, N: Integer;
  A, B, C, D: BigInteger;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      try
        C := A + B;
      except
        on E: Exception do
          Error(E.ClassName + ': ' + E.Message);
      end;
      D := AddResults[N].val;
      Check(C = D, Format('(%d,%d) %s + %s = %s (%s, diff=%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16), (C - D).ToString(16)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestAddFunction;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      try
        C := A;
        C.Add(B);
      except
        on E: Exception do
          Error(E.ClassName + ': ' + E.Message);
      end;
      D := AddResults[N].val;
      Check(C = D, Format('(%d,%d) %s + %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestSqrt;
var
  I, J, Exponent: Integer;
begin
  for I := 10 to High(BitShifts) do
  begin
    A := BitShifts[I];
    for J := 2 to 100 do
    begin
      Exponent := J;
      B := BigInteger.Pow(A, Exponent) + BigInteger.Pow(A, Exponent - 1);
      C := BigInteger.Sqrt(B);
      D := C * C;
      E := (C + 1) * (C + 1);
      Check((D <= B) and (B <= E), Format('(%d,%d) Sqrt(%s) = %s (%s not in [%s..%s])', [I, J, B.ToString(16), C.ToString(16), B.ToString(16), D.ToString(16), E.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestSquare;
var
  I: Integer;
begin
  for I := 0 to High(MultiplyResults) do
  begin
    A := MultiplyResults[I].val;
    B := BigInteger.Sqr(A);
    C := A * A;
    Check(B = C, Format('(%d) Sqr(%s) = %s (%s)', [I, A.ToString(16), B.ToString(16), C.ToString(16)]));
  end;
end;

procedure TTestBigInteger.TestSubtract;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      try
        C := A - B;
      except
        on E: Exception do
          Error(E.ClassName + ': ' + E.Message);
      end;
      D := SubtractResults[N].val;
      Check(C = D, Format('(%d,%d) %s - %s = %s (%s)', [I, J, A.ToString, B.ToString, C.ToString, D.ToString]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestMultiply;
var
  I, J, N: Integer;
  S, ErrorMsg: string;
  A, B, C, D: BigInteger;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      S := MultiplyResults[N].val;
      D := S;
      try
        C := BigInteger.Multiply(A, B);
      except
        on E: Exception do
          Error('Multiplication error, ' + E.ClassName + ': ' + E.Message);
      end;
      ErrorMsg := Format('(%d,%d,%d) %s * %s = %s (%s, diff = %s)', [I, J, N, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16), (D - C).ToString(16)]);
      Check(C = D, ErrorMsg);
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestMultiplyKaratsuba;
var
  I: Integer;
  R: IRandom;
begin
  R := TDelphiRandom.Create($123456);
  A := BigInteger.Create((BigInteger.KaratsubaThreshold + Random(100)) * 32, R);
  for I := 1 to 20 do
  begin
    B := BigInteger.Create((BigInteger.KaratsubaThreshold + Random(100)) * 32, R);
    C := BigInteger.MultiplyKaratsuba(A, B);

    // It is safe to assume that result given by MultiplyBaseCase is correct.
    D := BigInteger.MultiplyBaseCase(A, B);

    Check(C = D, Format('(%d x %d): %s * %s = %s (%s), diff = %s', [A.Size, B.Size, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16), (C - D).ToString(16)]));
    A := B;
  end;
end;

procedure TTestBigInteger.TestMultiplyToomCook3;
var
  I: Integer;
  R: IRandom;
begin
  R := TDelphiRandom.Create($123456);
  A := BigInteger.Create((BigInteger.ToomCook3Threshold + Random(100)) * 32, R);
  for I := 1 to 20 do
  begin
    B := BigInteger.Create((BigInteger.ToomCook3Threshold + Random(100)) * 32, R);
    C := BigInteger.MultiplyToomCook3(A, B);

    // It is safe to assume that result given by MultiplyBaseCase is correct.
    D := BigInteger.MultiplyBaseCase(A, B);

    Check(C = D, Format('(%d x %d): %s * %s = %s (%s), diff = %s', [A.Size, B.Size, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16), (C - D).ToString(16)]));
    A := B;
  end;
end;

procedure TTestBigInteger.TestInc;
var
  I: Integer;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    B := A + 1;
    C := A;
    Inc(C);
    Check(C = B, Format('(%d) %s --> %s (%s)', [I, A.ToString(16), C.ToString(16), B.ToString(16)]));
  end;
end;

procedure TTestBigInteger.TestIntDivide;
var
  I, J, N: Integer;
  TR: TTestResult;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      TR := DivisionResults[N];
      Inc(N);
      try
        C := A div B;
      except
        on E: EZeroDivide do
        begin
          Check(TR.info = triDivideByZero, Format('(%d,%d) Unexpected EZeroDivide exception occurred', [I, J]));
          Continue;
        end;
        on E: Exception do
          Error('TestIntDivide: Unexpected ' + E.ClassName + ' exception: ''' + E.Message + '''');
      end;
      Check(TR.info = triOk, Format('(%d,%d) Expected an exception', [I, J]));
      D := TR.val;
      Check(C = D, Format('(%d,%d) %s div %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestIntDivide16;
var
  I, J: Integer;
  W16: UInt16;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[I];
      W16 := UInt16(B);
      C := W16;
      if W16 = 0 then
        Continue;
      D := A div W16;
      E := A div C;
      Check(E = D, Format('(%d, %d) %s div %x = %s (%s)', [I, J, A.ToString(16), W16, D.ToString(16), E.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestIntDivide32;
var
  I, J: Integer;
  W32: UInt16;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[I];
      W32 := UInt32(B);
      C := W32;
      if W32 = 0 then
        Continue;
      D := A div W32;
      E := A div C;
      Check(E = D, Format('(%d, %d) %s div %x = %s (%s)', [I, J, A.ToString(16), W32, D.ToString(16), E.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestModulus;
var
  I, J, N: Integer;
  TR: TTestResult;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      TR := ModulusResults[N];
      Inc(N);
      try
        C := A mod B;
      except
        on E: EZeroDivide do
        begin
          Check(TR.info = triDivideByZero, Format('(%d,%d) Unexpected EZeroDivide exception occurred', [I, J]));
          Continue;
        end;
        on E: Exception do
          Error('TestModulus: Unexpected ' + E.ClassName + ' exception: ' + E.Message);
      end;
      Check(TR.info = triOk, Format('(%d,%d) Expected exception did not occur', [I, J]));
      D := TR.Val;
      Check(C = D, Format('(%d,%d) %s mod %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestModulus16;
var
  I, J: Integer;
  W16: UInt16;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[I];
      W16 := UInt16(B);
      C := W16;
      if W16 = 0 then
        Continue;
      D := A mod W16;
      E := A mod C;
      Check(E = D, Format('(%d, %d) %s mod %x = %s (%s)', [I, J, A.ToString(16), W16, D.ToString(16), E.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestModulus32;
var
  I, J: Integer;
  W32: UInt16;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[I];
      W32 := UInt32(B);
      C := W32;
      if W32 = 0 then
        Continue;
      D := A mod W32;
      E := A mod C;
      Check(E = D, Format('(%d, %d) %s mod %x = %s (%s)', [I, J, A.ToString(16), W32, D.ToString(16), E.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestNegative;
var
  I: Integer;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    B := -A;
    C := NegationResults[I].val;
    Check(B = C);
  end;
end;

procedure TTestBigInteger.TestBitwiseAnd;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      try
        C := A and B;
      except
        on E: Exception do
          Error(E.ClassName + ': ' + E.Message);
      end;
      D := BitwiseAndResults[N].val;
      Check(C = D, Format('(%d,%d) %s and %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestBitwiseOr;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      try
        C := A or B;
      except
        on E: Exception do
          Error(E.ClassName + ': ' + E.Message);
      end;
      D := BitwiseOrResults[N].val;
      Check(C = D, Format('(%d,%d) %s or %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestBitwiseXor;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      try
        C := A xor B;
      except
        on E: Exception do
          Error(E.ClassName + ': ' + E.Message);
      end;
      D := BitwiseXorResults[N].val;
      Check(C = D, Format('(%d,%d) %s xor %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), D.ToString(16)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestCreateBytes;
var
  I: Integer;
  Bytes: TArray<Byte>;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    Bytes := A.ToByteArray;
    B := BigInteger.Create(Bytes);
    Check(A = B, Format('(%d), Create(%s.ToByteArray) = %s', [I, A.ToString(16), B.ToString(16)]));
  end;
end;

procedure TTestBigInteger.TestCreateDouble;
var
  I: Integer;
begin
  BigInteger.RoundingMode := BigInteger.TRoundingMode.rmTruncate;
  for I := 0 to High(Doubles) do
  begin
    A := BigInteger.Create(Doubles[I]);
    B := CreateDoubleResults[I].val;
    Check(A = B, Format('(%d) BigInteger.Create(%f) = %s (%s)', [I, Doubles[I], A.ToString(16), B.ToString(16)]));
  end;
end;

procedure TTestBigInteger.TestCreateRandom;
var
  I, NumBits: Integer;
  ARandom: IRandom;
begin
  ARandom := TDelphiRandom.Create;
  for I := 0 to 1000 do
  begin
    NumBits := I;
    A := BigInteger.Create(NumBits, ARandom);
    Check(A.BitLength <= NumBits, Format('%s (bits = %d), Numbits = %d', [A.ToString(16), A.BitLength, NumBits]));
  end;
end;

procedure TTestBigInteger.TestLogicalNot;
var
  I: Integer;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    B := not A;
    C := LogicalNotResults[I].val;
    Check(B = C, Format('(%d) not %s = %s (%s)', [I, A.ToString(16), B.ToString(16), C.ToString(16)]));
  end;
end;

procedure TTestBigInteger.TestLeftShift;
var
  I, J, N, Shift: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(BitShifts) do
    begin
      Shift := BitShifts[J];
      B := A shl Shift;
      C := LeftShiftResults[N].val;
      Check(B = C, Format('(%d,%d) %s shl %d = %s (%s)', [I, J, A.ToString(16), Shift, B.ToString(16), C.ToString(16)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestRightShift;
var
  I, J, N, Shift: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(BitShifts) do
    begin
      Shift := BitShifts[J];
      B := A shr Shift;
      C := RightShiftResults[N].val;
      Check(B = C, Format('(%d,%d) %s shr %d = %s (%s)', [I, J, A.ToString(16), Shift, B.ToString(16), C.ToString(16)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestEqual;
var
  I, J, N: Integer;
  B1, B2: Boolean;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      B1 := A = B;
      B2 := ComparisonResults[N, crEqual];
      Check(B1 = B2, Format('%d,%d: %s = %s: %s (%s)', [i, j, Arguments[i], Arguments[j], BoolToStr(B1), BoolToStr(B2)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestNotEqual;
var
  I, J, N: Integer;
  B1, B2: Boolean;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      B1 := A <> B;
      B2 := ComparisonResults[N, crNotEqual];
      Check(B1 = B2, Format('%d,%d: %s <> %s: %s (%s)', [i, j, Arguments[i], Arguments[j], BoolToStr(B1), BoolToStr(B2)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestNthRoot;
var
  I, J, Exponent: Integer;
begin
  for I := 2 to High(BitShifts) do
  begin
    A := BitShifts[I];
    for J := 2 to 100 do
    begin
      Exponent := J;
      B := BigInteger.Pow(A, Exponent) + BigInteger.Pow(A, Exponent - 1);
      C := BigInteger.NthRoot(B, Exponent);
      D := BigInteger.Pow(C, Exponent);
      E := BigInteger.Pow(C + 1, Exponent);
      Check((D <= B) and (B <= E), Format('(%d,%d) NthRoot(%s, %d) = %s (%s)', [I, J, B.ToString(16), Exponent, C.ToString(16), A.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestTestBit;
var
  I, J: Integer;
  Bool1, Bool2: Boolean;
    R: Integer;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to 19 do
    begin
      R := System.Random(A.BitLength + 4 * SizeOf(TLimb));
      B := BigInteger.One shl R;
      Bool1 := A.TestBit(R);
      Bool2 := (B and A) <> 0;
      Check(Bool1 = Bool2, Format('%d,%d: %s.TestBit(%d): %s (%s) <-- %s (%s)', [I, J, A.ToString(16), R, BoolToStr(Bool1), BoolToStr(Bool2), A.ToString(16), B.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestGreaterThan;
var
  I, J, N: Integer;
  B1, B2: Boolean;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      B1 := A > B;
      B2 := ComparisonResults[N, crGreater];
      Check(B1 = B2, Format('%d,%d: %s > %s: %s (%s)', [i, j, Arguments[i], Arguments[j], BoolToStr(B1), BoolToStr(B2)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestGreaterThanOrEqual;
var
  I, J, N: Integer;
  B1, B2: Boolean;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      B1 := A >= B;
      B2 := ComparisonResults[N, crGreaterEqual];
      Check(B1 = B2, Format('%d,%d: %s >= %s: %s (%s)', [i, j, Arguments[i], Arguments[j], BoolToStr(B1), BoolToStr(B2)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestLessThan;
var
  I, J, N: Integer;
  B1, B2: Boolean;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      B1 := A < B;
      B2 := ComparisonResults[N, crLess];
      Check(B1 = B2, Format('%d,%d: %s < %s: %s (%s)', [i, j, Arguments[i], Arguments[j], BoolToStr(B1), BoolToStr(B2)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestLessThanOrEqual;
var
  I, J, N: Integer;
  B1, B2: Boolean;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      B1 := A <= B;
      B2 := ComparisonResults[N, crLessEqual];
      Check(B1 = B2, Format('%d,%d: %s <= %s: %s (%s)', [i, j, Arguments[i], Arguments[j], BoolToStr(B1), BoolToStr(B2)]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestAsDouble;
var
  I: Integer;
  D1, D2: Double;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    D1 := A.AsDouble;
    D2 := DoubleResults[I];
    if IsInfinite(D1) then
      Check(IsInfinite(D2))
    else if IsNan(D1) then
      Check(IsNan(D2))
    else
      Check(SameValue(D1, D2), Format('%d: Double(%s) = %0.15f (%0.15f)', [I, A.ToString, D1, D2]));
  end;
end;

procedure TTestBigInteger.TestAsInteger;
var
  I, Int1, Int2: Integer;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    try
      Int1 := A.AsInteger;
      Int2 := StrToInt(AsIntegerResults[I].val);
      Check(Int1 = Int2);
    except
      on E: EConvertError do
        Check(AsIntegerResults[I].info = triOverflow, Format('%d: EConvertError not expected', [I]));
      on E: Exception do
        Error('TestAsInteger: Unexpected exception: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
end;

procedure TTestBigInteger.TestAsCardinal;
var
  I: Integer;
  Card1, Card2: Cardinal;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    try
      Card1 := A.AsCardinal;
      Card2 := StrToInt(AsCardinalResults[I].val);
      Check(Card1 = Card2, Format('%d: %d (%d)', [I, Card1, Card2]));
    except
      on E: EConvertError do
        Check(AsCardinalResults[I].info = triOverflow, Format('%d: EConvertError not expected', [I]));
      on E: Exception do
        Error('TestAsCardinal: Unexpected exception: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
end;

procedure TTestBigInteger.TestAsInt64;
var
  I: Integer;
  Int1, Int2: Int64;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    try
      Int1 := A.AsInt64;
      Int2 := StrToInt64(AsInt64Results[I].val);
      Check(Int1 = Int2);
    except
      on E: EConvertError do
        Check(AsInt64Results[I].info = triOverflow, Format('%d: EConvertError not expected', [I]));
      on E: Exception do
        Error('TestAsInt64: Unexpected exception: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
end;

procedure TTestBigInteger.TestAsUInt64;
var
  I: Integer;
  UInt1: UInt64;
  S1, S2: string;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    try
      // Must use string comparison, because on some versions there is no suitable StrToUInt64, so
      // there is no way to compare UInt64s.
      UInt1 := A.AsUInt64;
      S1 := Format('%u', [UInt1]);
    except
      on E: EConvertError do
      begin
        Check(AsUInt64Results[I].info = triOverflow, Format('%d: EConvertError not expected', [I]));
        Continue;
      end;
      on E: Exception do
        Error('TestAsUInt64: Unexpected exception: ' + E.ClassName + ': ' + E.Message);
    end;
    S2 := AsUInt64Results[I].val;
    Check(S1 = S2, Format('%d: %s.ToUInt64 = %s (%s)', [I, A.ToString, S1, S2]));
  end;
end;

procedure TTestBigInteger.TestDec;
var
  I: Integer;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    B := A - 1;
    C := A;
    Dec(C);
    Check(C = B, Format('(%d) %s --> %s (%s)', [I, A.ToString, C.ToString, B.ToString]));
    Check(A = B + 1);
  end;
end;

procedure TTestBigInteger.TestDivMod;
var
  I, J, N: Integer;
  TRDiv, TRMod: TTestResult;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      TRDiv := DivisionResults[N];
      TRMod := ModulusResults[N];
      Inc(N);
      try
        C := 0;
        D := 0;
        BigInteger.DivMod(A, B, C, D);
      except
        on E: EZeroDivide do
        begin
          Check(TRDiv.info = triDivideByZero, Format('(%d,%d) Unexpected EZeroDivide exception occurred', [I, J]));
          Continue;
        end;
        on E: Exception do
          Error('Unexpected ' + E.ClassName + ' exception: ''' + E.Message + '''');
      end;
      Check(TRDiv.info = triOK, Format('%d,%d: Expected an exception for %s div %s', [I, J, A.ToString, B.ToString]));
      E := TRDiv.val;
      F := TRMod.val;
      Check(C = E, Format('(%d,%d) %s div %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), E.ToString(16)]));
      Check(D = F, Format('(%d,%d) %s mod %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), D.ToString(16), F.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestDivModKnuth;
var
  I, J, N: Integer;
  TRDiv, TRMod: TTestResult;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      TRDiv := DivisionResults[N];
      TRMod := ModulusResults[N];
      Inc(N);
      try
        C := 0;
        D := 0;
        BigInteger.DivModKnuth(A, B, C, D);
      except
        on E: EZeroDivide do
        begin
          Check(TRDiv.info = triDivideByZero, Format('(%d,%d) Unexpected EZeroDivide exception occurred', [I, J]));
          Continue;
        end;
        on E: Exception do
          Error('Unexpected ' + E.ClassName + ' exception: ''' + E.Message + '''');
      end;
      Check(TRDiv.info = triOK, Format('%d,%d: Expected an exception for %s div %s', [I, J, A.ToString, B.ToString]));
      E := TRDiv.val;
      F := TRMod.val;
      Check(C = E, Format('(%d,%d) %s div %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), C.ToString(16), E.ToString(16)]));
      Check(D = F, Format('(%d,%d) %s mod %s = %s (%s)', [I, J, A.ToString(16), B.ToString(16), D.ToString(16), F.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestDivMod16;
var
  I, J: Integer;
  W16: UInt16;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[I];
      W16 := UInt16(B);
      C := W16;
      if W16 = 0 then
        Continue;
      D := BigInteger.Divide(A, W16);
      E := BigInteger.Divide(A, C);
      Check(E = D, Format('(%d, %d) %s div %x = %s (%s)', [I, J, A.ToString(16), W16, D.ToString(16), E.ToString(16)]));
      D := BigInteger.Remainder(A, W16);
      E := BigInteger.Remainder(A, C);
      Check(E = D, Format('(%d, %d) %s mod %x = %s (%s)', [I, J, A.ToString(16), W16, D.ToString(16), E.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestDivMod32;
var
  I, J: Integer;
  W32: UInt32;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[I];
      W32 := UInt32(B);
      C := W32;
      if W32 = 0 then
        Continue;
      D := BigInteger.Divide(A, W32);
      E := BigInteger.Divide(A, C);
      Check(E = D, Format('(%d, %d) %s div %x = %s (%s)', [I, J, A.ToString(16), W32, D.ToString(16), E.ToString(16)]));
      D := BigInteger.Remainder(A, W32);
      E := BigInteger.Remainder(A, C);
      Check(E = D, Format('(%d, %d) %s mod %x = %s (%s)', [I, J, A.ToString(16), W32, D.ToString(16), E.ToString(16)]));
    end;
  end;
end;

procedure TTestBigInteger.TestDivModBurnikelZiegler;
var
  I: Integer;
  R: IRandom;
  Threshold: Integer;
  ASize, BSize: Integer;
  G, H: BigInteger;
begin
  R := TDelphiRandom.Create($1234567);
  for I := 1 to 20 do
  begin
    Threshold := 160;
    ASize := Threshold * 145;
    A := BigInteger.Create(ASize, R);
    BSize := Threshold * 65;
    B := BigInteger.Create(BSize, R);
    BigInteger.DivModKnuth(A, B, C, D);
    BigInteger.DivModBurnikelZiegler(A, B, E, F);
    BigInteger.DivMod(A, B, G, H);
    Check(C = E, Format('%d: %s div %s = %s (%s)', [I, A.ToString(16), B.ToString(16), E.ToString(16), C.ToString(16)])); // Check quotients
    Check(D = F, Format('%d: %s mod %s = %s (%s)', [I, A.ToString(16), B.ToString(16), F.ToString(16), D.ToString(16)])); // Check remainders
  end;
end;

//procedure TestTBigInteger.TestAbs;
//begin
//end;
//
procedure TTestBigInteger.TestBitLength;
var
  I: Integer;
begin
  A := 1;
  for I := 1 to 1000 do
  begin
    Check(A.BitLength = I);
    A := A + A;
  end;
  A := 1;
  for I := 1 to 1000 do
  begin
    Check(A.BitLength = I);
    A := A + A + BigInteger.One;
  end;
end;

procedure TTestBigInteger.TestGreatestCommonDivisor;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];
      C := BigInteger.GreatestCommonDivisor(A, B);
      D := GCDResults[N].val;

      Check(C = D);
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestLn;
var
  I: Integer;
  D1, D2: Double;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    D1 := BigInteger.Ln(A);
    D2 := LnResults[I];
    if IsInfinite(D1) then
      Check(IsInfinite(D2))
    else if IsNan(D1) then
      Check(IsNan(D2))
    else
      Check(SameValue(D1, D2), Format('%d: Ln(%s) = %0.15f (%0.15f)', [I, A.ToString, D1, D2]));
  end;
  A := BigInteger.Pow(1000, 1000);
  D1 := BigInteger.Ln(A);
  Check(Samevalue(D1, Ln_1000_1000), Format('Ln(Pow(1000, 1000)): %.15f (%.15f)', [D1, Ln_1000_1000]));
  D1 := BigInteger.Log10(A);
  Check(SameValue(D1, Log10_1000_1000, 1e-10), Format('Log10(Pow(1000, 1000)): %.15f (%.15f)', [D1, Log10_1000_1000]));
  D1 := BigInteger.Log2(A);
  Check(SameValue(D1, Log2_1000_1000, 1e-10), Format('Log2(Pow(1000, 1000)): %.15f (%.15f)', [D1, Log2_1000_1000]));
end;

procedure TTestBigInteger.TestMax;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];

    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];

      C := BigInteger.Max(A, B);
      D := MaxResults[N].val;
      Inc(N);
      Check(C = D);
    end;
  end;
end;

procedure TTestBigInteger.TestMin;
var
  I, J, N: Integer;
begin
  N := 0;
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];

    for J := 0 to High(Arguments) do
    begin
      B := Arguments[J];

      C := BigInteger.Min(A, B);
      D := MinResults[N].val;
      Inc(N);
      Check(C = D);
    end;
  end;
end;

//procedure TestTBigInteger.TestModPow;
//begin
//end;
//
procedure TTestBigInteger.TestParse;
var
  I: Integer;
  S0, S1: string;
  A, B, C, D: BigInteger;
begin
  S0 := '343597383679999999999999999995663191310057982263970188796520233154296875';
  S1 := '1000000000000000000000000000000000000000000000000000000000';
  A := S0;
  B := S1;
  s0 := A.ToStringClassic(16);
  s1 := b.tostringClassic(16);
  BigInteger.DivMod(A, B, C, D);
  S0 := C.ToStringClassic(16);
  S1 := D.ToStringClassic(16);

  for I := High(MultiplyResults) downto 0 do
  begin
    S0 := MultiplyResults[I].val;
    try
      A := S0;
    except
      on E: Exception do
      begin
        Error(Format('%s, MultiplyResults[%d]: %s'#13#10'val = %s', [E.ClassName, I, E.Message, MultiplyResults[I].val]));
      end;
    end;
    try
      S1 := A.ToString(10);
    except
      on E: Exception do
      begin
        Error(Format('(%d) Error %s with message: %s', [I, E.ClassName, E.Message]));
        raise;
      end;
    end;
    Check(S0 = S1, Format('MultiplyResults[%d]: ''%s'' --> %s (%s), classic: %s', [I, S0, S1, S0, A.ToStringClassic(10)]));
  end;
end;

procedure TTestBigInteger.TestPow;
var
  I, J, N, Exponent: Integer;
begin
  N := 0;
  for I := 0 to High(BitShifts) do
  begin
    A := BitShifts[I];
    for J := 0 to High(BitShifts) do
    begin
      Exponent := BitShifts[J];
      B := BigInteger.Pow(A, Exponent);
      C := PowerResults[N].val;
      Check(B = C, Format('(%d,%d) Pow(%s, %d) = %s (%s)', [I, J, A.ToString, Exponent, B.ToString, C.ToString]));
      Inc(N);
    end;
  end;
end;

procedure TTestBigInteger.TestToByteArray;
var
  I, J: Integer;
  S1, S2: string;
  Bytes: TArray<Byte>;
begin
  for I := 0 to High(Arguments) do
  begin
    A := Arguments[I];
    Bytes := A.ToByteArray;
    S1 := '';
    for J := 0 to High(Bytes) do
      S1 := S1 + Format('%.2X', [Bytes[J]]);
    S2 := ByteArrayResults[I].val;
    Check(S1 = S2, Format('%d: %s --> %s (%s)', [I, A.ToString(16), S1, S2]));
  end;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TTestBigInteger.Suite);
end.


