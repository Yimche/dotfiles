return {
    "m-gail/diagnostic_manipulation.nvim",
    event = "VeryLazy",
    init = function ()
        require("diagnostic_manipulation").setup {
            blacklist = {
                function(diagnostic)
                    return string.find(diagnostic.message, "Undefined global `vim`")
                end,
            },
            whitelist = {
            }
        }
    end
}
