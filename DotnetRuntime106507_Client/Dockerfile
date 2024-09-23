FROM mcr.microsoft.com/dotnet/runtime:8.0 AS base

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
     file \
     lldb \
     procps \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

USER app
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Debug
WORKDIR /src
COPY ["DotnetRuntime106507_Client/DotnetRuntime106507_Client.csproj", "DotnetRuntime106507_Client/"]
RUN dotnet restore "DotnetRuntime106507_Client/DotnetRuntime106507_Client.csproj"
COPY . .
WORKDIR "/src/DotnetRuntime106507_Client"
RUN dotnet build "DotnetRuntime106507_Client.csproj" -c $configuration -o /app/build

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS tools-install
RUN dotnet tool install --tool-path /dotnetcore-tools dotnet-sos
RUN dotnet tool install --tool-path /dotnetcore-tools dotnet-trace
RUN dotnet tool install --tool-path /dotnetcore-tools dotnet-dump
RUN dotnet tool install --tool-path /dotnetcore-tools dotnet-counters

FROM build AS publish
ARG configuration=Debug
RUN dotnet publish "DotnetRuntime106507_Client.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

# From https://github.com/dotnet/diagnostics/issues/573
FROM base AS final

COPY --from=tools-install /dotnetcore-tools /opt/dotnetcore-tools
ENV PATH="/opt/dotnetcore-tools:${PATH}"
RUN dotnet-sos install

WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DotnetRuntime106507_Client.dll"]
