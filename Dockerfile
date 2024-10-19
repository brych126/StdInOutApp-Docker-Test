# More Samples can be found here https://github.com/dotnet/dotnet-docker/blob/main/samples/dotnetapp/Dockerfile
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG TARGETARCH
WORKDIR /source

# Copy project file and restore as distinct layers
COPY --link *.csproj .
RUN dotnet restore -a $TARGETARCH

# Copy source code and publish app
COPY --link . .
RUN dotnet publish -a $TARGETARCH --no-restore -o /app


# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app

#Just to view processes
RUN apt-get update && apt-get install -y procps

# When copying from separate stage/local context then initial file permissions will be kept 
# When using Git repository as the build context:
# Permission for executables and directories is always rwx-xr-xr so, for files always rw-r--r
# So, app user is able to run program
COPY --link --from=build /app .

# Set system user as default
USER $APP_UID

ENTRYPOINT ["./StdInOutApp"]
