namespace DotnetRuntime106507_Client
{
    public sealed class HttpClientProvider
    {
        internal const string DefaultClientKey = $"{HttpClientNamePrefix}:default";
        internal const string HttpClientNamePrefix = nameof(HttpClientProvider);

        readonly TimeSpan timeout = Timeout.InfiniteTimeSpan;
        readonly Dictionary<string, HttpClient> clients = new(StringComparer.OrdinalIgnoreCase);

        public HttpClient GetClient()
        {
            var handler = new HttpClientHandler();

            // Allow self-signed cert
            handler.ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true;
            handler.SslProtocols = System.Security.Authentication.SslProtocols.Tls13;

            return GetHttpClient(handler);
        }

        HttpClient GetHttpClient(HttpMessageHandler handler) => new(handler) 
        { 
            Timeout = timeout,
        };
    }
}
