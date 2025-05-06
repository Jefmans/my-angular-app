# # Step 1: Build the Angular app
# FROM node:latest AS build

# WORKDIR /app
# COPY . .
# RUN npm install
# RUN npm run build --prod

# # Step 2: Serve the app using Nginx
# FROM nginx:alpine

# # Copy the built Angular files to Nginx's html directory
# COPY --from=build /app/dist/my-angular-app /usr/share/nginx/html

# # Expose port 80 to access the app
# EXPOSE 80

# # Run Nginx in the foreground
# CMD ["nginx", "-g", "daemon off;"]


# Step 1: Build the Angular app
FROM node:latest AS build

WORKDIR /app

# Copy the entire repository into the container
COPY . .

# Install dependencies
RUN npm install

# Build the Angular app
RUN npm run build --prod

# Step 2: Serve the app with a simple HTTP server (optional)
# This can be a simple Node.js or http-server (if needed for development)
FROM node:latest

# Install http-server (for serving static files)
RUN npm install -g http-server

WORKDIR /app

# Copy the built Angular files from the build stage into the container
COPY --from=build /app/dist/my-angular-app /app/dist/

# Expose the port that the HTTP server will use
EXPOSE 8080

# Run the http-server to serve the Angular app
CMD ["http-server", "dist", "-p", "8080"]
