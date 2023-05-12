FROM node:16
 
RUN npm install -g pnpm

WORKDIR /usr/src/app
 
# Copy root package.json and lockfile
COPY package.json ./
COPY package-lock.json ./
 
# Copy the web package.json
COPY apps/web/package.json ./apps/web/package.json
 
RUN pnpm install
RUN pnpm build
 
# Copy app source
COPY . .
 
EXPOSE 8080
 
CMD [ "node", "build" ]