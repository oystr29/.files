
get_image() {
  art="$(playerctl metadata mpris:artUrl)"
  echo ${art:7}
}

play_pause() {
  state="$(playerctl -a metadata --format '{\"text\": \"{{playerName}}: {{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F)"
  echo ${state}
}


if [[ "$1" == "--get-image" ]]; then
  get_image
elif [[ "$1" == "--play-pause" ]]; then
	play_pause
fi
