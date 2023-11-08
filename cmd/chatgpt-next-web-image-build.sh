#!/bin/bash
TAG=${1:-2.9.9}
mkdir -p ChatGPT-Next-Web/; cd ChatGPT-Next-Web
wget https://github.com/Yidadaa/ChatGPT-Next-Web/archive/refs/tags/v${TAG}.tar.gz
tar -zxvf v${TAG}.tar.gz
mv ChatGPT-Next-Web-${TAG} chatgpt-next-web

cat > Dockerfile <<EOF
FROM node:21.1.0
EXPOSE 3000

COPY chatgpt-next-web /chatgpt-next-web

WORKDIR /chatgpt-next-web

RUN git init \\
      && npx husky-init -y \\
        && yarn add sharp \\
          && yarn install  \\
            && yarn build 

CMD ["yarn", "start"]
EOF

docker build --network host . -t chatgpt-next-web:1.0