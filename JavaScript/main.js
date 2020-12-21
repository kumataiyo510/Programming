//次回は（https://www.youtube.com/watch?v=OdD0N3BV8mE)
//デバッグのフラグ
const DEBUG = true;

//
let drawCount = 0;
let fps = 0;
let lastTime = Date.now();

//スムージング
const SMOOTHING = false;

//ゲームスピード
GAME_SPEED = 1000/60; //1秒(1000MS)を60で割ったもの、つまり60FPS

/* 
イメージの話
サッカーのグラウンド　　=フィールド
カメラの画　　　　　　　=スクリーン
家で見ているディスプレイ=キャンバス
 */

 //画面サイズ
const SCREEN_W = 180;
const SCREEN_H = 320;

//キャンバスサイズ
const CANVAS_W = SCREEN_W * 2;
const CANVAS_H = SCREEN_H * 2;

//フィールドサイズ
const FIELD_W = SCREEN_W * 2;
const FIELD_H = SCREEN_H * 2;

//星の数
const STAR_MAX = 300

//キャンバスを作る
let can = document.getElementById("can");
let con = can.getContext("2d");
can.width  = CANVAS_W;
can.height = CANVAS_H;

con.mozimageSmoothingEnabled = SMOOTHING;
con.webkitimagieSmoothingEnabled = SMOOTHING;
con.msImageSmoothingEnabled = SMOOTHING;
con.imageSmoothingEnabled = SMOOTHING;
 

//フィールド（仮想画面を作る）
let vcan = document.createElement("canvas");
let vcon = vcan.getContext("2d");
vcan.width  = FIELD_W;
vcan.height = FIELD_H;

//カメラの座標
let camera_x = 0;
let camera_y = 0;

//星の実体
let star = [];

//キーボードの状態
let key = [];

//オブジェクトたち
let teki = [];
let teta = [];
let tama = [];
let jiki = new Jiki();
// teki[0] = new Teki(75, 200<<8, 200<<8, 0, 0);

//イメージオブジェクトを作ってファイルを読み込む
let spriteImage = new Image();
spriteImage.src = "sprite.png";
// spriteImage.src = "IMG_2147483647 (1395).png";   //さや
// spriteImage.src = "character_04_sp.png";            //プリキュア

//初期化関数
function gameInit(){
    for(let i = 0; i < STAR_MAX; i++)star[i] = new Star();
    setInterval(gameLoop, GAME_SPEED);
    //本気でFPSを設定したいときはrequestAnimationFrameを利用する
}

//オブジェクトをアップデート
function updateObj(obj){
    for(let i = obj.length - 1; i >= 0; i--){
        obj[i].update();
        if(obj[i].kill)obj.splice(i, 1); //spliceは配列の要素を消すメソッドだが、その際に消された添え字番号が消えるので上のif文では大きな数値からチェックしている
    }
}

//オブジェクトを描画
function drawObj(obj){
    for(let i = 0; i < obj.length; i++)obj[i].draw();

}

//移動の処理
function updateAll(){
    updateObj(star);
    updateObj(tama);
    updateObj(teki);
    updateObj(teta);
    jiki.update();
}

//描画の処理
function drawAll(){
    vcon.fillStyle = "black";
    vcon.fillRect(camera_x, camera_y, SCREEN_W, SCREEN_H);

    drawObj(star);
    drawObj(tama);
    jiki.draw();
    drawObj(teta);
    drawObj(teki);

    //自機の範囲 0 ~ FIELD_W
    //カメラの範囲 0 ~ (FIELD_W-SCREEN_W)
    camera_x = (jiki.x>>8) / FIELD_W * (FIELD_W-SCREEN_W)
    camera_y = (jiki.y>>8) / FIELD_H * (FIELD_H-SCREEN_H)

    //仮想画面から実際のキャンバスにコピー
    con.drawImage(vcan ,camera_x ,camera_y ,SCREEN_W, SCREEN_H, 0, 0, CANVAS_W, CANVAS_H);
}

//情報の表示
function putInfo(){
    if(DEBUG){
        drawCount++;
        if(lastTime + 1000 <= Date.now()){
            fps = drawCount;
            drawCount = 0;
            lastTime  = Date.now();
        }

        con.font = "20px 'Impact'";
        con.fillStyle = "white";
        con.fillText("FPS:"  + fps, 20, 20);
        con.fillText("Tama:" + tama.length, 20, 40);
        con.fillText("Teki:" + teki.length, 20, 60);
        con.fillText("Teta:" + teta.length, 20, 80);
    }
}

//ゲームループ
function gameLoop(){
    //テスト的に敵を出す
    if(rand(0,10) == 1)
    teki.push(new Teki(39, rand(0, FIELD_W)<<8, 0, 0, rand(300, 1200)));

    updateAll();
    drawAll();
    putInfo();
}

//オンロードでゲーム開始
window.onload = function() {
    gameInit();
}