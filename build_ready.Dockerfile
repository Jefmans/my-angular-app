
# Step 2: Serve the app using Nginx
FROM nginx:alpine

# Remove the default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy the built Angular files from the build stage to Nginx's html directory
# Adjusted path to point to the 'browser' directory inside the dist folder
COPY --from=build /app/dist/my-angular-app/browser /usr/share/nginx/html

# Set proper permissions on the copied files (Nginx needs to read them)
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
