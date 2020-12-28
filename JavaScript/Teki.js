//敵弾クラス
class Teta extends CharaBase{

    constructor(sn, x, y, vx, vy){
        super(sn, x, y, vx, vy);
        this.r = 4;
    }

    update(){
        super.update();

        if(!gameOver && !jiki.muteki && checkHit(
            // this.x, this.y, this.w, this.h,
            this.x, this.y, this.r,
            // teki[i].x, teki[i].y, teki[i].w, teki[i].h
            jiki.x, jiki.y, jiki.r)) {
            this.kill   = true;

            if((jiki.hp -= 30) <= 0){
                gameOver = true;
            } else {
                jiki.damage = 10;
                jiki.muteki = 60;
            }

        }
        this.sn = 14 + ((this.count >> 3) & 1);
    }
}

//角度Θ=archtan( 高さ / 底辺)

//敵クラスを親クラスを継承したクラスで作成
class Teki extends CharaBase{
    constructor(t, x, y, vx, vy){
        super(0, x, y, vx, vy);
        this.tnum = tekiMaster[t].tnum;
        this.r    = tekiMaster[t].r;
        this.hp   = tekiMaster[t].hp;
        this.score= tekiMaster[t].score;
        this.flag = false;
    }

    update(){
        //共通のアップデート
        super.update(); 

        //個別のアップデート
        tekiFunc[this.tnum](this);

        //当たり判定
        if(!gameOver && !jiki.muteki && checkHit(
            // this.x, this.y, this.w, this.h,
            this.x, this.y, this.r,
            // teki[i].x, teki[i].y, teki[i].w, teki[i].h
            jiki.x, jiki.y, jiki.r)) {
            this.kill   = true;

            if((jiki.hp -= 30) <= 0){
                gameOver = true;
            } else {
                jiki.damage = 10;
                jiki.muteki = 60;
            }
        }
    }
}

//弾を自機に向けて発射する
function tekiShot(obj, speed){
    if(gameOver)return;
    let an, dx, dy;
    an = Math.atan2(jiki.y - obj.y, jiki.x - obj.x); //自機への角度を求める

    // an += rand(-10,10) * Math.PI / 180; //角度をラジアンに直す

    //x = cos(Θ), y = sin(Θ)
    dx = Math.cos(an) * speed;
    dy = Math.sin(an) * speed;

    teta.push(new Teta(15, obj.x, obj.y, dx, dy));
}

//ピンクのひよこ
function tekiMove01(obj){
    if(!obj.flag){
        if(jiki.x > obj.x && obj.vx < 120)obj.vx += 4;
        else if(jiki.x < obj.x && obj.vx > -120)obj.vx -= 4;
    }
    else {
        if (jiki.x < obj.x && obj.vx < 400 ) obj.vx += 30;
        else if ( jiki.x > obj.x && obj.vx > -400 ) obj.vx -= 30;
    }

    // if ( Math.abs(jiki.y - obj.y) < (100<<8) ){
    if ( Math.abs(jiki.y - obj.y) < (100<<8) && !obj.flag){

        obj.flag = true;
        tekiShot(obj, 600);

    }

    if(obj.flag && obj.vy > -800) obj.vy -= 30;

    //スプライトの変更
    const ptn = [39, 40, 39, 41];
    obj.sn = ptn[(obj.count >> 3) & 3];    //%4と&3は同じ結果
}

//黄色のひよこ
function tekiMove02(obj){
    if(!obj.flag){
        if(jiki.x > obj.x && obj.vx < 600)obj.vx += 4;
        else if(jiki.x < obj.x && obj.vx > -600)obj.vx -= 4;
    }
    else {
        if (jiki.x < obj.x && obj.vx < 400 ) obj.vx += 30;
        else if ( jiki.x > obj.x && obj.vx > -400 ) obj.vx -= 30;
    }

    // if ( Math.abs(jiki.y - obj.y) < (100<<8) ){
    if ( Math.abs(jiki.y - obj.y) < (100<<8) && !obj.flag){

        obj.flag = true;

        tekiShot(obj, 600);
    }

    //スプライトの変更
    const ptn = [33, 34, 33, 35];
    obj.sn = ptn[(obj.count >> 3) & 3];    //%4と&3は同じ結果
    
}

let tekiFunc = [
    tekiMove01,
    tekiMove02
];