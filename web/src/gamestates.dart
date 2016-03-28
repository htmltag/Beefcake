part of beefcakegame;

enum GameStateEnum{intro, start, playing, gameOver, won, restart}

class GameStates{
  GameStateEnum currentState;

  GameStates(){
    currentState = GameStateEnum.intro;
  }

  void ChangeState(GameStateEnum state){
    currentState = state;
  }



}