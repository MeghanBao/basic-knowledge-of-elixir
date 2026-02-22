# 04_Functions/functions.ex
# Functions in Elixir / Elixir 函数
#
# Run / 运行方式:
#   elixir functions.ex

IO.puts("===== Named Functions (in Modules) / 命名函数（模块内） =====")

defmodule MathUtils do
  # Basic named function / 基本命名函数
  def add(a, b), do: a + b

  # Multi-line function body / 多行函数体
  def multiply(a, b) do
    result = a * b
    result   # last expression is the return value / 最后一个表达式是返回值
  end

  # Default arguments with \\ / 使用 \\ 设置默认参数
  def greet(name, language \\ :english) do
    case language do
      :english -> "Hello, #{name}!"
      :chinese -> "你好，#{name}！"
      _        -> "Hi, #{name}!"
    end
  end

  # Guard clauses with when / 使用 when 的守卫子句
  def abs_value(n) when n >= 0, do: n
  def abs_value(n), do: -n

  # Private function (defp) — only accessible within the module
  # 私有函数（defp）——只能在模块内部访问
  defp secret, do: "I'm private / 我是私有函数"

  def reveal_secret, do: secret()
end

IO.inspect(MathUtils.add(3, 4))
IO.inspect(MathUtils.multiply(6, 7))
IO.puts(MathUtils.greet("Alice"))
IO.puts(MathUtils.greet("小明", :chinese))
IO.inspect(MathUtils.abs_value(-10))
IO.puts(MathUtils.reveal_secret())


IO.puts("\n===== Anonymous Functions / 匿名函数 =====")
# Defined with fn ... end, called with .()
# 用 fn ... end 定义，用 .() 调用
square = fn x -> x * x end
IO.inspect(square.(5))     # => 25

# Shorthand syntax with & / 使用 & 的简写语法
double = &(&1 * 2)
IO.inspect(double.(7))     # => 14

add = &(&1 + &2)
IO.inspect(add.(3, 4))     # => 7


IO.puts("\n===== Higher-Order Functions / 高阶函数 =====")
# Functions that take or return other functions
# 接受或返回其他函数的函数
numbers = [1, 2, 3, 4, 5]

# Enum.map — transform each element / 变换每个元素
squared = Enum.map(numbers, fn x -> x * x end)
IO.inspect(squared)

# Shorter with & syntax / 使用 & 语法更简洁
doubled = Enum.map(numbers, &(&1 * 2))
IO.inspect(doubled)

# Enum.filter — keep elements matching condition / 保留满足条件的元素
evens = Enum.filter(numbers, &(rem(&1, 2) == 0))
IO.inspect(evens)

# Enum.reduce — accumulate a value / 累积一个值
sum = Enum.reduce(numbers, 0, &(&1 + &2))
IO.inspect(sum)


IO.puts("\n===== Pipe Operator |> / 管道运算符 =====")
# Pass result of one function as first argument of the next
# 将一个函数的结果作为下一个函数的第一个参数
result =
  [1, 2, 3, 4, 5, 6]
  |> Enum.filter(&(rem(&1, 2) == 0))   # keep even numbers / 保留偶数
  |> Enum.map(&(&1 * &1))              # square them / 求平方
  |> Enum.sum()                        # sum all / 求和

IO.inspect(result)   # => 56  (4 + 16 + 36)


IO.puts("\n===== Closures / 闭包 =====")
# Anonymous functions capture variables from their scope
# 匿名函数会捕获其作用域中的变量
multiplier = 3
times_three = fn x -> x * multiplier end
IO.inspect(times_three.(10))   # => 30
