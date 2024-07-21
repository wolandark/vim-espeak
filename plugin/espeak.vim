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
	let g:selection = join(lines)
	return g:selection
endfunction

"┌───────────────────────────┐
"│Speak Word Under The Cursor│
"└───────────────────────────┘
function! SpeakWord()
	let word_under_cursor = expand('<cword>')
	call system('echo "' . shellescape(word_under_cursor) . '" | ' . g:espeak)
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current Line│
"└──────────────────┘
function! SpeakCurrentLine()
	" Yank the current line to the 'a' register
	normal! "ayy
	" Execute the espeak command using the contents of the 'a' register
	call system('echo "' . shellescape(@a) . '" | ' . g:espeak)
	" Redraw the screen to clean up
	redraw!
endfunction

"┌───────────────────────┐
"│Speak Current Paragraph│
"└───────────────────────┘
function! SpeakCurrentParagraph()
	" Yank the current paragraph to the 'a' register
	normal! vap"ay
	" Get the contents of register 'a', split by newlines, and join into a single line
	let paragraph_text = join(split(@a, "\n"), " ")
	" Execute the espeak command using the contents of the paragraph
	call system('echo ' . shellescape(paragraph_text) . ' | ' . g:espeak)
	" Redraw the screen to clean up
	redraw!
endfunction

"┌──────────────────────┐
"│Speak Visual Selection│
"└──────────────────────┘
function! SpeakVisualSelection()
	let g:selection = ''
	call PassVisualSelection()
	" Execute the espeak command using the visual selection
	call system('echo "' . shellescape(g:selection) . '" | ' . g:espeak)
	" Redraw the screen to clean up
	redraw!
endfunction

"┌──────────────────┐
"│Speak Current File│
"└──────────────────┘
function! SpeakCurrentFile()
	" Yank the current file to the 'a' register
	execute "%y a"
	" Get the contents of register 'a', split by newlines, and join into a single line
	let paragraph_text = join(split(@a, "\n"), " ")
	" Execute the espeak command using the contents of the file
	call system('echo ' . shellescape(paragraph_text) . ' | ' . g:espeak)
	" Redraw the screen to clean up
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

