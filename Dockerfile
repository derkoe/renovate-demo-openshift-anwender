FROM maven:3-eclipse-temurin-11@sha256:5a781a7e008965e5631baa8240150d81e0de730377112f58b8c30a0a28c3e570 as builder

WORKDIR /build
COPY . .
RUN mvn clean verify

FROM eclipse-temurin:18-jre@sha256:15ce0ec54a40593126319ddc9e69a114baf332013c9c3494bf151e43a2389ade

# renovate: datasource=github-releases depName=apangin/jattach
ENV JATTACH_VERSION=1.5

RUN curl -Lo /usr/local/bin/jattach https://github.com/apangin/jattach/releases/download/v${JATTACH_VERSION}/jattach \
 && chmod +x /usr/local/bin/jattach

COPY --from=builder /build/target/demo.jar /demo.jar

ENTRYPOINT ["java", "-jar", "/demo.jar"]
