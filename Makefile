-include .env.default
-include .env

docker_stack_name := rabbitmq
service_replicas := 3

compose_files := -c docker-compose.yml
ifneq ("$(wildcard docker-compose.override.yml)","")
	compose_files += -c docker-compose.override.yml
endif

it:
	@echo "make [configs|deploy|destroy]"

.PHONY: configs
configs:
	@echo "No configs to generate [SKIP]"

plan:
	docker stack config $(compose_files)

deploy: configs
	docker stack deploy $(compose_files) ${docker_stack_name}

destroy:
	docker stack rm ${docker_stack_name}

scale:
	docker service scale ${docker_stack_name}_server=${service_replicas}
