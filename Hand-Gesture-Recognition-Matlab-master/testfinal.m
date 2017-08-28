clc;
close all;
clear;

a=imread('bg.bmp');
a=rgb2gray(a);
figure;
imshow(a);
b=imread('3.bmp');
b=rgb2gray(b);
c1=imsubtract(a,b);
d=im2bw(c1);
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


% figure;
Out=medfilt2(Out,[3 3]);
% imshow(Out,[]);
[L num]=bwlabel(Out);
STATS = regionprops(L,'all');


removed=0;
for i=1:num
dd=STATS(i).Area;
if dd < 500
  	L(L==i)=0;
	removed = removed + 1;
    num=num-1;
else
% imshow(L==i);
end
    
    
end
    disp(num);
    [L num]=bwlabel(L);


STATS = regionprops(L,'all');
stats1 = imfeature(L, 'Image'); % get image features
C = [];
c = stats1(1);
C = [c.Image]; % sepreate diffrent objects into C cell array.
C1 = imresize(C, [256 256], 'bilinear'); %
figure;
imshow(C1);
% imwrite(C1,'F3.BMP');


impixelinfo