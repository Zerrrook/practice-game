extends Panel
class_name HeartsGui

@onready var heart: Sprite2D = $Heart

func update_hearts(filled: bool): 
	if is_node_ready():
		if filled: heart.frame = 0 
		else: heart.frame = 1
