function  out = main2( dir1,dir2 )

          match1 = zeros(16,1);
          j=1;
          for i1= 1:4
              for i2= 1:4
                  match1( j,1 ) = mark2([dir1 '\c' num2str(i1) '.dat'],[dir2 '\c' num2str(i2) '.dat']);
                  j=j+1;
              end
          end
          match2(1,1)=match1(1);
          match2(1,2)=match1(6);
          match2(1,3)=match1(11);
          match2(1,4)=match1(16);%第一种相对位置下的相似度
          
          match2(2,1)=match1(2);
          match2(2,2)=match1(7);
          match2(2,3)=match1(12);
          match2(2,4)=match1(13);
          
          match2(3,1)=match1(3);
          match2(3,2)=match1(8);
          match2(3,3)=match1(9);
          match2(3,4)=match1(14);
          
          match2(4,1)=match1(4);
          match2(4,2)=match1(5);
          match2(4,3)=match1(10);
          match2(4,4)=match1(15);
          match2
          
          
          match3=0;
          tttt=zeros(4,2);%某个中间值
          tttt1=zeros(4,1);
          for i=1:4       %找出两个最大的相似度
              for j=1:4
                  if match2(i,j)>tttt(i,1)
                     tttt(i,1)=match2(i,j);
                  end
              end
          end
          
          for i=1:4       %找出两个最大的相似度
              for j=1:4
                  if match2(i,j)>tttt(i,2) && match2(i,j)~=tttt(i,1),
                     tttt(i,2)=match2(i,j);
                  end
              end
          end
          
          
          for i=1:4,
              tttt1(i,1)=tttt1(i,1)+tttt(i,1)+tttt(i,2);
          end
          for i=1:4,
              if tttt1(i,1)>match3
                  match3=tttt1(i,1);
              end
          end
          match3=match3/2;    
          
              
          stemp1=[0 ;0 ;0 ;0];
          for i=1:4,
              for j=1:4,
                  stemp1(i,1)=stemp1(i,1)+match2(i,j);
              end
          end
         stemp2=stemp1(1,1);
          for i=1:4
              if stemp1(i,1)>stemp2,
                 stemp2=stemp1(i,1);
              end
          end
          stemp3=stemp2/4;
          out = [stemp3  match3];%输出量个弹头的吻合度