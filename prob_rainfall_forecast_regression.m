X = load('nino.tsv');
long = 117.5:5:302.5;
lat = -32.5:5:32.5;
years = 1950:2009;
nx=38;
ny=14;
nt=60;


iocean=find(isfinite(X(1,:)));
Xo=X(:,iocean);

 
Cova = cov(Xo);
[EOFs,ve] = eig(Cova);
PCs=Xo*EOFs;
Var=real( diag(ve./trace(ve)) );
EOFLand=nan(nx*ny,2);
 

EOFLand(iocean,1)=EOFs(:,end);
PC1 = PCs(:,end);
eof1_xy = reshape(EOFLand(:,1),nx,ny);


year = 1950:2009;
figure(1)
subplot(2,1,1)
[X1,Y1] = meshgrid(long,lat);
contourf(X1,Y1,eof1_xy')
caxis([-0.1 0.1])
colorbar
title('EOF1')
ylabel('Latitude')
xlabel('Longitude')


subplot(2,1,2)
plot(year,PC1,'-*')
axis([1950 2009 -30 30])
grid on
title('PC1')
ylabel('Amplitude')
xlabel('Year')

% Calculate Rainfall Probabilities
precip=load('CRUPrcp.tsv');

z_precip=(precip-mean(precip))/std(precip);
m=mean(precip);
z_low=(424-m)/std(precip);
z_high=(514-m)/std(precip);
P_low=normcdf(z_low);
P_high=1-(normcdf(z_high));
P_avg=1-P_high-P_low;

% Prob using 60 year rainfall data
precip=load('CRUPrcp.tsv');

yrs_below=length(find(precip<424));
yrs_above=length(find(precip>514));
yrs_avg=60-yrs_below-yrs_above;
P_below=yrs_below/60;
P_avg=yrs_avg/60;
P_above=yrs_above/60;

% OND and JJA SST
% regression eq b/w rainfall and SST's
z_PC1=(PC1-mean(PC1))/std(PC1);
s_1=regstats(z_precip,z_PC1,'linear',{'beta','yhat'});
beta_1=s_1.beta;
yhat_1=s_1.yhat;
c=corrcoef(z_PC1,z_precip);

% Std error
sterr=sqrt(1-(.4375^2));

% 1996 Tamil relative to normal
zY=beta_1(2)*z_PC1(48,:);
z_low1997=(-0.431-zY)/sterr;
z_high1997=(0.431-zY)/sterr;
P_dry6=normcdf(-0.431,zY,sterr);
P_wet6=1-normcdf(0.431,zY,sterr);
P_neutral6=1-(P_dry6+P_wet6);

% Prob classes of rainfall relative to "normal"
zY=beta_1(2)*z_PC1(39,:);
z_low1988=(-0.431-zY)/sterr;
z_high1988=(0.431-zY)/sterr;
P_dry7=normcdf(-0.431,zY,sterr);
P_wet7=1-normcdf(0.431,zY,sterr);
P_neutral7=1-(P_dry7+P_wet7);

% 1999 Tamil Nadu Rainfall Prob
zY=beta_1(2)*z_PC1(50,:);
z_low1999=(-0.431-zY)/sterr;
z_high1999=(0.431-zY)/sterr;
P_dry9=normcdf(-0.431,zY,sterr);
P_wet9=1-normcdf(0.431,zY,sterr);
P_neutral9=1-(P_dry9+P_wet9);