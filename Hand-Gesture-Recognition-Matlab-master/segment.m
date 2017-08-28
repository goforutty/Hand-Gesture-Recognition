function [C1,c1]=segment(a,b)
 a=rgb2gray(a);
 b=rgb2gray(b);
c1=imsubtract(a,b);
d=im2bw(c1);

% impixelinfo
[r c]=size(d);

for i=1:r
    for j=1:c
        
        if c1(i,j)> 25
            Out(i,j)=255;
        else
            Out(i,j)=0;
            
        end
        
    end
end


 
Out=medfilt2(Out,[3 3]);
[L num]=bwlabel(Out);
STATS = regionprops(L,'all');


for i=1:num
dd=STATS(i).Area;
if dd < 500
  	L(L==i)=0;
    num=num-1;
end
        
end
    disp(num);
    [L num]=bwlabel(L);

stats1 = regionprops(L, 'Image'); % get image features
C = [];
c = stats1(1);
C = [c.Image]; % sepreate diffrent objects into C cell array.
C1 = imresize(C, [256 256], 'bilinear'); %
