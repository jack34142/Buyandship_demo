## buyandship demo
demo影片: https://www.youtube.com/watch?v=y8_pw28Qlxc

#### File Tree  
|- main.dart  
|- enums => 放enum  
|- configs => 放常用的常數, 目前有MyColors  
|- beans => json 用的 getter setter class  
|- http => api用的, BaseHttp主要設定dio的通用參數  
|- base => 放BaseBloc  
|- ui => 放widget(包含bloc)  

## 簡介
#### main.dart
```
  if (!kDebugMode) {   //release mode 自動禁用 debugPrint
    debugPrint = (String? message, {int? wrapWidth}) => null;
  }
```

```
  runApp(MaterialApp(
    ...
    ...
    builder: (context, child){
      return OverlayPage(child!);  //OverlayPage做全域使用的view, 目前有loading跟toast
    },
  ));
```

#### http/BaseHttp.dart
```
    dio.options.baseUrl = baseUrl;  //設定baseUrl
    dio.options.connectTimeout = Duration(seconds: 60);  //設定timeout的秒數
    dio.interceptors.add(...)  //攔截api request response的header data body ... 等資訊
```

#### http/GovApi.dart
1. GovApi 繼承 BaseHttp, 並override baseUrl
2. 這個class使用singleTon

#### base/BaseBloc.dart
1. BaseBloc 繼承 Bloc
2. 通用function  
   (1) init(context): 這裡初始化那些需要用到context的東西 ex. showMsg  
   (2) showMsg(msg): 通用的訊息談窗  
   (3) onApiError(error): api error時可以call這個function  
   (4) showLoading: 顯示轉圈圈畫面  
   (5) hideLoading: 關閉轉圈圈畫面  
   (6) showToast: 畫面上出現1.5秒的泡泡訊息  

### ui
#### OverlayPage
1. blocEvent有ShowLoading/HideLoading/ShowToast, BaseBloc會呼叫

#### HomePage
1. create時呼叫event GetBridges 跟 GetTunnels
2. callApi的時後會有loading, 沒有api在跑的時後loading會消失
3. api error時會有訊息談窗
4. 返回鍵點按時會出現toast, 1.5秒內再次返回時後會退出應用
5. ui用到2個套件  
   (1) StickyHeader: 保持header在畫面上方  
   (2) ScrollablePositionedList: 方便跳轉到指定的item index  
6. header上面有3個按鈕  
   (1) 開關: 可以將list收起與展開, 然後scroll到該header的position  
   (2) 橋樑: 選取後畫面只會出現橋樑的card, 然後scroll到該header的position  
   (3) 隧道: 選取後畫面只會出現隧道的card, 然後scroll到該header的position  
7. 右下floating button  
   (1) 上: scroll到上一個areaCode的position  
   (2) 下: scroll到下一個areaCode的position  
8. list item  
   (1) 橋樑card  
   (2) 隧道card  
9. RefreshIndicator 下拉刷新

### temeplates
#### CheckButton
1. 用isSelect控制button的顏色

#### MsgDialog
1. 通用的訊息Dialog
2. 有close button
3. tap outside 跟 backPress 都可以關閉談窗
4. 訊息過長, 內文的widget可以scroll
