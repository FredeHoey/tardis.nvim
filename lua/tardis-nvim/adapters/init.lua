local M = {}

---@class TardisAdapter
---@field get_revisions_for_current_file fun(parent: TardisSession?): string[]
---@field get_file_at_revision fun(revision: string, parent: TardisSession?): string[]
--- Optional fields
---@field get_revision_info? fun(revision: string, parent: TardisSession?): TardisRevisionInfo
---@field get_revision_under_cursor? fun(parent: TardisSession?): string

---@param type string?
---@return TardisAdapter?
function M.get_adapter(type)
    type = type or 'git'
    local ok, adapter = pcall(require, 'tardis-nvim.adapters.' .. type)
    if ok then
        return adapter
    end
    ok, adapter = pcall(require, type)
    if ok then
        return adapter
    end
    vim.notify('No suitable adapter found for current file')
    return nil
end

return M
