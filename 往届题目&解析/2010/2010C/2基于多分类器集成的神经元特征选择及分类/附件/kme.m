clc;
clear;

load shaixuan;
load train;

feature=train(1:135,1:43);

[rtrain,ctrain]=size(feature);

for i=1:ctrain
    suma=0;
     for j=1:rtrain
        suma=suma+abs(feature(j,i));
    end
    
    feature(:,i)=feature(:,i)/suma;
end

centres=abs(feature(45:51,1:43));

[rtrain,ctrain]=size(shaixuan);

feature=abs(shaixuan(1:rtrain,1:43));


[rtrain,ctrain]=size(feature);

for i=1:ctrain
    suma=0;
     for j=1:rtrain
        suma=suma+abs(feature(j,i));
    end
    
    feature(:,i)=feature(:,i)/suma;
end
%%




[ncentres,cf]=size(centres);

id = eye(ncentres);
%% Main loop of algorithm
for n = 1:100

  % Save old centres to check for termination
  old_centres = centres;
  
  % Calculate posteriors based on existing centres
  d2 = sp_dist2(feature, centres);
  % Assign each point to nearest centre
  [minvals, index] = min(d2', [], 1);
  post = id(index,:); % matrix, if word i is in cluster j, post(i,j)=1, else 0;
  

  num_points = sum(post, 1);
  % Adjust the centres based on new posteriors
  for j = 1:ncentres
    if (num_points(j) > 0)
      centres(j,:) = sum(feature(find(post(:,j)),:), 1)/num_points(j);
    end
  end

  % Error value is total squared distance from cluster centres
  e = sum(minvals);
 
  
  fprintf(1, 'µü´ú %4d  Error %11.6f\n', n, e);
 

  if n > 1
    % Test for termination
    if max(max(abs(centres - old_centres))) == 0 && ...
        abs(old_e - e) ==0
      
      return;
    end
  end
  old_e = e;
end

