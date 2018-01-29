function cr = crux(branch_wth)

cr = zeros(512,512);
cr(256-branch_wth:257+branch_wth,:)=255;
cr(:,256-branch_wth:257+branch_wth)=255;