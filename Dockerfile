# Build Stage
FROM node:20-alpine as build

WORKDIR /app

COPY . .

RUN yarn

RUN yarn build

# Runtime Stage
FROM node:20-alpine

COPY --from=build /app/dist/ ./dist
COPY --from=build /app/package.json ./

RUN yarn

EXPOSE 3000

ENTRYPOINT ["yarn", "start"]
