local M = {}

---@alias TardisKeymap {[string]: string}

---@class TardisSettings
---@field max_revisions integer
---@field initial_revisions integer
---@field show_commit_index boolean

---@class TardisConfig
---@field keymap TardisKeymap
---@field settings TardisSettings
--
---@class TardisPartialConfig
---@field keymap? TardisKeymap
---@field settings? TardisSettings

---@return TardisConfig
local function get_default_config()
    return {
        keymap = {
            ['next'] = '<C-j>',
            ['prev'] = '<C-k>',
            ['quit'] = 'q',
            ['revision_message'] = '<C-m>',
            ['commit'] = '<C-g>',
        },
        settings = {
            max_revisions = 256,
            initial_revisions = 10,
            show_commit_index = false,
        },
        debug = false,
    }
end

M.Config = {}

---@param user_config TardisPartialConfig?
---@return TardisConfig
function M.Config:new(user_config)
    user_config = user_config or {}
    local default_config = get_default_config()
    local config = vim.tbl_deep_extend('force', default_config, user_config)
    setmetatable(user_config, self)
    self.__index = self
    return config
end

return M
