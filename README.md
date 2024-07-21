# Vim espeak

A simple wrapper over the espeak text-to-speech system.<br> 
Espeak sounds robotic, for a more natural sounding tts, use [vim-piper](https://github.com/wolandark/vim-piper)

## Introduction

Vim espeak is a Vim plugin that integrates the espeak text-to-speech system into Vim. It allows you to easily convert text within Vim to speech using espeak.

## Dependency 
This plugin depends on the following:
- espeak
- Vim or Neovim

# Getting espeak
```
pacman -S espeak espeak-ng
apt install espeak espeak-ng
etc ...
```

# Installation

## Using vim-plug

Add the following to your `~/.vimrc` or `~/.config/nvim/init.vim`:

```vim
Plug 'wolandark/vim-espeak'
```

Then run `:PlugInstall` in Vim.

# Configuration

You can configure the following variable in your ~/.vimrc.

```vim
let g:espeak = 'espeak command to use'
```
default is:
```
let g:espeak = 'espeak -v en'
```
# Functions
The plugin provides the following functions:

   - PassVisualSelection(): Utility function to get the visual selection.
   - SpeakWord(): Speak the word under the cursor.
   - SpeakCurrentLine(): Speak the current line.
   - SpeakCurrentParagraph(): Speak the current paragraph.
   - SpeakVisualSelection(): Speak the visual selection.
   - SpeakCurrentFile(): Speak the current file.

# Mappings
The following mappings are defined by default:

- nnoremap <Leader>tw :call SpeakWord()<CR>
- nnoremap <Leader>tc :call SpeakCurrentLine()<CR>
- nnoremap <Leader>tp :call SpeakCurrentParagraph()<CR>
- nnoremap <Leader>tf :call SpeakCurrentFile()<CR>
- vnoremap <Leader>tv :call SpeakVisualSelection()<CR>

# License
Same as Vim.

# Enjoy!
