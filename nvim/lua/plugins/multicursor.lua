return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        set({ "n", "x" }, "ga", mc.addCursorOperator, { desc = "[MULTC] Operator" })
        set({ "v", "x" }, "<leader>s", mc.splitCursors, { desc = "[MULTC] Split Regex" })
        -- Helix-style: C = copy selection to next line, Alt-C = previous line
        set({ "n", "v", "x" }, "C", function() mc.lineAddCursor(1) end, { desc = "[MULTC] Add Cursor Down" })
        set({ "n", "v", "x" }, "<A-C>", function() mc.lineAddCursor(-1) end, { desc = "[MULTC] Add Cursor Up" })
        set({ "n", "x" }, "<leader>/", mc.searchAllAddCursors, { desc = "[MULTC] All Search Matches" })
        set({ "v", "x" }, "s", mc.matchCursors, { desc = "[MULTC] All Search Matches" })
        set({ "n"}, "gV", mc.restoreCursors, { desc = "[MULTC] Restore Cursors" })
        set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "[MULTC] Manual" })

        -- When "multicursor exists" mode
        mc.addKeymapLayer(function(layerSet)
            layerSet({ "n", "x" }, "Q", function() mc.matchSkipCursor(-1) end, { desc = "[MULTC] Skip Prev" })
            layerSet({ "n", "x" }, "q", function() mc.matchSkipCursor(1) end, { desc = "[MULTC] Skip Next" })

            layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "[MULTC] Prev" })
            layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "[MULTC] Next" })

            layerSet({ "n", "x" }, "<BS>", mc.deleteCursor, { desc = "[MULTC] Delete Cursor" })

            layerSet("n", "<CR>", mc.enableCursors, { desc = "[MULTC] Confirm" })
            layerSet("n", "<esc>", mc.clearCursors, { desc = "[MULTC] Clear" })
            -- Helix: , = keep only primary, Alt-, = remove primary
            layerSet("n", ",", mc.clearCursors, { desc = "[MULTC] Clear" })
            layerSet({ "n", "x" }, "<A-,>", mc.deleteCursor, { desc = "[MULTC] Remove Primary" })

            layerSet({ "v", "x" }, "(", function() mc.transposeCursors(-1) end, { desc = "[MULTC] Rotate content left" })
            layerSet({ "v", "x" }, ")", function() mc.transposeCursors(1) end, { desc = "[MULTC] Rotate content right" })

            layerSet({ "v", "x" }, "&", mc.alignCursors, { desc = "[MULTC] Align contents" })
        end)
    end
}
