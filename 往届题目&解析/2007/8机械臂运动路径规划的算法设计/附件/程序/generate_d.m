function d=generate_d(e)

t=rand([3,1])-[.5;.5;.5];
d=e+t./norm(t)*65;