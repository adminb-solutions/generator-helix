FROM node:6-jessie as install

# Install powershell
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-jessie-prod jessie main" > /etc/apt/sources.list.d/microsoft.list && \
    apt-get update && \
    apt-get install -y powershell 

WORKDIR /src

ADD package*.json ./

RUN npm install


FROM install as test

ADD . .

RUN npm test


FROM cluedin/yeoman:jessie

USER root 

# Install powershell
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-jessie-prod jessie main" > /etc/apt/sources.list.d/microsoft.list && \
    apt-get update && \
    apt-get install -y powershell 

ARG environment=Production

ENV NODE_ENV $environment

WORKDIR /usr/local/lib/node_modules/generator-helix

COPY --from=test /src/node_modules  ./node_modules
COPY --from=test /src/generators  ./generators
COPY --from=test /src/modules  ./modules
COPY --from=test /src/powershell  ./powershell
COPY --from=test /src/package*.json  ./
COPY --from=test /src/readme.md  ./README.md

USER yeoman

WORKDIR /generated

CMD [ "helix" ]