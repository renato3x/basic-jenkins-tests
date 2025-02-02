FROM node:20-alpine

WORKDIR /app

COPY . .

RUN yarn

RUN yarn build

ENV REDIS_HOST=redis

EXPOSE 3000

ENTRYPOINT ["yarn", "start"]
