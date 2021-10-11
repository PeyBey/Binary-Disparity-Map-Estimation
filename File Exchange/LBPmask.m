function d=LBPmask(pi,img,i,j)
i1=img(i-3,j-1);
i2=img(i-3,j);
i3=img(i-3,j+1);
i4=img(i-2,j-2);
i5=img(i-2,j+2);
i6=img(i-1,j-3);
i7=img(i-1,j+3);
i8=img(i,j-3);
i9=img(i,j+3);
i10=img(i+1,j-3);
i11=img(i+1,j+3);
i12=img(i+2,j-2);
i13=img(i+2,j+2);
i14=img(i+3,j-1);
i15=img(i+3,j);
i16=img(i+3,j+1);
D=[i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 i12 i13 i14 i15 i16];
d=D>pi;







