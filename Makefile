
.PHONY: start stop quit reload clean tail test show

t/logs/access.log:
	-mkdir ./t
	-mkdir ./t/logs
	touch "./t/logs/error.log"
	touch "./t/logs/access.log"

t/conf/nginx.conf: t/logs/access.log
	-mkdir ./t/conf
	cp nginx.conf ./t/conf/

t/logs/nginx.pid: t/conf/nginx.conf
	nginx -p "./t/" -c "conf/nginx.conf" 

start: t/logs/nginx.pid

stop:
	nginx -p "./t/" -c "conf/nginx.conf" -s stop

quit:
	nginx -p "./t/" -c "conf/nginx.conf" -s quit

reload:
	-@cp nginx.conf ./t/conf/
	nginx -p "./t/" -c "conf/nginx.conf" -s reload

clean: stop
	-@rm -rf t

tail: t/logs/access.log
	tail -F ./t/logs/error.log ./t/logs/access.log

test:
	curl -X GET http://localhost:8080/

show:
	ps -Af | grep nginx | grep -v 'grep nginx'
