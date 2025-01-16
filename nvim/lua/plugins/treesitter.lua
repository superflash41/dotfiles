-- treesitter setup
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "lua",
        "python",
        "javascript", "html", "css",
        "cpp",
        "java",
        "rust",
        "go"
    }, 
    highlight = {
        enable = true, -- syntax highlighting
    },
    indent = {
        enable = true -- enable indentation
    }
}
