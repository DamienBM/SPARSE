function cr = malevitch(coor_tl,coor_br)

% function cr = malevitch(coor_tl,coor_br)

cr = zeros(512,512);
cr(coor_tl(1):coor_br(1),coor_tl(2):coor_br(2))=255;
