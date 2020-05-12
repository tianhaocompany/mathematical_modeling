data DEMreg;
input net_h V;
cards;
3.41 0.834
3.42 0.835
3.49 0.837
3.5	0.839
3.57	0.84
3.64	0.843
3.68	0.844
3.79	0.849
4.01	0.857
4.13	0.861
4.51	0.876
7.51	1
8.06	1.02
9.48	1.12
10.25	1.139
23	1.8
25.81	2.054
27.33	2.055
27.56	2.071
27.91	2.094
27.97	2.12
28.23	2.116
28.85	2.159
29.08	2.175
29.23	2.185
29.3	2.19
29.75	2.222
29.97	2.237
30.51	2.328
31.55	2.351
31.66	2.389
31.82	2.4
32.58	2.457
33.13	2.469
;
proc glm data = demreg;
model v=net_h  net_h*net_h*net_h;
output out=demregNew p=yhat r=resid stdr=eresid;
run;
proc gplot data = demregNew;
plot v*net_h = 1 yhat*net_h = 2 /overlay;
symbol1 c=blue i = none v=star;
symbol2 c=red i = spline v = none;
run;

proc glm data = demreg;
model v=net_h net_h*net_h net_h*net_h*net_h;
output out=demregNew p=yhat r=resid stdr=eresid;
run;
proc glm data = demreg;
model v= net_h*net_h net_h*net_h*net_h;
output out=demregNew p=yhat r=resid stdr=eresid;
run;
