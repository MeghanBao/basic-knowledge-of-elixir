# 07_Maps/maps.ex
# Maps & Keyword Lists in Elixir / Elixir 映射与关键字列表
#
# Run / 运行方式:
#   elixir maps.ex

IO.puts("===== Maps / 映射 =====")
# Maps are key-value stores — keys can be any type
# Map 是键值存储——键可以是任何类型

# Atom keys (most common) / 原子键（最常见）
user = %{name: "Alice", age: 30, city: "Beijing"}
IO.inspect(user)

# Access with dot notation (atom keys only) / 点记法访问（仅限原子键）
IO.puts(user.name)
IO.inspect(user.age)

# Access with [] — safer, returns nil if missing / [] 访问——更安全，键不存在时返回 nil
IO.inspect(user[:city])
IO.inspect(user[:missing_key])   # => nil (no error!)

# String keys / 字符串键
config = %{"host" => "localhost", "port" => 4000}
IO.inspect(config["host"])

# Mixed keys / 混合键
mixed = %{:atom_key => 1, "string_key" => 2, 42 => "number key"}
IO.inspect(mixed)


IO.puts("\n===== Map Operations / Map 操作 =====")
person = %{name: "Bob", age: 25, country: "China"}

# Update with | syntax / 使用 | 更新
updated = %{person | age: 26}
IO.inspect(updated)

# Add a key using Map.put / 使用 Map.put 添加键
with_email = Map.put(person, :email, "bob@example.com")
IO.inspect(with_email)

# Delete a key / 删除键
without_country = Map.delete(person, :country)
IO.inspect(without_country)

# Check if key exists / 检查键是否存在
IO.inspect(Map.has_key?(person, :name))   # => true
IO.inspect(Map.has_key?(person, :phone))  # => false

# Get all keys / values / 获取所有键 / 值
IO.inspect(Map.keys(person))
IO.inspect(Map.values(person))

# Merge two maps / 合并两个 Map
extra = %{phone: "123-456", hobby: "coding"}
merged = Map.merge(person, extra)
IO.inspect(merged)


IO.puts("\n===== Pattern Matching with Maps / Map 的模式匹配 =====")
# You don't need to match all keys — partial match is fine
# 不需要匹配所有键——部分匹配即可
%{name: name, age: age} = person
IO.puts("Name: #{name}, Age: #{age}")

# In a function / 在函数中
defmodule UserInfo do
  def display(%{name: name, age: age}) do
    "#{name} is #{age} years old / #{name} 今年 #{age} 岁"
  end

  def is_adult?(%{age: age}) when age >= 18, do: true
  def is_adult?(_), do: false
end

IO.puts(UserInfo.display(person))
IO.inspect(UserInfo.is_adult?(person))


IO.puts("\n===== Keyword Lists / 关键字列表 =====")
# Keyword lists are lists of {atom, value} tuples
# 关键字列表是 {原子, 值} 元组的列表
# They preserve order and allow duplicate keys
# 它们保持顺序并允许重复键
opts = [timeout: 5000, retries: 3, debug: true]
IO.inspect(opts)
IO.inspect(Keyword.get(opts, :timeout))   # => 5000
IO.inspect(Keyword.get(opts, :missing, "default"))  # with default / 带默认值

# Keyword lists are often used for function options
# 关键字列表常用于函数选项
defmodule Http do
  def get(url, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, 3000)
    "GET #{url} with timeout=#{timeout}ms"
  end
end

IO.puts(Http.get("https://example.com"))
IO.puts(Http.get("https://example.com", timeout: 10_000))
