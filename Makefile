include .env

.PHONY: init index_create example

# setup
init:
	check_deployment=$$(atlas deployments list | grep "$(DEPLOYMENT_NAME)    LOCAL"); \
	echo "Check Deployment: '$$check_deployment'"; \
	if [ -n "$$check_deployment" ]; then \
		echo "Found '$(DEPLOYMENT_NAME)' in deployments"; \
		atlas deployments start $(DEPLOYMENT_NAME); \
	else \
		echo "Not found '$(DEPLOYMENT_NAME)' in deployments"; \
		atlas deployments setup --type local --bindIpAll --port $(PORT) --username $(USERNAME) --password $(PASSWORD) --force $(DEPLOYMENT_NAME); \
	fi; \
	tail -f /dev/null

index_create:
	echo "Index Setting"
	atlas deployments search indexes create --file indexDef.json

example:
	mongorestore --archive=sample/sampledata.archive --port=$(PORT) --username $(USERNAME) --password $(PASSWORD)
	atlas deployments search indexes create --type local --deploymentName $(DEPLOYMENT_NAME) --username $(USERNAME) --password $(PASSWORD) --file sample/sample_vector.json