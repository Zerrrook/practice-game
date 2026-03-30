extends PlayerState
class_name PlayerDead

func enter():
	super()
	player.dying = false
	player.died = true # Makes it so you can't get hit if you died
	
	# Allows an enemy to get pass the player
	player.set_collision_layer_value(2, false)
	player.set_collision_mask_value(3, false)
	
	Engine.time_scale = 0.5 # Slow down effect
	respawn()

func respawn():
	player.respawn_timer.start()

func _on_respawn_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func process_physics(_delta: float):
	player.velocity.x = 0 # Sets the velocity to 0 when you die
	apply_gravity_and_move(_delta)
