FROM node as builder

WORKDIR /usr/src/mmoaig-web-client
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:alpine
WORKDIR /usr/mmoaig-web-client
COPY --from=builder /usr/src/mmoaig-web-client/dist ./
CMD ["node", "server"]
