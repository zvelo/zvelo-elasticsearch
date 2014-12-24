DOCKER_IMAGE=zvelo/zvelo-elasticsearch

all: image

image:
	docker build -t $(DOCKER_IMAGE) .
