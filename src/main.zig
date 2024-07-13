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
    rl.setTargetFPS(60);
    defer rl.closeWindow();

    var ball = Ball.init(Width / 2, Height / 2);
    var paddle1 = Paddle.init(60, Height / 2, 40, 160);
    var paddle2 = Paddle.init(Width - 60 - 40, Height / 2, 40, 160);
    var ai = Ai.init(&paddle2, &ball);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        defer rl.clearBackground(Gray);

        if (rl.isKeyPressed(rl.KeyboardKey.key_f1)) {
            ball = Ball.init(Width / 2, Height / 2);
        }

        if (handleWinCondition(&ball)) continue;

        paddle1.handleCollision(&ball);
        paddle2.handleCollision(&ball);

        ball.update();
        paddle1.update(rl.getMousePosition());
        ai.update();

        ball.draw();
        paddle1.draw();
        paddle2.draw();
    }
}

inline fn handleWinCondition(ball: *Ball) bool {
    if (ball.boundryCheck(Width, Height)) |winner| {
        switch (winner) {
            .left => {
                rl.drawText(
                    "Left Wins!",
                    @divExact(Width, 2) - 150,
                    @divExact(Height, 2) - 300,
                    50,
                    rl.Color.white,
                );
            },
            .right => {
                rl.drawText(
                    "Right Wins!",
                    @divExact(Width, 2) - 150,
                    @divExact(Height, 2) - 300,
                    50,
                    rl.Color.white,
                );
            },
        }
        rl.drawText(
            "Press F1 to restart",
            @divExact(Width, 2) - 275,
            @divExact(Height, 2),
            50,
            rl.Color.white,
        );
        return true;
    }
    return false;
}
