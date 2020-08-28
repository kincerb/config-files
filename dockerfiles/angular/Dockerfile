FROM ubuntu:20.04
ARG NODE_VERSION=12.18.3
ARG SOURCE_DIR=/opt/project
ENV NODE_VERSION ${NODE_VERSION}
ENV SOURCE_DIR ${SOURCE_DIR}

RUN mkdir -p ${SOURCE_DIR} && \
    apt-get update && \
    apt-get install -y wget xz-utils git && \
    rm -rf /var/lib/apt/lists/*
RUN wget -O /tmp/node-${NODE_VERSION}.tar.xz \
    https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz && \
    tar -xJf /tmp/node-${NODE_VERSION}.tar.xz -C /usr/local --strip-components=1 --no-same-owner && \
    rm /tmp/node-${NODE_VERSION}.tar.xz && \
    ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    npm install -g @angular/cli && \
    npm install -g typescript && \
    npm install -g tslint

WORKDIR ${SOURCE_DIR}
RUN npm install
CMD ["ng", "serve"]
