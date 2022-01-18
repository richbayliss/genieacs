FROM node:12 as builder

WORKDIR /usr/src/app
COPY package.json .
RUN npm i

COPY . .
RUN npm run build

# ---
FROM node:12-slim as base

WORKDIR /genieacs
COPY --from=builder /usr/src/app/dist /genieacs
RUN npm i --production

FROM base as cwmp
CMD [ "/genieacs/bin/genieacs-cwmp" ]

FROM base as ui
CMD [ "/genieacs/bin/genieacs-ui" ]

FROM base as fs
CMD [ "/genieacs/bin/genieacs-fs" ]

FROM base as nbi
CMD [ "/genieacs/bin/genieacs-nbi" ]


