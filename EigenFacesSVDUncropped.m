%SVD of Original Images

clear all;
close all;
clc;
folder = 'yalefaces_uncropped'
myfiles = [];
myfiles = dir(fullfile(folder, 'subject*'));
myimage = [];

for i = 1:165
    current_file = fullfile('yalefaces_uncropped', myfiles(i).name);
    currentim = imread(current_file);
    myimage(:,i) = currentim(:);
end

finalimage = [];
finalimage = imresize(myimage, [77760,165]);

[U,S,V] = svd(finalimage, 'econ');

sv = diag(S);
data = length(norm(S));

%rank of face space
tol = max(size(S))*eps(norm(S));
R = rank(S,tol);

%reconstruction

for i = 1:data < R
    Back = U*S*transpose(V(i));
    n = norm(Back, 1);
    Final = abs(mean(mean(n)));
end

figure(1)
plot(U(:,1), 'r')
hold on;
plot(U(:,2), 'b')
hold on;
plot(U(:,3), 'g')
hold on;
title('First Few Reshaped Columns of U (Uncropped)')
legend('First Column of U', 'Second Column of U', 'Third Column of U')

figure(2)
plot(sv)
title('Singular Value Spectrum (Covariance Uncropped)')

figure(3)
plot(Back)
title('Final Reconstruction (Uncropped)')