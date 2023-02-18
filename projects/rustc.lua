-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          overrideCommand = {"python3", "x.py", "check", "--json-output"},
        },
	rustFmt = {
	  overrideCommand = {"./build/x86_64-unknown-linux-gnu/stage0/bin/rustfmt", "--edition=2021"},
	},
	procMacro = {
	  server = "./build/x86_64-unknown-linux-gnu/stage0/libexec/rust-analyzer-proc-macro-srv",
	  enable = true,
	},
	cargo = {
	  buildScripts = {
	    enable = true,
	    invocationLocation = "root",
	    invocationStrategy = "once",
	    overrideCommand = {"python3", "x.py", "check", "--json-output"},
	  },
	  sysroot = "./build/x86_64-unknown-linux-gnu/stage0-sysroot",
	},
	rustc = {
	  source = "./Cargo.toml"
	}
      },
    },
  },
}

require("rust-tools").setup(opts)
