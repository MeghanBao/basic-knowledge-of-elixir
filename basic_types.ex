# 02_BasicTypes/basic_types.ex
# Basic Data Types in Elixir / Elixir 基本数据类型
#
# Run / 运行方式:
#   elixir basic_types.ex

IO.puts("===== Integers / 整数 =====")
# Elixir supports arbitrary precision integers
# Elixir 支持任意精度整数
a = 42
b = 1_000_000    # underscores for readability / 下划线提高可读性
c = 0xFF         # hexadecimal / 十六进制
d = 0b1010       # binary / 二进制
e = 0o77         # octal / 八进制
IO.inspect([a, b, c, d, e])


IO.puts("\n===== Floats / 浮点数 =====")
# Floats require a decimal point and at least one digit on each side
# 浮点数必须有小数点，且两边至少各有一位数字
pi = 3.14159
sci = 1.0e-10    # scientific notation / 科学计数法
IO.inspect([pi, sci])


IO.puts("\n===== Booleans / 布尔值 =====")
# true and false are atoms in Elixir
# true 和 false 在 Elixir 中是原子
IO.inspect(true)
IO.inspect(false)
IO.inspect(true and false)   # logical AND / 逻辑与
IO.inspect(true or false)    # logical OR  / 逻辑或
IO.inspect(not true)         # logical NOT / 逻辑非


IO.puts("\n===== Atoms / 原子 =====")
# Atoms are constants whose value is their own name
# 原子是常量，其值就是其名称本身，类似 Ruby 的 Symbol
status = :ok
error  = :error
IO.inspect(status)
IO.inspect(:hello == :hello)   # atoms with same name are equal / 相同名称的原子相等
IO.inspect(is_atom(:foo))


IO.puts("\n===== Strings / 字符串 =====")
# Strings are UTF-8 encoded binaries
# 字符串是 UTF-8 编码的二进制数据
greeting = "Hello, 世界！"
IO.puts(greeting)
IO.inspect(String.length(greeting))       # number of characters / 字符数
IO.inspect(byte_size(greeting))           # number of bytes / 字节数
IO.inspect(String.upcase("elixir"))       # uppercase / 转大写
IO.inspect(String.contains?("hello", "ell"))  # contains? / 包含？


IO.puts("\n===== Nil / 空值 =====")
# nil represents the absence of a value (also an atom)
# nil 表示空值（同样是原子）
x = nil
IO.inspect(x)
IO.inspect(is_nil(x))
IO.inspect(nil == false)   # nil and false are NOT equal / nil 与 false 不相等


IO.puts("\n===== Type Checking / 类型检查 =====")
IO.inspect(is_integer(42))
IO.inspect(is_float(3.14))
IO.inspect(is_boolean(true))
IO.inspect(is_binary("hello"))
IO.inspect(is_atom(:ok))
