# zsh-only completion bootstrap (sourced from shell/rc under ZSH_VERSION).
# Kept in its own file so bash never has to parse zsh-specific syntax.

# Directory holding our _* completion functions (this file's dir), captured now
# because $0 won't point here once we're inside the deferred hook.
typeset -g _TOOLS_COMP_DIR="${0:A:h}"

# Put our completions on fpath so zsh can autoload the _* functions.
fpath=("$_TOOLS_COMP_DIR" $fpath)

# Register our completions. This MUST run after the final `compinit`: if the
# user's ~/.zshrc runs `compinit` *after* sourcing shell/rc, a compdef done at
# source time gets wiped. So defer registration to the first prompt (precmd),
# by which point compinit has definitely run. The hook self-removes after one run.
_tools_compinit_hook() {
  (( $+functions[compdef] )) || { autoload -Uz compinit && compinit -C; }
  local _c _n
  for _c in "$_TOOLS_COMP_DIR"/_*(N); do
    _n="${_c:t}"
    autoload -Uz "$_n"
    compdef "$_n" "${_n#_}" 2>/dev/null
  done
  precmd_functions=(${precmd_functions:#_tools_compinit_hook})
  unset -f _tools_compinit_hook
}
typeset -ga precmd_functions
precmd_functions+=(_tools_compinit_hook)
