extends KinematicBody

const HEIGHT = 1.5
const MAX_SPEED = 6
const ACCELERATION = 60

const Waypoint = preload("res://game/waypoint/Waypoint.tscn")

var target_position: Vector3 = Vector3.ZERO
var linear_velocity: Vector3 = Vector3.ZERO
var moving = false
var dontmove = 0.0


func _ready():
	# Get orbs and spawn them and do a thing
	Game.Player = self
	for key in Game.State.keys():
		if Game.State[key].has("ready") and Game.State[key]["ready"] == true:
			Game.give_orb()


func _physics_process(delta):
	click_to_move_controller(delta)
	wasd_controller(delta)
	
	if linear_velocity.length() > MAX_SPEED:
		linear_velocity = linear_velocity.normalized() * MAX_SPEED

	if linear_velocity.length() > 0:
		linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
		update_heading(linear_velocity)

	var floating_offset = sin(OS.get_ticks_msec() / 200.0) * 0.25
	$spirit.translation.y = HEIGHT + floating_offset
	

func wasd_controller(delta: float):
	var direction: Vector3 = Vector3.ZERO
	
	if Game.player_control:
		if Input.is_action_pressed("up"):
			direction += -Game.CurrentCamera.transform.basis.z
		if Input.is_action_pressed("down"):
			direction += Game.CurrentCamera.transform.basis.z
		if Input.is_action_pressed("left"):
			direction += -Game.CurrentCamera.transform.basis.x
		if Input.is_action_pressed("right"):
			direction += Game.CurrentCamera.transform.basis.x

	direction.y = 0
	direction = direction.normalized()
	
	if direction.length():
		linear_velocity += direction * ACCELERATION * delta
	else:
		linear_velocity *= 0.9


func click_to_move_controller(delta: float):
	dontmove -= delta
	if dontmove >= 0:
		return
		
	if Game.player_control:
		if Input.is_mouse_button_pressed(1):
			var mouse_position = get_viewport().get_mouse_position()
			var camera = Game.CurrentCamera
			var plane = Plane(Vector3(0,1,0), 0)
			var from = camera.project_ray_origin(mouse_position)
			target_position = plane.intersects_ray(from, camera.project_ray_normal(mouse_position))
			target_position.y = HEIGHT
			moving = true
	else:
		moving = false
		
	var direction = (target_position - translation).normalized()
	var distance = (target_position - translation).length()
	
	if moving:
		linear_velocity += direction * ACCELERATION * delta
		if distance < 2:
			moving = false
	else:
		linear_velocity *= 0.9


func update_heading(direction: Vector3):
	var goal_basis = transform.basis
	goal_basis.z = direction.normalized()
	goal_basis.y = Vector3(0,1,0)
	goal_basis.x = (goal_basis.z.cross(-goal_basis.y)).normalized()
	goal_basis = goal_basis.orthonormalized()
	
	transform.basis = transform.basis.orthonormalized()
	var q1 = Quat(transform.basis)
	var q2 = Quat(goal_basis)
	var q3 = q1.slerp(q2, 0.1)
	transform.basis = Basis(q3)


func shrink():
	var t = create_tween()
	t.tween_property($spirit, "scale", Vector3(0,0,0), 1.0)
	

func grow():
	var t = create_tween()
	t.tween_property($spirit, "scale", Vector3(1,1,1), 1.0)


func stop():
	moving = false
	target_position = Vector3.ZERO
	dontmove = 0.3
