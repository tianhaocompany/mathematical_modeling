function main
%问题四的主函数，一键执行
%  Author : LIU Chao  
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010  
% clear all;%清空工作空间所有数据
% [M,h]=data_pros;%取出数据和基因ID ,这里数据来源是project_data.xls
% M_init=M;%原始数据
% M=stdTrans(M);%标准化变换
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %M,h
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [M_sorted,h_sorted]=relief_new(M,h);%对矩阵按FSC进行排序
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %M_sorted,h_sorted
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a=zhucheng(M_sorted);%主成分分析
% % 找到61列具有最大FSC的基因
% data61 = M_sorted(:,(1:61));%取出这61列数据
% data61h=h_sorted(1:61);%取出这61列数据的基因ID
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %data61,data61h
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % [h_min,err_min]=RFE_Relief(data61,data61h);%找到决定分类的最小数量的基因组




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:1:length(h)
%     if strcmp(h(i),'Hsa.627')% 'Hsa.627''Hsa.8010' 'Hsa.1961'
%         M3(:,1)=M_init(:,i);
%     end
%     if strcmp(h(i),'Hsa.8010')% 'Hsa.627''Hsa.8010' 'Hsa.1961'
%         M3(:,2)=M_init(:,i);
%     end
%     if strcmp(h(i),'Hsa.1961')% 'Hsa.627''Hsa.8010' 'Hsa.1961'
%         M3(:,3)=M_init(:,i);
%     end
% end
% h_min={'Hsa.627','Hsa.8010','Hsa.1961'};
% [bestx,index,x_min,x_max]=test(h_min,M3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load M05
load h05
[bestx,index,x_min,x_max]=test(h5,M5);
A=data_search(h5(index));
stdA=std(A);
meanA=mean(A);
bestx_init=bestx*stdA+meanA
x_min_init=x_min*stdA+meanA%测试x_min_init是否是index对应列中的最小值
x_max_init=x_max*stdA+meanA%测试x_max_init是否是index对应列中的最大值

% [bestx,index,x_min,x_max]=test(data61h,data61);
% bestx_init=bestx*(std(data61))(index)+(mean(data61))(index)
% x_min_init=x_min*(std(data61))(index)+(mean(data61))(index)%测试x_min_init是否是index对应列中的最小值
% x_max_init=x_max*(std(data61))(index)+(mean(data61))(index)%测试x_max_init是否是index对应列中的最大值