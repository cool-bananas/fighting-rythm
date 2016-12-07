
extends "res://gamestate/controller.gd"

func _ready():
  yield(self, "players_are_set")
  for player in players.get_children():
    player.connect("player_attack", self, "_on_player_attack")

func _on_player_attack(player, type):
  call(type + "_attack", player, player.get_attacks())

func weak_attack(player, attacks):
  player.still()
  player.set_state('attack_a')
  attacks.weak_attack()
  yield(attacks, "attack_done")
  player.set_state('idle')

func strong_attack(player, attacks):
  player.still()
  player.set_state('attack_b')
  attacks.strong_attack()
  yield(attacks, "attack_done")
  player.set_state('idle')

func bullet_attack(player, attacks):
  player.still()
  player.set_state('attack_c')
  attacks.bullet_attack()
  yield(attacks, "attack_done")
  player.set_state('idle')
