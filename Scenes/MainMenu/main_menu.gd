extends Control


var main_scene: PackedScene = preload("uid://bn1xenp5ckbxk")

# CTRL + dragging from scen will create an onready statement
# dragging from scene will create a path ot the object like $HBoxContainer/HostButton

@onready var single_player: Button = $VBoxContainer/SinglePlayer
@onready var multiplayer_button: Button = $VBoxContainer/MultiplayerButton
@onready var quit_button: Button = $VBoxContainer/QuitButton
@onready var multiplayer_scene: PackedScene = load("uid://brcmm2ybedgyr")


func _ready() -> void:
	single_player.pressed.connect(_on_single_player_pressed)
	multiplayer_button.pressed.connect(_on_multiplayer_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	


func _on_single_player_pressed():
	get_tree().change_scene_to_packed(main_scene)

func _on_multiplayer_pressed():
	get_tree().change_scene_to_packed(multiplayer_scene)

func _on_quit_pressed():
	get_tree().quit()
