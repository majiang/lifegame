import std.datetime.stopwatch, std.experimental.logger;
import std.algorithm, std.random, std.range;
import lifegame;

void main()
{
    auto lg = LifeGame(100, 100);
    lg.fill(lg.n.iota.map!(i => choice([true, false])).array);
    auto stopwatch = StopWatch(AutoStart.yes);
    foreach (i; 0..1000)
        lg.step;
    "%s".logf(stopwatch.peek);
}
