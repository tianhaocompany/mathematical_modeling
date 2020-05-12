function shumo_all(r)
%SHUMO_ALL    Create plot of datasets and fits
%   SHUMO_ALL(R)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  4

% This function was automatically generated on 21-Oct-2007 10:57:40
 
% Data from dataset "原始数据":
%    Y = r
 
% Remove missing values
t_ = ~isnan(r);
r = r(t_);

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
legh_ = []; legt_ = {};   % handles and text for legend
probplot('normal');
ax_ = gca;
title(ax_,'');
set(ax_,'Box','on');
hold on;

 
% --- Plot data originally in dataset "原始数据"
r = r(:);
h_ = probplot(ax_,r...
             ,'noref');  % add to probability plot
set(h_,'Color',[0.333333 0.666667 0],'Marker','o', 'MarkerSize',6);
xlabel('Data');
ylabel('Probability')
legh_(end+1) = h_;
legt_{end+1} = '原始数据';

% Nudge axis limits beyond data limits
xlim_ = get(ax_,'XLim');
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end

x_ = linspace(xlim_(1),xlim_(2),100);

% --- Create fit "Nakagami分布"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     p_ = [3.987984983886, 3.204577286117];
p_ = mle('nakagami',r, 0.05);  % Fit Nakagami distribution;

% Get a description of the Nakagami distribution
dist_ = dfswitchyard('dfgetdistributions','nakagami');

h_ = probplot(ax_,dist_.cdffunc,p_);
set(h_,'Color',[1 0 0],'LineStyle','-', 'LineWidth',2);
legh_(end+1) = h_;
legt_{end+1} = 'Nakagami分布';

% --- Create fit "对数正态l分布"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     p_ = [0.5169979217478, 0.2562254340886];
p_ = lognfit(r, 0.05);;
h_ = probplot(ax_,@logncdf,p_);
set(h_,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
legh_(end+1) = h_;
legt_{end+1} = '对数正态l分布';

% --- Create fit "Weibull分布"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     p_ = [1.906095368426, 3.956884227039];
p_ = wblfit(r, 0.05);;
h_ = probplot(ax_,@wblcdf,p_);
set(h_,'Color',[0.666667 0.333333 0],'LineStyle','-', 'LineWidth',2);
legh_(end+1) = h_;
legt_{end+1} = 'Weibull分布';

% --- Create fit "Gamma分布"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     p_ = [15.44455663968, 0.112192893772];
p_ = gamfit(r, 0.05);;
h_ = probplot(ax_,@gamcdf,p_);
set(h_,'Color',[0.333333 0.333333 0.333333],'LineStyle','-', 'LineWidth',2);
legh_(end+1) = h_;
legt_{end+1} = 'Gamma分布';

hold off;
legend(ax_,legh_, legt_, 'Location','NorthEast');
