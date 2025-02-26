class_name EC_CommandClass

var id: String
var function: Callable
var functionInstance: Object
var helpText: String
var helpDetail: String

func _init(id:String, function:Callable, functionInstance: Object, helpText:String="", helpDetail:String = ""):
	self.id = id
	self.function = function
	self.functionInstance = functionInstance
	self.helpText = helpText
	self.helpDetail = helpDetail
