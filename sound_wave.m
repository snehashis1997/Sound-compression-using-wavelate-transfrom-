
[so,fs]=audioread('test.wav');
% so=imread('35.tif');
so=double(so);
fm=100;
[num1,den1]=butter(9,5*fm/fs,'low');
[num3,den3]=butter(9,5*fm/fs,'high');

z1=filter(num1,den1,so);
sz=size(z1);
z1=z1(1:1:sz);
z12=filter(num2,den2,z1);
LL=z12(1:1:size(z12));
z13=filter(num3,den3,z1);
LH=z13(1:1:size(z12));

z2=filter(num3,den3,so);
z2=z2(1:1:size(z2));
z21=filter(num1,den1,z2);
HL=z2(1:1:size(z21));
z22=filter(num3,den3,z2);
HH=z2(1:1:size(z21));


%lh ll part

y1_si=size(LL);
ze=zeros(1,2*y1_si(1));
for i=1:y1_si
    if LL(i)>0
        ze(i+1)=LL(i);
    end
end
zeLL=filter(num1,den1,ze); 

y1_si=size(LH);
zeLH=zeros(1,2*y1_si(1));
for i=1:y1_si
    if LH(i)>0
        zeLH(i+1)=LH(i);
    end
end
zeLH=filter(num3,den3,zeLH); 
addlor=zeLH+zeLL;
y1_si=size(addlor);
zeL_or=zeros(1,2*y1_si(2));
for i=1:y1_si(2)
    if addlor(i)>0
        zeL_or(i+1)=addlor(i);
    end
end
L_or=filter(num1,den1,zeL_or); 

%hl hh part
y1_si=size(HL);
zeHL=zeros(1,2*y1_si(1));
for i=1:y1_si(1)
    if HL(i)>0
        zeHL(i+1)=HL(i);
    end
end
ze1=filter(num1,den1,zeHL); 

y1_si=size(HH);
zeHH=zeros(1,2*y1_si(1));
for i=1:y1_si(1)
    if HH(i)>0
        zeHH(i+1)=HH(i);
    end
end
zeLH=filter(num3,den3,zeLH); 
addhor=zeHH+zeHL;
y1_si=size(addhor);
zeH_or=zeros(1,2*y1_si(2));
for i=1:y1_si(2)
    if addhor(i)>0
        zeH_or(1,i+1)=addhor(1,i);
    end
end
H_or=filter(num3,den3,zeH_or); 

final=H_or + L_or;


sound(so,fs);
pause(4);
sound(final,fs);
tiv=1/fs;
t=0:tiv:3;

t1=length(so);

plot(t(1:t1),so);

t1=length(final);

figure;

plot(t(1:t1),final);





