module lifegame;

import std.algorithm;
import std.bitmanip;
import std.experimental.logger;

struct LifeGame
{
    this (in size_t h, in size_t w)
    {
        this.h = h;
        this.w = w;
        this.n = h * w;
        _current.length = n;
        _next.length = n;
    }
    void fill(T)(T x)
        in (x.length == n)
    {
        foreach (i, e; x)
            _current[i] = e;
    }
    auto ref bool current(in size_t i, in size_t j)
    {
        return _current[index(i, j, h, w)];
    }
    void step()
    {
        foreach (i; 0..h)
            foreach (j; 0..w)
            {
                immutable
                    im = i ? i-1 : h-1,
                    ip = i+1 == h ? 0 : i+1,
                    jm = j ? j-1 : w-1,
                    jp = j+1 == w ? 0 : j+1,
                    n_neighbors =
                        current(im, jm) + current(im, j ) + current(im, jp) +
                        current(i , jm)          +          current(i , jp) +
                        current(ip, jm) + current(ip, j ) + current(ip, jp);
                _next[index(i, j, h, w)] =
                    (n_neighbors == 3) || (current(i, j) && (n_neighbors == 2));
            }
        auto tmp = _current;
        _current = _next;
        _next = tmp;
    }
    immutable size_t h, w, n;
    BitArray _current, _next;
}
size_t index(in size_t i, in size_t j, in size_t h, in size_t w)
    in (i < h)
    in (j < w)
    out (r; r < h * w)
{
    return i * w + j;
}
