# Step 1: Build the Angular app
FROM node:16 AS build

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# Step 2: Serve the app using Nginx
FROM nginx:alpine

# Copy the built Angular files to Nginx's html directory
COPY --from=build /app/dist/my-angular-app /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
