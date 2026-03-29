extends HBoxContainer
class_name HeartsContainer

var heart_gui = preload("res://scenes/gui/heart_gui.tscn")

func set_max_hearts(max_health: int):
	for i in range(max_health):
		var heart: HeartsGui = heart_gui.instantiate()
		add_child(heart) # Adds a heart per max_health

func update_hearts(current_health: int):
	var hearts = get_children()
	
	for i in range(hearts.size()):
		var heart = hearts[i] as HeartsGui
		heart.update_hearts(i < current_health)  
