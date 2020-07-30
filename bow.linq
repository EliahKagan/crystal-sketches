<Query Kind="Statements">
  <Namespace>System.Numerics</Namespace>
</Query>

static void EnsurePositive(int exponent)
{
    if (exponent < 0) {
        throw new ArgumentOutOfRangeException(
                paramName: nameof(exponent),
                message: "negative exponents not supported");
    }
}

static BigInteger Bang(BigInteger @base, int exponent)
{
    EnsurePositive(exponent);
    if (exponent == 0) return BigInteger.One;
    
    var power = Bang(@base, exponent / 2);
    power *= power;
    if (exponent % 2 != 0) power *= @base;
    return power;
}

static BigInteger Whimper(BigInteger @base, int exponent)
{
    EnsurePositive(exponent);
    if (exponent == 0) return BigInteger.One;
    
    var power = Whimper(@base, exponent / 2) * Whimper(@base, exponent / 2);
    if (exponent % 2 != 0) power *= @base;
    return power;
}

static BigInteger Test<TOut>(BigInteger @base, int exponent, string label,
                             Func<BigInteger, int, BigInteger> impl,
                             Func<BigInteger, TOut> reporter)
{
    var ti = Util.ElapsedTime;
    var result = impl(@base, exponent);
    var tf = Util.ElapsedTime;
    reporter(result).Dump($"{label}: {tf - ti}");
    return result;
}

static void HorizontalRule()
    => Util.RawHtml("<hr/>").Dump();

static void TestAll<TOut>(BigInteger @base, int exponent,
                          Func<BigInteger, TOut> reporter)
{
    foreach (var run in Enumerable.Range(0, 2)) {
        var bang = Test(@base, exponent,
                        nameof(Bang), Bang, reporter);
        
        var whimper = Test(@base, exponent,
                           nameof(Whimper), Whimper, reporter);
        
        var pow = Test(@base, exponent,
                       nameof(BigInteger.Pow), BigInteger.Pow, reporter);
        
        if (!(bang == whimper && whimper == pow))
            "The results differ!".Dump("WARNING");
        
        HorizontalRule();
    }
    
    HorizontalRule();
}

// Reporters
static T Id<T>(T n) => n;
static BigInteger LastNine(BigInteger n) => n % 1_000_000_000;

TestAll(3, 1000, Id);
TestAll(3, 1_000_000, LastNine);
TestAll(3, 10_000_000, LastNine);
