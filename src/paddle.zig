const Self = @This();
const Ball = @import("ball.zig");
const rl = @import("raylib");

pos: rl.Vector2,
width: i32,
height: i32,
color: rl.Color = rl.Color.red,

pub fn init(x: f32, y: f32, width: i32, height: i32) Self {
    return .{
        .width = width,
        .height = height,
        .pos = rl.Vector2.init(x, y - (@as(f32, @floatFromInt(height)) / 2)),
    };
}

pub fn update(self: *Self, pos: rl.Vector2) void {
    self.pos.y = pos.y - (@as(f32, @floatFromInt(self.height)) / 2);
}

pub fn draw(self: *Self) void {
    rl.drawRectangle(@intFromFloat(self.pos.x), @intFromFloat(self.pos.y), self.width, self.height, self.color);
}

pub fn handleCollision(self: *Self, ball: *Ball) void {
    const sh: f32 = @floatFromInt(self.height);
    const sw: f32 = @floatFromInt(self.width);
    const bh: f32 = @floatFromInt(ball.height);
    const bw: f32 = @floatFromInt(ball.width);

    const intersect =
        !(self.pos.x + sw <= ball.pos.x or
        ball.pos.x + bw <= self.pos.x or
        self.pos.y + sh <= ball.pos.y or
        ball.pos.y + bh <= self.pos.y);

    if (intersect) {
        ball.vel.x *= -1;
    }
}
