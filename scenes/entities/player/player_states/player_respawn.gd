extends PlayerState
class_name PlayerRespawn

# Play the respawn animation whenever player is respawned or 
# player is sent back to a fallback pointa

@export var idle_state: State

func enter():
	super()
	player.velocity.x = 0
	
	await player.animated_sprite.animation_finished
	player.is_invincible = true
	
func process_frame(_delta: float):
	if player.is_invincible:
		player.is_invincible = false
		return idle_state
	return null
