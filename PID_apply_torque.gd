extends RigidBody

var target_rot := Vector3.ZERO

export var PID_to_zero := Vector3(2,0,0) 
var last_error_z := Vector3.ZERO
var integral_z   := Vector3.ZERO

export var PID_to_target := Vector3(50,0.01,0.01)
var last_error_t := Vector3.ZERO
var integral_t   := Vector3.ZERO

export var PID_to_roll := Vector3(10,0.01,0.01)
var last_error_r := Vector3.ZERO
var integral_r   := Vector3.ZERO


var is_targetting := true

func _physics_process(delta):
#	target_rot = Vector3.ZERO
#	if Input.is_action_pressed("ui_up"):
#		target_rot += Vector3((-delta),0,0)
##		print(target_rot/TAU)
#	if Input.is_action_pressed("ui_down"):
#		target_rot += Vector3(delta,0,0)
##		print(target_rot/TAU)
#	if Input.is_action_pressed("ui_left"):
#		target_rot += Vector3(0,-delta,0)
##		print(target_rot/TAU)
#	if Input.is_action_pressed("ui_right"):
#		target_rot += Vector3(0,delta,0)
##		print(target_rot/TAU)
#	if Input.is_action_pressed("ui_high"):
#		target_rot += Vector3(0,0,delta)
##		print(target_rot/TAU)
#	if Input.is_action_pressed("ui_low"):
#		target_rot += Vector3(0,0,-delta)
#
#	if Input.is_action_just_pressed("ui_accept"):
#		target_rot =  Vector3.ZERO
#
	if Input.is_action_just_pressed("ui_focus_next"):
		is_targetting = !is_targetting
		
#	if target_rot.length() >= PI:
#		target_rot = target_rot.normalized() *PI
	
	var correction_to_zero = PID(-angular_velocity,delta,0)
	add_torque(correction_to_zero)
	
	if is_targetting:
		var target_basis = get_parent().get_node("Direct").transform.basis
#
#		target_basis = target_basis.rotated(Vector3(0,1,0),-target_rot.y) 
#		target_basis = target_basis.rotated(Vector3(1,0,0),-target_rot.x) 
#		target_basis = target_basis.rotated(Vector3(0,0,1),-target_rot.z) 

		var error_target :Vector3 = - target_basis.z.cross(transform.basis.z)
		
		var correction_to_target = PID(error_target,delta,1)
		
		add_torque(correction_to_target)
		
		
#		var error_roll : Vector3 = transform.basis.z * (target_basis.get_euler().z - transform.basis.get_euler().z)
		var error_roll : Vector3 
		
		if target_basis.x.cross(transform.basis.x).z > 0 :
			error_roll = transform.basis.z * (target_basis.x.cross( transform.basis.x).length())
		else:
			error_roll = transform.basis.z * - (target_basis.x.cross( transform.basis.x).length())
		add_torque(PID(error_roll,delta,2))
		
		
func PID(current_error:Vector3,time:float,PID_num:int):
	
	if PID_num == 0:
		integral_z += current_error * time
		var deriv = (current_error - last_error_z) /time
		last_error_z = current_error
		return current_error*PID_to_zero.x + integral_z *PID_to_zero.y + deriv*PID_to_zero.z
	elif PID_num == 1:
		integral_t += current_error * time
		var deriv = (current_error - last_error_t) /time
		last_error_t = current_error
		return current_error*PID_to_target.x + integral_t *PID_to_target.y + deriv*PID_to_target.z
	else:
		integral_r += current_error * time
		var deriv = (current_error - last_error_r) /time
		last_error_r = current_error
		return current_error*PID_to_roll.x + integral_t *PID_to_roll.y + deriv*PID_to_roll.z


#	var direction = -(global_transform.basis.get_euler() + target_rot).normalized()
#	if global_transform.basis.get_euler().round() == target_rot.round():
##		apply_torque_impulse(-angular_velocity)
#		angular_damp = 1
#	elif angular_velocity.length() < max_speed || direction.normalized() != angular_velocity.normalized():
#		apply_torque_impulse(direction)
#		angular_damp = -1

