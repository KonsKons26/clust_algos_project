% this script tests several numbers of clusters and plot them against
% the cost function so we can find the elbow of the plot to find the
% optimal number of clusters
load Salinas_Data
load preprocessed_X


num_features = size(X, 2);
smallest_m = 2;
largest_m = 25;
lower_limit = prctile(X, 25)';
upper_limit = prctile(X, 75)';
num_repeats = 10;
seeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

% k_means_mean_J_values = zeros(1, largest_m - smallest_m + 1);
% 
% for m = smallest_m:largest_m
%     disp(m);
%     J_values_for_m = zeros(1, num_repeats);
%     for repeat = 1:num_repeats
%         rand('seed', seeds(repeat));
%         randn('seed', seeds(repeat));
%         initial_thetas = lower_limit + (upper_limit - lower_limit)...
%                          .* rand(num_features, m);
%         [~, ~, J] = k_means(X', initial_thetas);
%         J_values_for_m(repeat) = J;
%     end
%     k_means_mean_J_values(m - smallest_m + 1) = mean(J_values_for_m);
% end
% 
% k_means_m_values = smallest_m:largest_m;
% figure;
% plot(k_means_m_values, k_means_mean_J_values, '-o', 'LineWidth', 2, ...
%     'MarkerSize', 6);
% xlabel('Number of Clusters (m)');
% ylabel('Cost Function (J)');
% title('k-means Clustering: m vs J (averaged over 10 runs)');
% grid on;



% Apparent elbow = 5 %
tic
    m = 5;
    [p, n, ~] = size(Salinas_Image);
    
    initial_thetas = lower_limit + (upper_limit - lower_limit)...
                             .* rand(num_features, m);
    [~, bel, ~] = k_means(X', initial_thetas);

    cl_label = bel;

    L=reshape(Salinas_Labels,p*n,1);
    existed_L=(L>0);
    cl_label_tot=zeros(p*n,1);
    cl_label_tot(existed_L)=cl_label;
    im_cl_label=reshape(cl_label_tot,p,n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("\n\nk-means with %d clusters\n", m))

    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);
    
    fprintf("\n\nk-means with %d clusters\n", m);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc


% Using 8 clusters which is the ground truth
tic
    m = 8;
    [p, n, ~] = size(Salinas_Image);
    
    initial_thetas = lower_limit + (upper_limit - lower_limit)...
                             .* rand(num_features, m);
    [~, bel, ~] = k_means(X', initial_thetas);
    
    cl_label = bel;
    
    L=reshape(Salinas_Labels,p*n,1);
    existed_L=(L>0);
    cl_label_tot=zeros(p*n,1);
    cl_label_tot(existed_L)=cl_label;
    im_cl_label=reshape(cl_label_tot,p,n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("\n\nk-means with %d clusters\n", m))
    
    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);
    
    fprintf("\n\nk-means with %d clusters\n", m);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc

% Test with data that were not preprocessed
[p, n, l] = size(Salinas_Image);
X_total = reshape(Salinas_Image, p * n, l);
L = reshape(Salinas_Labels, p * n, 1);
existed_L = (L > 0);
X = X_total(existed_L, :);
num_features = size(X, 2);

tic
    m = 8;
    [p, n, ~] = size(Salinas_Image);
    lower_limit = prctile(X, 25)';
    upper_limit = prctile(X, 75)';
    initial_thetas = lower_limit + (upper_limit - lower_limit)...
                             .* rand(num_features, m);
    [~, bel, ~] = k_means(X', initial_thetas);
    
    cl_label = bel;
    
    L=reshape(Salinas_Labels,p*n,1);
    existed_L=(L>0);
    cl_label_tot=zeros(p*n,1);
    cl_label_tot(existed_L)=cl_label;
    im_cl_label=reshape(cl_label_tot,p,n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("k-means with %d clusters\n" + ...
        "(not preprocessed)", m))
    
    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);
    
    fprintf("\n\nk-means with %d clusters not preprocessed\n", m);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc
