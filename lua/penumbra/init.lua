local theme = {}
local utils = require("penumbra.utils")
-- The palette depends on vim.o.background, which can change at runtime (and
-- Neovim re-sources the colorscheme when it does), so it is loaded lazily in
-- colorscheme() instead of being captured here at module load time.
local c

local default_config = {
    terminal_colors = true,
    dim_inactive = true,
    italics = {
        comments     = true,
        conditionals = false,
        keywords     = false,
        strings      = false,
    },
    overrides = {}
}
local user_config = vim.g.penumbra_config or {}
local config = vim.tbl_deep_extend("force", default_config, user_config)

local function set_terminal_colors()
    -- https://www.ditig.com/256-colors-cheat-sheet
    vim.g.terminal_color_0  = c.bg
    vim.g.terminal_color_1  = c.red_800
    vim.g.terminal_color_2  = c.green_900
    vim.g.terminal_color_3  = c.yellow_900
    vim.g.terminal_color_4  = c.indigo_800
    vim.g.terminal_color_5  = c.purple_800
    vim.g.terminal_color_6  = c.blue_900
    vim.g.terminal_color_7  = c.indigo_900

    vim.g.terminal_color_8  = c.indigo_300
    vim.g.terminal_color_9  = c.red_400
    vim.g.terminal_color_10 = c.green_800
    vim.g.terminal_color_11 = c.yellow_600
    vim.g.terminal_color_12 = c.indigo_700
    vim.g.terminal_color_13 = c.purple_800
    vim.g.terminal_color_14 = c.blue_800
    vim.g.terminal_color_15 = c.fg
end

