extends Spatial

func _ready():
	Game.CurrentCamera = $Camera
	Game.Player = $Player
	Game.State.checkin.visited = true


func _on_KioskArea_body_entered(body):
	$Kiosk/idleSound.stop()
	if Game.State.checkin.completed:
		$Kiosk/KioskAnim.play("youcandoit")
	else:
		$Kiosk/KioskAnim.play("welcome")


func _on_KioskArea_body_exited(body):
	$Kiosk/idleSound.play()
	$Kiosk/KioskAnim.stop()


func _on_KioskAnim_animation_finished(anim_name):
	if anim_name == "welcome":
		Game.State.checkin.completed = true
