//敵クラスを親クラスを継承したクラスで作成
class Teki extends CharaBase{
    constructor(snum, x, y, vx, vy){
        super(snum, x, y, vx, vy);
    }

    update(){
        super.update(); 
    }

    draw(){
        super.draw();
    }
}
