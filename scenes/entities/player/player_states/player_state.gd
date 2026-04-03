extends State
class_name PlayerState

# Declaration of variables
var direction : float

@export var player : Player
@export var animation_name : String


# Overrides the enter() function from the state class
func enter():
	player.animated_sprite.play(animation_name) # Used when super() is called
	pass

# If direction < 0, flip the sprite
func animation_flipping(dir):
	player.animated_sprite.flip_h = dir < 0 
