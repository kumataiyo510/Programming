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

# 次回１４６ページから