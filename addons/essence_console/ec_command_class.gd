class_name EC_CommandClass

var id: String
var function: Callable
var functionInstance: Object
var helpText: String
var getFunction

func _init(id:String, function:Callable, functionInstance: Object, helpText:String="", getFunction=null):
	self.id = id
	self.function = function
	self.functionInstance = functionInstance
	self.helpText = helpText
	if getFunction != null: self.getFunction = getFunction
