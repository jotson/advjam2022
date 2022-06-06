extends KinematicBody

const HEIGHT = 1.5
const MAX_SPEED = 5
const ACCELERATION = 20

const Waypoint = preload("res://game/waypoint/Waypoint.tscn")

var target_position: Vector3 = Vector3.ZERO
var linear_velocity: Vector3 = Vector3.ZERO
var moving = false


func _ready():
	pass


func _physics_process(delta):
	get_player_input()
	
	var direction = (target_position - translation).normalized()
	var distance = (target_position - translation).length()
	
	if moving:
		linear_velocity += direction * ACCELERATION * delta
		if distance < 2:
			moving = false
	else:
		linear_velocity *= 0.9

	if linear_velocity.length() > MAX_SPEED:
		linear_velocity = direction * MAX_SPEED

	if linear_velocity.length() > 0:
		linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
		update_player_heading(linear_velocity)

	var floating_offset = sin(OS.get_ticks_msec() / 200.0) * 0.25
	$body.translation.y = HEIGHT + floating_offset
	

func get_player_input():
	if Input.is_mouse_button_pressed(1):
		var mouse_position = get_viewport().get_mouse_position()
		var camera = Game.CurrentCamera
		var plane = Plane(Vector3(0,1,0), 0)
		var from = camera.project_ray_origin(mouse_position)
		target_position = plane.intersects_ray(from, camera.project_ray_normal(mouse_position))
		target_position.y = HEIGHT
		moving = true
		
		var w = Waypoint.instance()
		w.translation = target_position
		get_tree().current_scene.add_child(w)


func update_player_heading(direction: Vector3):
	var goal_basis = transform.basis
	goal_basis.z = direction.normalized()
	goal_basis.y = Vector3(0,1,0)
	goal_basis.x = (goal_basis.z.cross(-goal_basis.y)).normalized()
	goal_basis = goal_basis.orthonormalized()
	
	var q1 = Quat(transform.basis)
	var q2 = Quat(goal_basis)
	var q3 = q1.slerp(q2, 0.1)
	transform.basis = Basis(q3)
