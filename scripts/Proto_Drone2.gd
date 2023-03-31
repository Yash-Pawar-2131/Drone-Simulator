extends RigidBody

onready var desired_drone_state = get_node("/root/Spatial/Desired_Drone_State")
onready var motor = get_node("/root/Spatial/motor")
onready var force = get_node("/root/Spatial/force")

const SPEED = 1
const MAX = 100.0

const PGAIN = 20
const DGAIN = 3
const IGAIN = 2

var altitudePreviousError : float
var altitudeErrorIntegral : float

var xPreviousError : float
var xErrorIntegral : float

var rollPreviousError : float
var rollErrorIntegral : float

var thrust : float
var yaw : float
var pitch : float
var roll : float

var motorFR : float
var motorFL : float
var motorBR : float
var motorBL : float

var forceFR : Vector3
var forceFL : Vector3
var forceBL : Vector3
var forceBR : Vector3

var dir

func _ready():
	altitudePreviousError = 0.0
	altitudeErrorIntegral = 0.0
	
	xPreviousError = 0.0
	xErrorIntegral = 0.0
	
	rollPreviousError = 0.0
	rollErrorIntegral = 0.0

	thrust = 0.0
	yaw = 0.0
	pitch = 0.0
	roll = 0.0

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):

#	var altitudeError = desired_drone_state.translation.y - self.translation.y
#	var altitudeErrorDerivative = (altitudeError - altitudePreviousError) / delta
#	altitudePreviousError = altitudeError
#	altitudeErrorIntegral = altitudeErrorIntegral + altitudeError * delta

	var xError = desired_drone_state.translation.x - self.translation.x
	var xErrorDerivative = (xError - xPreviousError) / delta
	xPreviousError = xError
	xErrorIntegral = xErrorIntegral + xError * delta
	
	if desired_drone_state.get_transform().basis.z.cross(self.get_transform().basis.z).y >= 0:
		dir = -1
	else:
		dir = 1
	var rollError = 0.0 - Vector3.RIGHT.angle_to(global_transform.basis.x)
	var rollErrorDerivative = (rollError - rollPreviousError) / delta
	rollPreviousError = rollError
	rollErrorIntegral = rollErrorIntegral + rollError * delta
	
#	thrust = PGAIN * altitudeError + DGAIN * altitudeErrorDerivative + IGAIN * altitudeErrorIntegral
#	pitch = PGAIN * pitchError + DGAIN * pitchErrorDerivative + IGAIN * pitchErrorIntegral
#	roll = PGAIN * rollError + DGAIN * error_derivative + IGAIN * error_integral

	motorFR = thrust + yaw + pitch + roll
	motorFL = thrust - yaw + pitch - roll
	motorBR = thrust - yaw - pitch + roll
	motorBL = thrust + yaw - pitch - roll
	
	motor.text = "FR: " + String(motorFR) + ", FL: " + String(motorFL) + ", BR: " + String(motorBR) + ", BL:" + String(motorBL)
	
	forceFL = self.get_transform().basis.y * motorFL * SPEED
	forceBL = self.get_transform().basis.y * motorBL * SPEED
	forceBR = self.get_transform().basis.y * motorBR * SPEED
	forceFR = self.get_transform().basis.y * motorFR * SPEED
	
#	forceFL.x = clamp(forceFL.x, 0, MAX)
#	forceFL.y = clamp(forceFL.y, 0, MAX)
#	forceFL.z = clamp(forceFL.z, 0, MAX)
#
#	forceBL.x = clamp(forceBL.x, 0, MAX)
#	forceBL.y = clamp(forceBL.y, 0, MAX)
#	forceBL.z = clamp(forceBL.z, 0, MAX)
#
#	forceBR.x = clamp(forceBR.x, 0, MAX)
#	forceBR.y = clamp(forceBR.y, 0, MAX)
#	forceBR.z = clamp(forceBR.z, 0, MAX)
#
#	forceFR.x = clamp(forceFR.x, 0, MAX)
#	forceFR.y = clamp(forceFR.y, 0, MAX)
#	forceFR.z = clamp(forceFR.z, 0, MAX)
	
	force.text = "FR: " + String(forceFR.length()) + ", FL: " + String(forceFL.length()) + ", BR: " + String(forceBR.length()) + ", BL:" + String(forceBL.length())
	
#	print(Vector3(forceFL.x, forceFL.y, forceFL.z))
	
	add_force(forceFL, $Proto_Drone_Mesh/P1.get_transform().origin)
	add_force(forceBL, $Proto_Drone_Mesh/P2.get_transform().origin)
	add_force(forceBR, $Proto_Drone_Mesh/P3.get_transform().origin)
	add_force(forceFR, $Proto_Drone_Mesh/P4.get_transform().origin)
	
#	add_force(self.get_transform().basis.y * motorFL * SPEED, $Proto_Drone_Mesh/P1.get_transform().origin)
#	add_force(self.get_transform().basis.y * motorBL * SPEED, $Proto_Drone_Mesh/P2.get_transform().origin)
#	add_force(self.get_transform().basis.y * motorBR * SPEED, $Proto_Drone_Mesh/P3.get_transform().origin)
#	add_force(self.get_transform().basis.y * motorFR * SPEED, $Proto_Drone_Mesh/P4.get_transform().origin)
	
	# add_torque(Vector3(0, Input.get_axis("yaw_right", "yaw_left") * 10, 0))

	pass
