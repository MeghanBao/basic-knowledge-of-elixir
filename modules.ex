# 05_Modules/modules.ex
# Modules in Elixir / Elixir 模块
#
# Run / 运行方式:
#   elixir modules.ex

# Modules group related functions together
# 模块将相关函数组织在一起
defmodule Animal do
  # Module attribute — like a constant / 模块属性——类似常量
  @legs_default 4

  # struct defines a typed map for the module
  # struct 为模块定义一个类型化的 Map
  defstruct name: "Unknown", type: :mammal, legs: @legs_default

  # Constructor-like function / 类似构造函数
  def new(name, type \\ :mammal, legs \\ @legs_default) do
    %Animal{name: name, type: type, legs: legs}
  end

  # Function using the struct / 使用结构体的函数
  def describe(%Animal{name: name, type: type, legs: legs}) do
    "#{name} is a #{type} with #{legs} legs."
  end

  def is_bird?(%Animal{type: type}), do: type == :bird
end


IO.puts("===== Structs / 结构体 =====")
dog  = Animal.new("Rex")
bird = Animal.new("Tweety", :bird, 2)
fish = Animal.new("Nemo", :fish, 0)

IO.inspect(dog)
IO.puts(Animal.describe(dog))
IO.puts(Animal.describe(bird))
IO.inspect(Animal.is_bird?(bird))

# Update a struct with | syntax / 使用 | 语法更新结构体
updated_dog = %{dog | name: "Buddy"}
IO.inspect(updated_dog)


IO.puts("\n===== Nested Modules / 嵌套模块 =====")
defmodule Zoo do
  defmodule Exhibit do
    def info(animal) do
      "Exhibit: #{animal.name} (#{animal.type})"
    end
  end

  def open?, do: true
end

IO.puts(Zoo.Exhibit.info(dog))
IO.inspect(Zoo.open?())


IO.puts("\n===== Module Attributes / 模块属性 =====")
defmodule Config do
  # Attributes defined with @ are compile-time constants
  # 用 @ 定义的属性是编译时常量
  @version "1.0.0"
  @author  "Elixir Developer"
  @max_connections 100

  def version, do: @version
  def author,  do: @author
  def max_connections, do: @max_connections
end

IO.puts("Version: #{Config.version()}")
IO.puts("Author: #{Config.author()}")
IO.inspect(Config.max_connections())


IO.puts("\n===== Behaviours (Interfaces) / 行为（接口） =====")
# Behaviours define a set of functions a module must implement
# Behaviour 定义模块必须实现的函数集合（类似接口）
defmodule Shape do
  @callback area(map()) :: float()
  @callback perimeter(map()) :: float()
end

defmodule Circle do
  @behaviour Shape
  @pi 3.14159265

  def area(%{radius: r}),     do: @pi * r * r
  def perimeter(%{radius: r}), do: 2 * @pi * r
end

circle = %{radius: 5.0}
IO.inspect(Circle.area(circle))
IO.inspect(Circle.perimeter(circle))
