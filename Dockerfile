FROM eclipse-temurin:21
# VOLUME /tmp
# ARG JAVA_OPTS
# ENV JAVA_OPTS=$JAVA_OPTS
WORKDIR /app
COPY target/*.jar client-card.jar
# EXPOSE 3000
# ENTRYPOINT exec java $JAVA_OPTS -jar bootproject.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar bootproject.jar

# ENV DB_URL=dbc:mysql://mysql-clusterip-svc:23307/mydb
# ENV DB_URL=dbc:mysql://mysql-svc:23306/mydb
# ENV DB_URL=jdbc:mysql://192.168.100.221:23306/mydb
# ENV DB_USER=user
# ENV DB_PASS=mysql
# ENV DB_DRIVER=com.mysql.cj.jdbc.Driver


CMD ["java", "-jar", "client-card.jar"]
