
.PHONY: start stop quit reload clean tail test show help

# Check if openresty is available in PATH
OPENRESTY := $(shell which openresty)
ifeq ($(OPENRESTY),)
    OPENRESTY := $(shell which nginx)
endif
ifeq ($(OPENRESTY),)
    $(error Neither OpenResty nor Nginx found in PATH)
endif

help:
	@echo "Available make targets:"
	@echo ""
	@echo " - start/stop/quit/reload: will do as expected"
	@echo " - test  : will issue a GET request on 'http://localhost:8080/'"
	@echo " - tail  : will start a tail on the access and error log files"
	@echo " - show  : will show the current nginx processes running"
	@echo " - clean : will stop and clean the working directory/prefix"
	@echo ""

t/logs/access.log:
	-mkdir -p ./t/logs
	touch "./t/logs/access.log"

t/logs/error.log:
	-mkdir -p ./t/logs
	touch "./t/logs/error.log"

t/conf/nginx.conf: t/logs/access.log
	-mkdir -p ./t/conf
	cp nginx.conf ./t/conf/

start: t/conf/nginx.conf
	if [ ! -f t/logs/nginx.pid ]; then $(OPENRESTY) -p "./t/" -c "conf/nginx.conf"; fi

stop:
	if [ -f t/logs/nginx.pid ]; then $(OPENRESTY) -p "./t/" -c "conf/nginx.conf" -s stop; fi

quit:
	if [ -f t/logs/nginx.pid ]; then $(OPENRESTY) -p "./t/" -c "conf/nginx.conf" -s quit; fi

reload: start
	-cp nginx.conf ./t/conf/
	$(OPENRESTY) -p "./t/" -c "conf/nginx.conf" -s reload

clean: stop
	-rm -rf t

tail: t/logs/access.log t/logs/error.log
	tail -F ./t/logs/error.log ./t/logs/access.log

test:
	curl -X GET http://localhost:8080/

show:
	ps -Af | grep nginx | grep -v 'grep nginx'
