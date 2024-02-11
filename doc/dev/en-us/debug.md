# Debug
After successfully compiled Meowbili, you can start debugging Meowbili. This docs provided help on debugging.
## Select Target Platform
You can use SwiftUI Preview, emulator or real devices to debug Meowbili. As for different debug purpose, there are some different suggest platform.
- Debugging static UI, use SwiftUI Preview
- Debugging network data, use emulator
- Debugging video play, picture select and similar functions, use real device

Running player on emulator may occurr stuck. You must use real device to debug.
## Debug Output
At most of time, we need to view contents in varible. We can use debug output at that time.

You can use `debugPrint(_: Any...)` method to print varible content. However, please delete them before commit.

You can also use breakpoint debugging. Breakpoint **in varible score**. And set breakpoint to run `lldb` command (e.g. use `po [varible]` to print varible）. You're not suposed to delete breakpoints before commit. .gitignore file will skip breakpoint information.
