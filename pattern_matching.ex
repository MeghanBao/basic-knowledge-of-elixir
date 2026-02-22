# 03_PatternMatching/pattern_matching.ex
# Pattern Matching in Elixir / Elixir 模式匹配
# Pattern matching is one of the most powerful features in Elixir!
# 模式匹配是 Elixir 最强大的特性之一！
#
# Run / 运行方式:
#   elixir pattern_matching.ex

IO.puts("===== The Match Operator = / 匹配运算符 =====")
# In Elixir, = is the "match operator", not just assignment
# 在 Elixir 中，= 是"匹配运算符"，而不仅仅是赋值
x = 1
IO.inspect(x)

# This matches x against 1 (succeeds)
# 将 x 与 1 匹配（成功）
1 = x
IO.puts("1 = x succeeded / 匹配成功")

# Matching with a tuple
# 匹配元组
{a, b, c} = {1, 2, 3}
IO.inspect([a, b, c])


IO.puts("\n===== Matching with Lists / 列表匹配 =====")
# Head | Tail pattern for lists
# 列表的头部 | 尾部 模式
[head | tail] = [1, 2, 3, 4, 5]
IO.inspect(head)    # => 1
IO.inspect(tail)    # => [2, 3, 4, 5]

# Destructuring specific elements
# 解构特定元素
[first, second | rest] = [10, 20, 30, 40]
IO.inspect({first, second, rest})


IO.puts("\n===== Pin Operator ^ / 固定运算符 =====")
# ^ prevents rebinding — it matches against the existing value
# ^ 防止重新绑定——它与已有的值进行匹配
y = 5
{^y, z} = {5, 10}   # y must be 5 / y 必须为 5
IO.inspect(z)        # => 10


IO.puts("\n===== Pattern Matching in case / case 中的模式匹配 =====")
result = {:ok, 42}

message =
  case result do
    {:ok, value}    -> "Success! Value is #{value} / 成功！值为 #{value}"
    {:error, reason} -> "Error: #{reason} / 错误：#{reason}"
    _               -> "Unknown / 未知"
  end

IO.puts(message)


IO.puts("\n===== Matching Function Arguments / 函数参数匹配 =====")
# Functions can be defined with multiple clauses matched by pattern
# 函数可以定义多个通过模式匹配的子句
defmodule Greeter do
  # Match atom :morning / 匹配原子 :morning
  def greet(:morning), do: "Good morning! / 早上好！"
  # Match atom :evening / 匹配原子 :evening
  def greet(:evening), do: "Good evening! / 晚上好！"
  # Catch-all clause / 通配子句
  def greet(_),        do: "Hello! / 你好！"
end

IO.puts(Greeter.greet(:morning))
IO.puts(Greeter.greet(:evening))
IO.puts(Greeter.greet(:noon))


IO.puts("\n===== Underscore _ (ignore) / 下划线（忽略） =====")
# Use _ to ignore values you don't need
# 使用 _ 忽略不需要的值
{_, important, _} = {:ignored, "keep me", :also_ignored}
IO.inspect(important)
