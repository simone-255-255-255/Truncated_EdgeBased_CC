function [Rw,Gw,Bw]=norm_derivative_truncated(in, sigma, order, filtersize)

if(nargin<3) order=1; end

R=in(:,:,1);
G=in(:,:,2);
B=in(:,:,3);

if(order==1)
    Rx=gDer_truncated(R,sigma,1,0,filtersize);
    Ry=gDer_truncated(R,sigma,0,1,filtersize);
    Rw=sqrt(Rx.^2+Ry.^2);
    
    Gx=gDer_truncated(G,sigma,1,0,filtersize);
    Gy=gDer_truncated(G,sigma,0,1,filtersize);
    Gw=sqrt(Gx.^2+Gy.^2);
    
    Bx=gDer_truncated(B,sigma,1,0,filtersize);
    By=gDer_truncated(B,sigma,0,1,filtersize);
    Bw=sqrt(Bx.^2+By.^2);
end

if(order==2)        %computes frobius norm
    Rxx=gDer_truncated(R,sigma,2,0,filtersize);
    Ryy=gDer_truncated(R,sigma,0,2,filtersize);
    Rxy=gDer_truncated(R,sigma,1,1,filtersize);
    Rw=sqrt(Rxx.^2+4*Rxy.^2+Ryy.^2);
    
    Gxx=gDer_truncated(G,sigma,2,0,filtersize);
    Gyy=gDer_truncated(G,sigma,0,2,filtersize);
    Gxy=gDer_truncated(G,sigma,1,1,filtersize);
    Gw=sqrt(Gxx.^2+4*Gxy.^2+Gyy.^2);
    
    Bxx=gDer_truncated(B,sigma,2,0,filtersize);
    Byy=gDer_truncated(B,sigma,0,2,filtersize);
    Bxy=gDer_truncated(B,sigma,1,1,filtersize);
    Bw=sqrt(Bxx.^2+4*Bxy.^2+Byy.^2);
end