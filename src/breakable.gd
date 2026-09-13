extends StaticBody2D

func destroy():
	%GlassBreak.play()
	%Explosion.emitting = true
	%CollisionShape2D.set_deferred("disabled", true)
	%Sprite2D.visible = false
