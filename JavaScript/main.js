//参考サイト（https://aki28.com/f/stg2/）
//敵キャラとボスキャラを増やしてほしい、移動パターンも（https://www.youtube.com/watch?v=9Sn2DVz5nYI）
//敵倒したらアイテムを出してほしい（https://www.youtube.com/watch?v=9Sn2DVz5nYI）
//効果音やBGMをつける（https://www.youtube.com/watch?v=9Sn2DVz5nYI）


//デバッグのフラグ
const DEBUG = false;

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
const SCREEN_W = 320;
const SCREEN_H = 320;

//キャンバスサイズ
const CANVAS_W = SCREEN_W * 2;
const CANVAS_H = SCREEN_H * 2;

//フィールドサイズ
const FIELD_W = SCREEN_W + 120;
const FIELD_H = SCREEN_H + 40;

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
con.font = "20px 'Impact'";

 

//フィールド（仮想画面を作る）
let vcan = document.createElement("canvas");
let vcon = vcan.getContext("2d");
vcan.width  = FIELD_W;
vcan.height = FIELD_H;
con.font = "12px 'Impact'";


//カメラの座標
let camera_x = 0;
let camera_y = 0;

//ゲームオーバーフラグ
let gameOver = false;
let score = 0;

//ボスのHP
let bossHP = 0;
let bossMHP = 0;

//星の実体
let star = [];

//キーボードの状態
let key = [];

//オブジェクトたち
let teki = [];
let teta = [];
let tama = [];
let expl = [];
let jiki = new Jiki();
// teki[0] = new Teki(75, 200<<8, 200<<8, 0, 0);

//イメージオブジェクトを作ってファイルを読み込む
let spriteImage = new Image();
spriteImage.src = "sprite.png";
// spriteImage.src = "IMG_2147483647 (1395).png";      //s
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
    updateObj(expl);
    if(!gameOver)jiki.update();
}

//描画の処理
function drawAll(){
    vcon.fillStyle = (jiki.damage)?"red": "black";
    vcon.fillRect(camera_x, camera_y, SCREEN_W, SCREEN_H);

    drawObj(star);
    drawObj(tama);
    if(!gameOver)jiki.draw();
    drawObj(teki);
    drawObj(expl);
    drawObj(teta);

    //自機の範囲 0 ~ FIELD_W
    //カメラの範囲 0 ~ (FIELD_W-SCREEN_W)
    camera_x = Math.floor((jiki.x>>8) / FIELD_W * (FIELD_W-SCREEN_W));
    camera_y = Math.floor((jiki.y>>8) / FIELD_H * (FIELD_H-SCREEN_H));

    //ボスのHPを表示する
    if(bossHP > 0){
        let sz  = (SCREEN_W - 20) * bossHP / bossMHP;
        let sz2 = (SCREEN_W - 20);
        vcon.fillstyle = "rgba(255, 0, 0, 0.5)";
        vcon.fillRect(camera_x + 10, camera_y + 10, sz, 10)
        vcon.strokeStyle = "rgba(255, 0, 0, 0.9)";
        vcon.strokeRect(camera_x + 10, camera_y + 10, sz2, 10);
    }

    //自機のHPを表示する
    if(jiki.hp > 0){
        let sz  = (SCREEN_W - 20) * jiki.hp / jiki.mhp;
        let sz2 = (SCREEN_W - 20);
        vcon.fillstyle = "rgba(0, 0, 255, 0.5)";
        vcon.fillRect(camera_x + 10, camera_y + SCREEN_H - 14, sz, 10)
        vcon.strokeStyle = "rgba(0, 0, 255, 0.9)";
        vcon.strokeRect(camera_x + 10, camera_y + SCREEN_H - 14, sz2, 10);
    }

    //スコア表示
    vcon.fillstyle = "white";
    vcon.fillText("SCORE" + score, camera_x + 10, camera_y + 14);

    //仮想画面から実際のキャンバスにコピー
    con.drawImage(vcan ,camera_x ,camera_y ,SCREEN_W, SCREEN_H, 0, 0, CANVAS_W, CANVAS_H);
}

//情報の表示
function putInfo(){
    con.fillStyle = "white";

    if(gameOver){
        let s = " GAME OVER";
        let w = con.measureText(s).width;
        let x = CANVAS_W / 2 - w / 2;
        let y = CANVAS_H / 2 - 20;
        con.fillText(s, x, y);
        s = " PUSH 'R' key to restart !";
        w = con.measureText(s).width;
        x = CANVAS_W / 2 - w / 2;
        y = CANVAS_H / 2 - 20 + 20;
        con.fillText(s, x, y);
    }

    if(DEBUG){
        drawCount++;
        if(lastTime + 1000 <= Date.now()){
            fps = drawCount;
            drawCount = 0;
            lastTime  = Date.now();
        }

        con.fillText("FPS:"  + fps, 20, 20);
        con.fillText("Tama:" + tama.length, 20, 40);
        con.fillText("Teki:" + teki.length, 20, 60);
        con.fillText("Teta:" + teta.length, 20, 80);
        con.fillText("Expl:" + expl.length, 20, 100);
        con.fillText("X:"    + (jiki.x >> 8), 20, 120);
        con.fillText("Y:"    + (jiki.y >> 8), 20, 140);
        con.fillText("HP:"   + jiki.hp, 20, 160);
        con.fillText("SCORE:"+ score, 20, 180);
        con.fillText("COUNT:"+ gameCount, 20, 200);
        con.fillText("WAVE:" + gameWave, 20, 220);


    }
}

let gameCount = 0;
let gameWave  = 0;
let gameRound = 0;

let starSpeed    = 100;
let starSpeedReq = 100;

//ゲームループ
function gameLoop(){
    gameCount++;
    if(starSpeedReq > starSpeed)starSpeed++;
    if(starSpeedReq < starSpeed)starSpeed--;


    if(gameWave == 0){

        //テスト的に敵を出す
        if(rand(0,15) == 1){
            teki.push(new Teki(0, rand(0, FIELD_W)<<8, 0, 0, rand(300, 1200)));
        }
        if(gameCount > 60 * 20){
            gameWave++;
            gameCount = 0;
            starSpeedReq = 200;
        }
    }

    if(gameWave == 1){

        //テスト的に敵を出す
        if(rand(0,15) == 1){
            teki.push(new Teki(1, rand(0, FIELD_W)<<8, 0, 0, rand(300, 1200)));
        }
        if(gameCount > 60 * 20){
            gameWave++;
            gameCount = 0;
            starSpeedReq = 100;
        }
    }

    else if(gameWave == 2){

        //テスト的に敵を出す
        if(rand(0,10) == 1){
            let r = rand(0, 1);
            teki.push(new Teki(r, rand(0, FIELD_W)<<8, 0, 0, rand(300, 1200)));
        }
        if(gameCount > 60 * 20){
            gameWave++;
            gameCount = 0;
            teki.push(new Teki(2, (FIELD_W / 2) << 8, -(70 << 8), 0, 200));
            starSpeedReq = 600;
        }
    }

    else if(teki.length == 0){
        if(gameCount > 60 * 20){
            gameWave  = 0;
            gameCount = 0;
            gameRound++;
            starSpeedReq = 100;
        }
    }

    updateAll();
    drawAll();
    putInfo();
}

//オンロードでゲーム開始
window.onload = function() {
    gameInit();
    // teki.push(new Teki(2, (FIELD_W / 2) << 8, 0, 0, 200));

}