//敵弾クラス
class Teta extends CharaBase{}

//角度Θ=archtan( 高さ / 底辺)

//敵クラスを親クラスを継承したクラスで作成
class Teki extends CharaBase{
    constructor(snum, x, y, vx, vy){
        super(snum, x, y, vx, vy);
        this.flag = false;
        // this.w = 20;
        // this.h = 20;
        this.r = 10;
    }

    update(){
        super.update(); 

        if(!this.flag){
            if(jiki.x > this.x && this.vx < 120)this.vx += 4;
            else if(jiki.x < this.x && this.vx > -120)this.vx -= 4;
        }
        else {
            if (jiki.x < this.x && this.vx < 400 ) this.vx += 30;
            else if ( jiki.x > this.x && this.vx > -400 ) this.vx -= 30;
        }

        // if ( Math.abs(jiki.y - this.y) < (100<<8) ){
        if ( Math.abs(jiki.y - this.y) < (100<<8) && !this.flag){

            this.flag = true;

            let an, dx, dy;
            an = Math.atan2(jiki.y - this.y, jiki.x - this.x); //自機への角度を求める

            // an += rand(-10,10) * Math.PI / 180; //角度をラジアンに直す

            //x = cos(Θ), y = sin(Θ)
            dx = Math.cos(an) * 1000;
            dy = Math.sin(an) * 1000;

            teta.push(new Teta(15, this.x, this.y, dx, dy));
        }

        if(this.flag && this.vy > -800) this.vy -= 30;
    }

    draw(){
        super.draw();
    }
}
