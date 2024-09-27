local cwd_path = "C:/Files/Misc/nvim_wd"

-- stores cwd in file nvim_wd
local function store_cwd()
    local wd_record = io.open(cwd_path, "w")
    if wd_record then
        wd_record:write(vim.fn.getcwd() .. "\n")
        io.close(wd_record)
    end
end

--deletes nvim_wd
local function clear_cwd()
    local wd_record = io.open(cwd_path, "w")
    if wd_record then
        os.remove(cwd_path)
        io.close(wd_record)
    end
end

--autocmds that set and unset the wd on respective events
vim.api.nvim_create_autocmd({ "DirChanged" }, { callback = store_cwd })

vim.api.nvim_create_autocmd({ "VimLeave" }, { callback = clear_cwd })
