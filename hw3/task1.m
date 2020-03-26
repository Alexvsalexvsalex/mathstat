pkg load statistics

function p = test(n, mu, sigma)
    m = 100;
    X = sort(normrnd(mu, sigma, m, n));
    res = -1;
    for i=1:m
        X_i = X(i, :);
        F_X_i = normcdf(X_i, mu, sigma);
        current_val = max(abs(F_X_i  - i / m), abs(F_X_i - (i - 1) / m));
        res = max(res, current_val);
    endfor
    gamma = 0.95;
    u_gamma = 1.36;
    p = mean((sqrt(m) * res) > u_gamma);
endfunction

n = 100;
mu = 1;
sigma = 1;

t = mu - 3 * sigma : 0.5 : mu + 3 * sigma;
F_x = normcdf(t, mu, sigma);

X = sort(normrnd(mu, sigma, n, 1));
F_n = 1 / n : 1 / n : 1;
[a, b] = stairs(X, F_n);

u = 1.36;
delta = u / sqrt(n);
plot(a, b, t, F_x, a, max(b - delta, 0), a, min(b + delta, 1))

test(10000, mu, sigma);
test(1000000, mu, sigma);
