i = rgb2gray(im2double(imread("im1.png")));

GaussianScaleSpace = zeros(size(i));
DoGScaleSpace = zeros(size(i));
initsigma = 4;
sigma = initsigma;
doubling = 1;

AllSigma = zeros(17,1);
AllSigma(1) = sigma;
for n = 0:16
    filt = fspecial('gaussian', 20, sigma);
    im = (conv2(i, filt, 'same'));
    GaussianScaleSpace(:,:,n+1) = im;
    
    if mod(n,4) == 0 && n > 1
        doubling = doubling * 2;
    end
    
    sigma = initsigma * doubling * 2^((mod(n,4)+1)/4);
    
    if n~=16
        subplot(4,4,n+1), imshow(im);
        AllSigma(n+2) = sigma;
    end
    
    title("Sigma = "+sigma);
    
end

for n = 1:16
    temp = (GaussianScaleSpace(:,:,n+1)) - (GaussianScaleSpace(:,:,n));
    DoGScaleSpace(:,:,n) = rescale(temp,0,1);
    subplot(4,4,n), imshow(DoGScaleSpace(:,:,n));
end

s = size(DoGScaleSpace);
xs = s(1);
ys = s(2);
zs = s(3);

keypoints = zeros(1000,3);
n = 1;
% imshow(i);

% Question 4: SIFT keypoint detection
for z = 2: zs-1
    csig = AllSigma(z);
    dist =  uint8(2*csig);
    for x = 2+dist: xs-1-dist
        for y = 2+dist:ys-1-dist
            if is_local_extrema([x,y,z], DoGScaleSpace, 1.0025)
                keypoints(n,:) = [x,y,z];
                n = n+1;
%                 viscircles([x,y], csig);
            end
        end
    end
end
