FROM java:8-jdk-alpine as builder

WORKDIR /app
COPY . /app/
RUN /app/auto/build-war-package

FROM tomcat:8-slim as generator

COPY entrypoint /app/
COPY config/server.xml /usr/local/tomcat/conf/
COPY --from=builder /app/src/hello.war /usr/local/tomcat/webapps/

ENTRYPOINT ["/app/entrypoint"]
CMD ["catalina.sh", "run"]
