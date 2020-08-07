<Query Kind="Program" />

internal struct Point {
    public Point(double x, double y)
        => (X, Y) = (x, y);
    
    public void Deconstruct(out double x, out double y)
        => (x, y) = (X, Y);

    public double X { get; set; }
    public double Y { get; set; }
}

private static void Main()
{
    var a = new[] { new Point(10, 20), new Point(1.5, 3.6), new Point() };
    a.Dump(nameof(a));
    a[2].Y = 0.5; // Changes a[2], unlike in Crystal.
    a.Dump(nameof(a));
}
