I=imread('C:/Users/Aakash/Desktop/t5.jpg');
imshow(I),title('Image:1');
%change the color space
cform = makecform('srgb2lab');
J=applycform(I,cform);
figure;imshow(J),title('Image:2');
%equalise brightness to get skin area
K=J(:,:,2);% 2nd page of 3-d vector j
figure;imshow(K),title('Image:3');
L=graythresh(J(:,:,2));% find appropriate gray thresh value
BW1=im2bw(J(:,:,2),L);% convert to binary image based on threshold
figure;imshow(BW1),title('Image:4');
bw2=imfill(BW1,'holes');% fill patches with holes
figure;imshow(bw2)
bw3 = bwareaopen(bw2,100); %opens area greater than 1890
cc=bwconncomp(bw3)% connected comp for finding the density of people in
image
density=cc.NumObjects / (size(bw3,1) * size(bw3,2))
figure;imshow(bw3)
labeledImage = bwlabel(bw3, 8);%same as connected components
figure;imshow(labeledImage)
blobMeasurements = regionprops(labeledImage,'all');%measure all properties of the image
numberOfPeople = size(blobMeasurements, 1)% count the number of people
% draw bounding boxes
imagesc(I);
hold on;
title('Original with bounding boxes');
for k = 1 : numberOfPeople % Loop through all blobs.
% Find the mean of each blob.
% directly into regionprops.
thisBlobsBox = blobMeasurements(k).BoundingBox; 
% Get list of pixels in current blob.
x1 = thisBlobsBox(1);%1st side
y1 = thisBlobsBox(2);%2nd side
x2 = x1 + thisBlobsBox(3);%3rd side
y2 = y1 + thisBlobsBox(4);%4th side
x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
%subplot(3,4,2);
plot(x, y, 'LineWidth', 2);
end