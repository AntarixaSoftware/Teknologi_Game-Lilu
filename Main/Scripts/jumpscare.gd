extends Area3D

@onready var jumpscare = $"../jumpscare"
@onready var entered = false
func _ready():
	$"../TextureRect".visible = false
	$"../TextureRect".visible = false
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Main Character":
		if not entered:
			jumpscare.play()
			$"../AnimationPlayer".play("jumpscare")
			$"../TextureRect".visible = false
			entered = true
