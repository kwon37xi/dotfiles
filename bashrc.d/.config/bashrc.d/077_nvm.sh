export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# directory 진입/탈출시 자동으로 .nvmrc 인식하고 반응
# https://weston.ruter.net/2022/05/19/auto-nvm-use/
# nvm_find_up 은 nvm 자체에 내장된 shellscript 함수이다.
autonvm() {
	nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

	# If there are no .nvmrc file, use the default nvm version
	if [[ ! $nvm_path = *[^[:space:]]* ]]; then

		if [[ -z $nvm_default_version ]]; then
			nvm_default_version=$(nvm version default);
		fi

		# If there is no default version, set it to `node`
		# This will use the latest version on your machine
		if [[ $nvm_default_version == "N/A" ]]; then
			nvm alias default node;
			nvm_default_version=$(nvm version default);
		fi

		# If the current version is not the default version, set it to use the default version
		if [[ $(nvm current) != $nvm_default_version ]]; then
			nvm use default;
		fi

	elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
		nvm_version=$(<"$nvm_path"/.nvmrc)

		# `nvm ls` will check all locally-available versions
		# If there are multiple matching versions, take the latest one
		# Remove the `->` and `*` characters and spaces
		# `nvm_local_version` will be `N/A` if no local versions are found
		if [[ -z $nvm_local_version ]]; then
			nvm_local_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')
		fi

		# If it is not already installed, install it
		# `nvm install` will implicitly use the newly-installed version
		if [[ "$nvm_local_version" == "N/A" ]]; then
			nvm install "$nvm_version";
		elif [[ $(nvm current) != "$nvm_local_version" ]]; then
			nvm use "$nvm_version";
		fi
	fi
}
export PROMPT_COMMAND="$PROMPT_COMMAND; autonvm"
