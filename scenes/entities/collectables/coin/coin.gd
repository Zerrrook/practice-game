extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.add_point()
		$AnimatedSprite2D.visible = false
		$PickupSound.play()
		$CollisionShape2D.queue_free()
		await $PickupSound.finished
		queue_free()
