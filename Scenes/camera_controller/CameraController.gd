extends Node3D

@onready var focus : Node3D
@onready var raycast := %RayCast3D
@onready var camera := $SpringArm3D/Camera3D

func _process(delta):
	if not focus:
		return
	
	raycast.force_raycast_update()
	raycast.set_target_position(raycast.to_local(focus.global_position))
	

func set_focus(objective : Node3D):
	focus = objective

func get_camera() -> Camera3D:
	return camera


func get_child_fader(node:Node):
	for child in node.get_children():
		if child is MeshFader:
			return child
	return null

func _on_area_3d_body_entered(body):
	var p = body.get_parent()
	
	print("body entered %s" % p.name)
	if p is MeshInstance3D:
		var mesh_inst:MeshInstance3D = p
		
		var fader:MeshFader = get_child_fader(mesh_inst)
		
		if !fader:
			#var over_mat:StandardMaterial3D = preload("res://materials/translucent_wall.tres").duplicate()
			
			var fader_mat:StandardMaterial3D = StandardMaterial3D.new()
			fader_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			fader_mat.albedo_texture = mesh_inst.get_active_material(0).albedo_texture
		
			fader = MeshFader.new()
			fader.mesh_instance = mesh_inst
#			fader.material = over_mat
			fader.material = fader_mat
			
			mesh_inst.add_child(fader)
		
		fader.opacity = .2


func _on_area_3d_body_exited(body):
	var p = body.get_parent()
	print("body exit %s" % p.name)

	if p is MeshInstance3D:
		var mesh_inst:MeshInstance3D = p
	
		var fader:MeshFader = get_child_fader(mesh_inst)
		if fader:
			fader.opacity = 1
				
