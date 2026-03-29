extends PlayerState
class_name PlayerHurt

@onready var hurt_sound: AudioStreamPlayer2D = $"../../Sounds/HurtSound"

@export var run_state : State
@export var dead_state : State
var duration := 0.12
var timer := 0.0
var dying 
func enter():
	super()
	
	timer = duration
	
	var hit_data = player.pending_hit
	player.pending_hit = {}
	
	print(hit_data["damage"])
	hurt_sound.play()
	player.player_health_component.damage_taken(hit_data["damage"])
		
	# Applies knockback
	player.knockback_component.apply_knockback(hit_data["knockback"], 300.0, duration)
	
func process_physics(_delta: float):
	timer -= _delta
	player.velocity.y += gravity * _delta
	player.knockback_component.process_knockback(_delta)
	
	player.move_and_slide()
	
	if timer <= 0:
		if player.dying:
			return dead_state
		return run_state
	return null
