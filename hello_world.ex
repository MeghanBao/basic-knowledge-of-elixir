# 01_HelloWorld/hello_world.ex
# Hello World in Elixir / Elixir 的第一个程序
#
# Run / 运行方式:
#   elixir hello_world.ex

# IO.puts prints a string followed by a newline
# IO.puts 输出字符串并换行
IO.puts("Hello, World!")
IO.puts("你好，世界！")

# IO.inspect is useful for debugging — prints the value and its type
# IO.inspect 用于调试，打印值及其类型
IO.inspect("Hello from Elixir")

# String interpolation using #{}
# 使用 #{} 进行字符串插值
name = "Elixir"
IO.puts("Hello, #{name}!")

# Multiline strings using triple double-quotes (heredoc)
# 使用三引号定义多行字符串（heredoc）
poem = """
Elixir is functional,
Elixir is fast,
Built on Erlang VM,
designed to last.
"""

IO.puts(poem)
