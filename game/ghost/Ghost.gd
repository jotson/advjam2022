extends KinematicBody

const HEIGHT = 1.5
const MAX_SPEED = 4 # m/s
const ACCELERATION = 5 # m/s/s

var float_timing: float
var target_position: Vector3 = Vector3.ZERO
var linear_velocity: Vector3 = Vector3.ZERO


func _ready():
	randomize()
	float_timing = randf() * 5.0

	set_physics_process(false)
	
	var LIFETIME = 20.0
	var MIN_LIFE = 5.0
	$deathTimer.wait_time = randf() * (LIFETIME - MIN_LIFE) + MIN_LIFE
	$deathTimer.start()

	translation.y = -10
	var end = Vector3(translation.x, 1.5, translation.z)
	var t = create_tween()
	t.tween_property(self, 'translation', end, 3.0).set_delay(1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	t.tween_callback(self, 'set_physics_process', [true])
		

func _physics_process(delta):
	var floating_offset = sin(OS.get_ticks_msec() / 200.0 + float_timing) * 0.25
	$Ghost.translation.y = HEIGHT + floating_offset

	var direction = (target_position - translation).normalized()
	
	if direction.length():
		linear_velocity += direction * ACCELERATION * delta
		if linear_velocity.length() > MAX_SPEED:
			linear_velocity = linear_velocity.normalized() * MAX_SPEED

		linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
		update_heading(linear_velocity)
	else:
		linear_velocity *= 0.9


func update_heading(direction: Vector3):
	var goal_basis = transform.basis
	goal_basis.z = direction.normalized()
	goal_basis.y = Vector3(0,1,0)
	goal_basis.x = (goal_basis.z.cross(-goal_basis.y)).normalized()
	goal_basis = goal_basis.orthonormalized()
	
	var q1 = Quat(transform.basis)
	var q2 = Quat(goal_basis)
	var q3 = q1.slerp(q2, 0.1)
	transform.basis = Basis(q3)


func _on_moveTimer_timeout():
	$moveTimer.wait_time = randf() * 3.0 + 1.0
	$moveTimer.start()
	
	target_position = Game.get_random_position()
	target_position.y = HEIGHT


func _on_deathTimer_timeout():
	set_physics_process(false)
	
	var t = create_tween()
	var end = Vector3(translation.x, 20, translation.z)
	t.tween_property(self, "translation", end, 6.0)
	t.tween_callback(self, "queue_free")
