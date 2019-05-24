FROM node:lts-slim

LABEL "com.github.actions.name"="github-actions-release"
LABEL "com.github.actions.description"="GitHub actions for release"
LABEL "com.github.actions.icon"="award"
LABEL "com.github.actions.color"="white"

LABEL "repository"="https://github.com/thonatos/actions"
LABEL "homepage"="https://github.com/thonatos/actions"
LABEL "maintainer"="Thonatos Yang <thonatos.yang@gmail.com>"

COPY package.json ./

RUN npm install

COPY . .

ENTRYPOINT ["npm start"]