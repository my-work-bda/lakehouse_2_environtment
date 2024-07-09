DOCKER_NETWORK = dev_lakehouse
# ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t kevinity310/lasagna-spark:$(current_branch) -f ./images/spark/Dockerfile .
	docker build -t kevinity310/lasagna-hms:$(current_branch) -f ./images/hive-metastore/Dockerfile .
	docker build -t kevinity310/lasagna-trino:$(current_branch) -f ./images/trino/Dockerfile .
	docker build -t kevinity310/lasagna-workspace:$(current_branch) -f ./images/workspace/Dockerfile .

run: 
	docker compose up -d
	
restart: 
	docker compose up -d
	
# push: 
# 	# docker push kevinity310/hadoop-base:$(current_branch)
# 	# docker push kevinity310/hadoop-namenode:$(current_branch)
# 	# docker push kevinity310/hadoop-datanode:$(current_branch)
# 	# docker push kevinity310/hadoop-resourcemanager:$(current_branch)
# 	# docker push kevinity310/hadoop-nodemanager:$(current_branch)
# 	# docker push kevinity310/hadoop-historyserver:$(current_branch)
# 	# docker push kevinity310/hive:$(current_branch)
# 	# docker push kevinity310/pg-metastore:$(current_branch)
# 	# # docker push kevinity310/hadoop-submit:$(current_branch)

# # wordcount:
# 	docker build -t hadoop-wordcount ./submit
# 	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
# 	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
# 	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
# 	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
# 	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
# 	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -rm -r /input

# restart:
# 	docker compose -f docker-compose-host-dev.yml down -v
# 	docker compose -f docker-compose-host-dev.yml up -d

reset:
	make build 
	docker compose -f docker-compose-host-dev.yml down -v 
	docker compose -f docker-compose-host-dev.yml up -d 
	