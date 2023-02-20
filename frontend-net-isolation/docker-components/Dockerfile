## Stage 1, installing node, npm, angular and building static content
FROM amazonlinux:latest as builder
COPY nginx.conf /root
RUN amazon-linux-extras enable epel \
    && curl --silent --location https://rpm.nodesource.com/setup_14.x | bash - \
    && yum clean metadata && yum install epel-release -y && yum update -y \
    # Installing git, nodejs and npm
    && yum install git tar nodejs -y \
    && npm cache clean -f && npm install -g n && n 10 \
    # Angular setup
    && npm install -g @angular/cli@8.0.0 \


    # Building the project" 
RUN cd /V2_Portal && ng analytics off && npm install \
    && cd /V2_Portal && ng build trade-markets -c=prod
# Stage 2, publishing project files
FROM nginx:1.21.6-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /V2_Portal/dist /usr/share/nginx/html
EXPOSE 80
STOPSIGNAL SIGTERM
