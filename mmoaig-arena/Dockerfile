FROM node as builder

WORKDIR /usr/src/mmoaig-arena
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:alpine
WORKDIR /usr/mmoaig-arena
COPY --from=builder /usr/src/mmoaig-arena/dist ./
CMD ["node", "server"]

