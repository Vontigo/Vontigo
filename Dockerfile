FROM node:18
 
RUN npm install -g pnpm

WORKDIR /usr/src/app
 
# Copy root package.json and lockfile
COPY package.json ./
# COPY package-lock.json ./
COPY pnpm-lock.yaml ./
COPY pnpm-workspace.yaml ./
 
# Copy the web package.json
COPY apps/web/package.json ./apps/web/package.json
 
RUN pnpm -r update
RUN pnpm install
RUN pnpm run build
 
# Copy app source
COPY . .
 
EXPOSE 8080
 
CMD [ "node", "build" ]