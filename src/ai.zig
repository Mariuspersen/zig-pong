const Self = @This();
const Paddle = @import("paddle.zig");
const Ball = @import("ball.zig");

paddle: *Paddle,
ball: *Ball,

pub fn init(paddle: *Paddle,ball: *Ball) Self {
    return .{
        .paddle = paddle,
        .ball = ball,
    };
}

pub fn update(self: *Self) void {
    self.paddle.update(self.ball.pos);
}