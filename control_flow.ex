# 08_ControlFlow/control_flow.ex
# Control Flow in Elixir / Elixir 控制流
#
# Run / 运行方式:
#   elixir control_flow.ex

IO.puts("===== if / unless =====")
# if works like most languages
# if 用法类似大多数语言
age = 20

if age >= 18 do
  IO.puts("Adult / 成年人")
else
  IO.puts("Minor / 未成年人")
end

# unless = if not / unless 等价于 if not
unless age < 18 do
  IO.puts("Can vote! / 可以投票！")
end

# if as an expression / if 作为表达式
status = if age >= 18, do: "adult", else: "minor"
IO.inspect(status)


IO.puts("\n===== case =====")
# case matches against multiple patterns
# case 对多个模式进行匹配
http_status = 404

message =
  case http_status do
    200 -> "OK / 成功"
    201 -> "Created / 已创建"
    301 -> "Moved Permanently / 永久重定向"
    404 -> "Not Found / 未找到"
    500 -> "Internal Server Error / 服务器内部错误"
    _   -> "Unknown Status / 未知状态"   # catch-all / 通配
  end

IO.puts(message)

# case with guards / 带守卫的 case
score = 85

grade =
  case score do
    s when s >= 90 -> "A"
    s when s >= 80 -> "B"
    s when s >= 70 -> "C"
    s when s >= 60 -> "D"
    _              -> "F"
  end

IO.puts("Grade: #{grade}")


IO.puts("\n===== cond =====")
# cond checks multiple conditions (like if-else chain)
# cond 检查多个条件（类似 if-else 链）
hour = 14

time_greeting =
  cond do
    hour < 12  -> "Good morning! / 早上好！"
    hour < 17  -> "Good afternoon! / 下午好！"
    hour < 21  -> "Good evening! / 晚上好！"
    true       -> "Good night! / 晚安！"   # true = default / true 作为默认
  end

IO.puts(time_greeting)


IO.puts("\n===== with =====")
# with chains pattern matches — stops on first mismatch
# with 链式模式匹配——第一次不匹配时停止
defmodule UserAuth do
  def find_user(id) when id > 0, do: {:ok, %{id: id, name: "Alice", active: true}}
  def find_user(_), do: {:error, "User not found / 用户未找到"}

  def check_active(%{active: true} = user), do: {:ok, user}
  def check_active(_), do: {:error, "User is inactive / 用户已停用"}

  def get_permissions(%{id: id}), do: {:ok, [:read, :write]}

  def login(user_id) do
    with {:ok, user}        <- find_user(user_id),
         {:ok, active_user} <- check_active(user),
         {:ok, perms}       <- get_permissions(active_user) do
      "Welcome #{active_user.name}! Permissions: #{inspect(perms)}"
    else
      {:error, reason} -> "Login failed: #{reason}"
    end
  end
end

IO.puts(UserAuth.login(1))
IO.puts(UserAuth.login(-1))


IO.puts("\n===== Comprehensions (for) / 列表推导 =====")
# Generate lists with for / 用 for 生成列表
squares = for x <- 1..10, do: x * x
IO.inspect(squares)

# With filter / 带过滤器
even_squares = for x <- 1..10, rem(x, 2) == 0, do: x * x
IO.inspect(even_squares)

# Nested comprehension / 嵌套推导
pairs = for x <- 1..3, y <- 1..3, x != y, do: {x, y}
IO.inspect(pairs)

# Collect into a map / 收集到 Map
square_map = for x <- 1..5, into: %{}, do: {x, x * x}
IO.inspect(square_map)
