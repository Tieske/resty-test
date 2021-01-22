local app = {}

function app.init()
end

function app.init_worker()
end

-- function app.ssl_certificate()
-- end

-- function app.ssl_session_store()
-- end

function app.rewrite()
end

function app.access()
end

-- function app.balancer()
-- end

function app.content()
  ngx.say("<p>hello, world!</p>")
end

function app.header_filter()
end

function app.body_filter()
end

function app.log()
end

return app
