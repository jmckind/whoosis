APP_NAME=whoosis
APP_VERSION=$(shell cat $(SRC_DIR)/setup.py | grep -o 'version=.*' | cut -d"'" -f2)
BASE_DIR=$(shell pwd)
SRC_DIR=$(BASE_DIR)/src
DIST_DIR=$(SRC_DIR)/dist
DEV_IMAGE=python:3
DEV_NAME=$(APP_NAME)-dev
DEV_DIR=/opt/$(APP_NAME)
DEV_SRC_DIR=$(DEV_DIR)/src
DEV_PORT_CONTAINER=4778
DEV_PORT_HOST=$(DEV_PORT_CONTAINER)
DEV_PREVIEW_HOST=0.0.0.0:$(DEV_PORT_CONTAINER)
DEV_SHELL=/bin/bash
RELEASE_PROJECT=jmckind
RELEASE_IMAGE=$(RELEASE_PROJECT)/$(APP_NAME):$(APP_VERSION)
RELEASE_SRC_ARCHIVE=$(APP_NAME)-$(APP_VERSION).tar.gz
RUN_NAME=$(APP_NAME)-run
RUN_PORT_CONTAINER=$(DEV_PORT_CONTAINER)
RUN_PORT_HOST=8778

#
# The setup target creates a container locally to run the application in
# development mode.
#
.PHONY: setup
setup:
	docker run --name $(DEV_NAME) -itd \
		-v $(BASE_DIR):$(DEV_DIR) \
		-p $(DEV_PORT_HOST):$(DEV_PORT_CONTAINER) \
		-w $(DEV_SRC_DIR) \
		$(DEV_IMAGE)
	docker exec -it $(DEV_NAME) python setup.py install

#
# The devsh target creates a shell session on the running development container.
#
.PHONY: devsh
devsh:
	docker exec -it $(DEV_NAME) $(DEV_SHELL)

#
# The devrm target removes the running development container.
#
.PHONY: devrm
devrm:
	docker rm -f $(DEV_NAME) || true

#
# The preview target runs the development server.
#
.PHONY: preview
preview:
	docker exec -it $(DEV_NAME) python manage.py runserver $(DEV_PREVIEW_HOST)

#
# The manage target will run the provided task with the django manage script.
# Example: make manage TASK=collectstatic
#
.PHONY: manage
manage:
	docker exec -it $(DEV_NAME) python manage.py $(TASK)

#
# The migrate target will run perform any application migrations.
#
.PHONY: migrate
migrate:
	docker exec -it $(DEV_NAME) python manage.py makemigrations
	docker exec -it $(DEV_NAME) python manage.py migrate

#
# The init target will run the setup and migrate targets in order
#
.PHONY: init
init: | setup migrate

#
# The dist target will generate the distributable artifact for the application.
# The tag target adds a git tag for the current version.
#
.PHONY: dist
dist:
	docker exec -it $(DEV_NAME) python setup.py sdist

#
# The tag target adds a git tag for the current version.
#
.PHONY: tag
tag:
	git tag v$(APP_VERSION) -m"Tagging v$(APP_VERSION) release"
	git push --tags

#
# The release target uploads the release binary to the github release for the
# current version.
#
.PHONY: release
release: clean init dist
	github-release upload \
		--user $(RELEASE_PROJECT) \
		--repo $(APP_NAME) \
		--tag v$(APP_VERSION) \
		--name "$(RELEASE_SRC_ARCHIVE)" \
		--file $(DIST_DIR)/$(RELEASE_SRC_ARCHIVE)

#
# The run target runs the docker image for the application.
#
.PHONY: run
run:
	docker run --name $(RUN_NAME) -itd \
		-p $(RUN_PORT_HOST):$(RUN_PORT_CONTAINER) \
		$(RELEASE_IMAGE)

#
# The runrm target removes the running container for the application.
#
.PHONY: runrm
runrm:
	docker rm -f $(RUN_NAME) || true

#
# The clean target will remove any temporary artifacts generated during
# development.
#
.PHONY: clean
clean: | devrm runrm
	cd $(SRC_DIR) && rm -fr build dist *.egg-info
	find . -name __pycache__ -exec rm -fr {} \; 2> /dev/null || true

#
# The reset target will return the working directory back to a pristine state.
#
.PHONY: reset
reset: clean
	rm -fr $(SRC_DIR)/db.sqlite3
