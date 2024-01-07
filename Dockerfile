# Image that the container is going to be based on
FROM node:14

# Sets the working directory
WORKDIR /app

# Whenever you say dot (.) it refers to the previously set working directory
# Copies a file to the working directory
COPY package.json .

# Runs a command
RUN npm install

# Copying the whole application into the working directory
COPY . /app

# Exposing the container 3000 port into the computer's port
EXPOSE 80

# Why not 'RUN node app.mjs'? because that instruction runs everytime the image is
# created
# So with CMD this runs everytime we start a container
CMD [ "node", "app.mjs"]
# This command will keep the container running until it is stopped
