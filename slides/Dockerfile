FROM quay.io/fedora/fedora:30-x86_64
RUN dnf install -y git npm bzip2
ADD . /slides/
WORKDIR /slides
RUN npm install 
EXPOSE 8080
CMD ["npm","start"]
