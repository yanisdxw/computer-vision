# 平面的提取

## 这里介绍两种方法对点云数据进行平面的提取。一种是利用主成分分析（Principal components analysis，PCA）对点云数据进行处理，通过计算协方差矩阵的方式抽取拟合平面的法线。另一种是通过随机抽样一致算法（RANdom SAmple Consensus，RANSAC）进行平面提取。

### PCA 提取
1. 计算点云数据的质心G 与协方差矩阵M
2. 提取协方差矩阵M的特征值lamda与特征向量 u
3. 最小特征值对应的特征向量u_即为平面的法线向量n

### 代码释义：
 - calcentre：计算质心
 - cal_Mcov：计算协方差矩阵
 - plane_ACP：利用协方差矩阵求平面法向量

### RANSAC

1. 在点云数据中随机抽取三个点x（i），确定一个平面Pi（i），重复p次
2. “投票”：对于每一组样本平面Pi（i）计算离它距离小于阈值delta的点的个数vote（i）
3. 票数最多的i 所对应的平面即为所求平面 

### 代码释义：
 - plane_3pts：三点确定平面法向量与距离
 - vote_plane：投票，计算平面阈值距离内点的个数
 - extraction_plan_RANSAC：执行主程序
