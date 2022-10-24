%Joanis Prifti 3321

%First of all we need to load basic libraries 
pkg load image;
pkg load signal;
%------------------------------------------------------------
%1
f=imread('cameraman.tif');
colormap(gray);
imwrite(f,'original_cameraMan.jpg');
%------------------------------------------------------------
%2
DCT_cameraMan_5=dct2(f);
DCT_cameraMan_10=dct2(f);
DCT_cameraMan_20=dct2(f);
%------------------------------------------------------------
%3+4
zeros_5=0;
zeros_10=0;
zeros_20=0;
cameraManSize=size(DCT_cameraMan_5,1);
for i=1:cameraManSize
  for j=1:cameraManSize
    if (abs(DCT_cameraMan_5(i,j)))<5
      DCT_cameraMan_5(i,j)=0;
      zeros_5=zeros_5+1;
    endif
    if (abs(DCT_cameraMan_10(i,j)))<10
      DCT_cameraMan_10(i,j)=0;
      zeros_10=zeros_10+1;
    endif
    if (abs(DCT_cameraMan_20(i,j)))<20
      DCT_cameraMan_20(i,j)=0;
      zeros_20=zeros_20+1;
    endif
  endfor
endfor

IDCT_cameraMan_5=idct2(DCT_cameraMan_5);
IDCT_cameraMan_10=idct2(DCT_cameraMan_10);
IDCT_cameraMan_20=idct2(DCT_cameraMan_20);

uint8_cameraMan_5=uint8(IDCT_cameraMan_5);
uint8_cameraMan_10=uint8(IDCT_cameraMan_10);
uint8_cameraMan_20=uint8(IDCT_cameraMan_20);

imagesc([f,uint8_cameraMan_5,uint8_cameraMan_10,uint8_cameraMan_20]);

imwrite(uint8_cameraMan_5,'uint8_cameraMan_5_meros_2.jpg');
imwrite(uint8_cameraMan_10,'uint8_cameraMan_10_meros_2.jpg');
imwrite(uint8_cameraMan_20,'uint8_cameraMan_20_meros_2.jpg');

PSNR_5=psnr(f,uint8_cameraMan_5);
PSNR_10=psnr(f,uint8_cameraMan_10);
PSNR_20=psnr(f,uint8_cameraMan_20);

printf("PSNR FOR |F(u,v)|<5 = %d\n",PSNR_5);
printf("The zeros = %d\n",zeros_5);
printf("-----------------------------------------------------\n");
printf("PSNR FOR |F(u,v)|<10 = %d\n",PSNR_10);
printf("The zeros = %d\n",zeros_10);
printf("-----------------------------------------------------\n");
printf("PSNR FOR |F(u,v)|<20 = %d\n",PSNR_20);
printf("The zeros = %d\n",zeros_20);
printf("-----------------------------------------------------\n");
%------------------------------------------------------------
