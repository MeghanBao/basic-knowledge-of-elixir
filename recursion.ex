# 09_Recursion/recursion.ex
# Recursion in Elixir / Elixir 递归
# In Elixir there are no loops — recursion is the primary iteration mechanism
# Elixir 中没有循环——递归是主要的迭代机制
#
# Run / 运行方式:
#   elixir recursion.ex

defmodule MyRecursion do

  # ---- Factorial / 阶乘 ----
  # Base case: factorial of 0 is 1
  # 基础情况：0 的阶乘为 1
  def factorial(0), do: 1
  # Recursive case / 递归情况
  def factorial(n) when n > 0, do: n * factorial(n - 1)


  # ---- Sum of a list / 列表求和 ----
  def sum([]), do: 0                          # empty list / 空列表
  def sum([head | tail]), do: head + sum(tail)


  # ---- Fibonacci / 斐波那契数列 ----
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when n > 1, do: fib(n - 1) + fib(n - 2)


  # ---- Tail-Recursive Fibonacci (efficient) / 尾递归斐波那契（高效） ----
  # Tail recursion is optimized by the BEAM VM (no stack overflow)
  # 尾递归由 BEAM 虚拟机优化（不会栈溢出）
  def fib_fast(n), do: fib_fast(n, 0, 1)
  defp fib_fast(0, a, _), do: a
  defp fib_fast(n, a, b), do: fib_fast(n - 1, b, a + b)


  # ---- Reverse a list / 反转列表 ----
  def reverse([]),             do: []
  def reverse([head | tail]),  do: reverse(tail) ++ [head]

  # Tail-recursive version (accumulator pattern) / 尾递归版本（累加器模式）
  def reverse_fast(list), do: reverse_fast(list, [])
  defp reverse_fast([], acc),            do: acc
  defp reverse_fast([head | tail], acc), do: reverse_fast(tail, [head | acc])


  # ---- Map implementation / 自实现 Map ----
  def my_map([], _fun), do: []
  def my_map([head | tail], fun), do: [fun.(head) | my_map(tail, fun)]


  # ---- Filter implementation / 自实现 Filter ----
  def my_filter([], _fun), do: []
  def my_filter([head | tail], fun) do
    if fun.(head) do
      [head | my_filter(tail, fun)]
    else
      my_filter(tail, fun)
    end
  end


  # ---- Flatten a nested list / 展平嵌套列表 ----
  def flatten([]),                     do: []
  def flatten([head | tail]) when is_list(head),
    do: flatten(head) ++ flatten(tail)
  def flatten([head | tail]),
    do: [head | flatten(tail)]

end


IO.puts("===== Factorial / 阶乘 =====")
IO.inspect(MyRecursion.factorial(0))   # => 1
IO.inspect(MyRecursion.factorial(5))   # => 120
IO.inspect(MyRecursion.factorial(10))  # => 3628800


IO.puts("\n===== List Sum / 列表求和 =====")
IO.inspect(MyRecursion.sum([1, 2, 3, 4, 5]))   # => 15


IO.puts("\n===== Fibonacci / 斐波那契 =====")
IO.inspect(Enum.map(0..9, &MyRecursion.fib/1))          # slow / 慢
IO.inspect(Enum.map(0..9, &MyRecursion.fib_fast/1))     # fast / 快


IO.puts("\n===== Reverse / 反转 =====")
IO.inspect(MyRecursion.reverse([1, 2, 3, 4, 5]))
IO.inspect(MyRecursion.reverse_fast([1, 2, 3, 4, 5]))


IO.puts("\n===== Custom Map & Filter / 自实现 Map 和 Filter =====")
IO.inspect(MyRecursion.my_map([1, 2, 3, 4], &(&1 * 2)))
IO.inspect(MyRecursion.my_filter([1, 2, 3, 4, 5, 6], &(rem(&1, 2) == 0)))


IO.puts("\n===== Flatten / 展平 =====")
IO.inspect(MyRecursion.flatten([1, [2, 3], [4, [5, 6]], 7]))
# => [1, 2, 3, 4, 5, 6, 7]


IO.puts("\n===== Recursion vs Enum / 递归 vs Enum =====")
# In practice, prefer built-in Enum functions over manual recursion
# 实际开发中，优先使用内置 Enum 函数而非手动递归
list = Enum.to_list(1..100)
IO.inspect(Enum.sum(list))          # preferred / 推荐
IO.inspect(MyRecursion.sum(list))   # manual recursion / 手动递归（结果相同）
