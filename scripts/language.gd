extends Node
var lang = "PT"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	if lang == "PT":
		TranslationServer.set_locale("pt")
	else:
		TranslationServer.set_locale("en")
