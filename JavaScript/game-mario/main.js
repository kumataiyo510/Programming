// 次回（https://www.youtube.com/watch?v=TxDLa5k6Ogc）

// 仮想キャンバス
let vcan = document.createElement("canvas");
let vcon = vcan.getContext("2d");

let can = document.getElementById("can");
let con = can.getContext("2d");

vcan.width  = SCREEN_SIZE_W;
vcan.height = SCREEN_SIZE_H;

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

// おじさん作成
let ojisan = new Ojisan(100, 100)

// フィールドを作る
let field = new Field();

// ブロックのオブジェクト
let block = [];
let item = [];

function updateObj(obj){
    // スプライトのブロックを更新
    for(let i = obj.length - 1;i >= 0; i--){
        obj[i].update();
        if(obj[i].kill)obj.splice(i, 1);
    }
}




// 更新処理
function update(){
    // マップの更新
    field.update();

    updateObj(block);
    updateObj(item);
    
    // おじさんの更新
    ojisan.update();
}

// スプライトの描画
function drawSprite(snum, x, y){
    let sx = (snum & 15) * 16;    //&15（1111） ビット演算子　サブネットマスク的な意味（サブネット表示では/4的な）であり16で割ることと同じである
    let sy = (snum >> 4) * 16;
    vcon.drawImage(chImg, sx, sy, 16, 32, x, y, 16, 32);

    // console.log(ojisan.y);
}

function drawObj(obj){
        // スプライトのブロックを表示
        for(let i = 0;i < obj.length; i++)
        obj[i].draw();
}


// 描画処理
function draw(){
    // 画面を水色でクリア
    vcon.fillStyle = "#66AAFF";
    vcon.fillRect(0, 0, SCREEN_SIZE_W, SCREEN_SIZE_H);

    // マップを表示
    field.draw();

    // 
    drawObj(block);
    drawObj(item);

    // おじさんを表示
    ojisan.draw();

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
    if(e.keyCode == 90)keyb.BBUTTON = true;
    if(e.keyCode == 88)keyb.ABUTTON = true;

    if(e.keyCode == 65){
        block.push(new Block(368, 5, 5));
    }
    // if(e.keyCode == 65)field.scx--;
    // if(e.keyCode == 83)field.scx++;

}

// キーボードが離されたときに呼ばれる
document.onkeyup = function(e){
    if(e.keyCode == 37)keyb.left = false;
    if(e.keyCode == 39)keyb.right = false;
    if(e.keyCode == 90)keyb.BBUTTON = false;
    if(e.keyCode == 88)keyb.ABUTTON = false;

}