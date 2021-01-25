# 数学を勉強する意味
世の中の課題を解決すること<br>
## 数学のはじまり
* 幾何学
    * 測ること
    * 客観性がある（再現性がある）<br>
## 数学で大事なこと
* 公式を覚えるのではなく、意味を理解して「論理的に考えること」<br>
≒ロジックを自然言語で記述したものが国語であって、記号で書いたのが数学なだけ
* 論理的思考力　＝　思考体力
    1. 自己駆動力（知りたいと思う力）
    2. 多段思考力（考え続ける力）
    3. 疑い力　　（自分の判断を疑う力）
    4. 大局力　　（俯瞰して眺める力）
    5. 場合分け力（正しく評価する力）
    6. ジャンプ力（閃き）<br><br>

# 数学の世界は三つに分かれている
* 代数（数・式） = 二次方程式
* 解析（グラフ） = 微分・積分
* 幾何（図形）   = ベクトル
## 数学の重要な考え方
わからないものはわからなくていい、とりあえず **"x"** と置いて、そのうえでxの因果関係から答えを導き出す。<br>
わからないことが出てきたら都合の良い決まり事を作ればよい（√等）<br><br>

# 代数
* 一次方程式
~~~
    2 * x + 4 = 10
    これを解く際には2*xを塊としてとらえる
    2 * x = □
    □ + 4 = 10
    □ = 6
    2 * x = 6
    x = 3
~~~
* 負の数
~~~
    2 * x + 10 = 0
    x = -5
    負の数が存在しないと答えが「答えなし」のままになってしまう
~~~
* 二次方程式
~~~
    わからないものがかけられた回数が１回なら１次式、２回なら２次式
    a * a ２次式
    b + b １次式
~~~
* 無理数
~~~
    x * x = 3
    x^2 = 3
    x = √3
    この場合の√3を無理数（平方根）という 
~~~
<br>

# 二次方程式
## 片ずれ、両ずれの法則
* 片ずれ<br>
x * (x + 1) = 4
* 両ずれ<br>
(x + 2) * (x + 1) = 4

### 解法
~~~
x^2 + x = 4　上の片ずれから変形
x^2 + 3x = 2　上の両ずれから変形
↑
(x + 1) * (x + 1) = 4　両ずれで、両方同じ数だけずれていれば解けたのにと思った人がいた
(x + 1)^2 = 4
x + 1 = ±2
x = ±2 - 1
x = -3, 1
ならば、同じ数のずれの式に変換しよう
↓
x^2 + 4x + 3 = 0　+3はいったん無視して
(x + 2) * (x + 2) + 3 = 0　4xの4の半分で変形
(x + 2) * (x + 2) - 4 + 3 = 0　(x + 2)を展開すると+4が出てきて邪魔なので-4して消す
(x + 2) * (x + 2) - 1 = 0
(x + 2) ^2 = 1
x = ±1 - 2 
x = -1, -3
↓
上記の方法（平方完成）は使えそうだ　≒　解の公式は覚える必要なし
∵解の公式は平方完成で導き出せるから
~~~
### 例題：x ( 2x + 5 ) = 600　を解きなさい
~~~
x(2x + 5) = 600
2x^2 + 5x = 600
x^2 + (5x / 2) = 300
(x + 5/4)^2 - 25/16 = 300
(x + 5/4)^2 = 300 + 25/16
x + 5/4 = √(300 + 25/16)
x = √(300 + 25/16) - 5/4
~~~
### 因数分解による二次方程式の解き方
* ポイント１<br>
x * y = 0　のように右辺が0の場合にのみ利用できる<br>
    * 片ずれと両ずれで上記を考える<br>
(x + 1) * (x - 2) = 0　両ずれ<br>
x * (x + 1) = 0　片ずれ<br>
答えはそれぞれ<br>
x = -1, 2<br>
x = 0, -1<br>
∵乗算して0になる形だから
* ポイント２<br>
かけて０次の係数、足して１次の係数になる数の組み合わせが存在するか
    * x^2 - x - 2 = 0<br>
x^2 + 6x - 4 = 0<br>
それぞれ組み合わせを考える<br>
-2 * +1 = -2, -2 - (+1) = -1　で上は存在<br>
下は存在しない<br>
よって<br>
(x -2)*(x +1) = 0<br>
x = 2, -1　が因数分解により導かれる
* ポイント３<br>
因数分解で解ける問題はあまり存在しない、また因数分解を利用しなくても平方完成を利用すれば問題自体は解くことができる。

tips)<br>
もともと因数分解は共通項を抽出することを意味する[3x + 6]は[3(x +2)]に変換できる。この考え方事態はすごく大事で、実社会でこの概念はすごく役立つものである。<br><br>

# 解析
最終的には微分積分を行うことのこと

## 関数と方程式の違い
* 方程式 特定の条件下におけるx（わからないもの）について解くこと
* 関数 関係性そのものを表す（条件が定まったときは、方程式になる）

イメージ<br>
関数の線は線の集合体により成り立っていることを認識する<br>

## 一次関数と二次関数の違い
変数同士のかけ算が含まれないもの<br>
y = ax + b<br>
変数同士の掛け算が含まれるもの<br>
y = ax^2 + bx + c <br>
cの値は放物線をずらす値のことと考える<br>

## 二次関数のグラフの移動
* 右移動（y = 0のときx = nになるように）<br>
y = a(x - n)^2 + b(x - n) + c
* 左移動（y = 0のときx = -nになるように）<br>
y = a(x + n)^2 + b(x + n) + c

```
平方完成
y = ax^2 + bx + c
y = a(x + b/2a)^2 + c - b^2/4a
xが左にb/2aずれていて、上にc - b^2/4aずれているということ
```

## 反比例（第３の関数）
比例には正の比例（右上がり）と負の比例（右下がり）がある。反比例はそのどちらでもない。<br>
反比例とはy = a / x のグラフで、x軸とy軸に交わることがない。<br>

### 反比例の例
トレードオフの関係にあるもの（例：長方形の面積に対する長さの比率）
面積 = 縦 * 横
```
変形
横 = 面積 / 縦 (y = a / x)
y = 500 / x で面積500の場合は横と縦の長さの比が出る
```

<br>

# 幾何（図形）
図形の基本は三角形と丸<br>
∵点が一つで点、点が二つで線、点が三つで面（三角形は面の最小単位）<br>

## 三平方の定理
a^2 = b^2 + c^2<br>
斜辺^2 = 残りの二辺の二乗の和

## 円
* 円周角の定理<br>
1. 中心のところにできた各派、角Aの２倍になる
2. 円に内接する四角形があったときに、向き合う内閣を足すと必ず１８０度になる
3. 円に内接する三角形の辺が円の中心をとおる場合、その三角形は必ず直角三角形になる
* 方べきの定理
1. ２点が演習場にある三角形のもう一点が円の外側にはみ出たとき、元の大きな三角形とはみ出した小さな三角形は相似になる

中学数学は終了
# 微分積分のさわり（高校数学）
微分：分けて考える
積分：分けたものを積み上げて合算する

物事の考え方へも応用ができる<br>
細かく分けるほど、物事は単純に具体的になってくるので考える際には微分を行う。最後に積分で元に戻せばよい。