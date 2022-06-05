extends Spatial

func _ready():
	Game.CurrentCamera = $Camera
	Game.Player = $Player
	Game.State.kiosk.visited = true


func _on_KioskArea_body_entered(body):
	printt("entered area", body)
	$Kiosk/idleSound.stop()
	$Kiosk/welcomeSound.play()
	Game.State.kiosk.completed = true


func _on_KioskArea_body_exited(body):
	print("exited area")
	$Kiosk/idleSound.play()
	$Kiosk/welcomeSound.stop()
