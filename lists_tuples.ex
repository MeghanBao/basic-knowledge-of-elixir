# 06_Lists_Tuples/lists_tuples.ex
# Lists & Tuples in Elixir / Elixir 列表与元组
#
# Run / 运行方式:
#   elixir lists_tuples.ex

IO.puts("===== Lists / 列表 =====")
# Lists are linked lists — efficient head operations, O(1) prepend
# 列表是链表——头部操作高效，前置操作为 O(1)
fruits = ["apple", "banana", "cherry"]
numbers = [1, 2, 3, 4, 5]
mixed = [1, "hello", :ok, true, 3.14]   # can hold any type / 可存任意类型

IO.inspect(fruits)
IO.inspect(length(fruits))           # length / 长度
IO.inspect(hd(numbers))              # head / 头部
IO.inspect(tl(numbers))              # tail / 尾部

# Prepend with | (fast) / 用 | 前置（快速）
new_list = [0 | numbers]
IO.inspect(new_list)

# Concatenation with ++ / 用 ++ 拼接
combined = [1, 2] ++ [3, 4]
IO.inspect(combined)

# Subtraction with -- / 用 -- 差集
removed = [1, 2, 3, 2, 1] -- [2, 1]
IO.inspect(removed)    # => [3, 2, 1] removes first occurrence

# Checking membership / 检查成员
IO.inspect("banana" in fruits)   # => true


IO.puts("\n===== List Operations with Enum / Enum 模块操作列表 =====")
nums = [3, 1, 4, 1, 5, 9, 2, 6]

IO.inspect(Enum.sort(nums))                      # sort ascending / 升序排序
IO.inspect(Enum.sort(nums, :desc))               # sort descending / 降序排序
IO.inspect(Enum.uniq(nums))                      # remove duplicates / 去重
IO.inspect(Enum.max(nums))                       # max value / 最大值
IO.inspect(Enum.min(nums))                       # min value / 最小值
IO.inspect(Enum.sum(nums))                       # sum / 求和
IO.inspect(Enum.count(nums))                     # count / 计数
IO.inspect(Enum.take(nums, 3))                   # first 3 / 取前 3 个
IO.inspect(Enum.drop(nums, 3))                   # drop first 3 / 去掉前 3 个
IO.inspect(Enum.reverse(nums))                   # reverse / 反转
IO.inspect(Enum.any?(nums, &(&1 > 8)))           # any > 8? / 有大于8的吗？
IO.inspect(Enum.all?(nums, &(&1 > 0)))           # all > 0? / 全部大于0吗？
IO.inspect(Enum.zip([1,2,3], [:a,:b,:c]))        # zip two lists / 压缩两个列表
IO.inspect(Enum.chunk_every(nums, 3))            # chunk into groups / 分组


IO.puts("\n===== Tuples / 元组 =====")
# Tuples store elements contiguously — fast random access, fixed size
# 元组连续存储——随机访问快，大小固定
point = {3, 4}
person = {"Alice", 30, :female}
status = {:ok, "Data loaded successfully"}

IO.inspect(point)
IO.inspect(elem(person, 0))       # access by index / 按索引访问
IO.inspect(elem(person, 1))
IO.inspect(tuple_size(person))    # size / 大小

# Update a tuple / 更新元组
updated = put_elem(person, 1, 31)
IO.inspect(updated)

# Common pattern: {:ok, value} or {:error, reason}
# 常见模式：{:ok, 值} 或 {:error, 原因}
case status do
  {:ok, message}    -> IO.puts("OK: #{message}")
  {:error, reason}  -> IO.puts("Error: #{reason}")
end


IO.puts("\n===== List vs Tuple / 列表 vs 元组 =====")
# Use a LIST when:  / 使用列表当：
#   - size varies dynamically    / 大小动态变化
#   - frequent add/remove        / 频繁增删
#   - iterating sequentially     / 顺序遍历

# Use a TUPLE when: / 使用元组当：
#   - size is fixed              / 大小固定
#   - grouping heterogeneous data / 分组异构数据
#   - returning multiple values  / 返回多个值
IO.puts("List: dynamic, linked, O(n) access / 列表：动态、链表、O(n) 访问")
IO.puts("Tuple: fixed, contiguous, O(1) access / 元组：固定、连续、O(1) 访问")
