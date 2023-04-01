extends RigidBody

onready var desired_drone_state = get_node("/root/Spatial/Desired_Drone_State")

const SPEED = 1

const PGAIN = 20
const DGAIN = 3
const IGAIN = 2

const PGAIN_R = 3
const DGAIN_R = 10
const IGAIN_R = 3

var roll_error : float
var previous_roll_error : float
var roll_error_derivative : float
var roll_error_integral : float

var previous_error : float
var error : float
var error_derivative : float
var error_integral : float
var force : Vector3

var thrust : float
var yaw : float
var pitch : float
var roll : float

var motorFR : float
var motorFL : float
var motorBR : float
var motorBL : float


func _ready():
	previous_roll_error = 0.0
	roll_error_integral = 0.0;
	
	previous_error = 0.0
	error_integral = 0.0

	thrust = 0.0
	yaw = 0.0
	pitch = 0.0
	roll = 0.0

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	
	roll_error = (desired_drone_state.translation.x - self.translation.x) 
	roll_error_derivative = (roll_error - previous_roll_error) / delta
	previous_roll_error = roll_error
	roll_error_integral = roll_error_integral + roll_error * delta
		
	error = (desired_drone_state.translation.y - self.translation.y)
	error_derivative = (error - previous_error) / delta
	previous_error = error
	error_integral = error_integral + error * delta
#
#	thrust = PGAIN * error + DGAIN * error_derivative + IGAIN * error_integral
#
#	motorFR = roll
#	motorFL = (-1) * roll
#	motorBR = roll
#	motorBL = (-1) * roll

	roll = (roll_error * PGAIN_R  + roll_error_derivative * DGAIN_R + roll_error_integral * IGAIN_R )* 0.001
	thrust = error * PGAIN + error_derivative * DGAIN + error_integral * IGAIN
	
	motorFR = thrust +  roll
	motorFL = thrust - roll
	motorBR = thrust + roll
	motorBL = thrust - roll
	add_force(self.get_transform().basis.y * motorFL * SPEED, $Proto_Drone_Mesh/P1.global_transform.origin - self.global_transform.origin)
	add_force(self.get_transform().basis.y * motorBL * SPEED, $Proto_Drone_Mesh/P2.global_transform.origin - self.global_transform.origin)
	add_force(self.get_transform().basis.y * motorBR * SPEED, $Proto_Drone_Mesh/P3.global_transform.origin - self.global_transform.origin)
	add_force(self.get_transform().basis.y * motorFR * SPEED, $Proto_Drone_Mesh/P4.global_transform.origin - self.global_transform.origin)
	
	
	
#	print(motorBL)
#	var position = $Proto_Drone_Mesh/P1.global_transform.origin - self.global_transform.origin
#	add_force(self.get_transform().basis.y * motorFL * SPEED, $Proto_Drone_Mesh/P1.get_transform().origin)
#	add_force(self.get_transform().basis.y * motorBL * SPEED, $Proto_Drone_Mesh/P2.get_transform().origin)
#	add_force(self.get_transform().basis.y * motorBR * SPEED, $Proto_Drone_Mesh/P3.get_transform().origin)
#	add_force(self.get_transform().basis.y * motorFR * SPEED, $Proto_Drone_Mesh/P4.get_transform().origin)
#	var dir = self.global_transform.basis.y * 10
#	add_force(dir, position)
#	print(dir)
#	print($Proto_Drone_Mesh/P1.global_transform.origin)
#	print(self.get_global_transform().basis.y * 10)
#	add_force(self.get_transform().basis.y * 10, $Proto_Drone_Mesh/P2.global_transform.origin - self.global_transform.origin)
#	add_force(self.get_global_transform().basis.y * (-10), $Proto_Drone_Mesh/P3.get_transform().origin)
#	add_force(self.global_transform.basis.y * 2, $Proto_Drone_Mesh/P4.global_transform.origin)
#
#	# add_torque(Vector3(0, Input.get_axis("yaw_right", "yaw_left") * 10, 0))

	pass
