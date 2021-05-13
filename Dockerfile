FROM mhart/alpine-node:16

RUN set -x \
    && apk add --no-cache git bash \
    && git --version && bash --version && node -v && npm -v

WORKDIR /app
COPY package.json /app
RUN npm install --production --no-audit

COPY .env .bin/fc-agent.cjs fc-agents-init.sh /app/
RUN chmod +x /app/fc-agent.cjs
RUN chmod +x /app/fc-agents-init.sh
ENV PATH="/app:${PATH}"

RUN mkdir -p /app/data

ENTRYPOINT [ "fc-agents-init.sh" ]
