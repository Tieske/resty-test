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

Meanwhile check the logs in another terminal with
```shell
make tail
```

Checkout the [`Makefile`](Makefile) for more commands.
