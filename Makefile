
.PHONY: start stop quit reload clean tail test show

t/logs/access.log:
	-mkdir -p ./t/logs
	touch "./t/logs/error.log"
	touch "./t/logs/access.log"

t/conf/nginx.conf: t/logs/access.log
	-mkdir -p ./t/conf
	cp nginx.conf ./t/conf/

start: t/conf/nginx.conf
	if [ ! -f t/logs/nginx.pid ]; then nginx -p "./t/" -c "conf/nginx.conf"; fi

stop:
	if [ -f t/logs/nginx.pid ]; then nginx -p "./t/" -c "conf/nginx.conf" -s stop; fi

quit:
	if [ -f t/logs/nginx.pid ]; then nginx -p "./t/" -c "conf/nginx.conf" -s quit; fi

reload: start
	-cp nginx.conf ./t/conf/
	nginx -p "./t/" -c "conf/nginx.conf" -s reload

clean: stop
	-rm -rf t

tail: t/logs/access.log
	tail -F ./t/logs/error.log ./t/logs/access.log

test:
	curl -X GET http://localhost:8080/

show:
	ps -Af | grep nginx | grep -v 'grep nginx'
