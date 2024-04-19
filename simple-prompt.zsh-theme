#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg_bold[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%{$reset_color%}"

local WHITE_COLOR="%{$fg[white]%}"
local WHITE_COLOR_BOLD="%{$fg_bold[white]%}"
local RED_COLOR="%{$fg[red]%}"
local RED_COLOR_BOLD="%{$fg_bold[red]%}"
local CYAN_COLOR="%{$fg[cyan]%}"
local GREEN_COLOR="%{$fg[green]%}"
local GREEN_COLOR_BOLD="%{$fg_bold[green]%}"
local MAGENTA_COLOR="%{$fg[magenta]%}"
local YELLOW_COLOR="%{$fg[yellow]%}"
local GREY_COLOR="%{$fg[grey]%}"
local RESET_COLOR="%{$reset_color%}"

local user_host="%B%(!.$RED_COLOR.$GREY_COLOR)%n$RESET_COLOR@$YELLOW_COLOR%m$RESET_COLOR"
local user_symbol="%(!.#.%(?:➜ :$RED_COLOR_BOLD➜ ))"
local current_dir="%B$CYAN_COLOR%~%{$reset_color%}"

PROMPT="╭─${user_host}: ${current_dir} \$vcs_info_msg_0_
╰${user_symbol}"
