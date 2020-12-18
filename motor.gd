extends RigidBody

var direction :=Vector3.ZERO

var target_rot := Vector3(0,0,0)
func _ready():
			$Generic6DOFJoint.set("angular_limit_x/enabled",false)
			$Generic6DOFJoint.set("angular_motor_x/enabled",true)
			$Generic6DOFJoint.set("angular_limit_y/enabled",false)
			$Generic6DOFJoint.set("angular_motor_y/enabled",true)
			$Generic6DOFJoint.set("angular_limit_z/enabled",false)
			$Generic6DOFJoint.set("angular_motor_z/enabled",true)
#
func _physics_process(delta):
#	target_rot = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		target_rot += Vector3((-delta),0,0)
#		print(target_rot/TAU)
	if Input.is_action_pressed("ui_down"):
		target_rot += Vector3(delta,0,0)
#		print(target_rot/TAU)
	if Input.is_action_pressed("ui_left"):
		target_rot += Vector3(0,-delta,0)
#		print(target_rot/TAU)
	if Input.is_action_pressed("ui_right"):
		target_rot += Vector3(0,delta,0)
#		print(target_rot/TAU)
	if Input.is_action_pressed("ui_high"):
		target_rot += Vector3(0,0,delta)
#		print(target_rot/TAU)
	if Input.is_action_pressed("ui_low"):
		target_rot += Vector3(0,0,-delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		target_rot =  Vector3.ZERO
	
	
	if global_transform.basis.get_euler() != target_rot:
		direction = (global_transform.basis.get_euler() + target_rot).normalized() * 5
	else:
		direction = Vector3.ZERO
	$Generic6DOFJoint.set("angular_motor_y/target_velocity", direction.y)
	$Generic6DOFJoint.set("angular_motor_x/target_velocity", direction.x)
	$Generic6DOFJoint.set("angular_motor_z/target_velocity", direction.z)

	print(target_rot/TAU)
