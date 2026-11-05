local theme = {}
local utils = require'penumbra.utils'
local config = require'penumbra.config'
local c = require'penumbra.colorscheme'

local function set_terminal_colors()
    -- vim.g.terminal_color_0 = c.editorBackground
    -- vim.g.terminal_color_1 = c.syntaxError
    -- vim.g.terminal_color_2 = c.successText
    -- vim.g.terminal_color_3 = c.warningEmphasis
    -- vim.g.terminal_color_4 = c.syntaxFunction
    -- vim.g.terminal_color_5 = c.syntaxKeyword
    -- vim.g.terminal_color_6 = c.linkText
    -- vim.g.terminal_color_7 = c.mainText
    -- vim.g.terminal_color_8 = c.inactiveText
    -- vim.g.terminal_color_9 = c.errorText
    -- vim.g.terminal_color_10 = c.stringText
    -- vim.g.terminal_color_11 = c.warningText
    -- vim.g.terminal_color_12 = c.syntaxOperator
    -- vim.g.terminal_color_13 = c.syntaxError
    -- vim.g.terminal_color_14 = c.stringText
    -- vim.g.terminal_color_15 = c.commentText
    -- vim.g.terminal_color_background = c.editorBackground
    -- vim.g.terminal_color_foreground = c.mainText
end

