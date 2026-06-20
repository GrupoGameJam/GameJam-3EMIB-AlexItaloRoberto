extends Node2D
@export var starID: int = 0
@onready var player = get_tree().get_first_node_in_group("player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if starID in pickups.stars:
		self.modulate.a = 0.2
	else:
		self.modulate.a = 1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != player:
		return
	if starID not in pickups.stars:
		pickups.stars.append(starID)
		$AnimationPlayer.play('pickup')
		save_manager.save_game()
