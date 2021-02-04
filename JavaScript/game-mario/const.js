// 
// 定数の定義用
// 

const GAME_FPS = 1000 / 60;    //FPS
const SCREEN_SIZE_W = 256;     //画面のサイズ横
const SCREEN_SIZE_H = 224;     //画面のサイズ縦

//一画面当たりのブロックの数（サイズ）
const MAP_SIZE_W = SCREEN_SIZE_W / 16;
const MAP_SIZE_H = SCREEN_SIZE_H / 16;

// マップデータのブロックの数
const FIELD_SIZE_W = 256;
const FIELD_SIZE_H = 14;

//
// スプライトの基本クラス
//
class Sprite{
    constructor(sp, x, y, vx, vy){
        this.sp = sp;
        this.x  = x<<8;
        this.y  = y<<8;
        this.vx = vx;
        this.vy = vy;

        this.kill  = false;
        this.count = 0;
    }

    // 更新処理
    update(){
        if(this.vy < 64)this.vy += GRAVITY;
        this.x += this.vx;
        this.y += this.vy;

        if((this.y >> 4) > FIELD_SIZE_H * 16)this.kill = true;
    }

    // 描画処理
    draw(){
        if(this.kill)return;
        
        let an = this.sp;
        let sx = (an & 15) * 16;    //&15（1111） ビット演算子　サブネットマスク的な意味（サブネット表示では/4的な）であり16で割ることと同じである
        let sy = (an >> 4) * 16;
        let px = (this.x >> 4) - (field.scx);
        let py = (this.y >> 4) - (field.scy);
        vcon.drawImage(chImg, sx, sy, 16, 16, px, py, 16, 16);
    }
}