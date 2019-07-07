img1 = im2double(imread('test/Pic1.png'));
img2 = im2double(imread('Pic2.png'));
img3 = im2double(imread('test/Pic3.png'));
img4 = im2double(imread('Pic4.png'));
img6 = im2double(imread('test/Pic6.png'));
% img1 = img1(770:810,1480:1520,:);
% img2 = img2(770:810,1480:1520,:);
% img3 = img3(770:810,1480:1520,:);
imgs(1,:,:,:) = img1;
imgs(2,:,:,:) = img3;
imgs(3,:,:,:) = img6;

% dev = zeros(size(imgs,2), size(imgs,3));
% for y = 1 : size(imgs,2)
%     for x = 1 : size(imgs,3)
%         dev(y,x) = std([img1(y,x,1),img2(y,x,1),img3(y,x,1),img4(y,x,1),img6(y,x,1)]);
%     end
% end

[out, select] = max_entropy_cont(imgs,6);
imshow(out);
figure;
imshow(select./3);
