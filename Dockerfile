FROM node:22-alpine AS deps

RUN apk add --no-cache git

WORKDIR /app

COPY package.json package-lock.json ./
ENV HUSKY=0
RUN npm ci && npm prune --omit=dev && npm install dotenv --no-save

FROM node:22-alpine

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY src/ ./src/
COPY config*.js ./
COPY package.json ./package.json

ENV NODE_ENV=production

EXPOSE 2333

CMD ["npm", "start"]
