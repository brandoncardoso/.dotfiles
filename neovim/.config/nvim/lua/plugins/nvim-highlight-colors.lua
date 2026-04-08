-- Test colors:
-- #f4a8b5 #a8d8ea #b5e6c5 #f9e2ae #c4b5e0
-- #fab #aed #bda
-- rgb(186, 212, 235) rgba(224, 187, 228, 0.8)
-- hsl(340, 60%, 80%) hsla(160, 40%, 75%, 0.9)
-- lavender peachpuff thistle mistyrose
-- bg-rose-300 text-sky-300 border-teal-300
-- var(--primary-color) var(--accent)

return {
	"brenoprata10/nvim-highlight-colors",
	config = function()
		require("nvim-highlight-colors").setup({
			enable_tailwind = true,
			enable_var_usage = true,
		})
	end
}
