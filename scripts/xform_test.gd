extends MeshInstance


onready var desired_drone_state = get_node("/root/Spatial/Desired_Drone_State")
var vec : Vector3


func _ready():
	pass

func _process(delta):
	# self.global_transform.origin = desired_drone_state.get_transform().basis.xform(self.global_transform.origin)
	vec = desired_drone_state.get_transform().basis.xform(self.get_transform().basis.z)
	look_at(vec, self.get_transform().basis.y)

