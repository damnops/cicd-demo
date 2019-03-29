FROM java:8-jdk-alpine as builder

WORKDIR /app
COPY . /app/
RUN /app/auto/build-war-package

FROM tomcat:8-slim as generator

COPY --from=builder /app/hello.war /usr/local/tomcat/webapps/
