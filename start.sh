#!/usr/bin/env sh
mkdir -p /logs/${SERVICE_NAME}
if [ "$SPRING_PROFILES_ACTIVE" == "PROD" ]
then
	echo "PROD Environment"
	cat <<EOF >> application-startup.sh
java -Dserver.port=8080 -Dspring.profiles.active=production -DLOG_DIR=/logs/${SERVICE_NAME} -jar /apps/app.jar
EOF

elif [ "$SPRING_PROFILES_ACTIVE" == "PREPROD" ]
then
        echo "PREPROD Environment"
        cat <<EOF >> application-startup.sh
java -Dserver.port=8080 -Dspring.profiles.active=beta -DLOG_DIR=/logs/${SERVICE_NAME} -jar /apps/app.jar
EOF

elif [ "$SPRING_PROFILES_ACTIVE" == "NONPROD" ] || [ "$SPRING_PROFILES_ACTIVE" == "staging" ]
then
	echo "Staging Environment"
	cat <<EOF >> application-startup.sh
java -Dserver.port=8080 -Dspring.profiles.active=staging -DLOG_DIR=/logs/${SERVICE_NAME} -jar /apps/app.jar
EOF

elif [ "$SPRING_PROFILES_ACTIVE" == "QA" ] || [ "$SPRING_PROFILES_ACTIVE" == "DEV" ] || [ "$SPRING_PROFILES_ACTIVE" == "STAGE" ] || [ "$SPRING_PROFILES_ACTIVE" == "PT" ] || [ "$SPRING_PROFILES_ACTIVE" == "PROD_TEST" ]
then
	echo "Staging Environment"
	cat <<EOF >> application-startup.sh
java -Dserver.port=8080 -Dspring.profiles.active=dev -DLOG_DIR=/logs/${SERVICE_NAME} -jar /apps/app.jar
EOF

else
    echo "No Environment Specified, Running app without springboot profile"
	cat <<EOF >> application-startup.sh
java -Dserver.port=8080 -DLOG_DIR=/logs/${SERVICE_NAME} -jar /apps/app.jar
EOF

fi

exec sh application-startup.sh
