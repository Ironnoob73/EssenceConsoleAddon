extends RichTextLabel

@export var console_size: Vector2 = Vector2(100,30)
@export var USER_Name:String = "@USER"
@export var ShowTextArt:bool = true
@export var CanInput:bool = false

@export var commands:Dictionary = {}
@export var fileDirectory:Dictionary = {"home":{},"config":{}}
var current_path:String = "/home"

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

var _current_line:int = 0

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
	_PrefixText = "[bgcolor=DODGER_BLUE]" + USER_Name + "[/bgcolor][bgcolor=WEB_GRAY][color=DODGER_BLUE]\u25E3[/color]"\
		+ return_path_string(current_path) +"[/bgcolor][color=WEB_GRAY]\u25B6[/color]"
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
			"Space","Shift_Space":	insert_character(" ")
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
			"BackSlash":			insert_character("\\")
			"Shift+BackSlash":		insert_character("|")
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
			"PageUp":
				scroll_page(false)
			"PageDown":
				scroll_page()
				
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
		if current_path == "":
			current_path = "/"
		_PrefixText = "[bgcolor=DODGER_BLUE]" + USER_Name + "[/bgcolor][bgcolor=WEB_GRAY][color=DODGER_BLUE]\u25E3[/color]"\
			+ return_path_string(current_path) +"[/bgcolor][color=WEB_GRAY]\u25B6[/color]"
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

