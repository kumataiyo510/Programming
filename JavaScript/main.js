//次回は（https://www.youtube.com/watch?v=DA8IsiscQ9Q）から
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

let key = [];

//キーボードが押されたとき
document.onkeydown = function(e){
    key[e.keyCode] = true;
}

//キーボードが話されたとき
document.onkeyup = function(e){
    key[e.keyCode] = false;
}

let tama = [];

class Tama {
    constructor(x, y, vx, vy){
        this.sn   = 5;
        this.x    = x;
        this.y    = y;
        this.vx   = vx;
        this.vy   = vy;
        this.kill = false;
    }

    update() {
        this.x += this.vx;
        this.y += this.vy;

        if(    this.x < 0 || this.x > FIELD_W<<8
            || this.y < 0 || this.y > FIELD_H<<8)this.kill = true;
    }

    draw(){
        drawSprite( this.sn, this.x, this.y);
    }
}

class Jiki {
    constructor(){
        this.x = (FIELD_W / 2)<<8;
        this.y = (FIELD_H / 2)<<8;
        this.speed = 512; //256で1Fに1pix動く
        this.anime = 0;
    }
    
    //自機の移動
    update(){
        if(key[32]){
            tama.push(new Tama(this.x, this.y, 0, -2000));   //arrayオブジェクトのメソッド"プッシュ"
        }
        if(key[37] && this.x > this.speed){
            this.x -= this.speed; //左
            if(this.anime > -8)this.anime--;
        }
        else if(key[39] && this.x <= (FIELD_W<<8) - this.speed){
            this.x += this.speed; //右
            if(this.anime < 8)this.anime++;
        }
        else {
            if(this.anime>0) this.anime--;
            if(this.anime<0) this.anime++;
        }

        if(key[38] && this.y >  this.speed)
        this.y -= this.speed; //上
        if(key[40] && this.y <= (FIELD_H<<8) - this.speed)
        this.y += this.speed; //下
    }

    //自機の描画
    draw(){
        drawSprite(2 + (this.anime>>2), this.x, this.y);
    }
}
let jiki = new Jiki();

//イメージオブジェクトを作ってファイルを読み込む
let spriteImage = new Image();
spriteImage.src = "sprite.png";
// spriteImage.src = "IMG_2147483647 (1395).png";
// spriteImage.src = "character_04_sp.png";

//スプライトクラス
class Sprite {
    constructor (x, y, w, h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
}

//スプライト：sprite.pngの座標サイズ
let sprite = [
    new Sprite(  0, 0, 22, 48),  //0 左２
    new Sprite( 23, 0, 33, 48),  //1 左１
    new Sprite( 57, 0, 43, 48),  //2 正面
    new Sprite(101, 0, 33, 48),  //3 右１
    new Sprite(135, 0, 22, 48),  //4 右２

    new Sprite(0, 50, 3, 7),     //5 弾１
    new Sprite(0, 50, 5, 5),     //6 弾２

];

/* let sprite = [
    new Sprite(  0, 0, 48, 46),
    new Sprite(  0, 0, 48, 46),
    new Sprite(  0, 0, 48, 46),
    new Sprite(  0, 0, 48, 46),
    new Sprite(  0, 0, 48, 46),
]; */

/* let sprite = [
    new Sprite(  0, 0, 99, 165),
    new Sprite(  0, 0, 99, 165),
    new Sprite(  0, 0, 99, 165),
    new Sprite(  0, 0, 99, 165),
    new Sprite(  0, 0, 99, 165),
]; */

function drawSprite(snum, x, y){
    let sx = sprite[snum].x;
    let sy = sprite[snum].y;
    let sw = sprite[snum].w;
    let sh = sprite[snum].h;

    let px = (x>>8) - sw / 2;
    let py = (y>>8) - sw / 2;

    if(    px + sw / 2 < camera_x || px - sw / 2 >= camera_x + SCREEN_W
        || py + sh / 2 < camera_y || py - sh / 2 >= camera_y + SCREEN_H
    )return;
    
    vcon.drawImage(spriteImage, sx, sy, sw, sh, px, py, sw, sh);
}

//整数のランダム作成関数
function rand(min, max){
    return Math.floor( Math.random() * (max - min + 1) ) + min;
}

//星クラス
class Star {
    constructor() {
        this.x  = rand(0, FIELD_W)<<8;  //8ビットシフト（左）：下8ビット（右側256）は浮動小数点で256で1となる
        this.y  = rand(0, FIELD_H)<<8;
        this.vx = 0;
        this.vy = rand(30,200);
        this.sz = rand(1,2);
    }
    draw(){
        let x = this.x>>8;
        let y = this.y>>8;

        if(   x < camera_x || x >= camera_x + SCREEN_W
           || y < camera_y || y >= camera_y + SCREEN_H
        )return;

        vcon.fillStyle = rand(0, 2) != 0?"red":"white";
        vcon.fillRect(this.x>>8, this.y>>8, this.sz, this.sz);        
    }
    update(){
        this.x += this.vx;
        this.y += this.vy;
        if(this.y > FIELD_H <<8){
            this.y = 0;
            this.x = rand(0, FIELD_W)<<8;
        }
    }
}

//初期化関数
function gameInit(){
    for(let i = 0; i < STAR_MAX; i++)star[i] = new Star();
    setInterval(gameLoop, GAME_SPEED);
}

//ゲームループ
function gameLoop(){
    //移動の処理
    for(let i = 0; i < STAR_MAX; i++)star[i].update();
    for(let i = tama.length - 1; i >= 0; i--){
        tama[i].update();
        if(tama[i].kill)tama.splice(i, 1);
    }
    jiki.update();

    //描画の処理
    vcon.fillStyle = "black";
    vcon.fillRect(camera_x, camera_y, SCREEN_W, SCREEN_H);

    for(let i = 0; i < STAR_MAX; i++)star[i].draw();
    for(let i = 0; i < tama.length; i++)tama[i].draw();
    jiki.draw();
    
    //自機の範囲 0 ~ FIELD_W
    //カメラの範囲 0 ~ (FIELD_W-SCREEN_W)
    camera_x = (jiki.x>>8) / FIELD_W * (FIELD_W-SCREEN_W)
    camera_y = (jiki.y>>8) / FIELD_H * (FIELD_H-SCREEN_H)


    //仮想画面から実際のキャンバスにコピー
    con.drawImage(vcan ,camera_x ,camera_y ,SCREEN_W, SCREEN_H, 0, 0, CANVAS_W, CANVAS_H);
}

//オンロードでゲーム開始
window.onload = function() {
    gameInit();
}