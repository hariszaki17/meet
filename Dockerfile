# Stage 1: Build the Next.js app
FROM node:20 as build

WORKDIR /app

COPY package.json ./
COPY pnpm-lock.yaml ./

RUN npm install -g pnpm
RUN pnpm install

COPY . .

RUN pnpm run build

# Stage 2: Run the Next.js app
FROM node:20-alpine

WORKDIR /app

# Install pnpm in the runtime container
RUN npm install -g pnpm

COPY --from=build /app ./

EXPOSE 3000

CMD ["pnpm", "start"]
