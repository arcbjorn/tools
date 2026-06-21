# bash completion for: passcopy <entry> <field>
#
# Native bash completion (source this file in bash). Entry enumeration uses the
# same `compgen -f` technique as the official `pass` bash completion.

# Emit pass-store entry names matching $cur into COMPREPLY.
_passcopy_entries () {
	local prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store/}"
	prefix="${prefix%/}/"
	local IFS=$'\n'
	local items=($(compgen -f "$prefix$cur"))
	local item
	for item in "${items[@]}"; do
		# skip hidden files/dirs (.git, .gpg-id, etc.)
		[[ $item =~ /\.[^/]*$ ]] && continue
		if [[ -d $item ]]; then
			# directory: offer as a path prefix (trailing slash, no space)
			COMPREPLY+=("${item#$prefix}/")
		elif [[ $item =~ \.gpg$ ]]; then
			# leaf entry: strip prefix and .gpg suffix
			item="${item#$prefix}"
			COMPREPLY+=("${item%.gpg}")
		fi
	done
}

# Static field vocabulary. Real per-entry fields can't be read here (decrypting
# during completion can't prompt for a GPG pin); passcopy accepts ANY field.
_passcopy_fields='password login username email user account website street city country ip phone address notes url port host server api key token id pin code ssn license iban swift bic name firstname lastname company otp totp secret recovery card cvv passport'

_passcopy () {
	local cur="${COMP_WORDS[COMP_CWORD]}"
	COMPREPLY=()
	if (( COMP_CWORD == 1 )); then
		_passcopy_entries
	elif (( COMP_CWORD == 2 )); then
		COMPREPLY=($(compgen -W "$_passcopy_fields" -- "$cur"))
	fi
}

# -o nospace so directory prefixes (path/) don't get a trailing space.
complete -o nospace -F _passcopy passcopy
