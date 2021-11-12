# This image contains SDK's for Java and .NET
# It's intendet to be used in Java/.NET Interop Szenarios.
# 
# Use Cases:
# - Wrapping a CLI Tool from the other environment to be exposed as Library or Web API
# - Base container for services that cherry pick requirements from both environments

#
# First Step
#
# We base that image on the official Java OpenJDK image of eclipe-temurin.
#
FROM eclipse-temurin:11-alpine

#
# Second Step
#
# We update the apk of Alpine, after that we install the requirements for the .NET SDK.
# When it's donw we download and install .NET with the official installation script.
#
RUN apk update

# install apline requirements for .NET
RUN apk add --no-cache \
    icu-libs \
    krb5-libs \
    libgcc \
    libssl1.1 \
    libstdc++ \
    zlib \
    curl \
    bash \
    libintl \
    wget

RUN apk add libgdiplus --repository https://dl-3.alpinelinux.org/alpine/edge/testing/

RUN mkdir -p /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

RUN curl -LO https://dot.net/v1/dotnet-install.sh
RUN chmod +x dotnet-install.sh

# RUN ./dotnet-install.sh -c 3.1 --install-dir /usr/share/dotnet
RUN ./dotnet-install.sh -c 5.0 --install-dir /usr/share/dotnet
# RUN ./dotnet-install.sh -c 6.0 --install-dir /usr/share/dotnet

# remove the .NET installation script
RUN rm ./dotnet-install.sh

# Disable .NET Telemetry and extra info at first run
RUN echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" >> /etc/profile
RUN echo "export DOTNET_NOLOGO=1" >> /etc/profile

COPY show-info.sh /usr/bin/
RUN chmod +x /usr/bin/show-info.sh
CMD [ "show-info.sh" ]
