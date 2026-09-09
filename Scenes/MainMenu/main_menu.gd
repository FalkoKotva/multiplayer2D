extends Control

const PORT: int = 3000

var main_scene: PackedScene = preload("uid://bn1xenp5ckbxk")

# CTRL + dragging from scen will create an onready statement
# dragging from scene will create a path ot the object like $HBoxContainer/HostButton

@onready var single_player: Button = $VBoxContainer/SinglePlayer
@onready var multiplayer_button: Button = $VBoxContainer/MultiplayerButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	single_player.pressed.connect(_on_single_player_pressed)
	multiplayer_button.pressed.connect(_on_multiplayer_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	
func _on_host_pressed () -> void:
	# Meaning of ":=" - variable needs to be a type of return type
	var server_peer := ENetMultiplayerPeer.new()
	server_peer.create_server(PORT)
	multiplayer.multiplayer_peer = server_peer
	
	get_tree().change_scene_to_packed(main_scene)
	
func _on_join_pressed  () -> void:
	var client_peer := ENetMultiplayerPeer.new()
	client_peer.create_client("127.0.0.1",PORT)
	multiplayer.multiplayer_peer = client_peer


func _on_connected_to_server():
	get_tree().change_scene_to_packed(main_scene)

func _on_single_player_pressed():
	get_tree().change_scene_to_packed(main_scene)

func _on_multiplayer_pressed():
	pass

func _on_quit_pressed():
	get_tree().quit()
