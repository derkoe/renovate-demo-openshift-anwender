FROM maven:3-eclipse-temurin-11@sha256:5a781a7e008965e5631baa8240150d81e0de730377112f58b8c30a0a28c3e570 as builder

WORKDIR /build
COPY . .
RUN mvn clean verify

FROM eclipse-temurin:11-jre@sha256:958fe2fbe3c113bb29726c503f4eb987125d37597f4bdae81c5102bd5c67e9c0

# renovate: datasource=github-releases depName=apangin/jattach
ENV JATTACH_VERSION=1.5

RUN curl -Lo /usr/local/bin/jattach https://github.com/apangin/jattach/releases/download/v${JATTACH_VERSION}/jattach \
 && chmod +x /usr/local/bin/jattach

COPY --from=builder /build/target/demo.jar /demo.jar

ENTRYPOINT ["java", "-jar", "/demo.jar"]
