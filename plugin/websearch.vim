" Prevent plugin from running twice
if exists('g:loaded_websearch')
    finish
endif
let g:loaded_websearch = 1

" From plasticboy/vim-markdown:ftplugin/markdown.vim
function! s:VersionAwareNetrwBrowseX(url)
    if has('patch-7.4.567')
        call netrw#BrowseX(a:url, 0)
    else
        call netrw#NetrwBrowseX(a:url, 0)
    endif
endf

function! WebSearch(type, searchterm="empty")
    " Set searchterm
    if a:searchterm == "empty"
        let searchterm = getreg("a")
    else
        let searchterm = a:searchterm
    endif

    " Case
    if a:type == "open"
        let prefix = ""
    elseif a:type == "lucky"
        let prefix = "https://duckduckgo.com/?q=\\!ducky+"
    elseif a:type == "google"
        let prefix = "http://google.com/search?q="
    elseif a:type == "unicode"
        let prefix = "http://google.com/search?q=unicode+"
    elseif a:type == "thes"
        let prefix = "https://www.thesaurus.com/browse/"
    endif
    call s:VersionAwareNetrwBrowseX(prefix . searchterm)
endfunction


""""""""""""""
"  Mappings  "
""""""""""""""
" Google
nnoremap <leader>wg viw"ay:call WebSearch("google")<CR>
nnoremap <leader>Wg viW"ay:call WebSearch("google")<CR>
vnoremap <leader>wg    "ay:call WebSearch("google")<CR>
" Lucky
nnoremap <leader>w1 viw"ay:call WebSearch("lucky")<CR>
nnoremap <leader>W1 viW"ay:call WebSearch("lucky")<CR>
vnoremap <leader>w1    "ay:call WebSearch("lucky")<CR>
" Thesaurus
nnoremap <leader>wt viw"ay:call WebSearch("thes")<CR>
nnoremap <leader>Wt viW"ay:call WebSearch("thes")<CR>
vnoremap <leader>wt    "ay:call WebSearch("thes")<CR>
" Unicode
command! -nargs=* Uni call WebSearch("unicode", <q-args>)
" Browse math/alpha: https://www.compart.com/en/unicode/block/U+1D400

lua << EOF
  local ok, wk = pcall(require, 'which-key')
  if ok then
    wk.add({
    {'<leader>wg', icon=""},
    {'<leader>w1', icon="󰼏"},
    {'<leader>wt', icon=""},
    {'<leader>Wg', icon=""},
    {'<leader>W1', icon="󰼏"},
    {'<leader>Wt', icon=""},
    })
  end
EOF
