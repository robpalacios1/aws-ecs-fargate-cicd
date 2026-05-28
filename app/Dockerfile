# Use official Node.js image
FROM node:20-alpine

# Create and set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json .

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 80

# Start the application
CMD ["npm", "start"]