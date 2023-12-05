FROM mcr.microsoft.com/dotnet/sdk:7.0 AS builder
WORKDIR /build
RUN dotnet tool install retypeapp --tool-path /bin

COPY ./kmb-docs /build
COPY ./retype.yml /build
RUN retype build retype.yml --output .docker-build/

FROM httpd:latest
COPY --from=builder /build/.docker-build/ /usr/local/apache2/htdocs/