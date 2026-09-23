local M = {}

local scope = {
  include = {},
  exclude = {},
}

local function parse(value)
  local split = vim.split(value, ",")
  return vim
    .iter(split)
    :map(vim.trim)
    :filter(function(i)
      return i ~= ""
    end)
    :totable()
end

local function serialize(value)
  return table.concat(value, ", ")
end

local function handle_exclude(exclude)
  if exclude == nil then
    return
  else
    scope.exclude = parse(exclude)
    M.show()
  end
end

local function prompt_exclude()
  vim.ui.input({
    prompt = "Exclude: ",
    default = serialize(scope.exclude),
  }, handle_exclude)
end

local function handle_include(include)
  if include == nil then
    return
  else
    scope.include = parse(include)
    prompt_exclude()
  end
end

local function prompt_include()
  vim.ui.input({
    prompt = "Include: ",
    default = serialize(scope.include),
  }, handle_include)
end

function M.set()
  prompt_include()
end

function M.show()
  local include = #scope.include > 0 and serialize(scope.include) or "*"
  local exclude = #scope.exclude > 0 and serialize(scope.exclude) or "-"

  vim.notify(("Search scope\nInclude: %s\nExclude: %s"):format(include, exclude))
end

function M.clear()
  scope.include = {}
  scope.exclude = {}

  vim.notify("Search scope cleared")
end

function M.grep()
  local include_globs = vim.list_slice(scope.include)
  local exclude_globs = vim
    .iter(scope.exclude)
    :map(function(item)
      return "!" .. item
    end)
    :totable()

  local globs = vim.list_extend(include_globs, exclude_globs)

  Snacks.picker.grep({
    cwd = LazyVim.root(),
    glob = #globs > 0 and globs or nil,
  })
end

return M
