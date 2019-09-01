TAG  ?= v0.37.2

all: build push

build:
	$(PWD)/build.sh $(TAG)

push:
	@for image_name in $(shell docker images | grep -o "forrpi/certbot[-a-z]*" | sort | uniq); do \
		@echo "Pushing $${image_name}...\n"; \
		docker tag $${image_name}:$(TAG) "$${image_name}:latest"; \
		docker push $${image_name}:$(TAG); \
		docker push $${image_name}:latest; \
	done

