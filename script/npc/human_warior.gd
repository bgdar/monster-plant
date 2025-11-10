extends CharacterBody2D

var moster_ui : CharacterBody2D = null 
var is_move : bool = false 
const SPEED = 120.0
@onready var human_warior_ui: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_deteksi_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "monster" and moster_ui == null:
		moster_ui = body
		is_move = true

func _on_area_deteksi_body_exited(body: Node2D) -> void:
	if body.name == "monster":
		moster_ui = null
		is_move = false
		
func _draw() -> void:
	if moster_ui:
		draw_line(Vector2.ZERO, moster_ui.global_position - global_position, Color.RED, 2)
		
func _physics_process(delta: float) -> void:
	if is_move and moster_ui:
		var direction_attack = ( human_warior_ui.position - moster_ui.position).normalized()
		velocity = direction_attack * SPEED
		move_and_slide()
		human_warior_ui.play("runDown")
	else:
		human_warior_ui.play("idle")
