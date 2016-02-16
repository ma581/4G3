function ix=findpat(P1,P2)

P1=P1(:)';
P2=P2(:)';

ix=true(size(P1));

for i=1:length(P2)
    if ~isnan(P2(i));
        ix=ix & [P1(i:end)==P2(i), false(1,i-1)];
    end
end
