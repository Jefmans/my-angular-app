# Step 1: Build the Angular app
FROM node:latest AS build

RUN mkdir /app
WORKDIR /app
COPY . .

RUN npm install -g @angular/cli

# Install other dependencies
RUN npm install

RUN npm run build --prod

# Write the contents of /app/dist to a file
RUN ls -l /app/dist > /app/build_output.txt


# Step 2: Serve the app using Nginx
FROM nginx:alpine

# Copy the built Angular files to Nginx's html directory
COPY --from=build /app/dist/my-angular-app /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
