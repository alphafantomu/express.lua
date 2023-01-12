return {
    name = "lua-express",
    version = "0.0.1",
    description = "express in lua",
    tags = { "luvit", "express", "web", "framework", "port" },
    license = "MIT",
    author = { name = "Ari Kumikaeru", email = "phantomcrazyheart@gmail.com" },
    homepage = "https://github.com/alphafantomu/express.lua",
    dependencies = {
      'alphafantomu/orcus@0.0.3';
      'alphafantomu/orcus-getter@0.0.1';
      'alphafantomu/lua-emitter@0.0.1';
    },
    files = {
      "**.lua",
      "!test*"
    }
}

--[[
	 "dependencies": {
    "accepts": "~1.3.8",
    "array-flatten": "1.1.1",
    "body-parser": "1.19.2",
    "content-disposition": "0.5.4",
    "content-type": "~1.0.4",
    "cookie": "0.4.2",
    "cookie-signature": "1.0.6",
    "debug": "2.6.9",
    "depd": "~1.1.2",
    "encodeurl": "~1.0.2",
    "escape-html": "~1.0.3",
    "etag": "~1.8.1",
    "finalhandler": "~1.1.2",
    "fresh": "0.5.2",
    "merge-descriptors": "1.0.1",
    "methods": "~1.1.2",
    "on-finished": "~2.3.0",
    "parseurl": "~1.3.3",
    "path-to-regexp": "0.1.7",
    "proxy-addr": "~2.0.7",
    "qs": "6.9.7",
    "range-parser": "~1.2.1",
    "safe-buffer": "5.2.1",
    "send": "0.17.2",
    "serve-static": "1.14.2",
    "setprototypeof": "1.2.0",
    "statuses": "~1.5.0",
    "type-is": "~1.6.18",
    "utils-merge": "1.0.1",
    "vary": "~1.1.2"
  },
]]