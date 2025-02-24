extends RichTextLabel

@export var console_size: Vector2 = Vector2(100,30)
@export var USER_Name:String = "@USER"
@export var CanInput:bool = false

var TextArt:Array[String] = [
	"┎┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┒",
	"┇                 ████████        ███◤                        ┇",
	"┇          ▓▓▓▓▓▓▓▓      ██       █                           ┇",
	"┇   ▒▒▒▒▒▒▒▒        ████████      ██◤  ◢██ ◢██ ◢██ ██◣ ◢██ ◢██┇",
	"┇    ▒▒      ▓▓▓▓▓▓▓▓          ██ █    ◥█◣ ◥█◣ █ ◤ █ █ █   █ ◤┇",
	"┇     ▒▒▒▒▒▒▒▒               ███  ███◤ ██◤ ██◤ ███ █ █ ██◤ ███┇",
	"┇   ░░░▒▒                  ███                                ┇",
	"┇ ░░░  ▒▒ ◥██▶   ▬▬▬▬▬ ██████                                 ┇",
	"┇░░     ▒▒ ◢◤      ▓▓▓▓▓    ██    ◢███                  █     ┇",
	"┇ ░░       ▒▒▒▒▒▓▓▓          ██   █                     █     ┇",
	"┇  ░░░░░░▒▒             ████████  █    ◢██ ██◣ ◢██ ◢██  █  ◢██┇",
	"┇        ▒▒      ▓▓▓▓▓▓▓▓         █    █ █ █ █ ◥█◣ █ █  █  █ ◤┇",
	"┇         ▒▒▒▒▒▒▒▒                ███◤ ██◤ █ █ ██◤ ██◤  █◤ ███┇",
	"┖┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┚"
	]

var _console_lines: Array[String] = []

var CurrentInputString: String = ""

var _flash: bool = false
var _flash_timer = Timer.new()
var _start_up:int = 0
var _just_enter: bool = false
var _PrefixText: String = ""

func _ready() -> void:
	size = Vector2(console_size.x * 12.5, console_size.y * 23)
	add_child(_flash_timer)
	_PrefixText = "[bgcolor=DODGER_BLUE]"+USER_Name+"[/bgcolor][bgcolor=#7f7f7f][color=DODGER_BLUE]\u25E3[/color]\u2302[/bgcolor][color=#7f7f7f]\u25B6[/color]"
	_flash_timer.set_one_shot(true)
	_flash_timer.start(1)
	
func _process(delta: float) -> void:
	if _flash_timer.time_left == 0:
		if _start_up == 0:
			text = ""
			# Show Title: The art is 61*12, with border is 63*14
			for i in(console_size.y / 2 + 7):
				if i < console_size.y / 2 - 7:
					newline()
				else:
					push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
					append_text(TextArt[i-console_size.y / 2 + 7])
					pop()
					newline()
			_start_up += 1
			_flash_timer.start()
		elif _start_up == 1:
			_flash = !_flash
			if !CanInput:
				clear()
				CanInput = true
			append_current_input_string(false)
			_flash_timer.start()
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_pressed() and CanInput:
		match event.as_text():
			# Main character
			"A","B","C","D","E","F","G",\
			"H","I","J","K","L","M","N",\
			"O","P","Q","R","S","T","U",\
			"V","W","X","Y","Z":
				CurrentInputString += event.as_text().to_lower()
			"Shift+A","Shift+B","Shift+C","Shift+D","Shift+E","Shift+F","Shift+G",\
			"Shift+H","Shift+I","Shift+J","Shift+K","Shift+L","Shift+M","Shift+N",\
			"Shift+O","Shift+P","Shift+Q","Shift+R","Shift+S","Shift+T","Shift+U",\
			"Shift+V","Shift+W","Shift+X","Shift+Y","Shift+Z":
				CurrentInputString += event.as_text()[-1]
			"0","1","2","3","4","5","6","7","8","9":
				CurrentInputString += event.as_text()
			"Space":	CurrentInputString += " "
			# BBCode
			"BracketLeft":	CurrentInputString += "["
			"BracketRight":	CurrentInputString += "]"
			"Slash":		CurrentInputString += "/"
			# Other character
			"QuoteLeft":		CurrentInputString += "`"
			"Shift+QuoteLeft":	CurrentInputString += "~"
			"Shift+1":	CurrentInputString += "!"
			"Shift+2":	CurrentInputString += "@"
			"Shift+3":	CurrentInputString += "#"
			"Shift+4":	CurrentInputString += "$"
			"Shift+5":	CurrentInputString += "%"
			"Shift+6":	CurrentInputString += "^"
			"Shift+7":	CurrentInputString += "&"
			"Shift+8":	CurrentInputString += "*"
			"Shift+9":	CurrentInputString += "("
			"Shift+0":	CurrentInputString += ")"
			"Minus":	CurrentInputString += "-"
			"Shift+Minus":			CurrentInputString += "_"
			"Equal":				CurrentInputString += "="
			"Shift+Equal":			CurrentInputString += "+"
			"Shift+BracketLeft":	CurrentInputString += "{"
			"Shift+BracketRight":	CurrentInputString += "}"
			"Backslash":			CurrentInputString += "\\"
			"Shift+Backslash":		CurrentInputString += "|"
			"Semicolon":			CurrentInputString += ";"
			"Shift+Semicolon":		CurrentInputString += ":"
			"Apostrophe":			CurrentInputString += "'"
			"Shift+Apostrophe":		CurrentInputString += "\""
			"Comma":				CurrentInputString += ","
			"Shift+Comma":			CurrentInputString += "<"
			"Period":				CurrentInputString += "."
			"Shift+Period":			CurrentInputString += ">"
			"Shift+Slash":			CurrentInputString += "?"
			# Special action
			"Backspace","Shift+Backspace":
				CurrentInputString = CurrentInputString.left(CurrentInputString.length()-1)
			"Enter":
				append_current_input_string(true)
				#_PrefixText = "\u2590[bgcolor=DODGER_BLUE]"+USER_Name+"[/bgcolor][bgcolor=#7f7f7f][color=DODGER_BLUE]\u25E3[/color]\u2302[/bgcolor][color=#7f7f7f]\u25B6[/color]"

			# Unpacthed
			_: print(event.as_text())
		append_current_input_string(false)
		_just_enter = false

func append_current_input_string(enter:bool) -> void:
	if !_just_enter:
		remove_paragraph(get_paragraph_count()-1)
		
	if !enter:
		if _flash:
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			append_text(_PrefixText + CurrentInputString.replace("[", "[lb]")+"\u2581")
			pop()
		else:
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			append_text(_PrefixText + CurrentInputString.replace("[", "[lb]")+" ")
			pop()
	else:
		push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
		append_text(_PrefixText + CurrentInputString)
		pop()
		newline()
		CurrentInputString = ""
		_just_enter = true
