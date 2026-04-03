extends SlimeState
class_name SlimeRun


var previous_direction: int
	
func process_physics(_delta: float):
	if slime.direction == 1 and (!slime.ray_right_ground.is_colliding() or slime.ray_right_wall.is_colliding()):
		slime.direction = -1 # If a slime hits a wall or a hole on it's right, go left
	elif slime.direction == -1 and (!slime.ray_left_ground.is_colliding() or slime.ray_left_wall.is_colliding()):
		slime.direction = 1 # If a slime hits a wall or a hole on it's left, go right
	
	# Plays the turn animation
	if slime.direction != previous_direction:
		slime.animated_sprite.play("turn")
	previous_direction = slime.direction
	
	slime.velocity.x = lerp(slime.velocity.x, slime.direction * speed, 10.0 * _delta)
	animation_flipping(slime.direction)
	apply_gravity_and_move(_delta)
	

func _on_animation_finished() -> void:
	# After turning, go back to patrol animation
	if slime.animated_sprite.animation == "turn":
		slime.animated_sprite.play(animation_name)
