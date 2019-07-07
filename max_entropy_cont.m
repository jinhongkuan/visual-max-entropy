function [out,select] = max_entropy_cont(images, matrix_size)
out = zeros(size(images,2),size(images,3),size(images,4));
ent_map = zeros(size(images,1),size(images,2),size(images,3));
disp(size(out));
height = size(images,2);
width = size(images,3);
half_size = int64(matrix_size/2);
x1 = 1:matrix_size;
x2 = 1:matrix_size;
[X1, X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
mu = [matrix_size/2 matrix_size/2];
sigma = [matrix_size/4 matrix_size/4];
y = mvnpdf(X, mu, sigma);
filter = reshape(y, length(x1), length(x2));
select_weight = (0:(size(images,1)-1))/(size(images,1)-1);
select = zeros(height, width);
for x = matrix_size : width - matrix_size + 1
    for y = matrix_size : height - matrix_size + 1
        average_val = zeros(1,size(images,4));
        entropies = zeros(1,size(images,1));
        for i = 1:size(images,1)
            region = images(i,y-half_size:y+half_size-1,x-half_size:x+half_size-1,:);
            ent = entropy(region, filter, 0.2);
            entropies(i) = ent;
        end
        entropies = entropies ./ sum(entropies);
        select(y,x) = sum(select_weight .* entropies);
        for i = 1:size(images,1)
            for c = 1:size(images,4)
                out(y,x,c) = out(y,x,c) + entropies(i) * images(i,y,x,c);
        end
        
    end
end

end
