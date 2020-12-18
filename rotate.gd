extends Spatial

#const MODE_DIRECT = 0
#const MODE_CONSTANT = 1
#const MODE_SMOOTH = 2
#
#const ROTATION_SPEED = 1
#const SMOOTH_SPEED = 2.0
#
#export(int, "Direct", "Constant", "Smooth") var mode = MODE_DIRECT
#
#var direction = Vector3.FORWARD

var target_rot : Vector3

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
	
	rotation = -target_rot
		
