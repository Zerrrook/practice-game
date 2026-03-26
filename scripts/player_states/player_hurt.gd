extends PlayerState
class_name PlayerHurt

@onready var hurt_sound: AudioStreamPlayer2D = $"../../Sounds/HurtSound"


func Enter(hit_data : Dictionary = {}):
	print(hit_data["knockback"])
	is_hurt = true
	hurt_sound.play()
	player.health_component.damage_taken(hit_data["damage"])
	if is_alive:
		player.animated_sprite.play("hurt")
		
	# Applies knockback
	player.knockback_component.apply_knockback(hit_data["knockback"], 500, 0.01)

func Physics_Update(_delta: float):
	gravity(_delta)
	player.knockback_component.process_knockback(_delta)

func _on_animated_sprite_2d_animation_finished() -> void:
	if player.animated_sprite.animation == "hurt":
		is_hurt = false
		state_transition.emit(self, "run")
		if dying:
			player.die()
