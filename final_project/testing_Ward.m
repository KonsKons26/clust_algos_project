% Ward Clustering
load Salinas_Data
load preprocessed_X

% Normalize and cluster
X = zscore(X);

% % Plot the K largest lifespans
% Z = linkage(X, 'ward', 'euclidean');
% K = 30;
% [sorted_lifespans, sorted_indices] = plot_lifespans(...
%     Z, X, K, "Ward");


% Use K = 2 for number of clusters
tic
    Z = linkage(X, 'ward', 'euclidean');
    K = 2;
    [p,n,l]=size(Salinas_Image);
    X_total = reshape(Salinas_Image, p * n, l);
    L = reshape(Salinas_Labels, p * n, 1);
    existed_L = (L > 0);
    X = X_total(existed_L, :);

    cl_label = cluster(Z, 'maxclust', K);
    cl_label_tot = zeros(p * n, 1);
    cl_label_tot(existed_L) = cl_label;
    im_cl_label = reshape(cl_label_tot, p, n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("Ward clustering with %d clusters", K));


    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);

    fprintf("\n\nWard with %d clusters\n", K);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc


% Use K = 5 for number of clusters
tic
    Z = linkage(X, 'ward', 'euclidean');
    K = 5;
    [p,n,l]=size(Salinas_Image);
    X_total = reshape(Salinas_Image, p * n, l);
    L = reshape(Salinas_Labels, p * n, 1);
    existed_L = (L > 0);
    X = X_total(existed_L, :);

    cl_label = cluster(Z, 'maxclust', K);
    cl_label_tot = zeros(p * n, 1);
    cl_label_tot(existed_L) = cl_label;
    im_cl_label = reshape(cl_label_tot, p, n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("Ward clustering with %d clusters", K));


    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);

    fprintf("\n\nWard with %d clusters\n", K);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc


% Use K = 8 for number of clusters
tic
    Z = linkage(X, 'ward', 'euclidean');
    K = 8;
    [p,n,l]=size(Salinas_Image);
    X_total = reshape(Salinas_Image, p * n, l);
    L = reshape(Salinas_Labels, p * n, 1);
    existed_L = (L > 0);
    X = X_total(existed_L, :);

    cl_label = cluster(Z, 'maxclust', K);
    cl_label_tot = zeros(p * n, 1);
    cl_label_tot(existed_L) = cl_label;
    im_cl_label = reshape(cl_label_tot, p, n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("Ward clustering with %d clusters", K));


    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);

    fprintf("\n\nWard with %d clusters\n", K);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc