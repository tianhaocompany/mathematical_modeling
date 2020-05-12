function parents = selection_roulette(expectation,nParents,options)
%SELECTIONROULETTE Choose parents using roulette wheel.
%   PARENTS = SELECTIONROULETTE(EXPECTATION,NPARENTS,OPTIONS) chooses
%   PARENTS using EXPECTATION and number of parents NPARENTS. On each 
%   of the NPARENTS trials, every parent has a probability of being selected
%   that is proportional to their expectation.
%
%   Example:
%   Create an options structure using SELECTIONROULETTE as the selection
%   function
%     options = gaoptimset('SelectionFcn',@selectionroulette);

%   Copyright 2003-2004 The MathWorks, Inc.
%   $Revision: 1.7.4.1 $  $Date: 2004/08/20 19:50:06 $
%轮盘选择法
%expectation与目标值成反比
%可以改进，加入保优机制
wheel = cumsum(expectation) / nParents;
parents = zeros(1,nParents);
for i = 1:nParents
    r = rand;
    for j = 1:length(wheel)
        if(r < wheel(j))
            parents(i) = j;
            break;
        end
    end
end
    
