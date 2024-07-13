const std = @import("std");
const rl = @import("raylib");

const Gray = rl.Color.init(18, 18, 18, 255);

const Paddle = @import("paddle.zig");
const Ball = @import("ball.zig");
const Ai = @import("ai.zig");

const Width = 1920;
const Height = 1080;
const Title = "zong";

pub fn main() !void {
    rl.initWindow(Width, Height, Title);
    defer rl.closeWindow();

    var ball = Ball.init(Width / 2, Height / 2);
    var paddle1 = Paddle.init(60, Height / 2, 40, 160);
    var paddle2 = Paddle.init(Width - 60, Height / 2, 40, 160);
    var ai = Ai.init(&paddle2, &ball);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        paddle1.handleCollision(&ball);
        paddle2.handleCollision(&ball);

        ball.update();
        paddle1.update(rl.getMousePosition());
        ai.update();

        ball.draw();
        paddle1.draw();
        paddle2.draw();

        rl.clearBackground(Gray);
    }
}
