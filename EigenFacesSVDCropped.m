%SVD Analysis of Cropped Images

clear all; 
close all; 
clc;  

first_folder = 'CroppedYale';  
myimage = [];
Image = [];
myfiles = [];

folder = dir(fullfile(first_folder, 'Y*'));
for i = 1:38
    current = fullfile(first_folder, folder(i).name);
    myfiles = dir(fullfile(current, 'y*'));
    
    for k = 1:64
        current_file = fullfile(current,myfiles(k).name);
        currentim = imread(current_file);
        myimage(:,k) = currentim(:);
    end
    Image(:,i) = myimage(:);
end

finalimage = [];
finalimage = imresize(Image, [32256,64]);

[U, S, V] = svd(finalimage, 'econ');

%Singular Values
sv = diag(S);
data = length(norm(S));

tol = max(size(S))*eps(norm(S));
R = rank(S,tol);

%reconstruction

for i = 1:data < R
    Back = U*S*transpose(V(i));
    n = norm(Back, 1);
    Final = abs(mean(mean(n)));
end

figure(1);
plot (U(:,1), 'r')
hold on;
plot (U(:,2), 'b')
hold on;
plot (U(:,3), 'g')
title('First Few Reshaped Columns of U (Cropped)')
legend('First Column of U', 'Second Column of U', 'Third Column of U')

figure(2)
plot(sv, 'r')
title('Singular Value Spectrum (Covariance Cropped)')

figure(3)
plot(Back)
hold on;
title('Final Reconstruction (Cropped)')