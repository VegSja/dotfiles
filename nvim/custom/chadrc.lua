---@type ChadrcConfig 
 local M = {}
 M.ui = {theme = 'onedark'}
 M.plugins = 'custom.plugins'
 M.mappings = require 'custom.mappings'
---Some defaults
 vim.wo.relativenumber = true
 return M