local function set_groups()
    -- TODO: better grouping by interbase, syntax, etc. See link:
    -- https://vonheikemen.github.io/learn-nvim/feature/colorscheme.html#lua-color-scheme
    local groups = {
        -- base
        Normal = { fg = c.fg, bg = config.transparent and 'NONE' or c.bg },
        LineNr = { fg = c.indigo_300, bold = true },
        CursorLine = { bg = utils.shade(c.fg, 0.08, c.bg) },
        ColorColumn = { link = 'CursorLine' },
        -- Conceal = {},
        Cursor = { fg = c.bg, bg = c.fg },
        lCursor = { link = 'Cursor' },
        CursorIM = { link = 'Cursor' },
        Directory = { fg = c.indigo_800 },
        -- DiffAdd = { bg = c.bg, fg = c.green },
        -- DiffChange = { bg = c.bg, fg = c.yellow },
        -- DiffDelete = { bg = c.bg, fg = c.red },
        -- DiffText = { bg = bg, fg = diff_text },
        -- EndOfBuffer = { fg = c.syntaxKeyword },
        TermCursor = { link = 'Cursor' },
        TermCursorNC = { link = 'Cursor' },

        ErrorMsg = { fg = c.red },
        WarningMsg = { fg = c.yellow },

        WinSeparator = { link = 'Normal' },
        SignColumn = { link = 'Normal' },
        Folded = { fg = c.fg, bg = c.indigo_100 },
        FoldColumn = { link = 'SignColumn' },

        Search = { bg = c.indigo_300 },
        IncSearch = { bg = c.indigo_900, fg = c.bg, bold = true },
        CurSearch = { link = 'IncSearch' },
        Substitute = { link = 'IncSearch' },

        --   CursorLineNr = { fg = c.commentText },
        MatchParen = { fg = c.bg, bg = c.indigo_700, bold = true },
        ModeMsg = { link = 'Normal' },
        MsgArea = { link = 'Normal' },
        -- MsgSeparator = {},
        --   MoreMsg = { fg = c.syntaxFunction },
        NonText = { fg = utils.shade(c.indigo_900, 0.5, c.bg) },
        NormalFloat = { bg = c.indigo_100 },
        NormalNC = { link = 'Normal' },
        Pmenu = { link = 'NormalFloat' },
        PmenuSel = { bg = c.indigo_300 },
        WildMenu = { link = 'PmenuSel' },
        PmenuThumb = { bg = c.indigo_700 },
        --   Question = { fg = c.syntaxFunction },
        QuickFixLine = { bg = utils.shade(c.indigo_300, 0.5, c.bg) },
        SpecialKey = { fg = c.indigo_700 },
        StatusLine = { fg = c.fg, bg = c.indigo_100 },
        StatusLineNC = { fg = c.indigo_800, bg = c.indigo_100 },
        --   TabLine = {
        --     bg = c.sidebarBackground,
        --     fg = c.inactiveText,
        --   },
        --   TabLineFill = { link = 'TabLine' },
        --   TabLineSel = {
        --     bg = c.editorBackground,
        --     fg = c.emphasisText,
        --   },
        SpellBad = { undercurl = true, sp = c.red },
        SpellCap = { undercurl = true, sp = c.yellow },
        SpellLocal = { undercurl = true, sp = c.green },
        SpellRare = { undercurl = true, sp = c.red },
        Title = { fg = c.indigo_700 },
        FloatTitle = { fg = c.indigo_700, bg = c.indigo_100 },
        Visual = { bg = utils.shade(c.indigo_900, 0.2, c.bg) },
        VisualNOS = { link = 'Visual' },
        --   Whitespace = { fg = c.syntaxOperator },
        Comment = {
            fg = c.yellow,
            italic = config.italics.comments or true,
        },
        --
        Constant  = { fg   = c.blue, bold = true },
        Character = { link = 'Constant', bold = false },
        Boolean   = { fg   = c.blue, bold = true },
        Number = { fg   = c.red, bold = true },
        Float  = { link = 'Number' },
        String = { fg   = c.green },
        --
        Identifier = { fg = c.indigo_900 },
        Function = { fg = c.indigo_800 },
        Method = { fg = c.indigo_900},
        -- Property = { fg = c.indio },
        -- Field = { link = 'Property' },
        Parameter = { fg = c.fg },
        Statement = { fg = c.red, bold = true },
        Conditional = { link = 'Statement' },
        Label       = { link = 'Statement' },
        Repeat      = { link = 'Statement' },
        Keyword     = { link = 'Statement' },
        Exception   = { link = 'Statement' },
        PreProc     = { link = 'Statement' },
        -- Operator = { fg = c.teal_800 },
        -- Include = {},
        --   Define = { fg = c.syntaxKeyword },
        --   Macro = { link = 'Define' },
        --   PreCondit = { fg = c.syntaxError },
        --
        --   Type = { fg = c.syntaxKeyword },
        --   Struct = { link = 'Type' },
        --   Class = { link = 'Type' },
        --
        --   -- StorageClass = {},
        --   -- Structure = {},
        --   -- Typedef = {},
        --
        --   Attribute = { link = 'Character' },
        Punctuation = { fg = c.blue },
        Special = { fg = c.indigo_700 },
        --
        --   SpecialChar = { fg = c.syntaxError },
        --   Tag = { fg = c.stringText },
        Delimiter = { fg = c.fg },
        --   -- SpecialComment = {},
        --   Debug = { fg = c.specialKeyword },
        --
        --   Underlined = { underline = true },
        --   Bold = { bold = true },
        --   Italic = { italic = true },
        --   Ignore = { fg = c.editorBackground },
        Error = { link = 'ErrorMsg' },
        --   Todo = { fg = c.warningText, bold = true },
        --
        LspReferenceText = { bg = utils.shade(c.indigo_300, 0.6, c.bg) },
        --   -- LspReferenceRead = {},
        --   -- LspReferenceWrite = {},
        --   -- LspCodeLens = {},
        --   -- LspCodeLensSeparator = {},
        --   -- LspSignatureActiveParameter = {},
        --
        ---------------------------------------------------------------
        ----- Default diagnostics colors work perfect
        ---------------------------------------------------------------
        -- DiagnosticError = {},
        -- DiagnosticWarn = {},
        -- DiagnosticInfo = {},
        -- DiagnosticHint = {},
        --
        -- DiagnosticVirtualTextError = {},
        -- DiagnosticVirtualTextWarn = {},
        -- DiagnosticVirtualTextInfo = {},
        -- DiagnosticVirtualTextHint = {},
        --
        -- DiagnosticUnderlineError = {},
        -- DiagnosticUnderlineWarn = {},
        -- DiagnosticUnderlineInfo = {},
        -- DiagnosticUnderlineHint = {},

        -- DiagnosticFloatingError = {},
        -- DiagnosticFloatingWarn = {},
        -- DiagnosticFloatingInfo = {  },
        -- DiagnosticFloatingHint = {},

        -- DiagnosticSignError = {},
        -- DiagnosticSignWarn = {},
        -- DiagnosticSignInfo = {},
        -- DiagnosticSignHint = {},

        --   -- Tree-Sitter groups are defined with an "@" symbol, which must be
        --   -- specially handled to be valid lua code, we do this via the special
        --   -- sym function. The following are all valid ways to call the sym function,
        --   -- for more details see https://www.lua.org/pil/5.html
        --   --
        --   -- sym("@text.literal")
        --   -- sym('@text.literal')
        --   -- sym"@text.literal"
        --   -- sym'@text.literal'
        --   --
        --   -- For more information see https://github.com/rktjmp/lush.nvim/issues/109
        --
        --   ['@text'] = { fg = c.mainText },
        --   ['@texc.literal'] = { link = 'Property' },
        --   -- ["@texc.reference"] = {},
        --   ['@texc.strong'] = { link = 'Bold' },
        --   ['@texc.italic'] = { link = 'Italic' },
        --   ['@texc.title'] = { link = 'Keyword' },
        --   ['@texc.uri'] = {
        --     fg = c.syntaxFunction,
        --     sp = c.syntaxFunction,
        --     underline = true,
        --   },
        --   ['@texc.underline'] = { link = 'Underlined' },
        --   ['@symbol'] = { fg = c.syntaxOperator },
        --   ['@texc.todo'] = { link = 'Todo' },
        --   ['@comment'] = { link = 'Comment' },
        --   ['@punctuation'] = { link = 'Punctuation' },
        --   ['@punctuation.bracket'] = { fg = c.warningEmphasis },
        --   ['@punctuation.delimiter'] = { fg = c.syntaxError },
        --   ['@punctuation.terminator.statement'] = { link = 'Delimiter' },
        --   ['@punctuation.special'] = { fg = c.syntaxError },
        --   ['@punctuation.separator.keyvalue'] = { fg = c.syntaxError },
        --
        --   ['@texc.diff.add'] = { fg = c.successText },
        --   ['@texc.diff.delete'] = { fg = c.errorText },
        --
        --   ['@constant'] = { link = 'Constant' },
        --   ['@constant.builtin'] = { fg = c.syntaxFunction },
        --   ['@constanc.builtin'] = { link = 'Keyword' },
        --   -- ["@constanc.macro"] = {},
        --   -- ["@define"] = {},
        --   -- ["@macro"] = {},
        --   ['@string'] = { link = 'String' },
        --   ['@string.escape'] = { fg = utils.shade(c.stringText, 0.45) },
        --   ['@string.special'] = { fg = utils.shade(c.syntaxFunction, 0.45) },
        --   -- ["@character"] = {},
        --   -- ["@character.special"] = {},
        --   ['@number'] = { link = 'Number' },
        --   ['@boolean'] = { link = 'Boolean' },
        --   -- ["@float"] = {},
        --   ['@function'] = {
        --     link = 'Function',
        --     italic = config.italics.functions or false,
        --   },
        --   ['@function.call'] = { link = 'Function' },
        --   ['@function.builtin'] = { link = 'Function' },
        --   -- ["@function.macro"] = {},
        --   ['@parameter'] = { link = 'Parameter' },
        --   ['@method'] = { link = 'Function' },
        --   ['@field'] = { link = 'Property' },
        --   ['@property'] = { link = 'Property' },
        --   ['@constructor'] = { fg = c.syntaxFunction },
        --   -- ["@conditional"] = {},
        --   -- ["@repeat"] = {},
        --   ['@label'] = { link = 'Label' },
        --   ['@operator'] = { link = 'Operator' },
        --   ['@exception'] = { link = 'Exception' },
        -- ['@variable'] = {
        --     fg = c.mainText,
        --     -- italic = config.italics.variables or false,
        -- },
        --   ['@variable.builtin'] = { fg = c.syntaxFunction },
        ['@variable.member'] = { fg = c.indigo_900 },
        --   ['@variable.parameter'] = {
        --     fg = c.mainText,
        --     italic = config.italics.variables or false,
        --   },
        --   ['@type'] = { link = 'Type' },
        --   ['@type.definition'] = { fg = c.mainText },
        --   ['@type.builtin'] = { fg = c.syntaxFunction },
        --   ['@type.qualifier'] = { fg = c.syntaxFunction },
        --   ['@keyword'] = { link = 'Keyword' },
        --   -- ["@storageclass"] = {},
        --   -- ["@structure"] = {},
        --   ['@namespace'] = { link = 'Type' },
        --   ['@annotation'] = { link = 'Label' },
        --   -- ["@include"] = {},
        --   -- ["@preproc"] = {},
        --   ['@debug'] = { fg = c.specialKeyword },
        --   ['@tag'] = { link = 'Tag' },
        --   ['@tag.builtin'] = { link = 'Tag' },
        --   ['@tag.delimiter'] = { fg = c.syntaxOperator },
        --   ['@tag.attribute'] = { fg = c.syntaxKeyword },
        --   ['@tag.jsx.element'] = { fg = c.syntaxFunction },
        --   ['@attribute'] = { fg = c.syntaxKeyword },
        --   ['@error'] = { link = 'Error' },
        --   ['@warning'] = { link = 'WarningMsg' },
        --   ['@info'] = { fg = c.syntaxFunction },
        --
        --   -- Specific languages
        --   -- overrides
        --   ['@label.json'] = { fg = c.property }, -- For json
        --   ['@label.help'] = { link = '@texc.uri' }, -- For help files
        --   ['@texc.uri.html'] = { underline = true }, -- For html
        --
        --   -- semantic highlighting
        --   ['@lsp.type.namespace'] = { link = '@namespace' },
        --   ['@lsp.type.type'] = { link = '@type' },
        --   ['@lsp.type.class'] = { link = '@type' },
        --   ['@lsp.type.enum'] = { link = '@type' },
        --   ['@lsp.type.enumMember'] = { fg = c.syntaxFunction },
        --   ['@lsp.type.interface'] = { link = '@type' },
        --   ['@lsp.type.struct'] = { link = '@type' },
        --   ['@lsp.type.parameter'] = { link = '@parameter' },
        --   ['@lsp.type.property'] = { link = '@text' },
        --   ['@lsp.type.function'] = { link = '@function' },
        --   ['@lsp.type.method'] = { link = '@method' },
        --   ['@lsp.type.macro'] = { link = '@label' },
        --   ['@lsp.type.decorator'] = { link = '@label' },
        --   ['@lsp.typemod.function.declaration'] = { link = '@function' },
        --   ['@lsp.typemod.function.readonly'] = { link = '@function' },

        SnacksPickerToggle = { fg = c.blue, bg = c.indigo_100 },
    }

    -- overrides
    groups = vim.tbl_extend(
        'force',
        groups,
        type(config.overrides) == 'function' and config.overrides.overrides()
        or config.overrides
    )

    for group, parameters in pairs(groups) do
        vim.api.nvim_set_hl(0, group, parameters)
    end
end

function theme.setup(values)
    setmetatable(
        config,
        { __index = vim.tbl_extend('force', config.defaults, values) }
    )
end

function theme.colorscheme()
    if vim.version().minor < 8 then
        vim.notify(
            'Neovim 0.8+ is required for my-theme colorscheme',
            vim.log.levels.ERROR,
            { title = 'Min Theme' }
        )
        return
    end

    vim.api.nvim_command 'hi clear'
    if vim.fn.exists 'syntax_on' then
        vim.api.nvim_command 'syntax reset'
    end

    vim.g.VM_theme_set_by_colorscheme = true
    vim.o.termguicolors = true
    vim.g.colors_name = 'penumbra'

    set_terminal_colors()
    set_groups()
end

return theme
