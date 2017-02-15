FROM node:7.5

LABEL vendor = "Smart Ideas, LLC"

WORKDIR /usr/src/xo

RUN git config --global url."https://".insteadOf git://

RUN git clone -b stable http://github.com/vatesfr/xo-server && \
    git clone -b stable http://github.com/vatesfr/xo-web

ENV NPM_CONFIG_LOGLEVEL warn

RUN cd xo-server/ && npm install && npm run build && cd .. && \
    cd xo-web/ && npm install && npm run build && cd ..

COPY xo-server.yaml /usr/src/xo/xo-server/.xo-server.yaml

RUN cd xo-web/ && npm install && npm run build && cd .. && \
    cd xo-web/ && npm install && npm run build && cd ..

WORKDIR /usr/src/xo/xo-server

EXPOSE 80

CMD ["npm","start"]
