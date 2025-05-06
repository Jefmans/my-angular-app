# Step 1: Build the Angular app
FROM node:alpine AS build

RUN mkdir -p /app
WORKDIR /app
COPY . .

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install project dependencies
RUN npm install

# Install the required builder
RUN npm install --save-dev @angular-devkit/build-angular

# Build the Angular app (production build)
RUN npm run build --prod

# Keep the container running
CMD ["tail", "-f", "/dev/null"]

# RUN npm install -g @angular/cli

# # Install other dependencies
# RUN npm install

# RUN npm run build --prod

# # Write the contents of /app/dist to a file
# RUN ls -l /app/dist > /app/build_output.txt


# # Step 2: Serve the app using Nginx
# FROM nginx:alpine

# # Copy the built Angular files to Nginx's html directory
# COPY --from=build /app/dist/my-angular-app /usr/share/nginx/html

# # Expose port 80 to access the app
# EXPOSE 8080

# # Run Nginx in the foreground
# CMD ["nginx", "-g", "daemon off;"]


# Step 2: Serve the app using Nginx
# FROM nginx:alpine

# # Copy the built Angular files from the build stage to Nginx's html directory
# COPY --from=build /app/dist/my-angular-app /usr/share/nginx/html

# # Expose port 80 to access the app
# EXPOSE 80

# # Run Nginx in the foreground
# CMD ["nginx", "-g", "daemon off;"]