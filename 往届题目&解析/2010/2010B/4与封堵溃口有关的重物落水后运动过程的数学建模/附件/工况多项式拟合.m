function [p,S] = polyfit(x,y,n)    %工况1多项式拟合 
 x=[2.2 3 3.5 4 5 6.2	8  9.5	10.5 12.5];
 y=[26 23.5 22 19.5	17	15	12.5 9.5 6 3];
   p=polyfit(x,y,2)
xi=-0.2:0.01:0.3;
 yi=polyval(p,xi);
  plot(x,y,'o',xi,yi,'k');
  title('polyfit');
   if ~isequal(size(x),size(y))
  error('X and Y vectors must be the same size.')
end
x = x(:);
y = y(:);
m=length(x);n=length(y);
if m~=n, error('向量x与y的长度必须一致');end
s=0;
for i=1:n
   t=ones(1,length(xx));
   for j=1:n
      if j~=i, 
         t=t.*(xx-x(j))/(x(i)-x(j));
      end
   end
   s=s+t*y(i);
end
yy=s;
V(:,n+1) = ones(length(x),1);
for j = n:-1:1
    V(:,j) = x.*V(:,j+1);
end
[Q,R] = qr(V,0);
p = R\(Q'*y);   
r = y - V*p;
p = p.';         
S.R = R;
S.df = length(y) - (n+1);
S.normr = norm(r);
function [x, options] = fmins(funfcn,x,options,grad,varargin)
if nargin<3, options = []; end
options = foptions(options);
prnt = options(1);
tolx = options(2); 
tolf = options(3);
funfcn = fcnchk(funfcn,length(varargin));
n = prod(size(x));
if (~options(14)) 
   options(14) = 200*n; 
end
rho = 1; chi = 2; psi = 0.5; sigma = 0.5;
onesn = ones(1,n);
two2np1 = 2:n+1;
one2n = 1:n;
xin = x(:); 
v = zeros(n,n+1); fv = zeros(1,n+1);
v = xin;    
x(:) = xin;    
fv = feval(funfcn,x,varargin{:}); 
usual_delta = 0.05;            
zero_term_delta = 0.00025;      
for j = 1:n
   y = xin;
   if y(j) ~= 0
      y(j) = (1 + usual_delta)*y(j);
   else 
      y(j) = zero_term_delta;
   end  
   v(:,j+1) = y;
   x(:) = y; f = feval(funfcn,x,varargin{:});
   fv(1,j+1) = f;
end     
[fv,j] = sort(fv);
v = v(:,j);
func_evals = n+1;
if prnt > 0
   clc
   formatsave = get(0,{'format','formatspacing'});
   format compact
   format short e
   disp(' ')
   disp('initial')
   v
   fv
   func_evals
end
while func_evals < options(14)
   if max(max(abs(v(:,two2np1)-v(:,onesn)))) <= tolx &...
         max(abs(fv(1)-fv(two2np1))) <= tolf
      break
   end
   how = '';
    xbar = sum(v(:,one2n), 2)/n;
   xr = (1 + rho)*xbar - rho*v(:,end);
   x(:) = xr; fxr = feval(funfcn,x,varargin{:});
   func_evals = func_evals+1;
    if fxr < fv(:,1
      xe = (1 + rho*chi)*xbar - rho*chi*v(:,end);
      x(:) = xe; fxe = feval(funfcn,x,varargin{:});
      func_evals = func_evals+1;
      if fxe < fxr
         v(:,end) = xe;
         fv(:,end) = fxe;
         how = 'expand';
      else
         v(:,end) = xr; 
         fv(:,end) = fxr;
         how = 'reflect';
      end
   else 
      if fxr < fv(:,n)
         v(:,end) = xr; 
         fv(:,end) = fxr;
         how = 'reflect';
      else 
     
       if fxr < fv(:,end)
        
           xc = (1 + psi*rho)*xbar - psi*rho*v(:,end);
            x(:) = xc; fxc = feval(funfcn,x,varargin{:});
            func_evals = func_evals+1;
            
            if fxc <= fxr
               v(:,end) = xc; 
               fv(:,end) = fxc;
               how = 'contract outside';
            else
              
               how = 'shrink'; 
            end
         else
         
            xcc = (1-psi)*xbar + psi*v(:,end);
            x(:) = xcc; fxcc = feval(funfcn,x,varargin{:});
            func_evals = func_evals+1;
            
            if fxcc < fv(:,end)
               v(:,end) = xcc;
               fv(:,end) = fxcc;
               how = 'contract inside';
            else
              
               how = 'shrink';
            end
         end
         if strcmp(how,'shrink')
            for j=two2np1
               v(:,j)=v(:,1)+sigma*(v(:,j) - v(:,1));
               x(:) = v(:,j); fxcc = feval(funfcn,x,varargin{:});
            end
            func_evals = func_evals + n;
         end
      end
   end
   [fv,j] = sort(fv);
   v = v(:,j);
   if prnt > 0
      disp(' ')
      disp(how)
      v
      fv
      func_evals
   end  
end   
x(:) = v(:,1);
if prnt > 0,
   set(0,{'format','formatspacing'},formatsave);
end
options(10)=func_evals;
options(8)=min(fv); 
if func_evals >= options(14) 
   if options(1) >= 0
      disp(' ')
      disp(['Maximum number of function evaluations (', ...
            int2str(options(14)),') has been exceeded']);
      disp( '         (increase OPTIONS(14)).')
   end
end

