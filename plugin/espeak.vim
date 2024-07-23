" _____________________________________________________________
"/\                                                            \
"\_|        _                                            _     |
"  | __   _(_)_ __ ___         ___  ___ _ __   ___  __ _| | __ |
"  | \ \ / / | '_ ` _ \ _____ / _ \/ __| '_ \ / _ \/ _` | |/ / |
"  |  \ V /| | | | | | |_____|  __/\__ \ |_) |  __/ (_| |   <  |
"  |   \_/ |_|_| |_| |_|      \___||___/ .__/ \___|\__,_|_|\_\ |
"  |                                   |_|                     |
"  |                                                           |
"  |   ________________________________________________________|_
"   \_/__________________________________________________________/
"
" A simple wrapper over espeak text to speech system.
"
" Copyright © 2024 wolandark
"
" plugin home: https://github.com/wolandark/vim-espeak
"
"┌─────────┐
"│Load Once│
"└─────────┘
if exists("g:loaded_espeak")
	finish
endif
let g:loaded_espeak = 1

"┌──────────┐
"│Check vars│
"└──────────┘
if !exists('g:espeak')
	let g:espeak = 'espeak -v en'
endif

"┌────────────────────────────────────────────┐
"│Utility Function To Get The Visual Selection│
"└────────────────────────────────────────────┘
function! PassVisualSelection()
	let start = getpos("'<")
	let end = getpos("'>")
	let lines = getline(start[1], end[1])
	let lines[-1] = lines[-1][ : end[2] - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][start[2] - 1 : ]
	let g:selection = join(lines, ' ')
	return g:selection
endfunction

"┌───────────────────────────┐
"│Speak Word Under The Cursor│
"└───────────────────────────┘
function! SpeakWord()
	let word_under_cursor = expand('<cword>')
	let escaped_word = shellescape(word_under_cursor) 
	let command = 'echo '. escaped_word .' | '. g:espeak .' '
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current Line│
"└──────────────────┘
function! SpeakCurrentLine()
	normal! "ayy
	let line_text = join(split(@a, "\n"), " ")
	let escaped_line = shellescape(line_text)
	let command = 'echo '. escaped_line .' | '. g:espeak .' '
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌───────────────────────┐
"│Speak Current Paragraph│
"└───────────────────────┘
function! SpeakCurrentParagraph()
	normal! vap"ay
	let paragraph_text = join(split(@a, "\n"), " ")
	let escaped_paragraph = shellescape(paragraph_text)
    let command = 'echo ' . escaped_paragraph . ' | ' . g:espeak . ' '
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌──────────────────────┐
"│Speak Visual Selection│
"└──────────────────────┘
function! SpeakVisualSelection()
	let g:selection = ''
	call PassVisualSelection()
    let escaped_selection = shellescape(g:selection)
    let command = 'echo ' . escaped_selection . ' | ' . g:espeak . ' '
    call system(command)
	set lazyredraw
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current File│
"└──────────────────┘
function! SpeakCurrentFile()
	execute "%y a"
	let paragraph_text = join(split(@a, "\n"), " ")
	let escaped_file = shellescape(paragraph_text) 
	let command = 'echo ' . escaped_file . ' | '. g:espeak .' '
	call system(command)
	set lazyredraw
	redraw!
endfunction

"┌─────────────────┐
"│Map the functions│
"└─────────────────┘
nnoremap <Leader>tw :call SpeakWord()<CR>
nnoremap <Leader>tc :call SpeakCurrentLine()<CR>
nnoremap <Leader>tp :call SpeakCurrentParagraph()<CR>
nnoremap <Leader>tf :call SpeakCurrentFile()<CR>
vnoremap <Leader>tv :<C-U>call SpeakVisualSelection()<CR>
