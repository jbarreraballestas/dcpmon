# Use the official Alpine Linux image as the base
FROM alpine:latest

# Install necessary packages including OpenJDK
RUN apk update && apk add --no-cache openjdk11 wget git bash

# Download and install Apache Ant 1.10.15
RUN wget https://downloads.apache.org/ant/binaries/apache-ant-1.10.15-bin.tar.gz \
    && tar -xzf apache-ant-1.10.15-bin.tar.gz -C /opt \
    && ln -s /opt/apache-ant-1.10.15 /opt/ant \
    && rm apache-ant-1.10.15-bin.tar.gz

# Download and install Apache Tomcat 10.1.31
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.31/bin/apache-tomcat-10.1.31.tar.gz \
    && tar -xzf apache-tomcat-10.1.31.tar.gz -C /opt \
    && ln -s /opt/apache-tomcat-10.1.31 /opt/tomcat \
    && rm apache-tomcat-10.1.31.tar.gz

# Set environment variables
ENV ANT_HOME=/opt/ant
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=${ANT_HOME}/bin:${JAVA_HOME}/bin:${CATALINA_HOME}/bin:${PATH}

# Set the working directory
WORKDIR /dcpmon

# 
SHELL ["/bin/bash", "-c"]

# Run a command when the container starts
CMD ant -version \
&& java -version \
&& echo "ANT_HOME: $ANT_HOME" \
&& echo "JAVA_HOME: $JAVA_HOME" \
&& echo "CATALINA_HOME: $CATALINA_HOME" \
&& git --version \
&& sed -i 's|\${env.CATALINA_HOME}/lib/||g' build.xml \
&& wget https://repo1.maven.org/maven2/javax/servlet/servlet-api/2.5/servlet-api-2.5.jar -O servlet-api.jar \
&& ant \
&& ls stage/dcpmon-build \
&& cd stage/dcpmon-build \
&& chmod +x makeDcpmon.sh \
&& ./makeDcpmon.sh \
& ls -la
