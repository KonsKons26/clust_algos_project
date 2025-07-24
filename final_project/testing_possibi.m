load Salinas_Data
load preprocessed_X


% smallest_m = 2;
% largest_m = 25;
% ms = smallest_m:largest_m;
% num_repeats = 10;
% tot_ms = size(ms, 2);
% seeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
% q = 2;
% mean_J_values = zeros(1, tot_ms);
% init_proc = 3;
% thresh = 0.1;
% t = 1;
% for m = ms
%     J_values_for_q = zeros(1, num_repeats);
%     for repeat = 1:num_repeats
%         seed = seeds(repeat);
%         eta = calc_eta(X', m, q);
%         [U, theta] = possibi(X', m, eta, q, seed, init_proc, thresh);
%         J = possibi_cost(X', U, theta, q, eta);
%         J_values_for_q(repeat) = J;
%     end
%     mean_J_values(t) = mean(J_values_for_q);
%     fprintf("Iteration: %d of %d\tm = %d\n", t, tot_ms, m);
%     t = t + 1;
% end
% 
% figure;
% plot(ms, mean_J_values, '-o',...
%     'LineWidth', 2,...
%     'MarkerSize', 6);
% xlabel('Number of clusters (m)');
% ylabel('Cost Function (J)');
% title('possibilistic c-means Clustering: m vs J (averaged over 10 runs)');
% grid on;
% 
% num_features = size(X, 2);
% smallest_q = 4;
% largest_q = 10;
% tot_qs = 16;
% qs = linspace(smallest_q, largest_q, tot_qs);
% num_repeats = 10;
% seeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
% 
% mean_J_values = zeros(1, tot_qs);
% 
% init_proc = 3;
% m = 8;
% thresh = 0.1;
% t = 1;
% for q = qs
%     J_values_for_q = zeros(1, num_repeats);
%     for repeat = 1:num_repeats
%         seed = seeds(repeat);
%         eta = calc_eta(X', m, q);
%         [U, theta] = possibi(X', m, eta, q, seed, init_proc, thresh);
%         J = possibi_cost(X', U, theta, q, eta);
%         J_values_for_q(repeat) = J;
%     end
%     mean_J_values(t) = mean(J_values_for_q);
%     fprintf("Iteration: %d of %d\tq = %.4f\n", t, tot_qs, q);
%     t = t + 1;
% end
% 
% figure;
% plot(qs, mean_J_values, '-o',...
%     'LineWidth', 2,...
%     'MarkerSize', 6);
% xlabel('q');
% ylabel('Cost Function (J)');
% title('possibilistic c-means Clustering: q vs J (averaged over 10 runs)');
% grid on;

% q = 2
[p, n, ~] = size(Salinas_Image);
m = 8;
q = 2;
eta = calc_eta(X', m, q);
seed = 42;
init_proc = 3;
e_thresh = 0.0001;
tic
    [U, theta] = possibi(X', m, eta, q, seed, init_proc, e_thresh);

    [~, cl_label] = max(U, [], 2);

    L=reshape(Salinas_Labels,p*n,1);
    existed_L=(L>0);
    cl_label_tot=zeros(p*n,1);
    cl_label_tot(existed_L)=cl_label;
    im_cl_label=reshape(cl_label_tot,p,n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("\npossibilistic clustering with\n" + ...
        "%d clusters and q=%2.f", m, q))

    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);

    fprintf("\n\npossibilistic with %d clusters and " + ...
        "q=%.2f\n", m, q);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc

% q = 12
[p, n, ~] = size(Salinas_Image);
m = 8;
q = 12;
eta = calc_eta(X', m, q);
seed = 42;
init_proc = 3;
e_thresh = 0.0001;
tic
    [U, theta] = possibi(X', m, eta, q, seed, init_proc, e_thresh);

    [~, cl_label] = max(U, [], 2);

    L=reshape(Salinas_Labels,p*n,1);
    existed_L=(L>0);
    cl_label_tot=zeros(p*n,1);
    cl_label_tot(existed_L)=cl_label;
    im_cl_label=reshape(cl_label_tot,p,n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("\npossibilistic clustering with\n" + ...
        "%d clusters and q=%2.f", m, q))

    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);

    fprintf("\n\npossibilistic with %d clusters and " + ...
        "q=%.2f\n", m, q);
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

m = 8;
q = 2;
eta = calc_eta(X', m, q);
seed = 42;
init_proc = 3;
e_thresh = 0.0001;
tic
    [U, theta] = possibi(X', m, eta, q, seed, init_proc, e_thresh);

    [~, cl_label] = max(U, [], 2);

    L=reshape(Salinas_Labels,p*n,1);
    existed_L=(L>0);
    cl_label_tot=zeros(p*n,1);
    cl_label_tot(existed_L)=cl_label;
    im_cl_label=reshape(cl_label_tot,p,n);
    figure;
    imagesc(im_cl_label);
    title(sprintf("\npossibilistic clustering with\n" + ...
        "%d clusters and q=%2.f\n" + ...
        "(not preprocessed)", m, q))

    flat_labels = reshape(Salinas_Labels, [], 1);
    [AR, RI, MI, HI] = RandIndex(cl_label_tot, flat_labels);
    nmi_value = NMI(cl_label_tot, flat_labels);

    fprintf("\n\npossibilistic with %d clusters and " + ...
        "q=%.2f " + ...
        "(not preprocessed)\n", m, q);
    fprintf('Adjusted Rand Index (ARI): %.4f\n', AR);
    fprintf('Rand Index (RI): %.4f\n', RI);
    fprintf('Mirkin Index (MI): %.4f\n', MI);
    fprintf('Hubert Index (HI): %.4f\n', HI);
    fprintf('Normalized Mutual Information (NMI): %.4f\n', nmi_value);
toc