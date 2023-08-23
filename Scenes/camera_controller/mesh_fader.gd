extends Node
class_name MeshFader

@export var mesh_instance:MeshInstance3D
@export var material:StandardMaterial3D
@export var opacity:float
@export var rate:float = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh_instance.material_override = material
	#material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var cur_opacity = lerp(material.albedo_color.a, opacity, delta * rate)
	material.albedo_color.a = cur_opacity
	
