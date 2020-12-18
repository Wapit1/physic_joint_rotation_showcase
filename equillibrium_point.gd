extends RigidBody

var target_rot := Vector3.ZERO
export var rot_stiffness := 0.2
export var rot_damping := 0.005

func _ready():
			$Generic6DOFJoint.set("angular_limit_x/enabled",false)
			$Generic6DOFJoint.set("angular_spring_x/enabled",true)
			$Generic6DOFJoint.set("angular_limit_y/enabled",false)
			$Generic6DOFJoint.set("angular_spring_y/enabled",true)
			$Generic6DOFJoint.set("angular_limit_z/enabled",false)
			$Generic6DOFJoint.set("angular_spring_z/enabled",true)

			$Generic6DOFJoint.set("angular_spring_x/stiffness",rot_stiffness)
			$Generic6DOFJoint.set("angular_spring_y/stiffness",rot_stiffness)
			$Generic6DOFJoint.set("angular_spring_z/stiffness",rot_stiffness)

			$Generic6DOFJoint.set("angular_spring_x/damping",rot_damping)
			$Generic6DOFJoint.set("angular_spring_y/damping",rot_damping)
			$Generic6DOFJoint.set("angular_spring_z/damping",rot_damping)





func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		target_rot += Vector3((-delta),0,0)
		print(target_rot/TAU)
	if Input.is_action_pressed("ui_down"):
		target_rot += Vector3(delta,0,0)
		print(target_rot/TAU)
	if Input.is_action_pressed("ui_left"):
		target_rot += Vector3(0,-delta,0)
		print(target_rot/TAU)
	if Input.is_action_pressed("ui_right"):
		target_rot += Vector3(0,delta,0)
		print(target_rot/TAU)
	if Input.is_action_pressed("ui_high"):
		target_rot += Vector3(0,0,delta)
		print(target_rot/TAU)
	if Input.is_action_pressed("ui_low"):
		target_rot += Vector3(0,0,-delta)
		print(target_rot/TAU)
	

#	if target_rot.x >= 0.44*TAU:
#		target_rot.x = 0
#		print("tau flip")
#	if rad2deg(target_rot.y) >= 90:
#		target_rot.x += -PI
#		target_rot.z += -PI
#		target_rot.y = PI - target_rot.y
#		print("rot conversion")
		print(target_rot/TAU)
#	if target_rot.z >= 0.44*TAU:
#		target_rot.z = 0
#		print("tau flip")
#	if target_rot.x <= -0.45*TAU:
#		target_rot.x = 0
#		print(" - tau flip")
#	if target_rot.y <= -0.2*TAU:
#		target_rot.y = 0
#		print("- tau flip")
#	if target_rot.z <= -0.45*TAU:
#		target_rot.z = 0
#		print(" - tau flip")
	
	if Input.is_action_just_pressed("ui_accept"):
		target_rot =  Vector3.ZERO
		print ("reset")
		
	
							
							
							
	$Generic6DOFJoint.set("angular_spring_y/equilibrium_point", target_rot.y)
	$Generic6DOFJoint.set("angular_spring_x/equilibrium_point", target_rot.x)
	$Generic6DOFJoint.set("angular_spring_z/equilibrium_point", target_rot.z)
		
	
