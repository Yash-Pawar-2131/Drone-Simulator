extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var pivot : NodePath
onready var pos = get_node(pivot)

# Called when the node enters the scene tree for the first time.
func _ready():
#	print(self.BodyAxis.BODY_AXIS_LINEAR_X)
#	set_axis_lock(self.BODY_AXIS_ANGULAR_X, true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _integrate_forces(state):
#	state.set_transform(pos.global_transform)
	pass
