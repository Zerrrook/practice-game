extends PlayerState
class_name PlayerIdle

func Enter(_hit_data : Dictionary = {}):
	animated_sprite.play("idle")
