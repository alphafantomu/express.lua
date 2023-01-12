
--[[
	request.app (application instance)
	request.base_url (string) /greet/jp "/greet"
	request.body
	request.cookies (middleware specific)
	request.fresh (cache specific)
	request.host (string)
	request.hostname (string)
	request.ip (string)
	request.ips (array)
	request.method (string) GET, POST, PUT, etc
	request.original_url/url (string)
	request.params (array)
	request.path (string)
	request.protocol (string)
	request.query (query object??)
	request.res (response instance)
	request.route (unknown)
	request.secure (boolean)
	request.signed_cookies (middleware specific)
	request.stale (cache specific)
	request.subdomains (array)
	request.xhr (boolean)


	request.connection is assumed?
]]

local accepts = require('accepts'); --https://github.com/jshttp/accepts/blob/master/index.js
local typeis = require('type-is'); --https://github.com/jshttp/type-is
local parseRange = require('range-parser'); --https://github.com/jshttp/range-parser
local getter = require('orcus-getter');

local request = require('orcus')('request', {
	__private = {};
}, function(self, app)
	assert(app:isInstance() and app:isA('application'), 'bad app');
	self.app = app;
end);

local setNshiftUp, flattenArray;

local getAccept = function(self)
	local __private = self.__private;
	local accept = __private.accept or accepts(self);
	if (__private.accept ~= accept) then
		__private.accept = accept;
	end;
	return accept;
end;

local arrayAppend = function(array_a, array_b, si)
	local n = #array_b;
	for i = 0, n - 1 do
		local ni = si + i;
		local cv = array_a[ni];
		if (cv ~= nil) then
			setNshiftUp(array_a, ni + 1, cv);
		end;
		array_a[ni] = array_b[i + 1];
	end;
	return n - 1;
end;

flattenArray = function(array)
	local n = #array;
	local offset = 0;
	for i = 1, n do
		i = i + offset;
		local v = array[i];
		if (type(v) == 'table') then
			array[i], v = nil, flattenArray(v);
			offset = offset + arrayAppend(array, v, i);
		end;
	end;
	return array;
end;

setNshiftUp = function(array_a, i, v)
	local cv = array_a[i];
	if (cv ~= nil) then
		setNshiftUp(array_a, i + 1, cv);
	end;
	array_a[i] = v;
end;

request.accepts = function(self, a, b, c, d, e, f)
	return getAccept(self):types(a, b, c, d, e, f);
end;

request.acceptsCharsets = function(self, a, b, c, d, e, f)
	return getAccept(self):charsets(a, b, c, d, e, f);
end;

request.acceptsEncodings = function(self, a, b, c, d, e, f)
	return getAccept(self):encodings(a, b, c, d, e, f);
end;

request.acceptsLanguages = function(self, a, b, c, d, e, f)
	return getAccept(self):languages(a, b, c, d, e, f);
end;

request.header = function(self, name)
	assert(type(name) == 'string', 'name '..(name ~= nil and 'must be a string' or 'argument is required')..' to req.get');
	name = name:lower();
	local headers = self.headers;
	return ((name == 'referer' or name == 'referrer') and (headers.referer or headers.referrer)) or headers[name] or nil;
end;

request.is  = function(self, types)
	--tuple support here?
	
	types = flattenArray(types);
	return typeis(self, types);
end;

request.range = function(self, size, options)
	local range = self:get('Range');
	if (range ~= nil) then
		return parseRange(size, range, options);
	end;
end;

request.get = request.header;

request.protocol = getter(function(self)
	local connection = self.connection;
	local proto = connection.encrypted and 'https' or 'http';
	local trust = self.app:get('trust proxy fn');
	if (trust and not trust(connection.remoteAddress, 0)) then
		return proto;
	end;
	--Note: X-Forwarded-Proto is normally only ever a single value, but this is to be safe.
	local header = self:get('X-Forwarded-Proto') or proto;
	local index = header:find(',');
	return index and header:sub(1, index - 1).trim() or header.trim();
end);

request.secure = getter(function(self)

end);

request.ip = getter(function(self)

end);

request.ips = getter(function(self)

end);

request.subdomains = getter(function(self)

end);

request.path = getter(function(self)

end);

request.hostname = getter(function(self)

end);

request.fresh = getter(function(self)

end);

request.stale = getter(function(self)

end);

request.xhr = getter(function(self)

end);

return request;