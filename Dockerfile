FROM node:16.17.0-alpine as builder
WORKDIR /app
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install
COPY . .
ARG TMDB_V3_API_KEY=s/kdZcV3zNHQvn9r+fGbZg==
ENV VITE_APP_TMDB_V3_API_KEY=3d46f911a02dad701afcc4e7cad806ed
ENV VITE_APP_API_ENDPOINT_URL=aHR0cHM6Ly9hcGkudGhlbW92aWVkYi5vcmcvMw==
RUN yarn build

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
