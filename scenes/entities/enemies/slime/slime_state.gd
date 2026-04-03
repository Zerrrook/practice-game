extends State
class_name SlimeState

@export var speed := 30.0
@export var slime : Slime
@export var animation_name : String

# Overrides the enter() function from the state class
func enter():
	slime.animated_sprite.play(animation_name) # Used when super() is called
	pass

# If direction < 0, flip the sprite
func animation_flipping(dir):
	slime.animated_sprite.flip_h = dir < 0 
	
