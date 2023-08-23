extends Node3D
#this script is only used to describe how we created the scene

#1-Double click on the GLB file and change the root type to CharacterBody3D
#2-Disable export for all the unneaded shapes
#3-set loopmode to Linear for all the animations
#4-Add an animation tree and add our animation player into it
#5-set the tree root, for example to "AnimationStateMachine"
#6-Under root motion, click on track and select Root
#7-In tha Animation tree editor, add a blendSpace1D, connect it to the start, then enter it, and creat two points
#Idle animation in the center, and walk animation in 1
#add a collision shape, add the player to the world scene, add a camera, add a world environment and a sun, make the ground
#the character controllers comments are in the character script


@onready var player := %Misha
@onready var camera_controller := %CameraController
#@onready var bubble_text := %BubbleText
#@onready var mum := %Mum

func _ready():
	#### World is responsible to tell the camera who to focus, maybe we don't
	#### want to focus the player.
	camera_controller.set_focus(player)
#	bubble_text.set_current_camera(camera_controller.get_camera())
	
#	var interactables = get_tree().get_nodes_in_group("interactable")
#	for interactable in interactables:
#		bubble_text.set_current_npc(interactable)  # We connect all interactables to the BubbleText

func _process(delta):
	#### World is responsible of updating the camera's position, maybe we don't
	#### want to follow the player (but we can still focus it).
	update_camera_position(delta) # We delegate the responsibility
	

func update_camera_position(delta):
	camera_controller.global_position = lerp(camera_controller.global_position,player.global_position,5.0*delta)
