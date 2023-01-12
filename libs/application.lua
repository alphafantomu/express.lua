
local class = require('./30log');

local app = class('application');

local trust_proxy_default_symbol = '@@symbol:trust_proxy_default';

local logError = function()

end;

local tryRender = function()

end;

local debug = function(msg, ...)
	local env = process.env.LUA_ENV or 'development';
	if (env == 'development' or env == 'debug') then --this one came out of my ass
		print(string.format(msg, ...));
	end;
end;

--[[
	!! We don't really know the purpose of this below but it's in the file

	/**
	* Delegate `.VERB(...)` calls to `router.VERB(...)`.
	*/

	methods.forEach(function(method){
	app[method] = function(path){
		if (method === 'get' && arguments.length === 1) {
		// app.get(setting)
		return this.set(path);
		}

		this.lazyrouter();

		var route = this._router.route(path);
		route[method].apply(route, slice.call(arguments, 1));
		return this;
	};
	});
]]

app.init = function(self)
	self.cache, self.engines, self.settings = {}, {}, {};
	self:defaultConfiguration();
end;

app.lazyrouter = function(self)
	local env = process.env.LUA_ENV or 'development'; --subtle change to LUA_ENV

	--default settings
	self:enable('x-powered-by');
	self:set('etag', 'weak');
	self:set('env', env);
	self:set('query parser', 'extended');
	self:set('subdomain offset', 2);
	self:set('trust proxy', false);

	self[trust_proxy_default_symbol] = {
		configurable = true;
		value = true;
	};

	debug('booting in %s mode', env);

end;

app.handle = function(self, req, res, callback)

end;

app.use = function(self, fn)

end;

app.route = function(self, path)

end;

app.engine = function(self, ext, fn)

end;

app.param = function(self, name, fn)

end;

app.set = function(self, setting, val)

end;

app.path = function(self)

end;

app.enabled = function(self, setting)

end;

app.disabled = function(self, setting)

end;

app.enable = function(self, setting)

end;

app.disable = function(self, setting)

end;

app.all = function(self, path)

end;

app.render = function(self, name, options, callback)

end;

app.listen = function(self)

end;

return app;