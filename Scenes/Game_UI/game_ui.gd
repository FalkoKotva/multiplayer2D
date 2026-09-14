class_name GameUi
extends CanvasLayer

@export var enemy_manager: EnemyManager
@onready var timer_label: Label = %TimerLabel
@onready var round_label: Label = %RoundLabel
@onready var health_progress_bar: ProgressBar = %HealthProgressBar
@onready var display_name_label: Label = %DisplayNameLabel
@onready var ready_label: Label = %ReadyLabel
@onready var not_ready_label: Label = %NotReadyLabel
@onready var count_ready_label: Label = %CountReadyLabel
@onready var ready_up_container: VBoxContainer = %ReadyUpContainer
@onready var round_info_container: VBoxContainer = %RoundInfoContainer

@export var lobby_manager: LobbyManager

func _ready() -> void:
	enemy_manager.round_changed.connect(_on_round_began)
	lobby_manager.self_peer_ready.connect(_on_self_peer_ready)
	lobby_manager.lobby_closed.connect(_on_lobby_closed)
	lobby_manager.peer_ready_state_changed.connect(_on_peer_ready_state_changed)
	
	var is_single_plyer := multiplayer.multiplayer_peer is OfflineMultiplayerPeer
	
	ready_up_container.visible = !is_single_plyer
	round_info_container.visible = is_single_plyer
	ready_label.visible = false
	not_ready_label.visible = true


func _process(delta: float) -> void:
	timer_label.text = str(ceili(enemy_manager.get_round_time_remaining()))

func connect_player(player: Player):
	(func():
		if multiplayer.multiplayer_peer is OfflineMultiplayerPeer:
			display_name_label.text = "You"
		else:
			display_name_label.text = player.display_name
		player.health_component.health_changed.connect(_on_health_changed)
		_on_health_changed(player.health_component.current_health, player.health_component.max_health)
		).call_deferred() # this is called after the player is added to the scene so that health_component is ready
	
	
func _on_round_began(round_count: int):
	round_label.text = "Round %s" % round_count

func _on_health_changed(current_health: int, max_health: int):
	health_progress_bar.value = float(current_health) / max_health if max_health != 0 else 0

func _on_self_peer_ready ():
	ready_label.visible = true
	not_ready_label.visible = false

func _on_lobby_closed():
	ready_up_container.visible = false
	round_info_container.visible = true

func _on_peer_ready_state_changed(ready_count: int , total_count: int):
	count_ready_label.text = "%s/%s READY" % [ready_count, total_count]
