%configure hardware input device
clc;
clear;
close all;

vid=videoinput('winvideo',1,'YUY2_640x480'); 
set(vid,'ReturnedColorSpace','rgb');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
triggerconfig(vid,'manual'); 

set(vid,'FramesPerTrigger',1 );%Capture one frame per trigger
set(vid,'TriggerRepeat', Inf);
start(vid); %start video

 BW = imread('mask.bmp');
 BW=im2bw(BW);
 [B,L,N,A] = bwboundaries(BW);
  imshow(BW); hold on;
       for k=1:length(B),
         if(~sum(A(k,:)))
           boundary = B{k};
           plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
           for l=find(A(:,k))'
             boundary = B{l};
             save boundary boundary
             plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
           end
         end
       end
       
       
load boundary       
       
aa=1;
%Infinite while loop
load r;
load c;
% r=60:400;
% c=80:500;
while(1)
%Get Image
trigger(vid);
im=getdata(vid,1);
imshow(im);
hold on
if aa == 25
red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
figure;
imshow(Out);title('Capturing BackGround');
imwrite(Out,'bg.bmp');
   
end


plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
aa=aa+1;
disp(aa);
if aa == 60
   break 
end


end

stop(vid),delete(vid),clear vid; 

red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
imwrite(Out,'final.bmp');
figure, imshow(Out,[])
a=imread('bg.bmp');
C1=segment(a,Out);
figure, imshow(C1,[])
% close all;
imwrite(C1,'D10.bmp');  