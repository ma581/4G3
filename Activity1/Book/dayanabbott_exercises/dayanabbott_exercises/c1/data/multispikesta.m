%%

pat_1=[1];  %#ok<NBRAK>
pat_2=[1 nan nan nan nan 1]; 
pat_3=[1 nan 1]; 

%%

N=50; 
dt=2; 

%%%%%%%%%%%%%
%% Computing multi spike STAs

t=find(findpat(rho,pat_1))+length(pat_1)-1; 
STE=size(length(t),N); 
for i=1:length(t); 
    Nnans=max(N-t(i),0); 
    STE(i,1:Nnans)=NaN; 
    STE(i,Nnans+1:N)=stim(t(i)-N+Nnans+1:t(i)); 
end; 

STA=nanmean(STE);

%%

t=find(findpat(rho,pat_2))+length(pat_2)-1; 
STE=size(length(t),N); 
for i=1:length(t); 
    Nnans=max(N-t(i),0); 
    STE(i,1:Nnans)=NaN; 
    STE(i,Nnans+1:N)=stim(t(i)-N+Nnans+1:t(i)); 
end; 

STA_2=nanmean(STE);

%%

t=find(findpat(rho,pat_3))+length(pat_3)-1; 
STE=size(length(t),N); 
for i=1:length(t); 
    Nnans=max(N-t(i),0); 
    STE(i,1:Nnans)=NaN; 
    STE(i,Nnans+1:N)=stim(t(i)-N+Nnans+1:t(i)); 
end; 

STA_3=nanmean(STE);

%%%%%%%%%%%%%
%% Plotting multi spike STAs

figure(1); 
patt=pat_1; 
patt(isnan(patt))=0; 
clf; 
hold on; 
for i=1:length(patt); 
    if patt(end-i+1); 
        rectangle('Position',[length(STA)-i,0,1,10],'FaceColor','black'); 
    end; 
end; 
stairs(STA,'-k','LineWidth',2); 
hold off; 
axis([0 50 0 60]); 
set(gca,'XTick',(0:10:50),'XTickLabel',num2str([dt*50:-dt*10:0]'),'YTick',(0:10:60),'Linewidth',2,'Box','off','FontSize',16);
xlabel('time (ms)','FontSize',16);
ylabel('velocity (degs/s)','FontSize',16);
set(gcf,'PaperPositionMode','auto');

saveas(1,'sta_1.eps','epsc')

%%

figure(1); 
patt=pat_2; 
patt(isnan(patt))=0; 
clf; 
hold on; 
STA_r=conv(STA,patt)/sum(patt); 
STA_r=STA_r(end-length(STA)+1:end); 
for i=1:length(patt); 
    if patt(end-i+1); 
        rectangle('Position',[length(STA)-i,0,1,10],'FaceColor','black'); 
    end; 
end; 
stairs(STA_r,'-k','LineWidth',2); 
stairs(STA_2,'-b','LineWidth',2); 
hold off; 
axis([0 50 0 60]); 
set(gca,'XTick',(0:10:50),'XTickLabel',num2str([dt*50:-dt*10:0]'),'YTick',(0:10:60),'Linewidth',2,'Box','off','FontSize',16);
xlabel('time (ms)','FontSize',16);
ylabel('velocity (degs/s)','FontSize',16);
set(gcf,'PaperPositionMode','auto');

saveas(1,'sta_2_10.eps','epsc')

%%

figure(1); 
patt=pat_3; 
patt(isnan(patt))=0; 
clf; 
hold on; 
STA_r=conv(STA,patt)/sum(patt); 
STA_r=STA_r(end-length(STA)+1:end); 
for i=1:length(patt); 
    if patt(end-i+1); 
        rectangle('Position',[length(STA)-i,0,1,10],'FaceColor','black'); 
    end; 
end; 
stairs(STA_r,'-k','LineWidth',2); 
stairs(STA_3,'-r','LineWidth',2); 
hold off; 
axis([0 50 0 60]); 
set(gca,'XTick',(0:10:50),'XTickLabel',num2str([dt*50:-dt*10:0]'),'YTick',(0:10:60),'Linewidth',2,'Box','off','FontSize',16);
xlabel('time (ms)','FontSize',16);
ylabel('velocity (degs/s)','FontSize',16);
set(gcf,'PaperPositionMode','auto');

saveas(1,'sta_2_4.eps','epsc')
