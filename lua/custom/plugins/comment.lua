local present, nvim_comment = pcall(require, "nvim_comment")

if present then
  nvim_comment.setup({
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = true,
    -- Should key mappings be created
    create_mappings = true,
    -- Normal mode mapping left hand side
    line_mapping = "gcc",
    -- Visual/Operator mapping left hand side
    operator_mapping = "gc",
    -- Hook function to call before commenting takes place
    hook = function()
      -- If tx_context_commentstring plugin is available, use it to update commentstring 
      local present, ts_context_commentstring = pcall(require, "ts_context_commentstring.internal")

      if present then
        -- For javascript files
        -- This enables commenting jsx and javascript code differently based on file context
        -- ie. {/* <SomeJsxElement/> */ }
        --     // console.log("some javascript c0d3 1337 h4x");
        if vim.api.nvim_buf_get_option(0, "filetype") == "javascript" then
          ts_context_commentstring.update_commentstring()
        end
      end
    end
  })
end
