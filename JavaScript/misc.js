//キーボードが押されたとき
document.onkeydown = function(e){
    key[e.keyCode] = true;
}

//キーボードが話されたとき
document.onkeyup = function(e){
    key[e.keyCode] = false;
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

        vcon.fillStyle = rand(0, 2) != 0?"#66f":"#aef";
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

//キャラクターのベースクラス
class CharaBase {
    constructor(snum, x, y, vx, vy){
        this.sn   = snum;
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

function drawSprite(snum, x, y){
    let sx = sprite[snum].x;
    let sy = sprite[snum].y;
    let sw = sprite[snum].w;
    let sh = sprite[snum].h;

    let px = (x>>8) - sw / 2;
    let py = (y>>8) - sw / 2;

    if(    px + sw < camera_x || px >= camera_x + SCREEN_W
        || py + sh < camera_y || py >= camera_y + SCREEN_H
    )return;
    
    vcon.drawImage(spriteImage, sx, sy, sw, sh, px, py, sw, sh);
}

//整数のランダム作成関数
function rand(min, max){
    return Math.floor( Math.random() * (max - min + 1) ) + min;
}

