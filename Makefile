VERSION = 1.17

all: build push

build:
	docker build -t cronycledocker/tika:$(VERSION) .

push:
	docker push cronycledocker/tika:$(VERSION)

run:
	docker run -ti --rm --name tika -p 9998:9998 cronycledocker/tika:$(VERSION)
