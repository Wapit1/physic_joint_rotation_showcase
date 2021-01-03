extends RigidBody

var target_rot := Vector3.ZERO

var max_speed : float = 2

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
		
#	if target_rot.length() >= PI:
#		target_rot = target_rot.normalized() *PI
		
	var target_forward := Vector3.FORWARD
	
	target_forward = target_forward.rotated(Vector3(0,1,0),-target_rot.y) 
	target_forward = target_forward.rotated(Vector3(1,0,0),-target_rot.x) 
	target_forward = target_forward.rotated(Vector3(0,0,1),-target_rot.z) 
	
	var torque := target_forward.cross(transform.basis.z)
	
	apply_torque_impulse(torque/10)
	
	if torque.length() == 0:
		angular_damp = 1
	else:
		angular_damp = 0.05/torque.length()
	
	
#
#	var direction = -(global_transform.basis.get_euler() + target_rot).normalized()
#	if global_transform.basis.get_euler().round() == target_rot.round():
##		apply_torque_impulse(-angular_velocity)
#		angular_damp = 1
#	elif angular_velocity.length() < max_speed || direction.normalized() != angular_velocity.normalized():
#		apply_torque_impulse(direction)
#		angular_damp = -1

