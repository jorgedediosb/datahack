FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal AS base
WORKDIR /app

EXPOSE 7007

# Puertos en los cuales ASP.NET Core escucha:
ENV ASPNETCORE_URLS=http://+:7007

# Argumento, etiqueta y variable para la versión de la app:
ARG Version=${Version}
LABEL Version=${Version}
ENV Version=${Version}

# Argumento y variable para el entorno de la app:
ARG Entorno=${Entorno}
ENV Entorno=${Entorno}

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /src
COPY ["PracticaEval01.csproj", "./"]
RUN dotnet restore "PracticaEval01.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "PracticaEval01.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PracticaEval01.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "PracticaEval01.dll"]
