return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		--'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		"j-hui/fidget.nvim",
		"hrsh7th/cmp-nvim-lsp-signature-help"
	},

	config = function()
		require("fidget").setup({})
		require("mason").setup()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
		local lspconfig = require("lspconfig")
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"tsserver",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({})
				end,

				["lua_ls"] = function ()
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" }
								}
							}
						}
					})
				end
			}
		})
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-n>'] = cmp.mapping(function ()
					if cmp.visible() then
						cmp.select_next_item()
					end
				end),
				["<C-p>"] = cmp.mapping(function ()
					if cmp.visible() then
						cmp.select_prev_item()
					end
				end),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' }, -- For luasnip users.
				{ name = 'path' },
				{ name = 'nvim_lsp_signature_help' },
			}, {
				{ name = 'buffer' },
			}),
			experimental = {
				ghost_text = false
			}
		})
		vim.diagnostic.config({
			update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			}
		})
	end
}
