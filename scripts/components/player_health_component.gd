extends HealthComponent
class_name PlayerHealthComponent

@onready var hearts_container: HeartsContainer = $"../HealthBar/HeartsContainer"


func _ready():
	super()
	hearts_container.set_max_hearts(max_health)
func damage_taken(damage):
	super(damage)
	hearts_container.update_hearts(health)
	
