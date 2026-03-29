extends PlayerState
class_name PlayerDead

func enter():
	super()
	player.dying = false
	print("dead")
	Engine.time_scale = 0.5
	respawn()

func respawn():
	player.respawn_timer.start()

func _on_respawn_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func process_physics(_delta: float):
	player.velocity.y += gravity * _delta
	player.velocity.x = 0
	player.move_and_slide()
