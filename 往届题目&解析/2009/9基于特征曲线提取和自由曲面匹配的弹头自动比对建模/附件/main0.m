function  out = main0( dir1,dir2 )

          errors = zeros(16,2);
          
          for i1= 1:4
              for i2= 1:4
                  line1 = deRotateErr([dir1 '\c' num2str(i1) '.dat']);
                  line2 = deRotateErr([dir2 '\c' num2str(i2) '.dat']);
                  errors( 4*(i1-1)+i2 ,:) = compareCurve(line1,line2);
              end
          end
          
          out = errors;