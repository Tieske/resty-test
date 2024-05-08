# resty-test

Repo to quickly run some Lua test code with OpenResty.

## usage

Edit [`resty-test.lua`](resty-test.lua) to add some code to run.

Then run
```shell
make start; make test
```
or
```shell
make reload; make test
```

The test server will run on `localhost:8080`.

Meanwhile check the logs in another terminal with
```shell
make tail
```

## Commands

All commands are invoked using the [`Makefile`](Makefile):

- `make help` will list available targets (this is the default target)

- `make start`/`stop`/`quit`/`reload` will do as expected

- `make test` will issue a GET request on `http://localhost:8080/`

- `make tail` will start a tail on the access and error log files

- `make show` will show the current nginx processes running

- `make clean` will stop and clean the working directory/prefix


Checkout the [`Makefile`](Makefile) for details.
