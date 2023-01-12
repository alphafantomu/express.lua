
local uv = require('uv');

local emitter = require('lua-emitter');

local time = uv.hrtime;
local test_emitter = emitter();
local callback = function() end;

test_emitter:on('foo', callback);

local now = time();

for i = 1000000, 0, -1 do
	test_emitter:emit('foo');
end;

print('Emitter took ', time() - now, 'nanoseconds', test_emitter, test_emitter:isA(emitter));

--29284943 nodejs
--294800 luvit



p(flattenArray({1, 2, 3, {4, 5, 6, {7, 8, 9, {10, 11, 12}}}, {10, 11, 12}}));



--return require('./libs/express');