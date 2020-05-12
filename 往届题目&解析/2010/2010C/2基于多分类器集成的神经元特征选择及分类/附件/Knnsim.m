function Ksim=Knnsim(x,y)
if nargin==1
    Ksim=0;
elseif nargin==0
    Ksim=0;
else
    simx=sum(x.*y);
    simy=sum(x.*x)*sum(y.*y);
    Ksim=simx/sqrt(simy);
end 