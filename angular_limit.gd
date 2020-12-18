extends RigidBody

var target_rot := Vector3.ZERO

func _ready():
			$Generic6DOFJoint.set("angular_limit_x/enabled",true)
		
			$Generic6DOFJoint.set("angular_limit_y/enabled",true)
		
			$Generic6DOFJoint.set("angular_limit_z/enabled",true)
		


func _physics_process(delta):
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
		
	if target_rot.x > PI:
		target_rot.x -= TAU
	elif target_rot.x < -PI:
		target_rot.x += TAU
		
#	if target_rot.y > PI/2:
#		target_rot.x += -PI
#		target_rot.z += -PI
#		target_rot.y = PI - target_rot.y
#	elif target_rot.y < -PI/2:
#		target_rot.x += PI
#		target_rot.z += PI
#		target_rot.y = -(PI - target_rot.y)
#
	if target_rot.z > PI:
		target_rot.z -= TAU
	elif target_rot.z < -PI:
		target_rot.z += TAU
	
	
	$Generic6DOFJoint.set("angular_limit_y/upper_angle", rad2deg(target_rot.y))
	$Generic6DOFJoint.set("angular_limit_y/lower_angle", rad2deg(target_rot.y))
	$Generic6DOFJoint.set("angular_limit_x/upper_angle", rad2deg(target_rot.x))
	$Generic6DOFJoint.set("angular_limit_x/lower_angle", rad2deg(target_rot.x))
	$Generic6DOFJoint.set("angular_limit_z/upper_angle", rad2deg(target_rot.z))
	$Generic6DOFJoint.set("angular_limit_z/lower_angle", rad2deg(target_rot.z))
	
