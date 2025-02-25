extends RichTextLabel

@export var console_size: Vector2 = Vector2(100,30)
@export var USER_Name:String = "@USER"
@export var ShowTextArt:bool = true
@export var CanInput:bool = false

var commands:Dictionary = {}

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
var TextArtThin:Array[String] = [
	"┎┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┒",
	"┇                 ████████       ┇",
	"┇          ▓▓▓▓▓▓▓▓      ██      ┇",
	"┇   ▒▒▒▒▒▒▒▒        ████████     ┇",
	"┇    ▒▒      ▓▓▓▓▓▓▓▓          ██┇",
	"┇     ▒▒▒▒▒▒▒▒               ███ ┇",
	"┇   ░░░▒▒                  ███   ┇",
	"┇ ░░░  ▒▒ ◥██▶   ▬▬▬▬▬ ██████    ┇",
	"┇░░     ▒▒ ◢◤      ▓▓▓▓▓    ██   ┇",
	"┇ ░░       ▒▒▒▒▒▓▓▓          ██  ┇",
	"┇  ░░░░░░▒▒             ████████ ┇",
	"┇        ▒▒      ▓▓▓▓▓▓▓▓        ┇",
	"┇         ▒▒▒▒▒▒▒▒               ┇",
	"┖┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┚"
	]

var CurrentInputString: String = ""
var CurrentInputString_escaped: String = ""
var _current_cursor_pos: int = 0

var _flash: bool = false
var _flash_timer = Timer.new()
var _start_up:int = 0
var _just_enter: bool = false
var _PrefixText: String = ""

var _send_history: Array[String] = []
var _current_history : int = -1
var _last_input: String = ""

func _ready() -> void:
	size = Vector2(console_size.x * 12.5, console_size.y * 23)
	_built_in_command_init()
	add_child(_flash_timer)
	text = ""
	_PrefixText = "[bgcolor=DODGER_BLUE]"+USER_Name+"[/bgcolor][bgcolor=WEB_GRAY][color=DODGER_BLUE]\u25E3[/color]\u2302[/bgcolor][color=WEB_GRAY]\u25B6[/color]"
	_flash_timer.set_one_shot(true)
	_flash_timer.start(1)
	
func _process(delta: float) -> void:
	if _flash_timer.time_left == 0:
		if _start_up == 0 and ShowTextArt:
			# Show Title: The art is 61*12, with border is 63*14
			for i in(console_size.y / 2 + 7):
				if i < console_size.y / 2 - 7:
					newline()
				else:
					push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
					if console_size.x >= 63:
						append_text(TextArt[i-console_size.y / 2 + 7])
					elif console_size.x >= 34:
						append_text(TextArtThin[i-console_size.y / 2 + 7])
					pop()
					newline()
			_start_up += 1
			_flash_timer.start()
		else:
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
				insert_character(event.as_text().to_lower())
			"Shift+A","Shift+B","Shift+C","Shift+D","Shift+E","Shift+F","Shift+G",\
			"Shift+H","Shift+I","Shift+J","Shift+K","Shift+L","Shift+M","Shift+N",\
			"Shift+O","Shift+P","Shift+Q","Shift+R","Shift+S","Shift+T","Shift+U",\
			"Shift+V","Shift+W","Shift+X","Shift+Y","Shift+Z",\
			"Kp 1","Kp 2","Kp 3","Kp 4","Kp 5","Kp 6","Kp 7","Kp 8","Kp 9","Kp 0":
				insert_character(event.as_text()[-1])
			"0","1","2","3","4","5","6","7","8","9":
				insert_character(event.as_text())
			"Space":	insert_character(" ")
			# BBCode
			"BracketLeft":		insert_character("[")
			"BracketRight":		insert_character("]")
			"Slash","Kp Divide":insert_character("/")
			# Other character
			"QuoteLeft":		insert_character("`")
			"Shift+QuoteLeft":	insert_character("~")
			"Shift+1":	insert_character("!")
			"Shift+2":	insert_character("@")
			"Shift+3":	insert_character("#")
			"Shift+4":	insert_character("$")
			"Shift+5":	insert_character("%")
			"Shift+6":	insert_character("^")
			"Shift+7":	insert_character("&")
			"Shift+8","Kp Multiply":	insert_character("*")
			"Shift+9":	insert_character("(")
			"Shift+0":	insert_character(")")
			"Minus","Kp Subtract":	insert_character("-")
			"Shift+Minus":			insert_character("_")
			"Equal":				insert_character("=")
			"Shift+Equal","Kp Add":	insert_character("+")
			"Shift+BracketLeft":	insert_character("{")
			"Shift+BracketRight":	insert_character("}")
			"Backslash":			insert_character("\\")
			"Shift+Backslash":		insert_character("|")
			"Semicolon":			insert_character(";")
			"Shift+Semicolon":		insert_character(":")
			"Apostrophe":			insert_character("'")
			"Shift+Apostrophe":		insert_character("\"")
			"Comma":				insert_character(",")
			"Shift+Comma":			insert_character("<")
			"Period","Kp Period":	insert_character(".")
			"Shift+Period":			insert_character(">")
			"Shift+Slash":			insert_character("?")
			# Special action
			"Backspace","Shift+Backspace":
				if _current_cursor_pos == 0:
					CurrentInputString = CurrentInputString.left(CurrentInputString.length()-1)
				elif _current_cursor_pos > 0 && _current_cursor_pos < CurrentInputString.length():
					CurrentInputString = CurrentInputString.erase(CurrentInputString.length() -_current_cursor_pos - 1)
			"Enter","Kp Enter":
				append_current_input_string(true)
			"Left":
				_flash = true
				if _current_cursor_pos < CurrentInputString.length():
					_current_cursor_pos += 1
			"Right":
				_flash = true
				if _current_cursor_pos > 0:
					_current_cursor_pos -= 1
			"Up":
				append_history()
			"Down":
				append_history(false)
				
			# Unpacthed
			_: print(event.as_text())
		CurrentInputString_escaped = CurrentInputString.replace("[", "[lb]")
		append_current_input_string(false)
		_just_enter = false

