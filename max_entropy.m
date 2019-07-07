function [out,select, ent_map] = max_entropy(images, matrix_size)
out = zeros(size(images,2),size(images,3),size(images,4));
ent_map = zeros(size(image,1),size(images,2),size(images,3));
disp(size(images));
height = size(images,2);
width = size(images,3);
half_size = int8(matrix_size/2);
x1 = 1:matrix_size;
x2 = 1:matrix_size;
[X1, X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
mu = [matrix_size/2 matrix_size/2];
sigma = [matrix_size/4 matrix_size/4];
y = mvnpdf(X, mu, sigma);
filter = reshape(y, length(x1), length(x2));
select = ones(height, width);
for x = matrix_size : width - matrix_size + 1
    for y = matrix_size : height - matrix_size + 1
        max_i = 1;
        max_val = -1;
        for i = 1:size(images,1)
            
            ent = entropy(images(i,y-half_size:y+half_size-1,x-half_size:x+half_size-1,:), filter, 0.2);
            ent_map(i,y,x) = ent;
            if ent > max_val
                max_val = ent;
                max_i = i;
            end
        end
        select(y,x) = max_i;
        
    end
end
for x = 1 : width
    for y = 1 : height
        out(y,x,:) = images(select(y,x),y,x,:);
    end
end
for i = 1:size(images,1)
    temp = ent_map(i,:,:);
    ent_map(i,:,:) = ent_map(i,:,:) ./ max(temp(:));
end
end