func scroll_page(down:bool = true) -> void:
	if down:
		if _current_line > 0:
			_current_line -= 1
	elif _current_line < get_line_count() - console_size.y:
		_current_line += 1
	scroll_to_line(get_line_count() - console_size.y - _current_line)

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
	command = command.replace("\\,", "[comma]")
	command = command.replace("\\(", "[lp]")
	command = command.replace("\\)", "[rp]")
	if !commands.keys().has(command.get_slice("(",0)):
		push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
		append_text("[color=RED]Command not found:[/color] " + command.get_slice("(",0))
		pop()
		newline()
	else:
		var commandData = commands[command.get_slice("(",0)]
		var argu_in:Array[String] = []
		var argu_in_unesc:Array[String] = []
		if command.contains("("):
			argu_in.append_array(command.trim_prefix(command.get_slice("(",0)+"(").trim_suffix(")").split(","))
			for i in argu_in:
				i=i.replace("[comma]", ",")
				i=i.replace("[lp]", "(")
				i=i.replace("[rp]", ")")
				argu_in_unesc.append(i)
		if commandData.function.get_argument_count() != argu_in.size():
			push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
			append_text("[color=RED]Parameter count mismatch:[/color] expect %s, got %s." \
							% [str(commandData.function.get_argument_count()),argu_in_unesc])
			pop()
		else:
			commandData.function.callv(argu_in_unesc)
	
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
	
	# File system
	add_command(
		"currentDir",
		func():
			var path_instance = get_path_instance(current_path)
			if path_instance.has(null):
				pass
			else:
				append_text(path_instance.get(null))
				current_path = "/home"
			pop_all(),
		self,
		"Display current directory."
	)
	add_command(
		"dir",
		func():
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				for i in path_instance:
					var icon = "?"
					if path_instance[i] == null:
						icon = "\u2613"
					if path_instance[i] is String:
						icon = "\U01F4C4"
					elif path_instance[i] is Dictionary:
						if path_instance[i].is_empty():
							icon = "\U01F4C2"
						else:
							icon = "\U01F4C1"
					elif path_instance[i] is Object:
						match path_instance[i].get_class():
							"GDScript":
								icon = "\U01F4C3"
							_:
								icon = "\U01F4E6"
					if i is String:
						if i.is_valid_filename():
							append_text(icon + i)
						else:
							append_text("[color=RED]" + icon + i + "[/color]")
					else:
						append_text("[color=RED]" + icon + str(i) + "[/color]")
					pop_all()
					newline()
			else:
				append_text(path_instance.get(null))
				current_path = "/home"
			pop_all(),
		self,
		"List the directories and files in the current directory."
	)
	add_command(
		"changeDir",
		func(path:String):
			if !get_path_instance(path,true).has(null):
				pass
			else:
				append_text(get_path_instance(path).get(null))
			pop_all(),
		self,
		"Change the path to the corresponding directory."
	)
	add_command(
		"makeDir",
		func(folder_name:String):
			if folder_name.is_valid_filename():
				var path_instance = get_path_instance(current_path)
				if !path_instance.has(null):
					if !path_instance.has(folder_name):
						path_instance.get_or_add(folder_name,{})
					else:
						append_text("[i]" + folder_name + "[/i] is already exist.")
				else:
					append_text(path_instance.get(null))
			else:
				append_text("[color=RED]Invalid folder name:[/color][i]" + folder_name + "[/i], The file name cannot contain any of the following characters: [b]:/\\?*|%<>[/b]")
			pop_all(),
		self,
		"Create a directory."
	)
	add_command(
		"makeFile",
		func(file_name:String):
			if file_name.is_valid_filename():
				var path_instance = get_path_instance(current_path)
				if !path_instance.has(null):
					if !path_instance.has(file_name):
						path_instance.get_or_add(file_name,"")
					else:
						append_text("[i]" + file_name + "[/i] is already exist.")
				else:
					append_text(path_instance.get(null))
			else:
				append_text("[color=RED]Invalid file name:[/color][i]" + file_name + "[/i], The file name cannot contain any of the following characters: [b]:/\\?*|%<>[/b]")
			pop_all(),
		self,
		"Create a file."
	)
	add_command(
		"remove",
		func(file_name:String):
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					path_instance.erase(file_name)
				else:
					append_text("[i]" + file_name + "[/i] does not exist.")
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		"Remove a file or directory."
	)
	add_command(
		"rename",
		func(file_name:String,to_name:String):
			var path_instance = get_path_instance(current_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					if to_name.is_valid_filename():
						if !path_instance.has(to_name):
							path_instance.get_or_add(to_name,path_instance.get(file_name).duplicate(true))
							path_instance.erase(file_name)
						else:
							append_text("[i]" + to_name + "[/i] is already exist.")
					else:
						append_text("[color=RED]Invalid folder name:[/color][i]" + to_name + "[/i], The file name cannot contain any of the following characters: [b]:/\\?*|%<>[/b]")
				else:
					append_text("[i]" + file_name + "[/i] does not exist.")
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		"Change the name of a file or directory."
	)
	add_command(
		"copy",
		func(file_name:String,to_path:String,to_name:String):
			var path_instance = get_path_instance(current_path)
			var result_path_instance = get_path_instance(to_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					if !result_path_instance.has(null):
						if to_name == "":
							to_name = file_name
						if to_name.is_valid_filename():
							if !result_path_instance.has(to_name):
								result_path_instance.get_or_add(to_name,path_instance.get(file_name).duplicate(true))
							else:
								append_text("[i]" + to_name + "[/i] is already exist.")
						else:
							append_text("[color=RED]Invalid file or directory name:[/color][i]" + to_name + "[/i], The file name cannot contain any of the following characters: [b]:/\\?*|%<>[/b]")
					else:
						append_text(result_path_instance.get(null))
				else:
					append_text("[i]" + file_name + "[/i] does not exist.")
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		"Copy a file or directory to another corresponding directory and apply a new name."
	)
	add_command(
		"move",
		func(file_name:String,to_path:String):
			var path_instance = get_path_instance(current_path)
			var result_path_instance = get_path_instance(to_path)
			if !path_instance.has(null):
				if path_instance.has(file_name):
					if !result_path_instance.has(null):
						if !result_path_instance.has(file_name):
							result_path_instance.get_or_add(file_name,path_instance.get(file_name).duplicate(true))
							path_instance.erase(file_name)
						else:
							append_text("[i]" + file_name + "[/i] is already exist.")
					else:
						append_text(result_path_instance.get(null))
				else:
					append_text("[i]" + file_name + "[/i] does not exist.")
			else:
				append_text(path_instance.get(null))
			pop_all(),
		self,
		"Move a file or directory to another corresponding directory."
	)
	
	
	add_command(
		"parse", 
		func(command:String):
			var expression = Expression.new()
			var error = expression.parse(command)
			if error != OK:
				append_text("[color=RED]Parsing failed:[/color] " + expression.get_error_text())
				pop_all()
			else:
				var result = expression.execute()
				if not expression.has_execute_failed() and result:
					append_text(str(result))
					pop_all(),
		self,
		"Parse and execute input commands."
	)

func return_path_string(path:String) -> String:
	if current_path == "/home":
		return "\u2302"
	else:
		return current_path

func get_path_instance(path:String,goto:bool=false) -> Dictionary:
	if !path.begins_with("/"):
		path = current_path + "/" + path
	var current_path_instance = fileDirectory
	var path_array:PackedStringArray = path.split("/")
	if path_array.has(".."):
		while path_array.find("..") != -1:
			path_array.remove_at(path_array.find("..") - 1)
			path_array.remove_at(path_array.find(".."))
	for i in path_array:
		if i != "":
			if !current_path_instance.has(i):
				return {null:"[i]" + path + "[/i] does not exist."}
			elif current_path_instance.get(i) is Dictionary:
				current_path_instance = current_path_instance[i]
			else:
				return {null:"[i]" + path + "[/i] is not a valid directory."}
	if goto:
		current_path = ""
		for i in path_array:
			if i != "":
				current_path += "/" + i
	return current_path_instance
