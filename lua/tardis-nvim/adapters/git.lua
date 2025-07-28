local Job = require('plenary.job')
local util = require('tardis-nvim.util')

local M = {}

---@param root string
---@param ... string
---@return string[]
local function git(root, ...)
    root = Job:new{
        command = 'git',
        args = { '-C', root, 'rev-parse', '--show-toplevel' },
    }:sync()[1]
    local output = Job:new{
        command = 'git',
        args = { '-C', root, ... },
        on_stderr = function(_, msg)
            vim.print('Tardis: git failed: ' .. msg, vim.log.levels.WARN)
        end,
    }:sync()
    return output
end

---@param path string
---@return string
local function get_git_file_path(path)
    local root = util.dirname(path)
    return git(root, 'ls-files', '--full-name', path)[1]
end

---@param revision string
---@param parent TardisSession
---@return string[]
function M.get_file_at_revision(revision, parent)
    local root = util.dirname(parent.path)
    local file = get_git_file_path(parent.path)
    return git(root, 'show', string.format('%s:%s', revision, file))
end

---@param parent TardisSession
---@return string
function M.get_revision_under_cursor(parent)
    local current_revision = parent:get_current_buffer().revision
    local root = util.dirname(parent.path)
    local line, _ = vim.api.nvim_win_get_cursor(0)
    local blame_line = git(root, 'blame', '-L', line, current_revision)[1]
    return vim.split(blame_line, ' ', {})[1]
end

---@param parent TardisSession
---@return string[]
function M.get_revisions_for_current_file(parent)
    local root = util.dirname(parent.path)
    local file = get_git_file_path(parent.path)
    return git(root, 'log', '-n', parent.parent.config.settings.max_revisions, '--pretty=format:%h', '--', file)
end

---@class TardisRevisionInfo
---@field message string
---@field filetype string?

---@param revision string
---@param parent TardisSession
---@return TardisRevisionInfo
function M.get_revision_info(revision, parent)
    local root = util.dirname(parent.path)
    return {
        message = git(root, 'show', '--compact-summary', revision),
        filetype = "gitcommit"
    }
end

return M
