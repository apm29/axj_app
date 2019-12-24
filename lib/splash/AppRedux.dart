//数据类
class AppState {
  int count;

  AppState(this.count);

}

enum AppActions{ENTER,REJECT}

AppState appReduce(AppState state, action) {
  switch(action){
    case AppActions.ENTER:{
      state.count++;
      break;
    }
    case AppActions.REJECT:{
      state.count--;
      break;
    }
  }
  return state;
}