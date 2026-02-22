# 10_Processes/processes.ex
# Processes & Message Passing in Elixir / Elixir 进程与消息传递
# Elixir processes are lightweight, isolated, and communicate by messages
# Elixir 进程是轻量级的、隔离的，通过消息通信
#
# Run / 运行方式:
#   elixir processes.ex

IO.puts("===== Spawning Processes / 创建进程 =====")
# spawn/1 creates a new process and returns its PID
# spawn/1 创建新进程并返回其 PID
pid = spawn(fn ->
  IO.puts("Hello from process #{inspect(self())} / 来自进程的问候")
end)

IO.inspect(pid)
IO.inspect(self())   # current process PID / 当前进程 PID
Process.sleep(10)    # wait for spawned process / 等待子进程完成


IO.puts("\n===== Message Passing / 消息传递 =====")
# send/2 sends a message, receive/1 receives it
# send/2 发送消息，receive/1 接收消息
parent = self()

spawn(fn ->
  # Send a message to the parent process / 向父进程发送消息
  send(parent, {:hello, "World", from: self()})
end)

# receive blocks until a matching message arrives
# receive 阻塞直到收到匹配的消息
receive do
  {:hello, name, from: sender} ->
    IO.puts("Received: Hello #{name} from #{inspect(sender)}")
after
  # Timeout in milliseconds / 毫秒级超时
  1000 -> IO.puts("Timeout! No message received. / 超时！未收到消息")
end


IO.puts("\n===== Process Mailbox / 进程邮箱 =====")
# Processes have a mailbox — messages queue up until received
# 进程有邮箱——消息排队等待接收
receiver = spawn(fn ->
  receive do
    {:ping, from} ->
      send(from, :pong)
      IO.puts("Received ping, sent pong! / 收到 ping，已回复 pong！")
  end
end)

send(receiver, {:ping, self()})

receive do
  :pong -> IO.puts("Got pong! / 收到 pong！")
after
  1000 -> IO.puts("No pong received / 未收到 pong")
end


IO.puts("\n===== Stateful Processes with Loop / 用循环实现有状态进程 =====")
# A process can maintain state by looping and receiving messages
# 进程可以通过循环和接收消息来维持状态
defmodule Counter do
  # Start the counter process / 启动计数器进程
  def start(initial \\ 0) do
    spawn(fn -> loop(initial) end)
  end

  # Recursive loop to maintain state / 递归循环维持状态
  defp loop(count) do
    receive do
      {:increment, caller} ->
        send(caller, {:count, count + 1})
        loop(count + 1)

      {:decrement, caller} ->
        send(caller, {:count, count - 1})
        loop(count - 1)

      {:get, caller} ->
        send(caller, {:count, count})
        loop(count)

      :stop ->
        IO.puts("Counter stopped. Final value: #{count} / 计数器已停止，最终值：#{count}")
    end
  end

  # Helper to send messages and wait for response
  # 发送消息并等待响应的辅助函数
  def increment(pid) do
    send(pid, {:increment, self()})
    receive do: ({:count, n} -> n)
  end

  def decrement(pid) do
    send(pid, {:decrement, self()})
    receive do: ({:count, n} -> n)
  end

  def get(pid) do
    send(pid, {:get, self()})
    receive do: ({:count, n} -> n)
  end

  def stop(pid), do: send(pid, :stop)
end

counter = Counter.start(0)
IO.inspect(Counter.increment(counter))   # => 1
IO.inspect(Counter.increment(counter))   # => 2
IO.inspect(Counter.increment(counter))   # => 3
IO.inspect(Counter.decrement(counter))   # => 2
IO.inspect(Counter.get(counter))         # => 2
Counter.stop(counter)

Process.sleep(10)   # let the stop message process / 等待 stop 消息处理


IO.puts("\n===== Process Monitoring / 进程监控 =====")
# Monitor a process to be notified when it dies
# 监控进程以便在其终止时收到通知
monitored = spawn(fn ->
  Process.sleep(50)
  IO.puts("Monitored process exiting... / 被监控进程退出中...")
end)

ref = Process.monitor(monitored)

receive do
  {:DOWN, ^ref, :process, _pid, reason} ->
    IO.puts("Process exited with reason: #{inspect(reason)} / 进程以原因退出：#{inspect(reason)}")
after
  500 -> IO.puts("Timeout waiting for DOWN / 等待 DOWN 消息超时")
end


IO.puts("\n===== Key Takeaways / 关键要点 =====")
IO.puts("- Processes are cheap (~2KB) — millions can run simultaneously")
IO.puts("  进程很廉价（约2KB）——数百万个可同时运行")
IO.puts("- No shared memory — communicate only via messages")
IO.puts("  无共享内存——只通过消息通信")
IO.puts("- Failures are isolated — one crash doesn't affect others")
IO.puts("  故障是隔离的——一个崩溃不影响其他进程")
IO.puts("- This is the foundation of Elixir's fault-tolerance")
IO.puts("  这是 Elixir 容错性的基础")
