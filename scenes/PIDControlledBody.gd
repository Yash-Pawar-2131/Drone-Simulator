extends RigidBody
var dir : int
onready var desiredDroneState = get_node("../DesiredPosition")

func _ready():
	print(desiredDroneState)
	pass


func _process(delta):
#	if desired_drone_state.get_transform().basis.z.cross(self.get_transform().basis.z).y >= 0:
#		dir = -1
#	else:
#		dir = 1
#	var error_yaw = (dir) * desired_drone_state.get_transform().basis.z.angle_to(self.get_transform().basis.z)
#	var error_yaw_derivative = (error_yaw - previous_error_yaw) / delta
#	previous_error_yaw = error_yaw
#	error_yaw_integral = error_yaw_integral + error_yaw * delta
	
#	if desiredDroneState.get_transform().basis.y.dot((self.get_transform().basis.z).dot(desiredDroneState.get_transform().basis.x.normalized()) * desiredDroneState.get_transform().basis.x.normalized()) >= 0:
#		dir = 1
#	else:
#		dir = -1
	
	
	
	var projectionX = self.get_transform().basis.z.dot(desiredDroneState.get_transform().basis.x.normalized())) * desiredDroneState.get_transform().basis.x.normalized()
	print(projectionX)
	var projectionY = self.get_transform().basis.z.dot(desiredDroneState.get_transform().basis.y.normalized()) * desiredDroneState.get_transform().basis.y.normalized()
	
	var projection = projectionX + projectionY
#	print(projection)
	
	var pitchError = (self.get_transform().basis.z.dot(desiredDroneState.get_transform().basis.x.normalized())) * desiredDroneState.get_transform().basis.x.normalized().angle_to(projection)
#	var pitchError = (dir) * (self.get_transform().basis.z.dot(desiredDroneState.get_transform().basis.x.normalized()) * desiredDroneState.get_transform().basis.x.normalized()).angle_to(projection)
	
#	print(rad2deg(pitchError))
#	var pitchError = (dir) * (Dz)x.angle_to((Dz)xy)
	
	pass
