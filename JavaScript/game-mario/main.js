// 次回（https://www.youtube.com/watch?v=Zh7Xjkbacoo）
const GAME_FPS = 1000 / 60;
const SCREEN_SIZE_W = 256;
const SCREEN_SIZE_H = 224;

// 仮想キャンバス
let vcan = document.createElement("canvas");
let vcon = vcan.getContext("2d");

let can = document.getElementById("can");
let con = can.getContext("2d");

vcon.width  = SCREEN_SIZE_W;
vcon.height = SCREEN_SIZE_H;

can.width  = SCREEN_SIZE_W * 2;
can.height = SCREEN_SIZE_H * 2;

// 各ブラウザ毎の拡大によるぼやけ防止
con.mozimageSmoothingEnabled    = false;
con.imageSmoothingEnabled       = false;
con.webkitimageSmoothingEnabled = false;
con.msimageSmoothingEnabled     = false;


// フレームレート変数
let frameCount = 0;
let startTime;

let chImg = new Image();
chImg.src = "sprite.png";
chImg.onload = draw;

// キーボード
let keyb = {};

// おじさん情報
// 座標
let oji_x  = 100<<4;
let oji_y  = 100<<4;
let oji_vx = 0;
let oji_anime  =  0;
let oji_sprite = 48;
let oji_acount =  0;
let oji_dir    =  0;

// 更新処理
function update(){
    if(keyb.left){
        if(oji_anime == 0)oji_acount = 0;
        oji_anime = 1;
        oji_dir   = 1;
        if(oji_vx > -32)oji_vx -= 1;
        if(oji_vx > 0) oji_vx -= 1;
        if(oji_vx > 8)oji_anime = 2;
    } else if(keyb.right){
        if(oji_anime == 0)oji_acount = 0;
        oji_anime = 1;
        oji_dir   = 0;
        if(oji_vx <  32)oji_vx += 1;
        if(oji_vx < 0) oji_vx += 1;
        if(oji_vx < -8)oji_anime = 2;
    } else {
        if(oji_vx > 0) oji_vx -= 1;
        if(oji_vx < 0) oji_vx += 1;
        if(!oji_vx)    oji_anime = 0;
    }
    oji_acount++;
    if(Math.abs(oji_vx) == 32)oji_acount++;

    if(oji_anime == 0) oji_sprite = 0;
    else if(oji_anime == 1) oji_sprite = 2 + ((oji_acount/6)%3);
    else if(oji_anime == 2) oji_sprite = 5;
    if(oji_dir)oji_sprite += 48;
    oji_x += oji_vx;
}

function drawSprite(snum, x, y){
    let sx = (snum & 15) * 16;
    let sy = (snum >> 4) * 16;
    vcon.drawImage(chImg, sx, sy, 16, 32, x, y, 16, 32);
    // console.log(snum);

}

// 描画処理
function draw(){
    // 画面を水色でクリア
    vcon.fillStyle = "#66AAFF";
    vcon.fillRect(0, 0, SCREEN_SIZE_W, SCREEN_SIZE_H);

    // おじさんを表示
    drawSprite(oji_sprite, oji_x>>4, oji_y>>4);

    // デバッグ情報を表示
    vcon.font = "24px 'Impact'";
    vcon.fillStyle = "#FFFFFF";
    vcon.fillText("FRAME" + frameCount, 10, 25);
    
    // 仮想画面から実画面へ拡大転送
    con.drawImage(vcan, 0, 0, SCREEN_SIZE_W, SCREEN_SIZE_H,
                        0, 0, SCREEN_SIZE_W * 2, SCREEN_SIZE_H * 2)
}

// ゲームフレームレートの定義（60FPS）（*1 *2と選択的）
// setInterval(mainLoop, 1000/60);

// ループ開始（*2 *1と選択的）
window.onload = function(){
    startTime = performance.now();
    mainLoop();
}

// メインループ
function mainLoop(){
    let nowTime  = performance.now();
    let nowFrame = (nowTime - startTime) / GAME_FPS;

    if(nowFrame > frameCount){
        let c = 0;
        while(nowFrame > frameCount){
            // フレームレート変数の更新
            frameCount++;
            // 更新処理
            update();
            if(++c >= 4)break;
        }
        // 描画処理
        draw();
    }
    // 再帰でmainLoopを呼び出す（*2 *1と選択的）
    requestAnimationFrame(mainLoop);
}


// キーボードが押されたときに呼ばれる
document.onkeydown = function(e){
    if(e.keyCode == 37)keyb.left = true;
    if(e.keyCode == 39)keyb.right = true;  
}

// キーボードが離されたときに呼ばれる
document.onkeyup = function(e){
    if(e.keyCode == 37)keyb.left = false;
    if(e.keyCode == 39)keyb.right = false;  
}