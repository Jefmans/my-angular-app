# Step 1: Use Nginx as a base image
FROM nginx:alpine

# Remove the default Nginx static files
RUN rm -rf /usr/share/nginx/html/*
COPY . .
RUN chmod -R 755 /usr/share/nginx/html

# Copy the pre-built Angular files from the host machine to Nginx's html directory
COPY ./dist/my-angular-app/browser /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

