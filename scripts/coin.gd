extends Area2D

@onready var game_manager: Node = %GameManager


func _on_body_entered(body: Node2D) -> void:
	if body:
		game_manager.add_point()
		$AnimatedSprite2D.visible = false
		$PickupSound.play()
		$CollisionShape2D.queue_free()
		await $PickupSound.finished
		queue_free()
