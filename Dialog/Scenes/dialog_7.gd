extends Node3D

@onready var rich_text_label = $RichTextLabel
@onready var timer = $Timer

# Variabel daftar dialog
var dialog_queue: Array = [
	{"name": "Charles", "dialog": "Astaga... Aku tidak sangka dalamnya seperti ini. Lebih seram daripada yang aku bayangkan. Ucok, kita harus cepat-cepat cari petunjuk dan keluar dari sini."},
]

var current_name: String = ""
var current_dialog: String = ""
var display_text: String = ""  # Teks yang muncul satu per satu
var char_index: int = 0  # Indeks untuk huruf
var dialog_index: int = 0  # Indeks untuk antrean dialog
var char_interval: float = 0.03

func _ready():
	var start = get_node("/root/Main Scene/Story/Quests/Cabin/Inside_cabin")
	start.connect("display7", Callable(self, "_on_display7"))
	
func _on_display7():
	rich_text_label.visible = true
	timer.wait_time = char_interval
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	_load_next_dialog()

func _load_next_dialog():
	# Pastikan ada dialog di antrean
	if dialog_index < dialog_queue.size():
		# Ambil nama dan dialog berikutnya
		var entry = dialog_queue[dialog_index]
		current_name = entry["name"]
		current_dialog = entry["dialog"]
		display_text = ""
		char_index = 0

		rich_text_label.bbcode_enabled = true
		rich_text_label.text = "[b]" + current_name + ": [/b]"

		# Perbarui indeks antrean
		dialog_index += 1
		timer.start()  # Mulai menampilkan dialog baru
	else:
		print("All dialogs displayed.")
		timer.stop()

func _on_timer_timeout():
	if char_index < current_dialog.length():
		display_text += current_dialog[char_index]
		rich_text_label.text = "[b]" + current_name + ": [/b]" + display_text
		char_index += 1
	else:
		timer.stop()
		_load_next_dialog()
