source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

run_segment() {
    echo "$(tmux ls -F "#S#{?session_attached,*,}" | tr "\n" " " | sed "s/ $//" )"
	return 0
}
