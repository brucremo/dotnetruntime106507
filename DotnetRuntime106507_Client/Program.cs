namespace DotnetRuntime106507_Client
{
    internal class Program
    {
        static HttpClient client = new HttpClientProvider().GetClient();

        static void Main(string[] args)
        {
            var apiHostWithPort = Environment.GetEnvironmentVariable("API_HOST_PORT");

            bool allGood = true;

            while (allGood)
            {
                try
                {
                    var message = new HttpRequestMessage(HttpMethod.Get, $"https://{apiHostWithPort}/Weatherforecast")
                    {
                        Version = new Version(2, 0)
                    };

                    var result = client.SendAsync(message, HttpCompletionOption.ResponseHeadersRead).Result;
                    Console.WriteLine($"{DateTime.Now} - All Good");
                    Thread.Sleep(3);
                }
                catch (TaskCanceledException)
                {
                    allGood = false;
                    throw;
                }
                catch (Exception)
                {
                    Console.WriteLine($"{DateTime.Now} - Got an error, the server may be down?");
                    Thread.Sleep(10);
                }
            }
        }
    }
}
