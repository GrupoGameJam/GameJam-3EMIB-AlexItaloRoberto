extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if language.lang == "PT":
		$Camera2D/CanvasLayer/Control/Lang/Icon.texture = load("res://sprites/PT.png")
	else:
		$Camera2D/CanvasLayer/Control/Lang/Icon.texture = load("res://sprites/EN.png")

func play():
	get_tree().change_scene_to_file("res://scenes/start_cutscene.tscn")

func _on_play_btn_button_up() -> void:
	$Camera2D/CanvasLayer/Control/Door.play("slam")
	$slam.play()
	$Camera2D/AnimationPlayer.play("zoom")


func _on_play_btn_mouse_entered() -> void:
	$Camera2D/CanvasLayer/Control/Door.play("move")
	$creak1.play()


func _on_play_btn_mouse_exited() -> void:
	$Camera2D/CanvasLayer/Control/Door.play_backwards("move")
	$creak2.play()


func _on_quit_button_up() -> void:
	$click.play()
	await $click.finished
	get_tree().quit()


func _on_quit_mouse_entered() -> void:
	$hover.play()


func _on_lang_button_up() -> void:
	if language.lang == "PT":
		language.lang = "EN"
	else:
		language.lang = "PT"
