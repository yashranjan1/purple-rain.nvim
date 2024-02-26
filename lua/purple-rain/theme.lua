local util = require("purple-rain.util")
local colors = require("purple-rain.colors")

local M = {}
--
---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight

---@alias Highlights table<string,Highlight>

---@return Theme
function M.setup()
    local config = require("purple-rain.config")
    local options = config.options
    ---@class Theme
    ---@field highlights Highlights
    local theme = {
        config = options,
        colors = colors.setup(),
    }

    local c = theme.colors

    theme.highlights = {
        Comment = { fg = c.commentGray, style = options.styles.comments }, -- any comment
        ColorColumn = { bg = c.commentGray }, -- used for the columns set with 'colorcolumn'
        Conceal = { fg = c.Lavender300 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor = { fg = c.Violet400, bg = c.Lavender300 }, -- character under the cursor
        lCursor = { fg = c.Violet400, bg = c.Lavender300 }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM = { fg = c.Violet400, bg = c.Lavender300 }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorColumn = { bg = c.Violet300 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine = { bg = c.Violet300 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory = { fg = c.Violet300 }, -- directory names (and other special names in listings)
        DiffAdd = { fg = c.Green400, bg = c.Violet400, bold = true }, -- diff mode: Added line |diff.txt|
        DiffChange = { fg = c.Yellow400, bg = c.Violet400, bold = true }, -- diff mode: Changed line |diff.txt|
        DiffDelete = { fg = c.Coral400, bg = c.Violet400, bold = true }, -- diff mode: Deleted line |diff.txt|
        DiffText = { fg = c.Blue400, bg = c.Violet400, bold = true }, -- diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer = { fg = c.Violet400 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        -- TermCursor  = { }, -- cursor in a focused terminal
        -- TermCursorNC= { }, -- cursor in ank unfocused terminal
        ErrorMsg = { fg = c.Coral400, reverse = true }, -- error messages on the command line
        VertSplit = { fg = c.Violet300 }, -- the column separating vertically split windows
        WinSeparator = { fg = c.Violet300, bold = true }, -- the column separating vertically split windows
        Folded = { fg = c.Lavender300, bg = c.Violet300, bold = true }, -- line used for closed folds
        FoldColumn = { fg = c.Lavender300 }, -- 'foldcolumn'
        SignColumn = { fg = c.Lavender200 }, -- column where |signs| are displayed
        SignColumnSB = { fg = c.Lavender200 }, -- column where |signs| are displayed
        Substitute = { fg = c.Lavender100, bg = c.Orange400 }, -- |:substitute| replacement text highlighting
        LineNr = { fg = c.Blue50, bg = options.transparent and c.none or c.Violet400 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr = { fg = c.Blue400, sp = c.Blue400 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen = { fg = c.Coral50, bg = c.Coral400, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = { fg = c.Turquoise50 }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea = { fg = c.Lavender400 }, -- Area for messages and cmdline
        -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        MoreMsg = { fg = c.Lavender300 }, -- |more-prompt|
        NonText = { fg = c.Lavender300, bold = true }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = { fg = c.Lavender300, bg = options.transparent and c.none or c.Violet400 }, -- normal text
        NormalNC = {
            fg = c.Lavender300,
            bg = options.transparent and c.none or options.dim_inactive and c.Lavender400 or c.Lavender400,
        }, -- normal text in non-current windows
        NormalSB = { fg = c.Lavender300, bg = c.Violet400 }, -- normal text in sidebar
        NormalFloat = { fg = c.Lavender300, bg = c.Violet400 }, -- Normal text in floating windows.
        FloatBorder = { fg = c.Yellow400, bg = c.Violet400 },
        FloatTitle = { fg = c.Blue400, bg = c.Violet400 },
        Pmenu = { fg = c.Lavender300, bg = c.Violet400 }, -- Popup menu: normal item.
        PmenuSel = { fg = c.Lavender300, bg = c.Violet400, reverse = true }, -- Popup menu: selected item.
        PmenuSbar = { fg = c.Lilac400, reverse = true }, -- Popup menu: scrollbar.
        PmenuThumb = { fg = c.Lilac50, reverse = true }, -- Popup menu: Thumb of the scrollbar.
        Question = { fg = c.Turquoise400, bold = true }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine = { bg = c.Violet300, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search = { fg = c.Peach400, reverse = true }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch = { fg = c.Orange400, standout = true }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        CurSearch = { link = "IncSearch" },
        SpecialKey = { fg = c.Violet50 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad = { sp = c.Coral200, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = { sp = c.Pink300, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { sp = c.SkyBlue300, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = { sp = c.Yellow300, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine = { fg = c.Lilac50, bg = c.Lilac400 }, -- status line of current window
        StatusLineNC = { fg = c.commentGray, bg = c.Violet400 }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine = { fg = c.Lilac50, bg = c.Violet400, sp = c.Lilac50 }, -- tab pages line, not active tab page label
        TabLineFill = { fg = c.Lilac50, bg = c.commentGray }, -- tab pages line, where there are no labels
        TabLineSel = { fg = c.Green400, bg = c.Violet400 }, -- tab pages line, active tab page label
        Title = { fg = c.Orange400, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
        Visual = { bg = c.Lilac50, reverse = true }, -- Visual mode selection
        VisualNOS = { bg = c.Lilac50, reverse = true }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = { fg = c.Orange400, bold = true }, -- warning messages
        Whitespace = { fg = c.commentGray }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu = { fg = c.Lavender300, bg = c.Violet300, reverse = true }, -- current match in 'wildmenu' completion

        -- These groups are not listed as default vim groups,
        -- but they are defacto standard group names for syntax highlighting.
        -- commented out groups should chain up to their "preferred" group by
        -- default,
        -- Uncomment and edit if you want more specific syntax highlighting.

        Constant = { fg = c.Peach300 }, -- (preferred) any constant
        String = { fg = c.Mint300 }, --   a string constant: "this is a string"
        Character = { link = "Constant" }, --  a character constant: 'c', '\n'
        -- Number        = { }, --   a number constant: 234, 0xff
        -- Boolean       = { }, --  a boolean constant: TRUE, false
        -- Float         = { }, --    a floating point constant: 2.3e10

        Identifier = { fg = c.Lavender300, style = options.styles.variables }, -- (preferred) any variable name
        Function = { fg = c.Lavender300, style = options.styles.functions }, -- function name (also: methods for classes)

        Statement = { fg = c.Turquoise300 }, -- (preferred) any statement
        -- Conditional   = { }, --  if, then, else, endif, switch, etc.
        -- Repeat        = { }, --   for, do, while, etc.
        -- Label         = { }, --    case, default, etc.
        Operator = { fg = c.Salmon400 }, -- "sizeof", "+", "*", etc.
        Keyword = { fg = c.Mint300, style = options.styles.keywords }, --  any other keyword
        -- Exception     = { }, --  try, catch, throw

        PreProc = { fg = c.Coral400 }, -- (preferred) generic Preprocessor
        -- Include       = { }, --  preprocessor #include
        -- Define        = { }, --   preprocessor #define
        -- Macro         = { }, --    same as Define
        -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

        Type = { fg = c.Yellow200 }, -- (preferred) int, long, char, etc.
        -- StorageClass  = { }, -- static, register, volatile, etc.
        -- Structure     = { }, --  struct, union, enum, etc.
        -- Typedef       = { }, --  A typedef

        Special = { fg = c.SkyBlue400 }, -- (preferred) any special symbol
        -- SpecialChar   = { }, --  special character in a constant
        -- Tag           = { }, --    you can use CTRL-] on this
        -- Delimiter     = { }, --  character that needs attention
        -- SpecialComment= { }, -- special things inside a comment
        Debug = { fg = c.Orange400 }, --    debugging statements

        Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
        Bold = { bold = true },
        Italic = { italic = true },

        -- ("Ignore", below, may be invisible...)
        -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

        Error = { fg = c.Coral400 }, -- (preferred) any erroneous construct
        Todo = { fg = c.Pink400, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        qfLineNr = { fg = c.Coral300 },
        qfFileName = { fg = c.Lavender300 },

        htmlH1 = { fg = c.Lavender300, bold = true },
        htmlH2 = { fg = c.Lavender300, bold = true },

        -- mkdHeading = { fg = c.orange, bold = true },
        mkdCode = { bg = c.Green400 },
        mkdCodeDelimiter = { fg = c.terminalWhite, bg = c.commentGray },
        mkdCodeStart = { fg = c.Orange400, bold = true },
        mkdCodeEnd = { fg = c.Orange400, bold = true },
        -- mkdLink = { fg = c.blue, underline = true },

        markdownHeadingDelimiter = { fg = c.Orange400, bold = true },
        markdownCode = { fg = c.Yellow400, bg = c.Green400 },
        markdownCodeBlock = { fg = c.Yellow400, bg = c.Green400 },
        markdownH1 = { fg = c.Lilac400, bold = true },
        markdownH2 = { fg = c.Purple400, bold = true },
        markdownLinkText = { fg = c.Blue400, underline = true },

        ["helpCommand"] = { fg = c.Lavender300, bg = c.Violet400 },

        debugPC = { bg = c.Coral200 }, -- used for highlighting the current line in terminal-debug
        debugBreakpoint = { fg = c.Lavender50, bg = c.Lavender400 }, -- used for breakpoint colors in terminal-debug

        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own. Consult your LSP client's
        -- documentation.
        LspReferenceText = { underline = true }, -- used for highlighting "text" references
        LspReferenceRead = { underline = true }, -- used for highlighting "read" references
        LspReferenceWrite = { underline = true }, -- used for highlighting "write" references

        DiagnosticError = { fg = c.Coral400 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn = { fg = c.Yellow400 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo = { fg = c.Blue400 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint = { fg = c.Green400 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticUnnecessary = { fg = c.Peach400 }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

        DiagnosticVirtualTextError = { bg = c.Coral400, fg = c.Coral50 }, -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn = { bg = c.Yellow400, fg = c.Yellow50 }, -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo = { bg = c.Blue400, fg = c.Blue50 }, -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint = { bg = c.Green400, fg = c.Green50 }, -- Used for "Hint" diagnostic virtual text

        DiagnosticUnderlineError = { undercurl = true, sp = c.Coral400 }, -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn = { undercurl = true, sp = c.Yellow400 }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo = { undercurl = true, sp = c.Blue400 }, -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint = { undercurl = true, sp = c.Green400 }, -- Used to underline "Hint" diagnostics

        LspSignatureActiveParameter = { bg = c.Lavender300, bold = true },
        LspCodeLens = { fg = c.Lavender400 },
        LspInlayHint = { bg = c.Violet100, fg = c.Violet300 },

        LspInfoBorder = { fg = c.commentGray, bg = c.Violet300 },

        DapStoppedLine = { bg = c.Yellow300 }, -- Used for "Warning" diagnostic virtual text

        -- These groups are for the Neovim tree-sitter highlights.
        -- As of writing, tree-sitter support is a WIP, group names may change.

        --- Misc
        -- TODO:
        -- ["@comment.documentation"] = { },
        ["@operator"] = { fg = c.Salmon400 }, -- For any operator: `+`, but also `->` and `*` in C.

        --- Punctuation
        ["@punctuation.delimiter"] = { fg = c.Green400 }, -- For delimiters ie: `.`
        ["@punctuation.bracket"] = { fg = c.Coral400 }, -- For brackets and parens.
        ["@punctuation.special"] = { fg = c.Coral400 }, -- For special punctutation that does not fall in the catagories before.
        ["@punctuation.special.markdown"] = { fg = c.Coral400, bold = true },

        --- Literals
        ["@string.documentation"] = { fg = c.Mint300 },
        ["@string.regex"] = { fg = c.Mint300 }, -- For regexes.
        ["@string.escape"] = { fg = c.Salmon400 }, -- For escape characters within a string.

        --- Functions
        ["@constructor"] = { fg = c.Coral400 }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
        ["@parameter"] = { fg = c.Coral400 }, -- For parameters of a function.
        -- TODO:
        -- ["@parameter.builtin"] = {}, -- For builtin parameters of a function, e.g. "..." or Smali's p[1-99]

        --- Keywords
        ["@keyword"] = { fg = c.Mint300, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
        -- TODO:
        -- ["@keyword.coroutine"] = { }, -- For keywords related to coroutines.
        ["@keyword.function"] = { fg = c.Lavender300, style = options.styles.functions }, -- For keywords used to define a fuction.

        ["@label"] = { fg = c.Mint400 }, -- For labels: `label:` in C and `:label:` in Lua.

        --- Types
        ["@type.builtin"] = { link = "Type" },
        ["@field"] = { link = "Identifier" }, -- For fields.
        ["@property"] = { link = "Identifier" },

        --- Identifiers
        ["@variable"] = { fg = c.base0, style = options.styles.variables }, -- Any variable name that does not have another highlight.
        ["@variable.builtin"] = { fg = c.orange500 }, -- Variable names that are defined by the languages, like `this` or `self`.

        --- Text
        ["@text.literal.markdown"] = { fg = c.Coral400 },
        ["@text.literal.markdown_inline"] = { fg = c.Yellow400, bg = c.Green400 },
        ["@text.reference"] = { fg = c.Lavender300, underline = true },

        ["@text.todo.unchecked"] = { fg = c.Yellow400 }, -- For brackets and parens.
        ["@text.todo.checked"] = { fg = c.Green400 }, -- For brackets and parens.
        ["@text.warning"] = { fg = c.Orange50, bg = c.Orange400 },
        ["@text.danger"] = { fg = c.Coral50, bg = c.Coral400 },

        ["@text.diff.add"] = { link = "DiffAdd" },
        ["@text.diff.delete"] = { link = "DiffDelete" },

        ["@namespace"] = { fg = c.Lavender300, style = options.styles.variables },

        -- tsx
        ["@tag.tsx"] = { fg = c.Mint300 },
        ["@constructor.tsx"] = { fg = c.Lavender300 },
        ["@tag.delimiter.tsx"] = { fg = c.Orange400 },

        -- LSP Semantic Token Groups
        ["@lsp.type.boolean"] = { link = "@boolean" },
        ["@lsp.type.builtinType"] = { link = "@type.builtin" },
        ["@lsp.type.comment"] = { link = "@comment" },
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
        ["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
        ["@lsp.type.interface"] = { fg = c.Lavender300 },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.namespace"] = { link = "@namespace" },
        ["@lsp.type.number"] = { link = "@number" },
        ["@lsp.type.operator"] = { link = "@operator" },
        ["@lsp.type.parameter"] = { link = "@parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
        ["@lsp.type.string.rust"] = { link = "@string" },
        ["@lsp.type.typeAlias"] = { link = "@type.definition" },
        ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.Coral400 },
        ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
        ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
        ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
        ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.operator.injected"] = { link = "@operator" },
        ["@lsp.typemod.string.injected"] = { link = "@string" },
        ["@lsp.typemod.type.defaultLibrary"] = { fg = c.Lavender300 },
        ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
        ["@lsp.typemod.variable.injected"] = { link = "@variable" },
        -- NOTE: maybe add these with distinct highlights?
        -- ["@lsp.typemod.variable.globalScope"] (global variables)

        -- ts-rainbow
        rainbowcol1 = { fg = c.Coral400 },
        rainbowcol2 = { fg = c.Orange300 },
        rainbowcol3 = { fg = c.Yellow300 },
        rainbowcol4 = { fg = c.Mint300 },
        rainbowcol5 = { fg = c.Turquoise300 },
        rainbowcol6 = { fg = c.Blue400 },
        rainbowcol7 = { fg = c.Purple400 },

        -- ts-rainbow2 (maintained fork)
        TSRainbowRed = { fg = c.Coral400 },
        TSRainbowOrange = { fg = c.Orange300 },
        TSRainbowYellow = { fg = c.Yellow300 },
        TSRainbowGreen = { fg = c.Mint300 },
        TSRainbowBlue = { fg = c.Blue400 },
        TSRainbowViolet = { fg = c.Purple400 },
        TSRainbowCyan = { fg = c.Turquoise300 },

        -- rainbow-delimiters
        RainbowDelimiterRed = { fg = c.Coral400 },
        RainbowDelimiterOrange = { fg = c.Orange300 },
        RainbowDelimiterYellow = { fg = c.Yellow300 },
        RainbowDelimiterGreen = { fg = c.Mint300 },
        RainbowDelimiterBlue = { fg = c.Blue400 },
        RainbowDelimiterViolet = { fg = c.Purple400 },
        RainbowDelimiterCyan = { fg = c.Turquoise300 },

        -- LspTrouble
        TroubleText = { fg = c.Lavender300 },
        TroubleCount = { fg = c.Purple300 },
        TroubleNormal = { fg = c.Lavender300 },

        -- Illuminate
        illuminatedWord = { bg = c.Lilac400 },
        illuminatedCurWord = { bg = c.Lilac400 },
        IlluminatedWordText = { bg = c.Lilac400 },
        IlluminatedWordRead = { bg = c.Purple400 },
        IlluminatedWordWrite = { bg = c.Purple400 },

        -- diff
        diffAdded = { fg = c.Mint400 },
        diffRemoved = { fg = c.Coral400 },
        diffChanged = { fg = c.Yellow300 },
        diffOldFile = { fg = c.Purple300 },
        diffNewFile = { fg = c.Orange300 },
        diffFile = { fg = c.Lavender300 },
        diffLine = { fg = c.Violet300 },
        diffIndexLine = { fg = c.Purple300 },

        -- Neogit
        NeogitBranch = { fg = c.Violet200 },
        NeogitRemote = { fg = c.Purple300 },
        NeogitHunkHeader = { fg = c.Blue50, bg = c.Blue400 },
        NeogitHunkHeaderHighlight = { fg = c.Lavender300, bg = c.Lavender50 },
        NeogitDiffContextHighlight = { fg = c.Lilac50, bg = c.Violet400 },
        NeogitDiffDeleteHighlight = { fg = c.Coral50, bg = c.Coral400 },
        NeogitDiffAddHighlight = { fg = c.Mint50, bg = c.Mint400 },

        -- Neotest
        NeotestPassed = { fg = c.Mint400 },
        NeotestRunning = { fg = c.Yellow400 },
        NeotestFailed = { fg = c.Coral400 },
        NeotestSkipped = { fg = c.Lavender300 },
        NeotestTest = { fg = c.Purple400 },
        NeotestNamespace = { fg = c.Turquoise300 },
        NeotestFocused = { fg = c.Yellow400 },
        NeotestFile = { fg = c.SkyBlue300 },
        NeotestDir = { fg = c.Lavender300 },
        NeotestBorder = { fg = c.Lavender300 },
        NeotestIndent = { fg = c.Turquoise300 },
        NeotestExpandMarker = { fg = c.black },
        NeotestAdapterName = { fg = c.Purple200, bold = true },
        NeotestWinSelect = { fg = c.Lavender300 },
        NeotestMarked = { fg = c.Lavender300 },
        NeotestTarget = { fg = c.Lavender300 },
        --[[ NeotestUnknown = {}, ]]

        -- GitGutter
        GitGutterAdd = { fg = c.Mint300 }, -- diff mode: Added line |diff.txt|
        GitGutterChange = { fg = c.Yellow300 }, -- diff mode: Changed line |diff.txt|
        GitGutterDelete = { fg = c.Coral400 }, -- diff mode: Deleted line |diff.txt|
        GitGutterAddLineNr = { fg = c.Mint400 },
        GitGutterChangeLineNr = { fg = c.Yellow400 },
        GitGutterDeleteLineNr = { fg = c.Coral300 },

        -- GitSigns
        GitSignsAdd = { fg = c.Mint400 }, -- diff mode: Added line |diff.txt|
        GitSignsChange = { fg = c.Yellow300 }, -- diff mode: Changed line |diff.txt|
        GitSignsDelete = { fg = c.Coral400 }, -- diff mode: Deleted line |diff.txt|

        -- Telescope
        TelescopeBorder = { fg = c.Lavender300, bg = c.Violet400 },
        TelescopeNormal = { fg = c.Lavender300, bg = c.Violet400 },

        -- NvimTree
        NvimTreeNormal = { fg = c.Lavender300, bg = c.Violet400 },
        NvimTreeWinSeparator = {
            fg = options.styles.sidebars == "transparent" and c.Lavender300 or c.Lavender300,
            bg = c.Violet400,
        },
        NvimTreeNormalNC = { fg = c.Lavender300, bg = c.Violet400 },
        NvimTreeRootFolder = { fg = c.Lavender300, bold = true },
        NvimTreeGitDirty = { fg = c.Yellow400 },
        NvimTreeGitNew = { fg = c.Mint400 },
        NvimTreeGitDeleted = { fg = c.Coral400 },
        NvimTreeOpenedFile = { bg = c.Violet400 },
        NvimTreeSpecialFile = { fg = c.Lilac400, underline = true },
        NvimTreeIndentMarker = { fg = c.Violet200 },
        NvimTreeImageFile = { fg = c.Lavender300 },
        NvimTreeSymlink = { fg = c.Blue400 },
        NvimTreeFolderIcon = { bg = c.none, fg = c.Lavender300 },
        -- NvimTreeFolderName= { fg = c.fg_float },

        NeoTreeNormal = { fg = c.Lavender300, bg = c.Violet400 },
        NeoTreeNormalNC = { fg = c.Lavender300, bg = c.Violet400 },
        NeoTreeDimText = { fg = c.Lavender300 },

        -- Fern
        FernBranchText = { fg = c.Lavender50 },

        -- glyph palette
        GlyphPalette1 = { fg = c.Coral400 },
        GlyphPalette2 = { fg = c.Green400 },
        GlyphPalette3 = { fg = c.Yellow400 },
        GlyphPalette4 = { fg = c.Blue400 },
        GlyphPalette6 = { fg = c.Turquoise200 },
        GlyphPalette7 = { fg = c.Purple300 },
        GlyphPalette9 = { fg = c.Coral200 },

        -- Dashboard
        DashboardShortCut = { fg = c.Turquoise300 },
        DashboardHeader = { fg = c.Blue400 },
        DashboardCenter = { fg = c.Purple400 },
        DashboardFooter = { fg = c.Yellow400, italic = true },

        -- Alpha
        AlphaShortcut = { fg = c.Orange400 },
        AlphaHeader = { fg = c.Blue400 },
        AlphaHeaderLabel = { fg = c.Orange400 },
        AlphaFooter = { fg = c.Turquoise300 },
        AlphaButtons = { fg = c.Turquoise300 },

        -- WhichKey
        WhichKey = { fg = c.Lavender300 },
        WhichKeyGroup = { fg = c.Blue400 },
        WhichKeyDesc = { fg = c.Green400 },
        WhichKeySeperator = { fg = c.Lilac50 },
        WhichKeySeparator = { fg = c.Lilac50 },
        WhichKeyFloat = { bg = c.Violet400 },
        WhichKeyValue = { fg = c.SkyBlue300 },

        -- LspSaga
        DiagnosticWarning = { link = "DiagnosticWarn" },
        DiagnosticInformation = { link = "DiagnosticInfo" },

        LspFloatWinNormal = { bg = c.Violet400 },
        LspFloatWinBorder = { fg = c.Purple400 },
        LspSagaBorderTitle = { fg = c.Turquoise200 },
        LspSagaHoverBorder = { fg = c.Blue400 },
        LspSagaRenameBorder = { fg = c.Green400 },
        LspSagaDefPreviewBorder = { fg = c.Green400 },
        LspSagaCodeActionBorder = { fg = c.Blue400 },
        LspSagaFinderSelection = { fg = c.Lavender300 },
        LspSagaCodeActionTitle = { fg = c.Turquoise300 },
        LspSagaCodeActionContent = { fg = c.Purple400 },
        LspSagaSignatureHelpBorder = { fg = c.Coral200 },
        ReferencesCount = { fg = c.Purple400 },
        DefinitionCount = { fg = c.Purple400 },
        DefinitionIcon = { fg = c.Blue400 },
        ReferencesIcon = { fg = c.Blue400 },
        TargetWord = { fg = c.Turquoise300 },

        -- NeoVim
        healthError = { fg = c.Coral400 },
        healthSuccess = { fg = c.Turquoise200 },
        healthWarning = { fg = c.Yellow400 },

        -- BufferLine
        BufferLineIndicatorSelected = { fg = c.Yellow300 },

        -- Barbar
        BufferCurrent = { bg = c.Violet400, fg = c.Lavender300 },
        BufferCurrentERROR = { bg = c.Violet400, fg = c.Yellow400 },
        BufferCurrentHINT = { bg = c.Violet400, fg = c.Green400 },
        -- BufferCurrentIcon = { bg = c.Violet400, fg = c.},
        BufferCurrentINFO = { bg = c.Violet400, fg = c.Blue400 },
        BufferCurrentWARN = { bg = c.Violet400, fg = c.Yellow300 },
        BufferCurrentIndex = { bg = c.Violet400, fg = c.Blue400 },
        BufferCurrentMod = { bg = c.Violet400, fg = c.Yellow300 },
        BufferCurrentSign = { bg = c.Violet400, fg = c.Purple400 },
        BufferCurrentTarget = { bg = c.Violet400, fg = c.Coral400 },
        BufferAlternate = { bg = c.Mint400, fg = c.Lavender300 },
        BufferAlternateERROR = { bg = c.Violet400, fg = c.Coral400 },
        BufferAlternateHINT = { bg = c.Violet400, fg = c.Green400 },
        -- BufferAlternateIcon = { bg = c.base01, fg = c. },
        BufferAlternateIndex = { bg = c.base01, fg = c.Blue400 },
        BufferAlternateINFO = { bg = c.base01, fg = c.Blue400 },
        BufferAlternateMod = { bg = c.base01, fg = c.warning },
        BufferAlternateSign = { bg = c.base01, fg = c.Blue400 },
        BufferAlternateTarget = { bg = c.base01, fg = c.red },
        BufferAlternateWARN = { bg = c.base01, fg = c.warning },
        BufferVisible = { bg = c.bg_statusline, fg = c.fg },
        BufferVisibleERROR = { bg = c.bg_statusline, fg = c.error },
        BufferVisibleHINT = { bg = c.bg_statusline, fg = c.hint },
        -- BufferVisibleIcon = { bg = c.bg_statusline, fg = c. },
        BufferVisibleINFO = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleWARN = { bg = c.bg_statusline, fg = c.warning },
        BufferVisibleIndex = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleMod = { bg = c.bg_statusline, fg = c.warning },
        BufferVisibleSign = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleTarget = { bg = c.bg_statusline, fg = c.red },
        BufferInactive = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.violet500, 0.8) },
        BufferInactiveERROR = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.error, 0.8) },
        BufferInactiveHINT = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.hint, 0.8) },
        -- BufferInactiveIcon = { bg = c.bg_statusline, fg = util.darken(c., 0.1) },
        BufferInactiveINFO = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.info, 0.8) },
        BufferInactiveWARN = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
        BufferInactiveIndex = { bg = util.darken(c.bg_highlight, 0.4), fg = c.violet500 },
        BufferInactiveMod = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
        BufferInactiveSign = { bg = util.darken(c.bg_highlight, 0.4), fg = c.bg },
        BufferInactiveTarget = { bg = util.darken(c.bg_highlight, 0.4), fg = c.red },
        BufferOffset = { bg = c.bg_statusline, fg = c.violet500 },
        BufferTabpageFill = { bg = util.darken(c.bg_highlight, 0.8), fg = c.violet500 },
        BufferTabpages = { bg = c.bg_statusline, fg = c.none },

        -- Sneak
        Sneak = { fg = c.bg_highlight, bg = c.magenta },
        SneakScope = { bg = c.base03 },

        -- Hop
        HopNextKey = { fg = c.magenta500, bold = true },
        HopNextKey1 = { fg = c.violet500, bold = true },
        HopNextKey2 = { fg = c.violet700 },
        HopUnmatched = { fg = c.base01 },

        TSNodeKey = { fg = c.magenta500, bold = true },
        TSNodeUnmatched = { fg = c.base01 },

        LeapMatch = { bg = c.magenta500, fg = c.fg, bold = true },
        LeapLabelPrimary = { fg = c.magenta500, bold = true },
        LeapLabelSecondary = { fg = c.cyan, bold = true },
        LeapBackdrop = { fg = c.base01 },

        FlashBackdrop = { fg = c.base01 },
        FlashLabel = { bg = c.magenta500, bold = true, fg = c.fg },

        LightspeedGreyWash = { fg = c.base01 },
        -- LightspeedCursor = { link = "Cursor" },
        LightspeedLabel = { fg = c.magenta500, bold = true, underline = true },
        LightspeedLabelDistant = { fg = c.cyan, bold = true, underline = true },
        LightspeedLabelDistantOverlapped = { fg = c.cyan500, underline = true },
        LightspeedLabelOverlapped = { fg = c.magenta500, underline = true },
        LightspeedMaskedChar = { fg = c.orange },
        LightspeedOneCharMatch = { bg = c.magenta500, fg = c.fg, bold = true },
        LightspeedPendingOpArea = { bg = c.magenta500, fg = c.fg },
        LightspeedShortcut = { bg = c.magenta500, fg = c.fg, bold = true, underline = true },
        -- LightspeedShortcutOverlapped = { link = "LightspeedShortcut" },
        -- LightspeedUniqueChar = { link = "LightspeedUnlabeledMatch" },
        LightspeedUnlabeledMatch = { fg = c.violet500, bold = true },

        -- Cmp
        CmpDocumentation = { fg = c.fg, bg = c.bg_float },
        CmpDocumentationBorder = { fg = c.base02, bg = c.bg_float },
        CmpGhostText = { fg = c.base01 },

        CmpItemAbbr = { fg = c.fg, bg = c.none },
        CmpItemAbbrDeprecated = { fg = c.base01, bg = c.none, strikethrough = true },
        CmpItemAbbrMatch = { fg = c.violet500, bg = c.none },
        CmpItemAbbrMatchFuzzy = { fg = c.violet500, bg = c.none },

        CmpItemMenu = { fg = c.base01, bg = c.none },

        CmpItemKindDefault = { fg = c.base01, bg = c.none },

        CmpItemKindKeyword = { fg = c.cyan, bg = c.none },

        CmpItemKindVariable = { fg = c.magenta, bg = c.none },
        CmpItemKindConstant = { fg = c.magenta, bg = c.none },
        CmpItemKindReference = { fg = c.magenta, bg = c.none },
        CmpItemKindValue = { fg = c.magenta, bg = c.none },
        CmpItemKindCopilot = { fg = c.cyan500, bg = c.none },

        CmpItemKindFunction = { fg = c.blue, bg = c.none },
        CmpItemKindMethod = { fg = c.blue, bg = c.none },
        CmpItemKindConstructor = { fg = c.blue, bg = c.none },

        CmpItemKindClass = { fg = c.orange, bg = c.none },
        CmpItemKindInterface = { fg = c.orange, bg = c.none },
        CmpItemKindStruct = { fg = c.orange, bg = c.none },
        CmpItemKindEvent = { fg = c.orange, bg = c.none },
        CmpItemKindEnum = { fg = c.orange, bg = c.none },
        CmpItemKindUnit = { fg = c.orange, bg = c.none },

        CmpItemKindModule = { fg = c.yellow, bg = c.none },

        CmpItemKindProperty = { fg = c.cyan, bg = c.none },
        CmpItemKindField = { fg = c.cyan, bg = c.none },
        CmpItemKindTypeParameter = { fg = c.cyan, bg = c.none },
        CmpItemKindEnumMember = { fg = c.cyan, bg = c.none },
        CmpItemKindOperator = { fg = c.cyan, bg = c.none },
        CmpItemKindSnippet = { fg = c.violet500, bg = c.none },

        -- navic
        NavicIconsFile = { fg = c.fg, bg = c.bg_statusline },
        NavicIconsModule = { fg = c.yellow, bg = c.bg_statusline },
        NavicIconsNamespace = { fg = c.fg, bg = c.bg_statusline },
        NavicIconsPackage = { fg = c.fg, bg = c.bg_statusline },
        NavicIconsClass = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsMethod = { fg = c.blue, bg = c.bg_statusline },
        NavicIconsProperty = { fg = c.cyan, bg = c.bg_statusline },
        NavicIconsField = { fg = c.cyan, bg = c.bg_statusline },
        NavicIconsConstructor = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsEnum = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsInterface = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsFunction = { fg = c.blue, bg = c.bg_statusline },
        NavicIconsVariable = { fg = c.magenta, bg = c.bg_statusline },
        NavicIconsConstant = { fg = c.magenta, bg = c.bg_statusline },
        NavicIconsString = { fg = c.green, bg = c.bg_statusline },
        NavicIconsNumber = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsBoolean = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsArray = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsObject = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsKey = { fg = c.violet500, bg = c.bg_statusline },
        NavicIconsKeyword = { fg = c.violet500, bg = c.bg_statusline },
        NavicIconsNull = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsEnumMember = { fg = c.cyan, bg = c.bg_statusline },
        NavicIconsStruct = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsEvent = { fg = c.orange, bg = c.bg_statusline },
        NavicIconsOperator = { fg = c.fg, bg = c.bg_statusline },
        NavicIconsTypeParameter = { fg = c.cyan, bg = c.bg_statusline },
        NavicText = { fg = c.fg, bg = c.bg_statusline },
        NavicSeparator = { fg = c.fg, bg = c.bg_statusline },

        IblIndent = { fg = c.base03, nocombine = true },
        IndentBlanklineChar = { fg = c.base03, nocombine = true },
        IndentBlanklineContextChar = { fg = c.orange500, nocombine = true },

        -- Scrollbar
        ScrollbarHandle = { fg = c.none, bg = c.bg_highlight },

        ScrollbarSearchHandle = { fg = c.orange, bg = c.bg_highlight },
        ScrollbarSearch = { fg = c.orange, bg = c.none },

        ScrollbarErrorHandle = { fg = c.error, bg = c.bg_highlight },
        ScrollbarError = { fg = c.error, bg = c.none },

        ScrollbarWarnHandle = { fg = c.warning, bg = c.bg_highlight },
        ScrollbarWarn = { fg = c.warning, bg = c.none },

        ScrollbarInfoHandle = { fg = c.info, bg = c.bg_highlight },
        ScrollbarInfo = { fg = c.info, bg = c.none },

        ScrollbarHintHandle = { fg = c.hint, bg = c.bg_highlight },
        ScrollbarHint = { fg = c.hint, bg = c.none },

        ScrollbarMiscHandle = { fg = c.violet500, bg = c.bg_highlight },
        ScrollbarMisc = { fg = c.violet500, bg = c.none },

        -- Yanky
        YankyPut = { link = "IncSearch" },
        YankyYanked = { link = "IncSearch" },

        -- Lazy
        LazyProgressDone = { bold = true, fg = c.magenta500 },
        LazyProgressTodo = { bold = true, fg = c.base01 },

        -- Notify
        NotifyBackground = { fg = c.fg, bg = c.bg },
        --- Border
        NotifyERRORBorder = { fg = util.darken(c.error, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyWARNBorder = { fg = util.darken(c.warning, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyINFOBorder = { fg = util.darken(c.info, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyDEBUGBorder = { fg = util.darken(c.base01, 0.3), bg = options.transparent and c.none or c.bg },
        NotifyTRACEBorder = { fg = util.darken(c.violet500, 0.3), bg = options.transparent and c.none or c.bg },
        --- Icons
        NotifyERRORIcon = { fg = c.error },
        NotifyWARNIcon = { fg = c.warning },
        NotifyINFOIcon = { fg = c.info },
        NotifyDEBUGIcon = { fg = c.base01 },
        NotifyTRACEIcon = { fg = c.violet500 },
        --- Title
        NotifyERRORTitle = { fg = c.error },
        NotifyWARNTitle = { fg = c.warning },
        NotifyINFOTitle = { fg = c.info },
        NotifyDEBUGTitle = { fg = c.base01 },
        NotifyTRACETitle = { fg = c.violet500 },
        --- Body
        NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

        -- Mini
        MiniCompletionActiveParameter = { underline = true },

        MiniCursorword = { bg = c.base01 },
        MiniCursorwordCurrent = { bg = c.base01 },

        MiniIndentscopeSymbol = { fg = c.violet700, nocombine = true },
        MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

        MiniJump = { bg = c.magenta500, fg = c.base4 },

        MiniJump2dSpot = { fg = c.magenta500, bold = true, nocombine = true },

        MiniStarterCurrent = { nocombine = true },
        MiniStarterFooter = { fg = c.yellow, italic = true },
        MiniStarterHeader = { fg = c.blue },
        MiniStarterInactive = { fg = c.base01, style = options.styles.comments },
        MiniStarterItem = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        MiniStarterItemBullet = { fg = c.base01 },
        MiniStarterItemPrefix = { fg = c.warning },
        MiniStarterSection = { fg = c.violet500 },
        MiniStarterQuery = { fg = c.info },

        MiniStatuslineDevinfo = { fg = c.base01, bg = c.bg_highlight },
        MiniStatuslineFileinfo = { fg = c.base01, bg = c.bg_highlight },
        MiniStatuslineFilename = { fg = c.base01, bg = c.bg_highlight },
        MiniStatuslineInactive = { fg = c.blue, bg = c.bg_statusline },
        MiniStatuslineModeCommand = { fg = c.black, bg = c.yellow, bold = true },
        MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = true },
        MiniStatuslineModeNormal = { fg = c.black, bg = c.blue, bold = true },
        MiniStatuslineModeOther = { fg = c.black, bg = c.cyan500, bold = true },
        MiniStatuslineModeReplace = { fg = c.black, bg = c.red, bold = true },
        MiniStatuslineModeVisual = { fg = c.black, bg = c.magenta, bold = true },

        MiniSurround = { bg = c.orange, fg = c.black },

        MiniTablineCurrent = { fg = c.fg, bg = c.base01 },
        MiniTablineFill = { bg = c.black },
        MiniTablineHidden = { fg = c.violet500, bg = c.bg_statusline },
        MiniTablineModifiedCurrent = { fg = c.warning, bg = c.base01 },
        MiniTablineModifiedHidden = { bg = c.bg_statusline, fg = util.darken(c.warning, 0.7) },
        MiniTablineModifiedVisible = { fg = c.warning, bg = c.bg_statusline },
        MiniTablineTabpagesection = { bg = c.bg_statusline, fg = c.none },
        MiniTablineVisible = { fg = c.fg, bg = c.bg_statusline },

        MiniTestEmphasis = { bold = true },
        MiniTestFail = { fg = c.red, bold = true },
        MiniTestPass = { fg = c.green, bold = true },

        MiniTrailspace = { bg = c.red },

        -- Noice

        NoiceCompletionItemKindDefault = { fg = c.base01, bg = c.none },

        NoiceCompletionItemKindKeyword = { fg = c.cyan, bg = c.none },

        NoiceCompletionItemKindVariable = { fg = c.magenta, bg = c.none },
        NoiceCompletionItemKindConstant = { fg = c.magenta, bg = c.none },
        NoiceCompletionItemKindReference = { fg = c.magenta, bg = c.none },
        NoiceCompletionItemKindValue = { fg = c.magenta, bg = c.none },

        NoiceCompletionItemKindFunction = { fg = c.blue, bg = c.none },
        NoiceCompletionItemKindMethod = { fg = c.blue, bg = c.none },
        NoiceCompletionItemKindConstructor = { fg = c.blue, bg = c.none },

        NoiceCompletionItemKindClass = { fg = c.orange, bg = c.none },
        NoiceCompletionItemKindInterface = { fg = c.orange, bg = c.none },
        NoiceCompletionItemKindStruct = { fg = c.orange, bg = c.none },
        NoiceCompletionItemKindEvent = { fg = c.orange, bg = c.none },
        NoiceCompletionItemKindEnum = { fg = c.orange, bg = c.none },
        NoiceCompletionItemKindUnit = { fg = c.orange, bg = c.none },

        NoiceCompletionItemKindModule = { fg = c.yellow, bg = c.none },

        NoiceCompletionItemKindProperty = { fg = c.cyan, bg = c.none },
        NoiceCompletionItemKindField = { fg = c.cyan, bg = c.none },
        NoiceCompletionItemKindTypeParameter = { fg = c.cyan, bg = c.none },
        NoiceCompletionItemKindEnumMember = { fg = c.cyan, bg = c.none },
        NoiceCompletionItemKindOperator = { fg = c.cyan, bg = c.none },
        NoiceCompletionItemKindSnippet = { fg = c.violet500, bg = c.none },

        TreesitterContext = { bg = c.violet900 },
        Hlargs = { fg = c.yellow },
    }

    if not vim.diagnostic then
        local severity_map = {
            Error = "Error",
            Warn = "Warning",
            Info = "Information",
            Hint = "Hint",
        }
        local types = { "Default", "VirtualText", "Underline" }
        for _, type in ipairs(types) do
            for snew, sold in pairs(severity_map) do
                theme.highlights["LspDiagnostics" .. type .. sold] = {
                    link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
                }
            end
        end
    end

    ---@type table<string, table>
    theme.defer = {}

    if options.hide_inactive_statusline then
        local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.border }

        -- StatusLineNC
        theme.highlights.StatusLineNC = inactive

        -- LuaLine
        for _, section in ipairs({ "a", "b", "c" }) do
            theme.defer["lualine_" .. section .. "_inactive"] = inactive
        end

        -- mini.statusline
        theme.highlights.MiniStatuslineInactive = inactive
    end

    options.on_highlights(theme.highlights, theme.colors)

    if config.is_day() then
        util.invert_colors(theme.colors)
        util.invert_highlights(theme.highlights)
    end

    return theme
end

return M
