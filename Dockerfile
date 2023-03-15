# base image 
FROM node:17
ENV USER=discord_bot

RUN apt-get update \
    && apt-get -y install ffmpeg \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

# create discord_bot user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/discord_bot -r -g ${USER} ${USER}

# set up volume and user
USER ${USER}
WORKDIR /home/discord_bot

COPY --chown=${USER}:${USER} package*.json ./
RUN npm install
VOLUME [ "/home/discord_bot" ]

COPY --chown=${USER}:${USER}  . .

ENTRYPOINT [ "npm", "run" , "start"]
