extends KinematicBody

const HEIGHT = 1.5
var target_position: Vector3 = Vector3.ZERO


func _ready():
	pass


func _physics_process(delta):
	var linear_velocity: Vector3

	if target_position == Vector3.ZERO:
		linear_velocity = Vector3.ZERO
	else:
		linear_velocity = (target_position - translation)
		linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
		
	if linear_velocity.length() > 0:
		update_player_heading(linear_velocity)

	var floating_offset = sin(OS.get_ticks_msec() / 300.0) * 0.2
	$body.translation.y = HEIGHT + floating_offset
		

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


func move_to(target: Vector3):
	target.y = HEIGHT
	target_position = target
