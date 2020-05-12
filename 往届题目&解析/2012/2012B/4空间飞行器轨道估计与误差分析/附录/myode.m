% % %ODEFILE  ODE file syntax.
%
% NOTE:
%   The interpretation of the first input argument of the ODE solvers
%   (formerly referred to as 'ODEFILE') and several options available through
%   ODESET have changed in MATLAB v6. While the v5 syntax is still supported,
%   any new functionality is available only with the new syntax. This help
%   describes the v5 syntax. For information about the new syntax, see a help
%   entry for any of the ODE solvers or for ODESET. To see the v5 help, type 
%   in the command line
%       more on, type odefile, more off

% NOTE:
%   This portion describes the ODEFILE and the syntax the ODE solvers used in
%   MATLAB v5.   
%
% An ODE file is an M-file function you write to define a differential
% equation problem for the ODE Suite solvers.  This M-file is referred to as
% 'ODEFILE' here, although you can give your M-file any name you like.
% 
% By default, the ODE Suite solvers solve initial value problems of the form
% dy/dt = F(t,y) where t is an independent variable and y is a vector of
% dependent variables.  To do this, the solvers repeatedly call F =
% ODEFILE(T,Y) where argument T is a scalar, Y is a column vector, and
% output F is expected to be a column vector of the same length.  Note that
% the ODE file must accept the arguments T and Y, although it does not have
% to use them.  In its simplest form, an ODE file can be coded as
%  
%function F = odefile(t,y)
%F = < Insert a function of t and/or y here. >;
% 
% As described in the User's Guide, the ODE Suite solvers are capable of
% using additional information coded in the ODE file.  In this more general
% usage, an ODE file is expected to respond to the arguments
% ODEFILE(T,Y,FLAG,P1,P2,...) where T and Y are the integration variables,
% FLAG is a lower case string indicating the type of information that the
% ODE file should return, and P1,P2,... are any additional parameters that
% the problem requires.  The currently supported flags are
% 
%    FLAGS        RETURN VALUES
%    '' (empty) - F(t,y)
%    'init'     - default TSPAN, Y0 and OPTIONS for this problem
%    'jacobian' - Jacobian matrix J(t,y) = dF/dy
%    'jpattern' - matrix showing the Jacobian sparsity pattern
%    'mass'     - mass matrix M, M(t), or M(t,y), for solving M*y' = F(t,y)
%    'events'   - information for zero-crossing location

% 
function varargout = myode(t,y,flag,  pr1, pr2, pr3)
switch flag
    case ''                                 % Return dy/dt = f(t,y).
        varargout{1} = f(t,y, pr1, pr2,pr3);
%     case 'init'                             % Return default [tspan,y0,options].
%         [varargout{1:3}] = init(para);
    otherwise
        error('Unknown flag''flag''.');
end
%-------------------------------------------------------------------------
     function dydt = f(t, y, pr1, pr2,pr3 )
          x = y(1:3);%位置矢量
        vel = y(4:6);%速度矢量
        r = norm(x); %sqrt(x(1)^2+x(2)^2+x(3)^2); 
        
        pr3 = - abs(pr3);%秒耗量为负
        pr2 = abs(pr2);%vrt 为正
        if pr2 ~= 0
            pr3 = - abs(pr3);%秒耗量为负
            pr2 = abs(pr2);%vrt 为正
            a2 = -vel/norm(vel).*pr2./(t + pr3);
        else
            a2 = 0;
        end
        
        acl = - pr1/(r^3)*x  + a2; 
        
        dydt = [vel; acl];%-p1*x/(r^3)
     end

end
% -------------------------------------------------------------------------
% % -
% function [tspan,y0,options] = init(p1,p2,p3,p4,p5,p6)
%     tspan = p2;
%     y0 =p3;
%     options =  odeset('AbsTol',p4,'RelTol',p5,'OutputFcn','odephas3','Maxtep',p6);
% end

