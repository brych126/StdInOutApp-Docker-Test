// See https://aka.ms/new-console-template for more information

Console.WriteLine("This is simple app just to test sdin/stdout while using docker");
Console.WriteLine(Environment.NewLine);

while (true)
{
    Console.Write("Enter any text: ");
    string msg = Console.ReadLine() ?? string.Empty;
    Console.WriteLine($"Your text: {msg}");
    Console.WriteLine(Environment.NewLine);
}
