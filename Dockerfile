# Stage 1: Development
ARG NODE_VERSION=18-alpine
FROM node:${NODE_VERSION} AS development
WORKDIR /app
COPY todo_app/. .
RUN yarn install
CMD ["yarn", "start"]

# Stage 2: Build
FROM development AS build
RUN yarn build

# Stage 3: Production
FROM node:${NODE_VERSION} AS production
WORKDIR /app
COPY --from=build /app/build ./build
RUN yarn install --production
CMD ["node", "build/index.js"]
EXPOSE 3000
