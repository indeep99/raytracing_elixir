defmodule Vec3Test do
  use ExUnit.Case
  alias Vec3

  test "vector creation" do
    v = Vec3.new(1.0, 2.0, 3.0)
    assert v.x == 1.0
    assert v.y == 2.0
    assert v.z == 3.0
  end

  test "vector addition" do
    v1 = Vec3.new(1.0, 2.0, 3.0)
    v2 = Vec3.new(4.0, 5.0, 6.0)
    result = Vec3.add(v1, v2)

    assert result == %Vec3{x: 5.0, y: 7.0, z: 9.0}
  end

  test "vector subtraction" do
    v1 = Vec3.new(4.0, 5.0, 6.0)
    v2 = Vec3.new(1.0, 2.0, 3.0)
    result = Vec3.subtract(v1, v2)

    assert result == %Vec3{x: 3.0, y: 3.0, z: 3.0}
  end

  test "scalar multiplication" do
    v = Vec3.new(1.0, -2.0, 3.0)
    result = Vec3.scale(v, 2.0)

    assert result == %Vec3{x: 2.0, y: -4.0, z: 6.0}
  end

  test "scalar division" do
    v = Vec3.new(2.0, -4.0, 6.0)
    result = Vec3.divide(v, 2.0)

    assert result == %Vec3{x: 1.0, y: -2.0, z: 3.0}
  end

  test "dot product" do
    v1 = Vec3.new(1.0, 2.0, 3.0)
    v2 = Vec3.new(4.0, -5.0, 6.0)
    result = Vec3.dot(v1, v2)

    assert result == 12.0
  end

  test "cross product" do
    v1 = Vec3.new(1.0, 2.0, 3.0)
    v2 = Vec3.new(4.0, 5.0, 6.0)
    result = Vec3.cross(v1, v2)

    assert result == %Vec3{x: -3.0, y: 6.0, z: -3.0}
  end

  test "vector negation" do
    v = Vec3.new(1.0, -2.0, 3.0)
    result = Vec3.negate(v)

    assert result == %Vec3{x: -1.0, y: 2.0, z: -3.0}
  end

  test "vector magnitude" do
    v = Vec3.new(3.0, 4.0, 0.0)
    assert Vec3.magnitude(v) == 5.0
  end

  # Add small buffer for assert due to float precision
  test "vector normalization" do
    v = Vec3.new(3.0, 4.0, 0.0)
    result = Vec3.normalize(v)

    expected = Vec3.new(3.0 / 5.0, 4.0 / 5.0, 0.0)

    assert_in_delta result.x, expected.x, 1.0e-9
    assert_in_delta result.y, expected.y, 1.0e-9
    assert_in_delta result.z, expected.z, 1.0e-9
  end
end
