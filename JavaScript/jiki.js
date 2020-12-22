//弾クラス
class Tama extends CharaBase{
    constructor(x, y, vx, vy){
        super(5, x, y, vx, vy);
        // this.w = 4;
        // this.h = 6;
        this.r = 4;
    }

    update(){
        super.update();

        for (let i = 0; i < teki.length; i++){
            if(!teki[i].kill){
                if(checkHit(
                    // this.x, this.y, this.w, this.h,
                    this.x, this.y, this.r,
                    // teki[i].x, teki[i].y, teki[i].w, teki[i].h
                    teki[i].x, teki[i].y, teki[i].r
                )) {
                    teki[i].kill = true;
                    this.kill = true;
                    break;
                }
            }
        }
    }

    draw(){
        super.draw();
    }
}

class Jiki {
    constructor(){
        this.x = (FIELD_W / 2)<<8;
        this.y = (FIELD_H / 2)<<8;
        this.speed  = 512; //256で1Fに1pix動く
        this.anime  = 0;
        this.reload = 0;
        this.relo2  = 0;
    }
    
    //自機の移動
    update(){
        if(key[32] && this.reload == 0){
            tama.push(new Tama(this.x + (4<<8), this.y-(10<<8),   0, -2000));   //arrayオブジェクトのメソッド"プッシュ"
/*             tama.push(new Tama(this.x - (4<<8), this.y-(10<<8),   0, -2000));
            tama.push(new Tama(this.x + (8<<8), this.y-(10<<8),  80, -2000));
            tama.push(new Tama(this.x - (8<<8), this.y-(10<<8), -80, -2000)); */
            this.reload = 4;
            if(++this.relo2 == 4){
                this.reload = 20;
             this.relo2  = 0;
            }
        }

        if(!key[32]) this.reload = this.relo2 = 0
        if(this.reload > 0) this.reload--;

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