func append_current_input_string(enter:bool) -> void:
	if !_just_enter:
		remove_paragraph(get_paragraph_count()-1)
		
	if !enter:
		if _flash:
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			if _current_cursor_pos == 0:
				append_text(_PrefixText + CurrentInputString_escaped + "\u2581")
			elif _current_cursor_pos > 0:
				append_text(_PrefixText + CurrentInputString_escaped.left(-_current_cursor_pos))
				push_bgcolor(Color("WHITE"))
				push_color(Color("BLACK"))
				append_text(CurrentInputString_escaped[-_current_cursor_pos])
				pop()
				pop()
				append_text(CurrentInputString_escaped.right(_current_cursor_pos - 1))
			pop()
		else:
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			if _current_cursor_pos == 0:
				append_text(_PrefixText + CurrentInputString_escaped + " ")
			elif _current_cursor_pos > 0:
				append_text(_PrefixText + CurrentInputString_escaped)
			pop()
	else:
		_current_cursor_pos = 0
		push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
		append_text(_PrefixText + CurrentInputString_escaped)
		pop()
		newline()
		process(CurrentInputString)
		if CurrentInputString != "":
			_send_history.append(CurrentInputString)
		_current_history = -1
		_last_input = ""
		CurrentInputString = ""
		CurrentInputString_escaped = ""
		_just_enter = true

func insert_character(character:String) -> void:
	if _current_cursor_pos == 0:
		CurrentInputString += character
	elif _current_cursor_pos > 0:
		CurrentInputString = CurrentInputString.insert(CurrentInputString.length() -_current_cursor_pos,character)

func append_history(up:bool = true) -> void:
	_current_cursor_pos = 0
	if _current_history == -1:
		_last_input = CurrentInputString
	if _send_history.size() != 0:
		if up:
			if _current_history == -1:
				_current_history = _send_history.size() -1
			elif _current_history != 0:
				_current_history -= 1
		else:
			if _current_history == -1:
				pass
			elif _current_history == _send_history.size() -1:
				_current_history = -1
			elif _current_history < _send_history.size() -1:
				_current_history += 1
	if _send_history.size() != 0 and _current_history != -1 and _current_history <= _send_history.size() -1:
		CurrentInputString = _send_history[_current_history]
	else:
		_current_history = -1
		CurrentInputString = _last_input
	
func process(command):
	if !commands.keys().has(CurrentInputString.get_slice("(",0)):
		push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
		append_text("[color=RED]Command not found:[/color] " + CurrentInputString.get_slice("(",0))
		pop()
		newline()
	else:
		var commandData = commands[CurrentInputString.get_slice("(",0)]
		var argu_in:Array[String] = []
		if CurrentInputString.contains("("):
			argu_in.append_array(CurrentInputString.get_slice("(",1).trim_suffix(")").split(","))
		if commandData.function.get_argument_count() != argu_in.size():
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			append_text("[color=RED]Parameter count mismatch[/color]: expect %s, got %s." \
							% [str(commandData.function.get_argument_count()),argu_in])
			pop()
		else:
			commandData.function.callv(argu_in)
	
func add_command(id:String, function:Callable, functionInstance:Object, helpText:String="", getFunction=null):
	commands[id] = EC_CommandClass.new(id, function, functionInstance, helpText, getFunction)

func _built_in_command_init():
	add_command(
		"help", 
		func():
			for i in commands:
				append_text("<"+i+"> "+commands[i].helpText)
				pop_all()
				newline(),
		self,
		"Show all of the valid command."
	)
	add_command(
		"clear", 
		func():
			clear()
			return,
		self,
		"Clears the console."
	)
	add_command(
		"echo", 
		func(input:String):
			append_text(input)
			pop_all(),
		self,
		"Repeat what you say."
	)
