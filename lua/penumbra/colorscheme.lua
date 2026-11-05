local M

if vim.o.background == 'dark' then
    M = {
        -- https://www.inclusivecolors.com/?style_dictionary=eyJjb2xvciI6eyJiYXNlIjp7ImluZGlnbyI6eyI1MCI6eyJ2YWx1ZSI6IiMxNjE3MWQiLCJsb2NrZWQiOnRydWV9LCIxMDAiOnsidmFsdWUiOiIjMjAyMTJkIiwibG9ja2VkIjp0cnVlfSwiMjAwIjp7InZhbHVlIjoiIzJiMmQzZiIsImxvY2tlZCI6dHJ1ZX0sIjMwMCI6eyJ2YWx1ZSI6IiMzZDQyNmEiLCJsb2NrZWQiOnRydWV9LCI0MDAiOnsidmFsdWUiOiIjNTE1NzkzIiwibG9ja2VkIjp0cnVlfSwiNTAwIjp7InZhbHVlIjoiIzZlNzRjNiIsImxvY2tlZCI6dHJ1ZX0sIjYwMCI6eyJ2YWx1ZSI6IiM4NzhhZDgiLCJsb2NrZWQiOnRydWV9LCI3MDAiOnsidmFsdWUiOiIjYTZhOGU4IiwibG9ja2VkIjp0cnVlfSwiODAwIjp7InZhbHVlIjoiI2MxYzFmMSIsImxvY2tlZCI6dHJ1ZX0sIjkwMCI6eyJ2YWx1ZSI6IiNkOWQ4ZjMiLCJsb2NrZWQiOnRydWV9LCI5NTAiOnsidmFsdWUiOiIjZjFlZmY3IiwibG9ja2VkIjp0cnVlfX19fX0%253D
        indigo_950 = '#f1eff7',
        indigo_900 = '#d9d8f3',
        indigo_800 = '#c1c1f1',
        indigo_700 = '#a6a8e8',
        indigo_600 = '#878ad8',
        indigo_500 = '#6e74c6',
        indigo_400 = '#515793',
        indigo_300 = '#3d426a',
        indigo_200 = '#2b2d3f',
        indigo_100 = '#20212d',
        indigo_50  = '#16171d',

        yellow = '#fef9c3',
        yellow_bg = '#292108',
        red = '#f5d8d9',
        red_bg = '#2d1e1e',
        blue = '#c7ddf3',
        blue_bg = '#1f2226',
        green = '#bbf7d0',
        green_bg = '#1f231e',
    }
else
    M = {
        -- indigo_50 = '#f1eff7',
        indigo_50 = '#d9d8f3',
        indigo_100 = '#c1c1f1',
        indigo_200 = '#a6a8e8',
        indigo_300 = '#878ad8',
        indigo_600 = '#6e74c6',
        indigo_700 = '#515793',
        indigo_800 = '#3d426a',
        indigo_900 = '#2b2d3f',
        indigo_950 = '#20212d',
        -- indigo_950  = '#16171d',

        yellow_bg = '#fef9c3',
        yellow = '#605434',
        red_bg = '#f5d8d9',
        red = '#693638',
        blue_bg = '#c7ddf3',
        blue = '#1f2226',
        green_bg = '#bbf7d0',
        green = '#4d6246',
    }
end

M.fg = M.indigo_950
M.bg = M.indigo_50

return M
