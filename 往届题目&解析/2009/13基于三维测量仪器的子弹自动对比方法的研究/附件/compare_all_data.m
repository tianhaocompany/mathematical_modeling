%   计算每一个子弹与其他所有子弹的距离值
%   得出的结果在变量x中存放。
function x=compare_all_data()
load all_data    %   载入数据
for index1=1:22 %       对每一个子弹分别求其对其他子弹的距离
    for index2=1:22
        a=index1;
        b=index2;
        data_duiying=zeros(1,4);
        index2
        for i=1:4 %     每一个对应 都计算相应的结果
            data_cileng=zeros(1,4); %0
            for j=1:4 %     对每一个刺棱求其距离值
                data_pingyi=zeros(1,5);
                for k=-10:5:10%     每一个平移求其最小的值 减小题目中平移误差的影响 通过调节步长可进一步减小误差
                    data_pingyi(1,(k+10)/5+1)=sum(sum(abs(...
                        all_data_circle((a-1)*500+100:(a-1)*500+200,(j-1)*500+16+k:(j-1)*500+300+15+k)...
                        -all_data_circle((b-1)*500+100:(b-1)*500+200,mod(i+j-2,4)*500+16:mod(i+j-2,4)*500+300+15)...
                    )));
                end
                data_cileng(1,j)=min(data_pingyi);
            end
            data_duiying(1,i)=sum(data_cileng)-max(data_cileng);%   去除四个次棱距离中最大的一个
        end
        x(index1,index2)=min(data_duiying);%     取四个对应结果中最小的一个为连个子弹的距离
    end
end
