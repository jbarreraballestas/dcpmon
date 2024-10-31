# Dependencies

- OpenJDK
- Apache Ant

# Download servlet-api.jar
```bash
wget https://repo1.maven.org/maven2/javax/servlet/servlet-api/2.5/servlet-api-2.5.jar -O servlet-api.jar
```

# Compile

```bash
ant
```

# Generate dcpmon.war

Previously to generate *dcpmon.war* configure the database connection and required config

```bash
cd stage/dcpmon-build
./makeDcpmon.sh
```

