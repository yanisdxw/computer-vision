
迭代最近点 Iterative Closest Point （ICP）

ICP算法是点云配准中的常用算法，其本质上是基于最小二乘法的最优配准方法.其算法过程如下：

1. 对于目标点云中的每个点，匹配参考点云中的最近点（目标点P1与参考点P2的个数不一定一致，但得到的匹配点P1’与P2’的数目应相同）。
2. 对得到的新的匹配点P1‘与P2’，计算刚体变换矩阵R与T。
3. 将变换矩阵作用于参考匹配点P1’。计算新参考匹配点P1’与目标匹配点P2’的均方根差f。
4. 迭代，重复（2）（3），直到 f小于一个阈值fmax或达到规定的迭代次数。

需要注意几个问题：

1. 因异常点造成的f无法收敛。
2. 局部最优解的问题。

算法的优化：

因为需要对每一组匹配点进行计算，时间复杂度为O(n1n2). 当匹配点数量很少时（小于1000个）计算时间只需要几秒钟，但是当点的数量过大（比如通过Kinect获取的点云数据）时，可能需要几个小时。这里提出两种常用的优化方法。

1. 对匹配点进行采样（取N个点），使其复杂度降为O(N n2) ，N << n1。本程序使用的就是采样优化。
2. 最邻近近似法（Approximate Nearest Neighbor，ANN）。将点云数据存储到kd-tree中从而实现最邻近搜索，时间复杂度可以降为O(n1 log n2)。

代码文件释义：

 appariement：对参考点与目标点进行匹配，得到一组匹配点
 decimation：采样函数
 evolution：均方差估值函数
 iteration：迭代主程序
 tf_RT：刚体作用矩阵
 transf：求变换矩阵

迭代前:
![](https://github.com/yanisdxw/computer-vision/blob/master/ICP/screenshots/foot_init.png)

迭代后：
![](https://github.com/yanisdxw/computer-vision/blob/master/ICP/screenshots/foot_ite5.png)

f值收敛：
![](https://github.com/yanisdxw/computer-vision/blob/master/ICP/screenshots/foot_ite5.png)


