if command -q mise
	mise activate fish | source
else
	echo "warning: mise not installed"
end
