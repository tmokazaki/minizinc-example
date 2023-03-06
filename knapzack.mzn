int: n; % number of objects
% 個別の品物を配列の要素として定義
set of int: OBJ = 1..n;
% 容量
int: capacity;
% 各品物の利益
array[OBJ] of int: profit;
% 各品物のサイズ
array[OBJ] of int: size;

array[OBJ] of var int: x; % how many of each object

% 荷物は0個以上
constraint forall(i in OBJ)(x[i] >= 0);
% 全ての荷物を足し合わせた制約
constraint sum(i in OBJ)(size[i] * x[i]) <= capacity;
% 価値の最大化
solve maximize sum(i in OBJ)(profit[i] * x[i]);

output [
"x = ", show(x), "\n",
"total value= ", show(sum(i in OBJ)(profit[i] * x[i])), "\n"
];
