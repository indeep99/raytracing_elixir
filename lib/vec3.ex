defmodule Vec3 do
  defstruct x: 0.0, y: 0.0, z: 0.0

  def new(x, y, z), do: %Vec3{x: x, y: y, z: z}

  def negate(%Vec3{x: x, y: y, z: z}), do: %Vec3{x: -x, y: -y, z: -z}

  def add(%Vec3{x: x1, y: y1, z: z1}, %Vec3{x: x2, y: y2, z: z2}) do
    %Vec3{x: x1 + x2, y: y1 + y2, z: z1 + z2}
  end

  def subtract(%Vec3{x: x1, y: y1, z: z1}, %Vec3{x: x2, y: y2, z: z2}) do
    %Vec3{x: x1 - x2, y: y1 - y2, z: z1 - z2}
  end

  def multiply(%Vec3{x: x1, y: y1, z: z1}, %Vec3{x: x2, y: y2, z: z2}) do
    %Vec3{x: x1 * x2, y: y1 * y2, z: z1 * z2}
  end

  def scale(%Vec3{x: x, y: y, z: z}, t) do
    %Vec3{x: x * t, y: y * t, z: z * t}
  end

  def divide(v, t) when t != 0, do: scale(v, 1 / t)

  def dot(%Vec3{x: x1, y: y1, z: z1}, %Vec3{x: x2, y: y2, z: z2}) do
    x1 * x2 + y1 * y2 + z1 * z2
  end

  def cross(%Vec3{x: x1, y: y1, z: z1}, %Vec3{x: x2, y: y2, z: z2}) do
    %Vec3{
      x: y1 * z2 - z1 * y2,
      y: z1 * x2 - x1 * z2,
      z: x1 * y2 - y1 * x2
    }
  end

  def magnitude(v), do: :math.sqrt(length_squared(v))

  def length_squared(%Vec3{x: x, y: y, z: z}), do: x * x + y * y + z * z

  def normalize(v), do: divide(v, magnitude(v))

  def to_string(%Vec3{x: x, y: y, z: z}), do: "#{x} #{y} #{z}"
end