local function set_groups()
    local groups = {
        -----------------------------------------------------
        -----------------------------------------------------
        -- Base neovim UI |help highlight-groups|
        -----------------------------------------------------
        -----------------------------------------------------
        ColorColumn  = { link = "CursorLine" },                  -- Used for the columns set with 'colorcolumn'.
        Conceal      = { link = "NonText" },                  -- Placeholder characters substituted for concealed
        Cursor       = { fg   = c.bg, bg = c.fg },               -- Character under the cursor.
        lCursor      = { link = "Cursor" },                      -- Character under the cursor when |language-mapping|
        CursorIM     = { link = "Cursor" },                      -- Like Cursor, but used when in IME mode. *CursorIM*
        TermCursor   = { link = "Cursor" },                      -- Cursor in a focused terminal.
        CursorColumn = { link = "CursorLine" },                  -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine   = { bg   = utils.shade(c.fg, 0.1, c.bg) },  -- Screen-line at the cursor, when 'cursorline' is set.
        Directory    = { fg   = c.indigo_800 },                  -- Directory names (and other special names in listings).

        NonText = { fg = utils.shade(c.indigo_800, 0.6, c.bg) }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        EndOfBuffer = { link = "NonText" }, -- Filler lines (~) after the last line in the buffer. By default, this is highlighted like |hl-NonText|.
        Whitespace  = { link = "NonText" }, -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.

        OkMsg      = { fg = c.green_800, bold = true },  -- Success messages.
        WarningMsg = { fg = c.yellow_800, bold = true }, -- Warning messages.
        ErrorMsg   = { fg = c.red_800, bold = true },    -- Error messages.
        StderrMsg    = { link = "ErrorMsg" },   -- Messages in stderr from shell commands.
        StdoutMsg    = { link = "Normal" },     -- Messages in stdout from shell commands.
        ModeMsg      = { fg = c.green_900 },    -- 'showmode' message (e.g., "  -- INSERT --").
        MsgArea      = { link = "Normal" },     -- Area for messages and command-line, see also 'cmdheight'.
        MsgSeparator = { link = "StatusLine" }, -- Separator for scrolled messages |msgsep|.
        MoreMsg      = { fg = c.blue_800 },     -- |more-prompt|
        Question     = { fg = c.blue_800 },     -- |hit-enter| prompt and yes/no questions.
        Title        = { fg = c.indigo_600, bold = true },   -- Titles for output from ":set all", ":autocmd" etc.

        WinBar    = { bg = c.indigo_200, fg = c.indigo_900 }, -- Window bar of current window.
        WinBarNC  = { bg = c.indigo_100, fg = c.indigo_400 }, -- Window bar of not-current windows.
        WinSeparator = { link = "Special" },               -- Separators between window splits.
        Folded       = { fg   = c.indigo_400, bg = c.indigo_50 }, -- Line used for closed folds.
        FoldColumn   = { link = "SignColumn" }, -- 'foldcolumn'
        SignColumn   = { link = "Normal" }, -- Column where |signs| are displayed.

        Search     = { bg = c.indigo_300 },                           -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        IncSearch  = { bg = c.indigo_900, fg = c.bg, bold = true },   -- 'incsearch' highlighting; also used for the text replaced with ":s///c".
        CurSearch  = { link = "IncSearch" },                          -- Current match for the last search pattern (see 'hlsearch').
        MatchParen = { fg   = c.bg, bg = c.purple_800, bold = true }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        Substitute = { link = "IncSearch" },                          -- |:substitute| replacement text highlighting.

        LineNr       = { fg = c.indigo_300, bold = true },   -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        LineNrAbove  = { link = "LineNr"},                   -- Line number for when the 'relativenumber' option is set, above the cursor line.
        LineNrBelow  = { link = "LineNr" },                  -- Line number for when the 'relativenumber' option is set, below the cursor line.
        CursorLineNr = { link = "CursorLine", bold = true }, -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
        CursorLineFold = { link = "FoldColumn" },            -- Like FoldColumn when 'cursorline' is set for the cursor line.
        CursorLineSign = { link = "SignColumn" },            -- Like SignColumn when 'cursorline' is set for the cursor line.

        Normal             = { fg = c.fg, bg = c.bg }, -- Normal text.
        NormalFloat        = { bg = c.indigo_200 },    -- Normal text in floating windows.
        FloatBorder        = { bg = c.indigo_200, fg = c.indigo_600 }, -- Border of floating windows.
        FloatShadow        = { bg   = c.indigo_300 },  -- Blended areas when border is "shadow".
        FloatShadowThrough = { link = "FloatShadow" }, -- Shadow corners when border is "shadow".
        FloatTitle         = { fg = c.indigo_600, bg = c.indigo_200, bold = true }, -- Title of floating windows.
        FloatFooter        = { link = "FloatTitle" },  -- Footer of floating windows.
        NormalNC           = { link = "Normal" },      -- Normal text in non-current windows.
        Visual             = { bg   = utils.shade(c.indigo_900, 0.15, c.bg) }, -- Visual mode selection.
        VisualNOS          = { link = "Visual" }, -- Visual mode selection when vim is "Not Owning the Selection".

        Pmenu         = { link = "NormalFloat" }, -- Popup menu: Normal item.
        PmenuSel      = { bg   = c.indigo_300 },  -- Popup menu: Selected item. Combined with |hl-Pmenu|.
        PmenuKind     = { link = "Pmenu"},        -- Popup menu: Normal item "kind".
        PmenuKindSel  = { link = "PmenuSel" },    -- Popup menu: Selected item "kind".
        PmenuExtra    = { link = "Pmenu" },       -- Popup menu: Normal item "extra text".
        PmenuExtraSel = { link = "PmenuSel" },    -- Popup menu: Selected item "extra text".
        PmenuSbar     = { link = "Pmenu" },       -- Popup menu: Scrollbar.
        PmenuThumb    = { bg   = c.indigo_700 },  -- Popup menu: Thumb of the scrollbar.
        PmenuMatch    = { fg   = c.indigo_800, bold = true }, -- Popup menu: Matched text in normal item.  Combined with |hl-Pmenu|.
        PmenuMatchSel = {}, -- Popup menu: Matched text in selected item.  Combined with |hl-PmenuMatch| and |hl-PmenuSel|.
        PmenuBorder        = { link = "FloatBorder" },       -- Popup menu: border of popup menu.
        PmenuShadow        = { link = "FloatShadow"},        -- Popup menu: blended areas when 'pumborder' is "shadow".
        PmenuShadowThrough = { link = "FloatShadowThrough"}, -- Popup menu: shadow corners when 'pumborder' is "shadow".
        ComplMatchIns      = {}, -- Matched text of the currently inserted completion.
        PreInsert          = { link = "NonText" },    -- Text inserted when "preinsert" is in 'completeopt'.
        ComplHint          = { link = "NonText" },  -- Virtual text of the currently selected completion.
        ComplHintMore      = { link = "MoreMsg" },  -- The additional information of the virtual text.
        WildMenu           = { link = "PmenuSel" }, -- Current match in 'wildmenu' completion.

        QuickFixLine         = { bg   = utils.shade(c.indigo_300, 0.5, c.bg) }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        SnippetTabstop       = { link = "Visual" },  -- Tabstops in snippets. |vim.snippet|
        SpecialKey           = { link = "Special" }, -- Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        SnippetTabstopActive = { link = "SnippetTabstop" }, -- The currently active tabstop. |vim.snippet|

        SpellBad   = { undercurl = true, sp = c.red_800 },    -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap   = { undercurl = true, sp = c.yellow_900 }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { undercurl = true, sp = c.green_900 },  -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare  = { undercurl = true, sp = c.blue_900 }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

        StatusLine       = { fg = c.indigo_600, bg = c.indigo_200, bold = true }, -- Status line of current window.
        StatusLineNC     = { fg = c.indigo_800, bg = c.indigo_100, bold = true }, -- Status lines of not-current windows.
        StatusLineTerm   = { fg = c.purple_800, bg = c.purple_300, bold = true }, -- Status line of |terminal| window.
        StatusLineTermNC = { link = "StatusLineNC" }, -- Status line of non-current |terminal| windows.
        TabLine          = { link = "TabLineFill"  }, -- Tabpages line, not active tabpage label.
        TabLineFill      = { link = "StatusLineNC" }, -- Tabpages line, where there are no labels.
        TabLineSel       = { fg = c.fg, bg = c.indigo_300, bold = true, italic = true}, -- Tabpages line, active tabpage label.

        -- https://oklch.com
        ActiveWindow   = { bg = c.indigo_100 },
        InactiveWindow = { fg = "#cecded", bg = "#191a26" },


        -----------------------------------------------------
        -----------------------------------------------------
        -- Diff related highlights
        -----------------------------------------------------
        -----------------------------------------------------
        Added   = { fg = c.green_800},   -- added line in a diff
        Changed = { fg = c.yellow_800 }, -- changed line in a diff
        Removed = { fg = c.red_800 },    -- removed line in a diff

        DiffAdd     = { bg = c.green_200, fg = c.fg }, -- Diff mode: Added line. |diff.txt|
        DiffChange  = { bg = c.indigo_200 },           -- Diff mode: Changed line. |diff.txt|
        DiffDelete  = { bg = c.red_200, fg   = c.fg }, -- Diff mode: Deleted line. |diff.txt|
        DiffText    = { bg = c.indigo_300 },           -- Diff mode: Changed text within a changed line. |diff.txt|
        DiffTextAdd = { bg = c.green_300 },            -- Diff mode: Added text within a changed line.  Linked to |hl-DiffText| by default. |diff.txt|

        ["@diff.plus"]  = { link = "Added" },   -- added text (for diff files)
        ["@diff.minus"] = { link = "Removed" }, -- deleted text (for diff files)
        ["@diff.delta"] = { link = "Changed" }, -- changed text (for diff files)

        -----------------------------------------------------
        -----------------------------------------------------
        -- Syntax |help group-name|
        -----------------------------------------------------
        -----------------------------------------------------
        Comment = { fg = c.yellow_900, italic = config.italics.comments }, -- any comment

        Constant  = { fg = c.blue_900, bold = true },  -- any constant
        String    = { fg = c.green_900, italic = config.italics.strings }, -- a string constant: "this is a string"
        Character = { link = "Constant" },                 -- a character constant: 'c', '\n'
        Number    = { fg   = c.red_800,  bold = true },  -- a number constant: 234, 0xff
        Boolean   = { fg   = c.blue_900, bold = true },  -- a boolean constant: TRUE, false
        Float     = { link = "Number" },                   -- a floating point constant: 2.3e10

        Identifier = { fg = c.indigo_900 }, -- any variable name
        Function   = { fg = c.indigo_800 }, -- function name (also: methods for classes)

        Statement   = { fg = c.indigo_900, bold = true }, -- any statement
        Conditional = { fg = c.indigo_900, bold = true, italic = config.italics.conditionals }, -- if, then, else, endif, switch, etc.
        Repeat      = { link = "Statement" },               -- for, do, while, etc.
        Label       = { link = "Statement" },               -- case, default, etc.
        Operator    = { fg = c.indigo_900 }, -- "sizeof", "+", "*", etc.
        Keyword     = { fg = c.indigo_900, bold = true, italic = config.italics.keywords },               -- any other keyword
        Exception   = { link = "Statement" },               -- try, catch, throw

        PreProc      = { link = "Statement" }, -- generic Preprocessor
        Include   = { link = "PreProc" }, -- preprocessor #include
        Define    = { link = "PreProc" }, -- preprocessor #define
        Macro     = { link = "PreProc" }, -- same as Define
        PreCondit = { link = "PreProc" }, -- preprocessor #if, #else, #endif, etc.

        Type         = { fg = c.purple_900 }, -- int, long, char, etc.
        StorageClass = { link = "Type" }, -- static, register, volatile, etc.
        Structure    = { link = "Type" }, -- struct, union, enum, etc.
        Typedef      = { link = "Type" }, -- a typedef

        Special     = { fg = c.indigo_700, bold = true }, -- any special symbol
        SpecialChar = { link = "Special" }, -- special character in a constant
        Tag         = { link = "Special" }, -- you can use CTRL-] on this
        Delimiter   = { fg = c.indigo_900, bold = true }, -- character that needs attention
        SpecialComment = { link = "Special" }, -- special things inside a comment
        Debug          = { link = "Special" }, -- debugging statements

        Underlined = { underline = true }, -- text that stands out, HTML links
        Bold       = { bold      = true },
        Italic     = { italic    = true },
        Ignore     = { fg = c.bg }, -- left blank, hidden  |hl-Ignore|
        Error      = { fg = c.red_800, bg = c.red_100, bold = true }, -- any erroneous construct
        Todo       = { fg = c.blue_800, bold = true }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX


        -----------------------------------------------------
        -----------------------------------------------------
        -- Treesitter |help treesitter-highlight-groups|
        -----------------------------------------------------
        -----------------------------------------------------
        ["@variable"]         = { fg = c.fg }, -- various variable names
        ["@variable.builtin"] = { fg = c.fg, bold = true }, -- built-in variable names (e.g. `this`, `self`)
        -- ["@variable.parameter"]         = { fg = c.fg }, -- parameters of a function
        ["@variable.parameter.builtin"] = { link = "@variable.builtin" }, -- special parameters (e.g. `_`, `it`)
        ["@variable.member"]            = { link = "Identifier" }, -- object and struct fields

        ["@constant"]         = { link = "Constant" }, -- constant identifiers
        ["@constant.builtin"] = { link = "Special" }, -- built-in constant values
        -- ["@constant.macro"]   = {}, -- constants defined by the preprocessor

        ["@module"]         = { link = "Structure" }, -- modules or namespaces
        ["@module.builtin"] = { link = "Special" }, -- built-in modules or namespaces
        ["@label"]          = { link = "Label" }, -- `GOTO` and other labels (e.g. `label:` in C), including heredoc labels

        ["@string"]         = { link = "String" },          -- string literals
        ["@string.special"] = { link = "SpecialChar" },     -- other special strings (e.g. dates)
        ["@string.regexp"]  = { link = "@string.special" }, -- regular expressions
        ["@string.escape"]  = { link = "@string.special" }, -- escape sequences
        ["@string.special.path"] = { bold = true, italic = true },    -- filenames
        ["@string.special.url"]  = { bold = true, underline = true }, -- URIs (e.g. hyperlinks)
        -- ["@string.documentation"]  = {}, -- string documenting code (e.g. Python docstrings)
        -- ["@string.special.symbol"] = {}, -- symbols or atoms

        ["@character"]         = { link = "Character" }, -- character literals
        ["@character.special"] = { link = "Special" }, -- special characters (e.g. wildcards)

        ["@boolean"]      = { link = "Boolean" }, -- boolean literals
        ["@number"]       = { link = "Number" }, -- numeric literals
        ["@number.float"] = { link = "Number"}, -- floating-point number literals

        ["@type"]            = { link = "Type" }, -- type or class definitions and annotations
        ["@type.builtin"]    = { link = "Special" }, -- built-in types
        -- ["@type.definition"] = {}, -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)

        ["@attribute"]         = { link = "Macro" }, -- attribute annotations (e.g. Python decorators, Rust lifetimes)
        ["@attribute.builtin"] = { link = "Special" }, -- builtin annotations (e.g. `@property` in Python)
        ["@property"]          = { link = "Identifier" }, -- the key in key/value pairs

        ["@function"]         = { link = "Function" }, -- function definitions
        ["@function.builtin"] = { link = "Special" }, -- built-in functions
        -- ["@function.call"]    = {}, -- function calls
        -- ["@function.macro"]   = {}, -- preprocessor macros
        -- ["@function.method"]      = {}, -- method definitions
        -- ["@function.method.call"] = {}, -- method calls

        ["@constructor"] = { link = "Special" }, -- constructor calls and definitions
        ["@operator"]    = { link = "Operator" }, -- symbolic operators (e.g. `+`, `*`)

        ["@keyword"] = { link = "Keyword" }, -- keywords not fitting into specific categories
        -- ["@keyword.coroutine"] = {}, -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
        -- ["@keyword.function"]  = {}, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
        -- ["@keyword.operator"]  = {}, -- operators that are English words (e.g. `and`, `or`)
        -- ["@keyword.import"]    = {}, -- keywords for including or exporting modules (e.g. `import`, `from` in Python)
        -- ["@keyword.type"]      = {}, -- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
        -- ["@keyword.modifier"]  = {}, -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
        -- ["@keyword.repeat"]    = {}, -- keywords related to loops (e.g. `for`, `while`)
        -- ["@keyword.return"]    = {}, -- keywords like `return` and `yield`
        -- ["@keyword.debug"]     = {}, -- keywords related to debugging
        -- ["@keyword.exception"] = {}, -- keywords related to exceptions (e.g. `throw`, `catch`)
        -- ["@keyword.directive"]   = {}, -- various preprocessor directives and shebangs
        ["@keyword.conditional"] = { link = "Conditional" }, -- keywords related to conditionals (e.g. `if`, `else`)
        -- ["@keyword.conditional.ternary"] = {}, -- ternary operator (e.g. `?`, `:`)
        -- ["@keyword.directive.define"]    = {}, -- preprocessor definition directives

        ["@punctuation"] = { link = "Delimiter" }, -- delimiters (e.g. `;`, `.`, `,`)
        ["@punctuation.special"]   = { link = "Special" }, -- special symbols (e.g. `{}` in string interpolation)
        -- ["@punctuation.bracket"]   = {}, -- brackets (e.g. `()`, `{}`, `[]`)

        ["@comment"]         = { link = "Comment" },         -- line and block comments
        ["@comment.error"]   = { link = "DiagnosticError" }, -- error  -type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
        ["@comment.warning"] = { link = "DiagnosticWarn" },  -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
        ["@comment.todo"]    = { link = "Todo" },            -- todo-type comments (e.g. `TODO`, `WIP`)
        ["@comment.note"]    = { link = "DiagnosticInfo" },  -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
        -- ["@comment.documentation"] = {}, -- comments documenting code

        ["@markup.strong"] = { bold   = true }, -- bold text
        ["@markup.italic"] = { italic = true }, -- italic text
        ["@markup.strikethrough"] = { strikethrough = true}, -- struck-through text
        ["@markup.underline"]     = { underline     = true}, -- underlined text (only for literal underline markup!)

        ["@markup.heading"]   = { link = "Title" }, -- headings, titles (including markers)
        -- ["@markup.heading.1"] = {}, -- top-level heading
        -- ["@markup.heading.2"] = {}, -- section heading
        -- ["@markup.heading.3"] = {}, -- subsection heading
        -- ["@markup.heading.4"] = {}, -- and so on
        -- ["@markup.heading.5"] = {}, -- and so forth
        -- ["@markup.heading.6"] = {}, -- six levels ought to be enough for anybody
        -- ["@markup.quote"] = {}, -- block quotes
        -- ["@markup.math"]  = {}, -- math environments (e.g. `$ ... $` in LaTeX)
        ["@markup.link"]       = { link = "Underlined" }, -- text references, footnotes, citations, etc.
        -- ["@markup.link.label"] = {}, -- link, reference descriptions
        -- ["@markup.link.url"]   = {}, -- URL-style links
        -- ["@markup.raw"]       = {}, -- literal or verbatim text (e.g. inline code)
        -- ["@markup.raw.block"] = {}, -- literal or verbatim text as a stand-alone block
        -- ["@markup.list"]           = {}, -- list markers
        -- ["@markup.list.checked"]   = {}, -- checked todo  -style list markers
        -- ["@markup.list.unchecked"] = {}, -- unchecked todo-style list markers

        ["@tag"]           = { link = "Tag" }, -- XML-style tag names (e.g. in XML, HTML, etc.)
        ["@tag.builtin"]   = { link = "Special" }, -- builtin tag names (e.g. HTML5 tags)
        -- ["@tag.attribute"] = {}, -- XML-style tag attributes
        -- ["@tag.delimiter"] = {}, -- XML-style tag delimiters


        -----------------------------------------------------
        -----------------------------------------------------
        -- LSP Semantic |help lsp-semantic-highlight|
        -----------------------------------------------------
        -----------------------------------------------------
        -- NOTE: Treesitter has highlights for different types of comments (BUG, FIX, TODO, etc).
        -- However, when an lsp has semantic tokens, it links `lsp.type.comments` to `Comments`, which overrides
        -- Treesitter's highlights for those different types of comments. So basically, let's not do anything
        -- with this highlight.
        ["@lsp.type.comment"]    = {},                               -- Tokens that represent a comment
        ["@lsp.type.class"]      = { link = "@type" },               -- Identifiers that declare or reference a class type
        ["@lsp.type.decorator"]  = { link = "@attribute" },          -- Identifiers that declare or reference decorators and annotations
        ["@lsp.type.enum"]       = { link = "@type" },               -- Identifiers that declare or reference an enumeration type
        ["@lsp.type.enumMember"] = { link = "@constant" },           -- Identifiers that declare or reference an enumeration property, constant, or member
        ["@lsp.type.event"]      = { link = "@type" },               -- Identifiers that declare an event property
        ["@lsp.type.function"]   = { link = "@function" },           -- Identifiers that declare a function
        ["@lsp.type.interface"]  = { link = "@type" },               -- Identifiers that declare or reference an interface type
        ["@lsp.type.keyword"]    = { link = "@keyword" },            -- Tokens that represent a language keyword
        ["@lsp.type.macro"]      = { link = "@constant.macro" },     -- Identifiers that declare a macro
        ["@lsp.type.method"]     = { link = "@function.method" },    -- Identifiers that declare a member function or method
        ["@lsp.type.modifier"]   = { link = "@type.qualifier" },     -- Tokens that represent a modifier
        ["@lsp.type.namespace"]  = { link = "@module" },             -- Identifiers that declare or reference a namespace, module, or package
        ["@lsp.type.number"]     = { link = "@number" },             -- Tokens that represent a number literal
        ["@lsp.type.operator"]   = { link = "@operator" },           -- Tokens that represent an operator
        ["@lsp.type.parameter"]  = { link = "@variable.parameter" }, -- Identifiers that declare or reference a function or method parameters
        ["@lsp.type.property"]   = { link = "@property" },           -- Identifiers that declare or reference a member property, member field, or member variable
        ["@lsp.type.regexp"]     = { link = "@string.regexp" },      -- Tokens that represent a regular expression literal
        ["@lsp.type.string"]     = { link = "@string" },             -- Tokens that represent a string literal
        ["@lsp.type.struct"]     = { link = "@type" },               -- Identifiers that declare or reference a struct type
        ["@lsp.type.type"]       = { link = "@type" },               -- Identifiers that declare or reference a type that is not covered above
        ["@lsp.type.typeParameter"] = { link = "@type.definition" }, -- Identifiers that declare or reference a type parameter
        ["@lsp.type.variable"]      = { link = "@variable" }, -- Identifiers that declare or reference a local or global variable

        ["@lsp.mod.deprecated"]     = { link = "DiagnosticDeprecated" }, -- Symbols that should no longer be used
        -- ["@lsp.mod.abstract"]       = {}, -- Types and member functions that are abstract
        -- ["@lsp.mod.async"]          = {}, -- Functions that are marked async
        -- ["@lsp.mod.declaration"]    = {}, -- Declarations of symbols
        -- ["@lsp.mod.defaultLibrary"] = {}, -- Symbols that are part of the standard library
        -- ["@lsp.mod.definition"]     = {}, -- Definitions of symbols, for example, in header files
        -- ["@lsp.mod.documentation"]  = {}, -- Occurrences of symbols in documentation
        -- ["@lsp.mod.modification"]   = {}, -- Variable references where the variable is assigned to
        -- ["@lsp.mod.readonly"]       = {}, -- Readonly variables and member fields (constants)
        -- ["@lsp.mod.static"]         = {}, -- Class members (static members)


        -----------------------------------------------------
        -----------------------------------------------------
        -- LSP |help lsp-highlight|
        -----------------------------------------------------
        -----------------------------------------------------
        LspReferenceText   = { bg = c.indigo_200 }, -- used for highlighting "text" references
        LspReferenceRead   = { link = "LspReferenceText" },   -- used for highlighting "read" references
        LspReferenceWrite  = { link = "LspReferenceText" },   -- used for highlighting "write" references
        LspReferenceTarget = { link = "LspReferenceText" },   -- used for highlighting reference targets (e.g. in a hover range)
        LspInlayHint       = { fg = c.indigo_400, italic = true},   -- used for highlighting inlay hints

        LspCodeLens        = { link = "NonText" }, -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        LspCodeLensSeparator = { link = "LspCodeLens" }, -- Used to color the separator between two or more code lenses.

        LspSignatureActiveParameter = { link = "Visual" }, -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

        -----------------------------------------------------
        -----------------------------------------------------
        -- Diagnostics |help diagnostic-highlights|
        -----------------------------------------------------
        -----------------------------------------------------
        DiagnosticError = { fg = c.red_800,    bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticWarn  = { fg = c.yellow_800, bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticInfo  = { fg = c.purple_800, bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticHint  = { fg = c.blue_800,   bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticOk    = { fg = c.green_800,  bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)

        DiagnosticVirtualTextError = { link = "DiagnosticError" }, -- Used for "Error" diagnostic virtual text.
        DiagnosticVirtualTextWarn  = { link = "DiagnosticWarn"  }, -- Used for "Warn" diagnostic virtual text.
        DiagnosticVirtualTextInfo  = { link = "DiagnosticInfo"  }, -- Used for "Info" diagnostic virtual text.
        DiagnosticVirtualTextHint  = { link = "DiagnosticHint"  }, -- Used for "Hint" diagnostic virtual text.
        DiagnosticVirtualTextOk    = { link = "DiagnosticOk"    }, -- Used for "Ok" diagnostic virtual text.

        DiagnosticVirtualLinesError = { link = "DiagnosticError" }, -- Used for "Error" diagnostic virtual lines.
        DiagnosticVirtualLinesWarn  = { link = "DiagnosticWarn"  }, -- Used for "Warn" diagnostic virtual lines.
        DiagnosticVirtualLinesInfo  = { link = "DiagnosticInfo"  }, -- Used for "Info" diagnostic virtual lines.
        DiagnosticVirtualLinesHint  = { link = "DiagnosticHint"  }, -- Used for "Hint" diagnostic virtual lines.
        DiagnosticVirtualLinesOk    = { link = "DiagnosticOk"    }, -- Used for "Ok" diagnostic virtual lines.

        DiagnosticUnderlineError = { sp = c.red_800,    italic = true, underline = true }, -- Used to underline "Error" diagnostics.
        DiagnosticUnderlineWarn  = { sp = c.yellow_800, italic = true, underline = true }, -- Used to underline "Warn" diagnostics.
        DiagnosticUnderlineInfo  = { sp = c.purple_800, italic = true, underline = true }, -- Used to underline "Info" diagnostics.
        DiagnosticUnderlineHint  = { sp = c.blue_800,   italic = true, underline = true }, -- Used to underline "Hint" diagnostics.
        DiagnosticUnderlineOk    = { sp = c.green_800,  italic = true, underline = true }, -- Used to underline "Ok" diagnostics.

        DiagnosticFloatingError = { link = "DiagnosticError" }, -- Used to color "Error" diagnostic messages in diagnostics float.
        DiagnosticFloatingWarn  = { link = "DiagnosticWarn"  }, -- Used  to color "Warn" diagnostic messages in diagnostics float.
        DiagnosticFloatingInfo  = { link = "DiagnosticInfo"  }, -- Used to color "Info" diagnostic messages in diagnostics float.
        DiagnosticFloatingHint  = { link = "DiagnosticHint"  }, -- Used to color "Hint" diagnostic messages in diagnostics float.
        DiagnosticFloatingOk    = { link = "DiagnosticOk"    }, -- Used to color "Ok" diagnostic messages in diagnostics float.

        DiagnosticSignError = { link = "DiagnosticError" }, -- Used for "Error" signs in sign column.
        DiagnosticSignWarn  = { link = "DiagnosticWarn"  }, -- Used for "Warn" signs in sign column.
        DiagnosticSignInfo  = { link = "DiagnosticInfo"  }, -- Used for "Info" signs in sign column.
        DiagnosticSignHint  = { link = "DiagnosticHint"  }, -- Used for "Hint" signs in sign column.
        DiagnosticSignOk    = { link = "DiagnosticOk"    }, -- Used for "Ok" signs in sign column.

        DiagnosticDeprecated = { fg = c.red_800, strikethrough = true, italic = true}, -- Used for deprecated or obsolete code. Applied by the "underline" handler; disabled when `vim.diagnostic.config({ underline = false })`.
        DiagnosticUnnecessary = { fg = c.indigo_400, bold = true }, -- Used for unnecessary or unused code. Applied by the "underline" handler; disabled when `vim.diagnostic.config({ underline  = false })`.


        -----------------------------------------------------
        -----------------------------------------------------
        -- Plugins
        -----------------------------------------------------
        -----------------------------------------------------
        SnacksPickerToggle = { fg = c.purple_800, bg = c.indigo_200, bold = true },

        MiniClueDescGroup = { link = "DiagnosticInfo" },
        MiniStatuslineModeNormal  = { fg = c.bg, bg = c.indigo_800, },
        MiniStatuslineModeVisual  = { fg = c.bg, bg = c.purple_800 },
        MiniStatuslineModeReplace = { fg = c.bg, bg = c.red_800 },
        MiniStatuslineModeCommand = { fg = c.fg, bg = c.indigo_300 },
        MiniStatuslineModeOther   = { link = "StatusLineTerm" },
        MiniStatuslineFilename    = { bg = c.indigo_50 },
    }

    -- overrides
    groups = vim.tbl_extend(
        "force",
        groups,
        type(config.overrides) == "function" and config.overrides.overrides()
        or config.overrides
    )

    for group, parameters in pairs(groups) do
        vim.api.nvim_set_hl(0, group, parameters)
    end
end

local function set_inactive_window_dim()
    local group = vim.api.nvim_create_augroup("DimInactiveWindows", { clear = true })
    local aucmd = vim.api.nvim_create_autocmd

    aucmd("WinEnter", {
        group = group,
        desc = "Highlight active window",
        callback = function()
            vim.opt_local.winhighlight =
            "Normal:ActiveWindow,NormalNC:InactiveWindow,SignColumn:ActiveWindow"
        end,
    })

    aucmd("WinLeave", {
        group = group,
        desc = "Dim inactive window",
        callback = function()
            vim.opt_local.winhighlight =
            "Normal:ActiveWindow,NormalNC:InactiveWindow,SignColumn:InactiveWindow"
        end,
    })
end

function theme.colorscheme()
    vim.api.nvim_command "hi clear"
    if vim.fn.exists "syntax_on" then
        vim.api.nvim_command "syntax reset"
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "penumbra"

    -- Drop the cached palette so it is rebuilt for the current 'background'.
    package.loaded["penumbra.colorscheme"] = nil
    c = require("penumbra.colorscheme")[vim.o.background]

    if config.terminal_colors then
        set_terminal_colors()
    end

    if config.dim_inactive then
        set_inactive_window_dim()
    end
    set_groups()
end

return theme
