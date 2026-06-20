extends Node2D

@onready var rich_text_label: RichTextLabel = $Camera2D/CanvasLayer/Control/RichTextLabel
@onready var uh: AudioStreamPlayer2D = $Uh

var ultimo_caractere_visivel := 0

func _ready() -> void:
	pass

func start():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _process(delta: float) -> void:
	var total = rich_text_label.get_total_character_count()
	var atual = int(rich_text_label.visible_ratio * total)

	if atual > ultimo_caractere_visivel:
		uh.pitch_scale = randf_range(0.95, 1.05)
		uh.play()

	ultimo_caractere_visivel = atual

func _on_skip_button_up() -> void:
	$click.play()
	await $click.finished
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func playbackspeed(scale: float):
	Engine.time_scale = scale

func _on_skip_mouse_entered() -> void:
	$hover.play()


func _on_skip_mouse_exited() -> void:
	$hover.play()


func _on_x_button_up() -> void:
	$click.play()
	if Engine.time_scale == 1:
		playbackspeed(2)
		$"Camera2D/CanvasLayer/Control/Skip/2x/Label".text = "1x"
	else:
		playbackspeed(1)
		$"Camera2D/CanvasLayer/Control/Skip/2x/Label".text = "2x"


func _on_x_mouse_entered() -> void:
	$hover.play()


func _on_x_mouse_exited() -> void:
	$hover.play()
