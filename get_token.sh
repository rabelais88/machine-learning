CONTAINER=$(docker container ls | grep machine-learning | awk '{print $1}')
echo $CONTAINER

REPLACE="localhost"
URL=$(docker container exec -it $CONTAINER jupyter notebook list | awk 'NR==2{print $1}' | sed "s/.0.0.0.0/${REPLACE}/")
echo $URL