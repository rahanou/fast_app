build:
	@echo "Building docker image..."
	@docker build -t $(DOCKER_IMAGE_NAME) .

run:
	@echo "Running docker image..."
	@docker run -it --rm -p $(PORT):$(PORT) -e PORT=$(PORT) $(DOCKER_IMAGE_NAME)


tag:
	@echo "Tagging Docker image..."
	docker tag "$(DOCKER_IMAGE_NAME)" "$(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME)"


push:
	@echo "Pushing Docker image to gcp..."
	docker push "$(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME)"


deploy:
	@echo "Deploying docker image..."
	@gcloud run deploy first-app --image "$(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME)" --region europe-west1 --allow-unauthenticated


all: build run tag push deploy
