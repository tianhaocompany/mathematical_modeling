function [ss1,ss2,ss3,ss4,ss5]=step_rules(r)

   if r<10
       ss1=[0 -0.1  0.1];
       ss2=[-0.1 0 0.1];
       ss3=[-0.1 0 0.1];
       ss4=[0 2 1 .5 -0.1  0.1 .5 1 2];
       ss5=[2 1 .5 -0.1 0 0.1 .5 1 2];
   else   
      ss1=[0 -2 2];ss2=[-2 0 2];ss3=[-2 0 2];ss4=[0 -2 2];ss5=[-2 0 2];ss6=[-2 0 2];
   end
