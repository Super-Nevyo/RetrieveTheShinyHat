class_name PlayerStateMachine

var Player: PlayerController
var CurrentState:PlayerState
var Move:PSMove
var Fall:PSFalling
var Swim:PSSwim
var God:PSGodMode

func _init(player: PlayerController):
	Player = player
	Move = PSMove.new(Player)
	Fall = PSFalling.new(Player)
	Swim = PSSwim.new(Player)
	God = PSGodMode.new(Player)

func Update(delta:float):
	CurrentState.Update(delta)

func Initialize(StartState:PlayerState):
	CurrentState = StartState
	CurrentState.Enter()

func ChangeState(NewState:PlayerState):
	if NewState == CurrentState:
		return
	CurrentState.Exit()
	CurrentState = NewState
	CurrentState.Enter()
 
func Attack():
	CurrentState.Attack()

func Jump():
	CurrentState.Jump()
