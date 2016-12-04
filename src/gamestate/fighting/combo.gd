
extends "res://gamestate/controller.gd"

func _ready():
  yield(self, "players_are_set")
  for player in players.get_children():
    player.connect("player_attack", self, "_on_player_attack")

func _on_player_attack(player, type):
  var attacks = player.get_attacks()
  var combo = player.get_combo()
  call(type + "_attack", player, attacks, combo)

func weak_attack(player, attacks, combo):
  if combo.weak < 3:
    combo.weak += 1
    player.still()
    player.set_state('attack_A')
    attacks.weak_attack()
    yield(attacks, "attack_done")
    player.set_timer(0.05)
  if combo.weak == 3:
    player.set_timer(0.4)
  yield(player.get_timer(), "timeout")
  player.set_state('idle')
  player.reset_combo()
  print("combo reset!")

func strong_attack(player, attacks, combo):
  if combo.strong < 1:
    combo.strong += 1
    player.still()
    player.set_state('attack_B')
    attacks.strong_attack()
    yield(attacks, "attack_done")
    player.set_timer(0.5)
  yield(player.get_timer(), "timeout")
  player.set_state('idle')
  player.reset_combo()
  print("combo reset!")

func bullet_attack(player, attacks, combo):
  if combo.bullet < 1:
    combo.bullet += 1
    player.still()
    player.set_state('attack_B')
    attacks.bullet_attack()
    yield(attacks, "attack_done")
    player.set_timer(0.5)
  yield(player.get_timer(), "timeout")
  player.set_state('idle')
  player.reset_combo()
  print("combo reset!")
