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

#
	if Input.is_action_just_pressed("ui_focus_next"):
		is_targetting = !is_targetting
		print(rotation_degrees)

	
	var correction_to_zero = PID(-angular_velocity,delta,0)
	add_torque(correction_to_zero)
	
	if is_targetting:
		var target_basis = get_parent().get_node("Direct").transform.basis
		var error_target :Vector3 = - target_basis.z.cross(transform.basis.z)
		var correction_to_target = PID(error_target,delta,1)
		add_torque(correction_to_target)
		
		
#		
		var error_roll : Vector3 
		var cross_p_roll :Vector3 = target_basis.x.cross(transform.basis.x)
		if target_basis.x.x > 0 && target_basis.y.y > 0 || target_basis.z.z > 0:
#		if true:
			if cross_p_roll.z > 0 :
				error_roll = transform.basis.z * - cross_p_roll.length()
			else:
				error_roll = transform.basis.z *  cross_p_roll.length()
		else:
			if cross_p_roll.z > 0 :
				error_roll = transform.basis.z * cross_p_roll.length()
			else:
				error_roll = transform.basis.z * - cross_p_roll.length()
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

