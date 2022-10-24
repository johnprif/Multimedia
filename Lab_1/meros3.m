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
%2+3+4+5
IDCT_cameraMan_5=f;
IDCT_cameraMan_10=f;
IDCT_cameraMan_20=f;

zeros_5=0;
zeros_10=0;
zeros_20=0;

for horizontal=1:8:256
  for vertical=1:8:256
    cameraMan_8_block=f(horizontal:horizontal+7,vertical:vertical+7);
    DCT_cameraMan_5=dct2(cameraMan_8_block);
    DCT_cameraMan_10=DCT_cameraMan_5;
    DCT_cameraMan_20=DCT_cameraMan_5;
    

    
    for i=1:8
      for j=1:8
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
    IDCT_cameraMan_5(horizontal:horizontal+7,vertical:vertical+7)=idct2(DCT_cameraMan_5);
    IDCT_cameraMan_10(horizontal:horizontal+7,vertical:vertical+7)=idct2(DCT_cameraMan_10);
    IDCT_cameraMan_20(horizontal:horizontal+7,vertical:vertical+7)=idct2(DCT_cameraMan_20);
  endfor
endfor

IDCT_cameraMan_5=uint8(IDCT_cameraMan_5);
IDCT_cameraMan_10=uint8(IDCT_cameraMan_10);
IDCT_cameraMan_20=uint8(IDCT_cameraMan_20);

imagesc([f,IDCT_cameraMan_5,IDCT_cameraMan_10,IDCT_cameraMan_20]);

imwrite(IDCT_cameraMan_5,'uint8_cameraMan_5_meros_3.jpg');
imwrite(IDCT_cameraMan_10,'uint8_cameraMan_10_meros_3.jpg');
imwrite(IDCT_cameraMan_20,'uint8_cameraMan_20_meros_3.jpg');

PSNR_5=psnr(f,IDCT_cameraMan_5);
PSNR_10=psnr(f,IDCT_cameraMan_10);
PSNR_20=psnr(f,IDCT_cameraMan_20);

printf("PSNR FOR |F(u,v)|<5 = %d\n",PSNR_5);
printf("Zeros FOR |F(u,v)|<5 = %d\n",zeros_5);
printf("-----------------------------------------------------\n");
printf("PSNR FOR |F(u,v)|<10 = %d\n",PSNR_10);
printf("Zeros FOR |F(u,v)|<10 = %d\n",zeros_10);
printf("-----------------------------------------------------\n");
printf("PSNR FOR |F(u,v)|<20 = %d\n",PSNR_20);
printf("Zeros FOR |F(u,v)|<20 = %d\n",zeros_20);
printf("-----------------------------------------------------\n");

%------------------------------------------------------------