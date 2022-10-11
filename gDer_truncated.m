function [H]= gDer_truncated(f,sigma, iorder,jorder, filtersize)

%H = HxRecGauss(f, sigma, sigma, iorder,jorder,3);
%H = HxGaussDerivative2d(f, sigma, iorder,jorder,3);

% filtersize=metà window

%original program
%Initialize the filter

if filtersize==-1
    break_off_sigma = 3.;
    filtersize = floor(break_off_sigma*sigma+0.5);
end

f=fill_border(f,filtersize);

x=-filtersize:1:filtersize;

Gauss=1/(sqrt(2 * pi) * sigma)* exp((x.^2)/(-2 * sigma * sigma) );

switch(iorder)
case 0
    Gx= Gauss/sum(Gauss);
case 1
    Gx  =  -(x/sigma^2).*Gauss;
    Gx  =  Gx./(sum(sum(x.*Gx)));
case 2
    Gx = (x.^2/sigma^4-1/sigma^2).*Gauss;
    Gx = Gx-sum(Gx)/size(x,2);
    Gx = Gx/sum(0.5*x.*x.*Gx);
end
H = filter2(Gx,f);

switch(jorder)
case 0
    Gy= Gauss/sum(Gauss);
case 1
    Gy  =  -(x/sigma^2).*Gauss;
    Gy  =  Gy./(sum(sum(x.*Gy)));
case 2
    Gy = (x.^2/sigma^4-1/sigma^2).*Gauss;
    Gy = Gy-sum(Gy)/size(x,2);
    Gy = Gy/sum(0.5*x.*x.*Gy);
end
H = filter2(Gy',H);

H=H(filtersize+1:size(H,1)-filtersize,filtersize+1:size(H,2)-filtersize);