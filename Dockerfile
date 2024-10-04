FROM gradle:7.2-jdk11

ENV GRADLE_VERSION=7.2

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && apt-get clean

# RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip -P /tmp && \
#     unzip -d /opt/gradle /tmp/gradle-$GRADLE_VERSION-bin.zip && \
#     ln -s /opt/gradle/gradle-$GRADLE_VERSION /opt/gradle/latest && \
#     echo 'export PATH=$PATH:/opt/gradle/latest/bin' >> /etc/profile.d/gradle.sh

WORKDIR /app


COPY . .
# COPY ./src /app/src
# COPY ./webapps /app/

# COPY ./gradlew ./
# RUN chmod +x gradlew

RUN gradle build -x test --no-daemon

COPY /app/build/libs/* /usr/local/tomcat/webapps/myapp

RUN file="$(ls -1 /app/build/libs/)" && echo $file
CMD ["echo", "123"]

# CMD ["./gradlew", "bootRun"]