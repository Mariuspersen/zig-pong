const std = @import("std");
const rl = @import("raylib");

const Self = @This();
const RndGen = std.Random.DefaultPrng;

pos: rl.Vector2,
vel: rl.Vector2,
width: i32 = 20,
height: i32 = 20,
color: rl.Color = rl.Color.red,

const Wall = enum {
    left,
    right,
};

pub fn init(x: f32, y: f32) Self {
    var rnd = RndGen.init(@bitCast(std.time.milliTimestamp()));

    return .{
        .vel = rl.Vector2.init(
            rnd.random().float(f32)/3,
            rnd.random().float(f32)/3,
        ),
        .pos = rl.Vector2.init(
            x,
            y,
        ),
    };
}

pub fn update(self: *Self) void {
    self.pos = self.pos.add(self.vel);
}

pub fn draw(self: *Self) void {
    rl.drawRectangle(@intFromFloat(self.pos.x), @intFromFloat(self.pos.y), self.width, self.height, self.color);
}

pub fn boundryCheck(self: *Self, width: i32, height: i32) ?Wall {
    if (@as(i32, @intFromFloat(self.pos.x)) + self.width >= width) {
        self.vel.x *= -1;
        return .right;
    }
    if (self.pos.x < 0) {
        self.vel.x *= -1;
        return .left;
    }
    if (@as(i32, @intFromFloat(self.pos.y)) + self.height >= height or self.pos.y < 0) {
        self.vel.y *= -1;
    }
    return null;
}
