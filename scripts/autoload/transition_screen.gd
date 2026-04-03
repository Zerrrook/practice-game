extends CanvasLayer

signal on_transitioned_finished
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func _ready():
	color_rect.visible = false
	
func transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		on_transitioned_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
