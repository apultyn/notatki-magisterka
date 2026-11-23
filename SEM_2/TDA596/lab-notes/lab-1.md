# Lab 1 notes

```go
select {
case msg := <-sub.queue:
	return msg, true
case <-sub.done:
case <-stopping:
case <-timer.C:
}
```

- constructions like that try to read from channels, if they succeed the case is met, if not it skips to the next one
- `sub.polling` - ensuring only one polling for subscriber
- `RWMutex` - mutex ensuring correct read and write
    - multiple read blocks allowed, writer needs to wait for all reads to end
    - you can upload multiple files at once, because writer lock is set only during file swap
