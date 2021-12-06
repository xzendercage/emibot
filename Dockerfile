FROM node:14.16.1-slim

ENV USER=emibot

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove

# create emibot user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/emibot -r -g ${USER} ${USER}

# set up volume and user
USER ${USER}
WORKDIR /home/emibot

COPY --chown=${USER}:${USER} package*.json ./
RUN npm install
VOLUME [ "/home/emibot" ]

COPY --chown=${USER}:${USER}  . .

ENTRYPOINT [ "node", "index.js" ]
