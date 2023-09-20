% num of clusters
int: k;

% num of points
int: n;

% points
array[1..n] of float: x1;
array[1..n] of float: x2;

% centroids
array[1..k] of var float: c1;
array[1..k] of var float: c2;

% variable holding distance of a point form its centroid
array[1..n] of var float: d;
array[1..n, 1..k] of var float: abs_d;

% finding min distance from centroid
array[1..n, 1..k] of var int: y;

% large number
int: M = 1000000000;

constraint forall (i in 1..n, j in 1..k) ( abs_d[i,j] >= ((x1[i] - c1[j]) + (x2[i] - c2[j])) );
constraint forall (i in 1..n, j in 1..k) ( abs_d[i,j] >= (-(x1[i] - c1[j]) + (x2[i] - c2[j])) );
constraint forall (i in 1..n, j in 1..k) ( abs_d[i,j] >= ((x1[i] - c1[j]) - (x2[i] - c2[j])) );
constraint forall (i in 1..n, j in 1..k) ( abs_d[i,j] >= (-(x1[i] - c1[j]) - (x2[i] - c2[j])) );


constraint forall (i in 1..n, j in 1..k) ( abs_d[i,j] <= (d[i] + (1 - y[i,j]) * M) ) ;
constraint forall (i in 1..n) (sum(j in 1..k)(y[i,j]) = 1);
constraint forall (i in 1..n, j in 1..k) (y[i,j] >= 0);

solve minimize (sum(i in 1..n)(d[i]));