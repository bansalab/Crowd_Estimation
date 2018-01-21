%Defining Threshold
threshold = 200;
%Input Image for Analysis
im=imread('C:/Users/Aakash/Desktop/t1.jpeg');
%Show Image
imshow(im),title('Original Image');
%Change Colour Space from RGB to LAB
cform = makecform('srgb2lab');
im2=applycform(im,cform);
figure;imshow(im2),title('LAB Converted Image');
%Equalizing Brightness (Provides Clear Facial Image)
K=im2(:,:,2);
%Display Image
figure;imshow(K),title('Equalized Image');
%Calculate Appropriate Threshold Value of Gray region and Convert image to
%Black and White using the Threshold Value
grayth=graythresh(im2(:,:,2));
im3=im2bw(im2(:,:,2),grayth);
figure;imshow(im3),title('First BnW Generated Image');
%Fill extra patches with dark holes
im4=imfill(im3,'holes');
figure;
imshow(im4),title('Final BnW Generated Image');
%Cover Minute White Patches Upto a specified Threshold
%Change Value of Threshold from the variable at the top
im5 = bwareaopen(im4,threshold); 
%Check for Connected Components and Measure Density
cc=bwconncomp(im5);
density = cc.NumObjects / (size(im5,1) * size(im5,2))
figure;
imshow(im5)
labeledImage = bwlabel(im5, 8);
figure;imshow(labeledImage)
%Check Properties of Image and calculate number of people
blobMeasurements = regionprops(labeledImage,'all');
headcount = size(blobMeasurements, 1)
%Mark all Heads
imagesc(im);
hold on;
%title('Original with bounding boxes');
for k = 1 : headcount
Box = blobMeasurements(k).BoundingBox; 
x1 = Box(1);
y1 = Box(2);
x2 = x1 + Box(3);
y2 = y1 + Box(4);
x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
plot(x, y, 'LineWidth', 2);
end