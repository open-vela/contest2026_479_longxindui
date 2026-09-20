# ls2k0300 openvela通用测试结果

# 1 功能测试

## 1\.1 系统内核

#### 1\.1\.1 系统内存管理测试

##### 成功

指令：cmocka\_mm\_test

日志：

```YAML
nsh> cmocka_mm_test
nxtask_activate: cmocka_mm_test pid=4,TCB=0x900000009806e880
[==========] nuttx_mm_test_suites: Running 8 test(s).
[ RUN      ] test_nuttx_mm01
[       OK ] test_nuttx_mm01
[ RUN      ] test_nuttx_mm02
[       OK ] test_nuttx_mm02
[ RUN      ] test_nuttx_mm03
[       OK ] test_nuttx_mm03
[ RUN      ] test_nuttx_mm04
[       OK ] test_nuttx_mm04
[ RUN      ] test_nuttx_mm05
[       OK ] test_nuttx_mm05
[ RUN      ] test_nuttx_mm06
[       OK ] test_nuttx_mm06
[ RUN      ] test_nuttx_mm07
SET memsize to:592
TEST END because of the mem_info.mxordblk is:112
[       OK ] test_nuttx_mm07
[ RUN      ] test_nuttx_mm08
nxtask_activate: cmocka_mm_test pid=5,TCB=0x90000000980731b0
nxtask_activate: cmocka_mm_test pid=6,TCB=0x9000000098073b40
nxtask_activate: cmocka_mm_test pid=7,TCB=0x90000000980744d0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=5 exit_value=0
nxtask_exit: cmocka_mm_test pid=5,TCB=0x90000000980731b0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=6 exit_value=0
nxtask_exit: cmocka_mm_test pid=6,TCB=0x9000000098073b40
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=7 exit_value=0
nxtask_exit: cmocka_mm_test pid=7,TCB=0x90000000980744d0
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x900000009806e7e0
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x900000009806e800
pthread_join: Returning 0
[       OK ] test_nuttx_mm08
[==========] nuttx_mm_test_suites: 8 test(s) run.
[  PASSED  ] 8 test(s).
nxtask_exit: cmocka_mm_test pid=4,TCB=0x900000009806e880

```

##### cmocka\_mm\_test启用配置：

在nuttx/boards/loongarch/ls2k0300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_ALLOW\_MIT\_COMPONENTS=y

CONFIG\_LIBC\_EXECFUNCS=y

CONFIG\_LIBC\_REGEX=y

CONFIG\_TESTING\_CMOCKA=y

CONFIG\_TESTS\_TESTSUITES=y

CONFIG\_CM\_MM\_TEST=y

CONFIG\_CM\_SCHED\_TEST=y

CONFIG\_CM\_SYSCALL\_TEST=y

CONFIG\_CM\_TIME\_TEST=y

CONFIG\_CM\_PTHREAD\_TEST=y

CONFIG\_CM\_MUTEX\_TEST=y

CONFIG\_CM\_FS\_TEST=y

CONFIG\_CM\_KVDB\_TEST=y

CONFIG\_CM\_SOCKET\_TEST=y

CONFIG\_CM\_DFX\_TEST=y



#### 1\.1\.2 系统调度测试

##### 成功

指令：cmocka\_sched\_test

日志：

```YAML
nsh> cmocka_sched_test
nxtask_activate: cmocka_sched_test pid=8,TCB=0x900000009806e880
[==========] nuttx_sched_test_suites: Running 16 test(s).
[ RUN      ] test_nuttx_sched_pthread01
nxtask_activate: cmocka_sched_test pid=9,TCB=0x9000000098073330
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=9 exit_value=0
nxtask_exit: cmocka_sched_test pid=9,TCB=0x9000000098073330
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread01
[ RUN      ] test_nuttx_sched_pthread02
nxtask_activate: cmocka_sched_test pid=10,TCB=0x9000000098073330
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=10 exit_value=0
nxtask_exit: cmocka_sched_test pid=10,TCB=0x9000000098073330
pthread_destroyjoin: pjoin=0x900000009806e7e0
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread02
[ RUN      ] test_nuttx_sched_pthread03
nxtask_activate: cmocka_sched_test pid=11,TCB=0x9000000098073330
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=11 exit_value=0
nxtask_exit: cmocka_sched_test pid=11,TCB=0x9000000098073330
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread03
[ RUN      ] test_nuttx_sched_pthread04
nxtask_activate: cmocka_sched_test pid=12,TCB=0x9000000098073330
pthread_completejoin: pid=12 exit_value=0xffffffffffffffff
pthread_destroyjoin: pjoin=0x900000009806e7e0
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread04
[ RUN      ] test_nuttx_sched_pthread05
nxtask_activate: cmocka_sched_test pid=13,TCB=0x9000000098073330
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=13 exit_value=0
nxtask_exit: cmocka_sched_test pid=13,TCB=0x9000000098073330
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread05
[ RUN      ] test_nuttx_sched_pthread06
nxtask_activate: cmocka_sched_test pid=14,TCB=0x9000000098073330
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=14 exit_value=0
nxtask_exit: cmocka_sched_test pid=14,TCB=0x9000000098073330
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread06
[ RUN      ] test_nuttx_sched_pthread07
nxtask_activate: cmocka_sched_test pid=15,TCB=0x9000000098073330
nxtask_activate: cmocka_sched_test pid=20,TCB=0x9000000098073cc0
nxtask_activate: cmocka_sched_test pid=21,TCB=0x9000000098074650
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlockpthread_mutex_timedlockpthread_mutex_timedlock:::   Rmmeuutttueerxxn==i00nxxg99 0000000
00pthread_mutex_timedlock00:00 00m99u88t00e77x22=bb088x8890

0pthread_mutex_timedlock0:0 0R0e0t9u8r0n7i2nbg8 80

pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=15 exit_value=0
nxtask_exit: cmocka_sched_test pid=15,TCB=0x9000000098073330
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_join: Returning 0
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072pthread_mutex_timedlockb:8 8Re
turning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Repthread_mutex_timedlockt:u rRneitnugr n0in
gpthread_mutex_timedlock :0 m
upthread_mutex_unlockt:e xm=u0txe9x0=000x090000009080007029b880872
b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072bpthread_mutex_timedlock8:8 R
eturning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x9000000098072b88
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=20 exit_value=0
nxtask_exit: cmocka_sched_test pid=20,TCB=0x9000000098073cc0
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x9000000098072b88
pthread_mutex_unlock: Returning 0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=21 exit_value=0
nxtask_exit: cmocka_sched_test pid=21,TCB=0x9000000098074650
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x900000009806e7e0
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread07
[ RUN      ] test_nuttx_sched_pthread08
nxtask_activate: cmocka_sched_test pid=22,TCB=0x9000000098073330
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=22 exit_value=0
nxtask_exit: cmocka_sched_test pid=22,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_pthread08
[ RUN      ] test_nuttx_sched_pthread09
nxtask_activate: cmocka_sched_test pid=23,TCB=0x9000000098073330
nxtask_activate: cmocka_sched_test pid=25,TCB=0x9000000098073cc0
nxtask_activate: cmocka_sched_test pid=26,TCB=0x9000000098074650
nxtask_activate: cmocka_sched_test pid=27,TCB=0x9000000098074fe0
nxtask_activate: cmocka_sched_test pid=28,TCB=0x9000000098075970
nxtask_activate: cmocka_sched_test pid=29,TCB=0x9000000098076300
nxtask_activate: cmocka_sched_test pid=30,TCB=0x9000000098076c90
nxtask_activate: cmocka_sched_test pid=31,TCB=0x9000000098077620
nxtask_activate: cmocka_sched_test pid=36,TCB=0x9000000098077fb0
nxtask_activate: cmocka_sched_test pid=37,TCB=0x9000000098078940
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=23 exit_value=0
nxtask_exit: cmocka_sched_test pid=23,TCB=0x9000000098073330
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=25 exit_value=0
nxtask_exit: cmocka_sched_test pid=25,TCB=0x9000000098073cc0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=26 exit_value=0
nxtask_exit: cmocka_sched_test pid=26,TCB=0x9000000098074650
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=27 exit_value=0
nxtask_exit: cmocka_sched_test pid=27,TCB=0x9000000098074fe0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=28 exit_value=0
nxtask_exit: cmocka_sched_test pid=28,TCB=0x9000000098075970
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=29 exit_value=0
nxtask_exit: cmocka_sched_test pid=29,TCB=0x9000000098076300
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=30 exit_value=0
nxtask_exit: cmocka_sched_test pid=30,TCB=0x9000000098076c90
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=31 exit_value=0
nxtask_exit: cmocka_sched_test pid=31,TCB=0x9000000098077620
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=36 exit_value=0
nxtask_exit: cmocka_sched_test pid=36,TCB=0x9000000098077fb0
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=37 exit_value=0
nxtask_exit: cmocka_sched_test pid=37,TCB=0x9000000098078940
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x900000009806e800
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x900000009806e820
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x900000009806e840
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x900000009806e860
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x9000000098073330
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x9000000098073350
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x9000000098073370
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x9000000098073390
pthread_join: Returning 0
pthread_destroyjoin: pjoin=0x90000000980733b0
pthread_join: Returning 0
[       OK ] test_nuttx_sched_pthread09
[ RUN      ] test_nuttx_sched_task01
nxtask_activate: schedtask01routine pid=38,TCB=0x9000000098073330
nxtask_exit: schedtask01routine pid=38,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_task01
[ RUN      ] test_nuttx_sched_task02
nxtask_activate: schedtask02routine pid=39,TCB=0x9000000098073330
nxtask_activate: schedtask02routine pid=39,TCB=0x9000000098073330
nxtask_activate: schedtask02routine pid=39,TCB=0x9000000098073330
nxtask_exit: schedtask02routine pid=39,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_task02
[ RUN      ] test_nuttx_sched_task03
nxtask_activate: schedtask03routine pid=41,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_task03
[ RUN      ] test_nuttx_sched_task04
nxtask_activate: schedtask04routine pid=42,TCB=0x9000000098073330
[test_nuttx_sched_task04]:scheduling policy is RR!
nxtask_exit: schedtask04routine pid=42,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_task04
[ RUN      ] test_nuttx_sched_task05
nxtask_activate: schedtask05routine pid=43,TCB=0x9000000098073330
nxtask_exit: schedtask05routine pid=43,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_task05
[ RUN      ] test_nuttx_sched_task06
nxtask_activate: schedtask06routine pid=44,TCB=0x9000000098073330
nxtask_exit: schedtask06routine pid=44,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_task06
[ RUN      ] test_nuttx_sched_task07
nxtask_activate: schedtask07routine pid=45,TCB=0x9000000098073330
nxtask_exit: schedtask07routine pid=45,TCB=0x9000000098073330
[       OK ] test_nuttx_sched_task07
[==========] nuttx_sched_test_suites: 16 test(s) run.
[  PASSED  ] 16 test(s).
nxtask_exit: cmocka_sched_test pid=8,TCB=0x900000009806e880
```

##### cmocka\_sched\_test启用配置：

在nuttx/boards/loongarch/ls2k300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_ALLOW\_MIT\_COMPONENTS=y

CONFIG\_LIBC\_EXECFUNCS=y

CONFIG\_LIBC\_REGEX=y

CONFIG\_TESTING\_CMOCKA=y

CONFIG\_TESTS\_TESTSUITES=y

CONFIG\_CM\_MM\_TEST=y

CONFIG\_CM\_SCHED\_TEST=y

CONFIG\_CM\_SYSCALL\_TEST=y

CONFIG\_CM\_TIME\_TEST=y

CONFIG\_CM\_PTHREAD\_TEST=y

CONFIG\_CM\_MUTEX\_TEST=y

CONFIG\_CM\_FS\_TEST=y

CONFIG\_CM\_KVDB\_TEST=y

CONFIG\_CM\_SOCKET\_TEST=y

CONFIG\_CM\_DFX\_TEST=y



#### 1\.1\.3 系统调用测试

##### 成功

指令：cmocka\_syscall\_test

日志：

```YAML
nsh> cmocka_syscall_test
nxtask_activate: cmocka_syscall_test pid=5,TCB=0x90000000980d0e20
nxsig_tcbdispatch: TCB=0x90000000980d0e20 pid=5 signo=0 code=0 value=0 masked=NO
[==========] nuttx_syscall_test_suites: Running 83 test(s).
[ RUN      ] test_nuttx_syscall_chdir01
[       OK ] test_nuttx_syscall_chdir01
[ RUN      ] test_nuttx_syscall_chdir02
[       OK ] test_nuttx_syscall_chdir02
[ RUN      ] test_nuttx_syscall_getitimer01
clock_getres: clock_id=6, clock_type=6
[       OK ] test_nuttx_syscall_getitimer01
[ RUN      ] test_nuttx_syscall_clockgettime01
[       OK ] test_nuttx_syscall_clockgettime01
[ RUN      ] test_nuttx_syscall_clocknanosleep01
[       OK ] test_nuttx_syscall_clocknanosleep01
[ RUN      ] test_nuttx_syscall_clocksettime01
[       OK ] test_nuttx_syscall_clocksettime01
[ RUN      ] test_nuttx_syscall_close01
[       OK ] test_nuttx_syscall_close01
[ RUN      ] test_nuttx_syscall_close02
[       OK ] test_nuttx_syscall_close02
[ RUN      ] test_nuttx_syscall_close03
[       OK ] test_nuttx_syscall_close03
[ RUN      ] test_nuttx_syscall_creat01
[       OK ] test_nuttx_syscall_creat01
[ RUN      ] test_nuttx_syscall_creat02
[       OK ] test_nuttx_syscall_creat02
[ RUN      ] test_nuttx_syscall_fcntl02
[       OK ] test_nuttx_syscall_fcntl02
[ RUN      ] test_nuttx_syscall_fcntl03
[       OK ] test_nuttx_syscall_fcntl03
[ RUN      ] test_nuttx_syscall_fcntl04
[       OK ] test_nuttx_syscall_fcntl04
[ RUN      ] test_nuttx_syscall_fcntl06
[       OK ] test_nuttx_syscall_fcntl06
[ RUN      ] test_nuttx_syscall_fstatfs01
[       OK ] test_nuttx_syscall_fstatfs01
[ RUN      ] test_nuttx_syscall_fsync01
[       OK ] test_nuttx_syscall_fsync01
[ RUN      ] test_nuttx_syscall_fsync02
[       OK ] test_nuttx_syscall_fsync02
[ RUN      ] test_nuttx_syscall_fsync03
[       OK ] test_nuttx_syscall_fsync03
[ RUN      ] test_nuttx_syscall_getpeername01
[       OK ] test_nuttx_syscall_getpeername01
[ RUN      ] test_nuttx_syscall_getsockopt01
[       OK ] test_nuttx_syscall_getsockopt01
[ RUN      ] test_nuttx_syscall_setsockopt01
[       OK ] test_nuttx_syscall_setsockopt01
[ RUN      ] test_nuttx_syscall_listen01
listen(-400, 0) failed
bad file descriptor successful
listen(3, 0) failed
not a socket successful
listen(4, 0) failed
UDP listen successful
[       OK ] test_nuttx_syscall_listen01
[ RUN      ] test_nuttx_syscall_socketpair02
[       OK ] test_nuttx_syscall_socketpair02
[ RUN      ] test_nuttx_syscall_ftruncate01
[       OK ] test_nuttx_syscall_ftruncate01
[ RUN      ] test_nuttx_syscall_getcwd01
[       OK ] test_nuttx_syscall_getcwd01
[ RUN      ] test_nuttx_syscall_getcwd02
[       OK ] test_nuttx_syscall_getcwd02
[ RUN      ] test_nuttx_syscall_getpid01
[       OK ] test_nuttx_syscall_getpid01
[ RUN      ] test_nuttx_syscall_getppid01
[       OK ] test_nuttx_syscall_getppid01
[ RUN      ] test_nuttx_syscall_gethostname01
[       OK ] test_nuttx_syscall_gethostname01
[ RUN      ] test_nuttx_syscall_gettimeofday01
nxsig_notification: pid=5 signo=14 code=2 sival_ptr=0x90000000980adc50
nxsig_tcbdispatch: TCB=0x90000000980d0e20 pid=5 signo=14 code=2 value=-1744118704 masked=NO
up_schedule_sigaction: tcb=0x90000000980d0e20, rtcb=0x90000000980abb38 current_regs=0x90000000987ffe90
loongarch_sigdeliver: rtcb=0x90000000980d0e20 sigdeliver=0x900000009801218c sigpendactionq.head=0x90000000980ad5f0
nxsig_deliver: Deliver signal 14 to PID 5
loongarch_sigdeliver: Resuming EPC: 900000009801ee08 INT_CTX: 0000000000000000
[       OK ] test_nuttx_syscall_gettimeofday01
[ RUN      ] test_nuttx_syscall_lseek01
[       OK ] test_nuttx_syscall_lseek01
[ RUN      ] test_nuttx_syscall_lseek07
[       OK ] test_nuttx_syscall_lseek07
[ RUN      ] test_nuttx_syscall_lstat01
[       OK ] test_nuttx_syscall_lstat01
[ RUN      ] test_nuttx_syscall_dup01
[       OK ] test_nuttx_syscall_dup01
[ RUN      ] test_nuttx_syscall_dup02
[       OK ] test_nuttx_syscall_dup02
[ RUN      ] test_nuttx_syscall_dup03
[       OK ] test_nuttx_syscall_dup03
[ RUN      ] test_nuttx_syscall_dup04
[       OK ] test_nuttx_syscall_dup04
[ RUN      ] test_nuttx_syscall_dup05
[       OK ] test_nuttx_syscall_dup05
[ RUN      ] test_nuttx_syscall_dup201
[       OK ] test_nuttx_syscall_dup201
[ RUN      ] test_nuttx_syscall_dup202
[       OK ] test_nuttx_syscall_dup202
[ RUN      ] test_nuttx_syscall_fpathconf01
[       OK ] test_nuttx_syscall_fpathconf01
[ RUN      ] test_nuttx_syscall_getegid01
[       OK ] test_nuttx_syscall_getegid01
[ RUN      ] test_nuttx_syscall_getegid02
[       OK ] test_nuttx_syscall_getegid02
[ RUN      ] test_nuttx_syscall_geteuid01
[       OK ] test_nuttx_syscall_geteuid01
[ RUN      ] test_nuttx_syscall_getgid01
[       OK ] test_nuttx_syscall_getgid01
[ RUN      ] test_nuttx_syscall_getgid02
[       OK ] test_nuttx_syscall_getgid02
[ RUN      ] test_nuttx_syscall_getuid01
[       OK ] test_nuttx_syscall_getuid01
[ RUN      ] test_nuttx_syscall_pathconf01
[       OK ] test_nuttx_syscall_pathconf01
[ RUN      ] test_nuttx_syscall_pipe01
[       OK ] test_nuttx_syscall_pipe01
[ RUN      ] test_nuttx_syscall_pipe02
[       OK ] test_nuttx_syscall_pipe02
[ RUN      ] test_nuttx_syscall_pread01
[       OK ] test_nuttx_syscall_pread01
[ RUN      ] test_nuttx_syscall_pwrite01
[       OK ] test_nuttx_syscall_pwrite01
[ RUN      ] test_nuttx_syscall_pwrite02
[       OK ] test_nuttx_syscall_pwrite02
[ RUN      ] test_nuttx_syscall_rmdir01
[       OK ] test_nuttx_syscall_rmdir01
[ RUN      ] test_nuttx_syscall_rmdir02
[       OK ] test_nuttx_syscall_rmdir02
[ RUN      ] test_nuttx_syscall_truncate01
[       OK ] test_nuttx_syscall_truncate01
[ RUN      ] test_nuttx_syscall_unlink01
[       OK ] test_nuttx_syscall_unlink01
[ RUN      ] test_nuttx_syscall_nansleep01
[       OK ] test_nuttx_syscall_nansleep01
[ RUN      ] test_nuttx_syscall_nansleep02
[       OK ] test_nuttx_syscall_nansleep02
[ RUN      ] test_nuttx_syscall_time01
[       OK ] test_nuttx_syscall_time01
[ RUN      ] test_nuttx_syscall_time02
[       OK ] test_nuttx_syscall_time02
[ RUN      ] test_nuttx_syscall_timercreate01
[       OK ] test_nuttx_syscall_timercreate01
[ RUN      ] test_nuttx_syscall_timerdelete01
[       OK ] test_nuttx_syscall_timerdelete01
[ RUN      ] test_nuttx_syscall_timergettime01
[       OK ] test_nuttx_syscall_timergettime01
[ RUN      ] test_nuttx_syscall_mkdir01
[       OK ] test_nuttx_syscall_mkdir01
[ RUN      ] test_nuttx_syscall_mkdir02
[       OK ] test_nuttx_syscall_mkdir02
[ RUN      ] test_nuttx_syscall_mkdir03
[       OK ] test_nuttx_syscall_mkdir03
[ RUN      ] test_nuttx_syscall_sched01
[       OK ] test_nuttx_syscall_sched01
[ RUN      ] test_nuttx_syscall_sched02
[       OK ] test_nuttx_syscall_sched02
[ RUN      ] test_nuttx_syscall_sched03
[       OK ] test_nuttx_syscall_sched03
[ RUN      ] test_nuttx_syscall_sched04
[       OK ] test_nuttx_syscall_sched04
[ RUN      ] test_nuttx_syscall_write01
[       OK ] test_nuttx_syscall_write01
[ RUN      ] test_nuttx_syscall_write02
[       OK ] test_nuttx_syscall_write02
[ RUN      ] test_nuttx_syscall_write03
[       OK ] test_nuttx_syscall_write03
[ RUN      ] test_nuttx_syscall_read01
[       OK ] test_nuttx_syscall_read01
[ RUN      ] test_nuttx_syscall_read02
[       OK ] test_nuttx_syscall_read02
[ RUN      ] test_nuttx_syscall_read03
[       OK ] test_nuttx_syscall_read03
[ RUN      ] test_nuttx_syscall_read04
[       OK ] test_nuttx_syscall_read04
[ RUN      ] test_nuttx_syscall_symlink01
[       OK ] test_nuttx_syscall_symlink01
[ RUN      ] test_nuttx_syscall_symlink02
[       OK ] test_nuttx_syscall_symlink02
[ RUN      ] test_nuttx_syscall_sockettest01
NO.1 do socket() test, ret=-1  erron=22 experrno=97
NO.2 do socket() test, ret=-1  erron=93 experrno=97
NO.3 do socket() test, ret=-1  erron=93 experrno=97
NO.4 do socket() test, ret=-1  erron=93 experrno=97
NO.6 do socket() test, ret=-1  erron=93 experrno=97
[       OK ] test_nuttx_syscall_sockettest01
[ RUN      ] test_nuttx_syscall_sockettest02
[       OK ] test_nuttx_syscall_sockettest02
[==========] nuttx_syscall_test_suites: 83 test(s) run.
[  PASSED  ] 83 test(s).
nxsig_tcbdispatch: TCB=0x90000000980cabd0 pid=3 signo=17 code=5 value=0 masked=NO
nxtask_exit: cmocka_syscall_test pid=5,TCB=0x90000000980d0e20
nsh>

```

##### cmocka\_syscall\_test 启用配置：

在nuttx/boards/loongarch/ls2k0300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_ALLOW\_MIT\_COMPONENTS=y

CONFIG\_LIBC\_EXECFUNCS=y

CONFIG\_LIBC\_REGEX=y

CONFIG\_TESTING\_CMOCKA=y

CONFIG\_TESTS\_TESTSUITES=y

CONFIG\_TESTS\_TESTSUITES\_STACKSIZE=16384

CONFIG\_CM\_SYSCALL\_TEST=y

CONFIG\_FS\_TMPFS=y

CONFIG\_FS\_LINKS=y

CONFIG\_ARCH\_SETJMP\_H=y

CONFIG\_BUILTIN=y

CONFIG\_NSH\_BUILTIN\_APPS=y

CONFIG\_FAT\_LFN=y

CONFIG\_IOB\_NBUFFERS=128

CONFIG\_IOB\_NCHAINS=4

CONFIG\_NET=y

CONFIG\_NETDEV\_LATEINIT=y

CONFIG\_NET\_ICMP=y

CONFIG\_NET\_LOCAL=y

CONFIG\_NET\_SOCKOPTS=y

CONFIG\_NET\_TCP=y

CONFIG\_NET\_UDP=y

CONFIG\_PSEUDOFS\_SOFTLINKS=y

CONFIG\_SCHED\_HAVE\_PARENT=y

CONFIG\_SCHED\_LPWORK=y



#### 1\.1\.4 Kernel\-ostest测试

##### 成功

指令：ostest

日志：太长了无法放出



#### 1\.1\.5 Kernel\-getprime测试

##### 成功

指令：getprime

日志：

```YAML
nsh> getprime
task_spawn: name=getprime entry=0x900000009802fa80 file_actions=0x9000000098054d08 attr=0x9000000098054d10 argv=0x9000000098054ea8
nxtask_activate: getprime pid=4,TCB=0x9000000098057c00
nxtask_activate: getprime pid=5,TCB=0x9000000098058ba0
Set thread priority to 10
Set thread policy to SCHED_RR
Start thread #0
thread #0 started, looking for primes < 10000, doing 10 run(s)
thnx_pthread_exit: exit_value=0
pthread_completejoin: pid=5 exit_value=0
pthread_join: Returning 0, exit_value 0
pthread_completejoin: pid=5 exit_value=0xffffffffffffffff
nxtask_exit: getprime pid=4,TCB=0x9000000098057c00
read #0 finished, found 1230 primes, last one was 9973
Done
getprime took 80 msec

```

#### 1\.1\.6 Kernel\-mm内存测试

##### 成功

指令：mm

日志：

```Java
nsh> mm
task_spawn: name=mm entry=0x900000009802fc98 file_actions=0x90000000980555e8 attr=0x90000000980555f0 argv=0x9000000098055788
nxtask_activate: mm pid=4,TCB=0x90000000980584e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155520
       Total allocated space             = 23608
       Total non-inuse space             = 155520
(0)Allocating 5040 bytes
(0)Memory allocated at 0x9000000098059480
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 150496
       Total allocated space             = 28632
       Total non-inuse space             = 150496
(1)Allocating 124352 bytes
(1)The allocated memory exceeds the threshold, skipping
(2)Allocating 5712 bytes
(2)Memory allocated at 0x900000009805a820
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 144784
       Total allocated space             = 34344
       Total non-inuse space             = 144784
(3)Allocating 96 bytes
(3)Memory allocated at 0x900000009805be70
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 144704
       Total allocated space             = 34424
       Total non-inuse space             = 144704
(4)Allocating 2768 bytes
(4)Memory allocated at 0x900000009805bec0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 141936
       Total allocated space             = 37192
       Total non-inuse space             = 141936
(5)Allocating 32 bytes
(5)Memory allocated at 0x900000009805c990
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 141904
       Total allocated space             = 37224
       Total non-inuse space             = 141904
(6)Allocating 624 bytes
(6)Memory allocated at 0x900000009805c9b0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 141280
       Total allocated space             = 37848
       Total non-inuse space             = 141280
(7)Allocating 48 bytes
(7)Memory allocated at 0x900000009805cc20
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 141232
       Total allocated space             = 37896
       Total non-inuse space             = 141232
(8)Allocating 1552 bytes
(8)Memory allocated at 0x900000009805cc50
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 139680
       Total allocated space             = 39448
       Total non-inuse space             = 139680
(9)Allocating 992 bytes
(9)Memory allocated at 0x900000009805d260
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 138704
       Total allocated space             = 40424
       Total non-inuse space             = 138704
(10)Allocating 69200 bytes
(10)Memory allocated at 0x900000009805d630
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 69504
       Total allocated space             = 109624
       Total non-inuse space             = 69504
(11)Allocating 928 bytes
(11)Memory allocated at 0x900000009806e480
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 68592
       Total allocated space             = 110536
       Total non-inuse space             = 68592
(12)Allocating 6768 bytes
(12)Memory allocated at 0x900000009806e810
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 61824
       Total allocated space             = 117304
       Total non-inuse space             = 61824
(13)Allocating 1664 bytes
(13)Memory allocated at 0x9000000098070280
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 60160
       Total allocated space             = 118968
       Total non-inuse space             = 60160
(14)Allocating 1040 bytes
(14)Memory allocated at 0x9000000098070900
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 59120
       Total allocated space             = 120008
       Total non-inuse space             = 59120
(15)Allocating 32 bytes
(15)Memory allocated at 0x9000000098070d10
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 59088
       Total allocated space             = 120040
       Total non-inuse space             = 59088
(16)Allocating 224 bytes
(16)Memory allocated at 0x9000000098070d30
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 58880
       Total allocated space             = 120248
       Total non-inuse space             = 58880
(17)Allocating 496 bytes
(17)Memory allocated at 0x9000000098070e00
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 58384
       Total allocated space             = 120744
       Total non-inuse space             = 58384
(18)Allocating 2032 bytes
(18)Memory allocated at 0x9000000098070ff0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 56352
       Total allocated space             = 122776
       Total non-inuse space             = 56352
(19)Allocating 2608 bytes
(19)Memory allocated at 0x90000000980717e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 53744
       Total allocated space             = 125384
       Total non-inuse space             = 53744
(20)Allocating 240 bytes
(20)Memory allocated at 0x9000000098072210
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 53504
       Total allocated space             = 125624
       Total non-inuse space             = 53504
(21)Allocating 992 bytes
(21)Memory allocated at 0x9000000098072300
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 52512
       Total allocated space             = 126616
       Total non-inuse space             = 52512
(22)Allocating 96 bytes
(22)Memory allocated at 0x90000000980726e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 52432
       Total allocated space             = 126696
       Total non-inuse space             = 52432
(23)Allocating 880 bytes
(23)Memory allocated at 0x9000000098072730
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 51568
       Total allocated space             = 127560
       Total non-inuse space             = 51568
(24)Allocating 10272 bytes
(24)Memory allocated at 0x9000000098072a90
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 41296
       Total allocated space             = 137832
       Total non-inuse space             = 41296
(25)Allocating 32 bytes
(25)Memory allocated at 0x90000000980752b0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 41264
       Total allocated space             = 137864
       Total non-inuse space             = 41264
(26)Allocating 672 bytes
(26)Memory allocated at 0x90000000980752d0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 40608
       Total allocated space             = 138520
       Total non-inuse space             = 40608
(27)Allocating 9952 bytes
(27)Memory allocated at 0x9000000098075560
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 30656
       Total allocated space             = 148472
       Total non-inuse space             = 30656
(28)Allocating 4752 bytes
(28)Memory allocated at 0x9000000098077c40
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 25904
       Total allocated space             = 153224
       Total non-inuse space             = 25904
(29)Allocating 800 bytes
(29)Memory allocated at 0x9000000098078ed0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 25120
       Total allocated space             = 154008
       Total non-inuse space             = 25120
(30)Allocating 128 bytes
(30)Memory allocated at 0x90000000980791e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 24992
       Total allocated space             = 154136
       Total non-inuse space             = 24992
(31)Allocating 81664 bytes
(31)The allocated memory exceeds the threshold, skipping
(0)Re-allocating at 0x900000009805d260 from 962 to 963 bytes
(0)Memory re-allocated at 0x900000009805d260
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 24992
       Total allocated space             = 154136
       Total non-inuse space             = 24992
(1)Re-allocating at 0x9000000098070e00 from 480 to 4346 bytes
(1)Memory re-allocated at 0x9000000098079260
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 20624
       Total allocated space             = 158008
       Total non-inuse space             = 21120
(2)Re-allocating at 0x90000000980726e0 from 68 to 592 bytes
(2)Memory re-allocated at 0x900000009807a370
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 20016
       Total allocated space             = 158536
       Total non-inuse space             = 20592
(3)Re-allocating at 0 from 81647 to 4734 bytes
(3)Memory re-allocated at 0x900000009807a5d0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 15264
       Total allocated space             = 163288
       Total non-inuse space             = 15840
(4)Re-allocating at 0x9000000098072300 from 969 to 812 bytes
(4)Memory re-allocated at 0x9000000098072300
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 15264
       Total allocated space             = 163128
       Total non-inuse space             = 16000
(5)Re-allocating at 0 from 124321 to 6 bytes
(5)Memory re-allocated at 0x9000000098072640
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 15264
       Total allocated space             = 163160
       Total non-inuse space             = 15968
(6)The reallocs memory exceeds the threshold, skipping
(7)Re-allocating at 0x9000000098072a90 from 10254 to 511 bytes
(7)Memory re-allocated at 0x9000000098072a90
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 15264
       Total allocated space             = 153416
       Total non-inuse space             = 25712
(8)Re-allocating at 0x9000000098059480 from 5011 to 9172 bytes
(8)Memory re-allocated at 0x9000000098072ca0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 5
       Largest non-inuse chunk           = 15264
       Total allocated space             = 157576
       Total non-inuse space             = 21552
(9)Re-allocating at 0x900000009805c9b0 from 601 to 42 bytes
(9)Memory re-allocated at 0x900000009805c9b0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 15264
       Total allocated space             = 157016
       Total non-inuse space             = 22112
(10)Re-allocating at 0x9000000098070900 from 1024 to 18 bytes
(10)Memory re-allocated at 0x9000000098070900
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 15264
       Total allocated space             = 156008
       Total non-inuse space             = 23120
(11)Re-allocating at 0x9000000098077c40 from 4732 to 8663 bytes
(11)Memory re-allocated at 0x900000009807b860
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 6592
       Total allocated space             = 159928
       Total non-inuse space             = 19200
(12)Re-allocating at 0x90000000980717e0 from 2590 to 1666 bytes
(12)Memory re-allocated at 0x90000000980717e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 6592
       Total allocated space             = 159000
       Total non-inuse space             = 20128
(13)Re-allocating at 0x9000000098072730 from 852 to 5040 bytes
(13)Memory re-allocated at 0x900000009807da40
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 5024
       Total allocated space             = 163192
       Total non-inuse space             = 15936
(14)The reallocs memory exceeds the threshold, skipping
(15)The reallocs memory exceeds the threshold, skipping
(16)Re-allocating at 0x9000000098070d10 from 3 to 1412 bytes
(16)Memory re-allocated at 0x900000009807ee00
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 5024
       Total allocated space             = 164584
       Total non-inuse space             = 14544
(17)The reallocs memory exceeds the threshold, skipping
(18)Re-allocating at 0x9000000098070280 from 1646 to 221 bytes
(18)Memory re-allocated at 0x9000000098070280
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 10
       Largest non-inuse chunk           = 5024
       Total allocated space             = 163160
       Total non-inuse space             = 15968
(19)Re-allocating at 0x900000009805be70 from 70 to 416 bytes
(19)Memory re-allocated at 0x9000000098070e00
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 11
       Largest non-inuse chunk           = 5024
       Total allocated space             = 163512
       Total non-inuse space             = 15616
(20)The reallocs memory exceeds the threshold, skipping
(21)Re-allocating at 0x900000009805c990 from 7 to 4 bytes
(21)Memory re-allocated at 0x900000009805c990
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 11
       Largest non-inuse chunk           = 5024
       Total allocated space             = 163512
       Total non-inuse space             = 15616
(22)Re-allocating at 0x900000009805a820 from 5692 to 123 bytes
(22)Memory re-allocated at 0x900000009805a820
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 11
       Largest non-inuse chunk           = 5648
       Total allocated space             = 157944
       Total non-inuse space             = 21184
(23)Re-allocating at 0x900000009805d630 from 69179 to 7830 bytes
(23)Memory re-allocated at 0x900000009805d630
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 61360
       Total allocated space             = 96584
       Total non-inuse space             = 82544
(24)Re-allocating at 0x900000009805bec0 from 2746 to 1990 bytes
(24)Memory re-allocated at 0x900000009805bec0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 13
       Largest non-inuse chunk           = 61360
       Total allocated space             = 95816
       Total non-inuse space             = 83312
(25)Re-allocating at 0x900000009806e480 from 901 to 28 bytes
(25)Memory re-allocated at 0x900000009806e480
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 61360
       Total allocated space             = 94952
       Total non-inuse space             = 84176
(26)Re-allocating at 0x9000000098070ff0 from 2011 to 229 bytes
(26)Memory re-allocated at 0x9000000098070ff0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 61360
       Total allocated space             = 93160
       Total non-inuse space             = 85968
(27)Re-allocating at 0x9000000098078ed0 from 776 to 4088 bytes
(27)Memory re-allocated at 0x90000000980781e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 61360
       Total allocated space             = 96472
       Total non-inuse space             = 82656
(28)Re-allocating at 0x90000000980752b0 from 12 to 3088 bytes
(28)Memory re-allocated at 0x9000000098059480
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 61360
       Total allocated space             = 99544
       Total non-inuse space             = 79584
(29)Re-allocating at 0x900000009805cc50 from 1536 to 168 bytes
(29)Memory re-allocated at 0x900000009805cc50
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 16
       Largest non-inuse chunk           = 61360
       Total allocated space             = 98168
       Total non-inuse space             = 80960
(30)Re-allocating at 0x900000009806e810 from 6750 to 11 bytes
(30)Memory re-allocated at 0x900000009806e810
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 17
       Largest non-inuse chunk           = 61360
       Total allocated space             = 91432
       Total non-inuse space             = 87696
(31)Re-allocating at 0x9000000098075560 from 9932 to 3723 bytes
(31)Memory re-allocated at 0x9000000098075560
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 17
       Largest non-inuse chunk           = 61360
       Total allocated space             = 85224
       Total non-inuse space             = 93904
(0)Releasing memory at 0x9000000098072210 (size=9374 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 17
       Largest non-inuse chunk           = 61360
       Total allocated space             = 84984
       Total non-inuse space             = 94144
(1)Releasing memory at 0x900000009805cc20 (size=91255 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 17
       Largest non-inuse chunk           = 61360
       Total allocated space             = 84936
       Total non-inuse space             = 94192
(2)Releasing memory at 0x900000009805a820 (size=123 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 16
       Largest non-inuse chunk           = 61360
       Total allocated space             = 84792
       Total non-inuse space             = 94336
(3)Releasing memory at 0x900000009806e480 (size=28 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 62272
       Total allocated space             = 84744
       Total non-inuse space             = 94384
(4)Releasing memory at 0x900000009805d630 (size=7830 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 70112
       Total allocated space             = 76904
       Total non-inuse space             = 102224
(5)Releasing memory at 0x900000009807a5d0 (size=4734 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 16
       Largest non-inuse chunk           = 70112
       Total allocated space             = 72152
       Total non-inuse space             = 106976
(6)Releasing memory at 0x9000000098072300 (size=812 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 16
       Largest non-inuse chunk           = 70112
       Total allocated space             = 71320
       Total non-inuse space             = 107808
(7)Releasing memory at 0x9000000098072640 (size=6 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 70112
       Total allocated space             = 71288
       Total non-inuse space             = 107840
(8)Releasing memory at 0x900000009807a370 (size=592 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 70112
       Total allocated space             = 70680
       Total non-inuse space             = 108448
(9)Releasing memory at 0x9000000098070ff0 (size=229 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 70112
       Total allocated space             = 70440
       Total non-inuse space             = 108688
(10)Releasing memory at 0x9000000098072a90 (size=511 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 70112
       Total allocated space             = 69912
       Total non-inuse space             = 109216
(11)Releasing memory at 0x9000000098072ca0 (size=9172 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 13
       Largest non-inuse chunk           = 70112
       Total allocated space             = 60728
       Total non-inuse space             = 118400
(12)Releasing memory at 0x9000000098070280 (size=221 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 70112
       Total allocated space             = 60488
       Total non-inuse space             = 118640
(13)Releasing memory at 0x900000009807ee00 (size=1412 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 70112
       Total allocated space             = 59064
       Total non-inuse space             = 120064
(14)Releasing memory at 0x9000000098070d30 (size=30421 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 70112
       Total allocated space             = 58856
       Total non-inuse space             = 120272
(15)Releasing memory at 0x9000000098059480 (size=3088 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 70112
       Total allocated space             = 55752
       Total non-inuse space             = 123376
(16)Releasing memory at 0x900000009805c990 (size=4 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 70112
       Total allocated space             = 55720
       Total non-inuse space             = 123408
(17)Releasing memory at 0x900000009806e810 (size=11 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 11
       Largest non-inuse chunk           = 78544
       Total allocated space             = 55688
       Total non-inuse space             = 123440
(18)Releasing memory at 0x9000000098079260 (size=4346 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 11
       Largest non-inuse chunk           = 78544
       Total allocated space             = 51320
       Total non-inuse space             = 127808
(19)Releasing memory at 0x900000009805cc50 (size=168 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 10
       Largest non-inuse chunk           = 78544
       Total allocated space             = 51144
       Total non-inuse space             = 127984
(20)Releasing memory at 0x9000000098070900 (size=18 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 79824
       Total allocated space             = 51112
       Total non-inuse space             = 128016
(21)Releasing memory at 0x9000000098070e00 (size=416 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 82352
       Total allocated space             = 50680
       Total non-inuse space             = 128448
(22)Releasing memory at 0x900000009805c9b0 (size=42 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 82352
       Total allocated space             = 50616
       Total non-inuse space             = 128512
(23)Releasing memory at 0x90000000980752d0 (size=59139 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 82352
       Total allocated space             = 49960
       Total non-inuse space             = 129168
(24)Releasing memory at 0x900000009805bec0 (size=1990 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 82352
       Total allocated space             = 47960
       Total non-inuse space             = 131168
(25)Releasing memory at 0x900000009807da40 (size=5040 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 82352
       Total allocated space             = 42904
       Total non-inuse space             = 136224
(26)Releasing memory at 0x900000009805d260 (size=963 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 5
       Largest non-inuse chunk           = 99168
       Total allocated space             = 41928
       Total non-inuse space             = 137200
(27)Releasing memory at 0x90000000980717e0 (size=1666 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 114912
       Total allocated space             = 40248
       Total non-inuse space             = 138880
(28)Releasing memory at 0x900000009807b860 (size=8663 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 114912
       Total allocated space             = 31576
       Total non-inuse space             = 147552
(29)Releasing memory at 0x9000000098075560 (size=3723 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 126304
       Total allocated space             = 27832
       Total non-inuse space             = 151296
(30)Releasing memory at 0x90000000980781e0 (size=4088 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 130400
       Total allocated space             = 23736
       Total non-inuse space             = 155392
(31)Releasing memory at 0x90000000980791e0 (size=11666 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155520
       Total allocated space             = 23608
       Total non-inuse space             = 155520
(0)Allocating 962 bytes aligned to 0x00000080
(0)Memory allocated at 0x9000000098059480
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154544
       Total allocated space             = 24584
       Total non-inuse space             = 154544
(1)Allocating 480 bytes aligned to 0x00000800
(1)Memory allocated at 0x900000009805a000
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 152080
       Total allocated space             = 25080
       Total non-inuse space             = 154048
(2)Allocating 68 bytes aligned to 0x00020000
(2)The reallocs memory exceeds the threshold, skipping
(3)Allocating 81647 bytes aligned to 0x00002000
(3)Memory allocated at 0x900000009805c000
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 62720
       Total allocated space             = 106744
       Total non-inuse space             = 72384
(4)Allocating 969 bytes aligned to 0x00000020
(4)Memory allocated at 0x9000000098059880
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 62720
       Total allocated space             = 107736
       Total non-inuse space             = 71392
(5)Allocating 124321 bytes aligned to 0x00008000
(5)The reallocs memory exceeds the threshold, skipping
(6)Allocating 194 bytes aligned to 0x00004000
(6)Memory allocated at 0x9000000098070000
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 5
       Largest non-inuse chunk           = 62256
       Total allocated space             = 107944
       Total non-inuse space             = 71184
(7)Allocating 10254 bytes aligned to 0x00040000
(7)The reallocs memory exceeds the threshold, skipping
(8)Allocating 5011 bytes aligned to 0x00000200
(8)Memory allocated at 0x900000009805a400
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 62256
       Total allocated space             = 112968
       Total non-inuse space             = 66160
(9)Allocating 601 bytes aligned to 0x00001000
(9)Memory allocated at 0x9000000098071000
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 57744
       Total allocated space             = 113592
       Total non-inuse space             = 65536
(10)Allocating 1024 bytes aligned to 0x00010000
(10)The reallocs memory exceeds the threshold, skipping
(11)Allocating 4732 bytes aligned to 0x00000008
(11)Memory allocated at 0x9000000098071270
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 52992
       Total allocated space             = 118344
       Total non-inuse space             = 60784
(12)Allocating 2590 bytes aligned to 0x00000040
(12)Memory allocated at 0x9000000098070100
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 52992
       Total allocated space             = 120952
       Total non-inuse space             = 58176
(13)Allocating 852 bytes aligned to 0x00000400
(13)Memory allocated at 0x9000000098072800
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 51360
       Total allocated space             = 121816
       Total non-inuse space             = 57312
(14)Allocating 111 bytes aligned to 0x00000010
(14)Memory allocated at 0x900000009806ff00
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 51360
       Total allocated space             = 121944
       Total non-inuse space             = 57184
(15)Allocating 646 bytes aligned to 0x00000004
(15)Memory allocated at 0x9000000098072500
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 51360
       Total allocated space             = 122600
       Total non-inuse space             = 56528
(0)Allocating 3 bytes aligned to 0x00000080
(0)Memory allocated at 0x900000009805a280
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 10
       Largest non-inuse chunk           = 51360
       Total allocated space             = 122632
       Total non-inuse space             = 56496
(1)Allocating 28 bytes aligned to 0x00000800
(1)Memory allocated at 0x9000000098073000
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 11
       Largest non-inuse chunk           = 50128
       Total allocated space             = 122680
       Total non-inuse space             = 56448
(2)Allocating 1646 bytes aligned to 0x00020000
(2)The reallocs memory exceeds the threshold, skipping
(3)Allocating 70 bytes aligned to 0x00002000
(3)Memory allocated at 0x9000000098074000
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 46000
       Total allocated space             = 122760
       Total non-inuse space             = 56368
(4)Allocating 222 bytes aligned to 0x00000020
(4)Memory allocated at 0x900000009805a2a0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 46000
       Total allocated space             = 123000
       Total non-inuse space             = 56128
(5)Allocating 7 bytes aligned to 0x00008000
(5)The reallocs memory exceeds the threshold, skipping
(6)Allocating 5692 bytes aligned to 0x00004000
(6)The reallocs memory exceeds the threshold, skipping
(7)Allocating 69179 bytes aligned to 0x00040000
(7)The reallocs memory exceeds the threshold, skipping
(8)Allocating 2746 bytes aligned to 0x00000200
(8)Memory allocated at 0x9000000098073200
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 13
       Largest non-inuse chunk           = 46000
       Total allocated space             = 125768
       Total non-inuse space             = 53360
(9)Allocating 901 bytes aligned to 0x00001000
(9)Memory allocated at 0x9000000098075000
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 41072
       Total allocated space             = 126680
       Total non-inuse space             = 52448
(10)Allocating 2011 bytes aligned to 0x00010000
(10)The reallocs memory exceeds the threshold, skipping
(11)Allocating 776 bytes aligned to 0x00000008
(11)Memory allocated at 0x9000000098073cd0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 41072
       Total allocated space             = 127464
       Total non-inuse space             = 51664
(12)Allocating 12 bytes aligned to 0x00000040
(12)Memory allocated at 0x9000000098073080
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 41072
       Total allocated space             = 127496
       Total non-inuse space             = 51632
(13)Allocating 1536 bytes aligned to 0x00000400
(13)Memory allocated at 0x9000000098074400
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 16
       Largest non-inuse chunk           = 41072
       Total allocated space             = 129048
       Total non-inuse space             = 50080
(14)Allocating 6750 bytes aligned to 0x00000010
(14)Memory allocated at 0x9000000098075390
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 16
       Largest non-inuse chunk           = 34304
       Total allocated space             = 135816
       Total non-inuse space             = 43312
(15)Allocating 9932 bytes aligned to 0x00000004
(15)Memory allocated at 0x9000000098076e00
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 16
       Largest non-inuse chunk           = 24352
       Total allocated space             = 145768
       Total non-inuse space             = 33360
(0)Releasing memory at 0x900000009805a400 (size=5011 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 24352
       Total allocated space             = 140744
       Total non-inuse space             = 38384
(1)Releasing memory at 0 (size=124321 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 24352
       Total allocated space             = 140744
       Total non-inuse space             = 38384
(2)Releasing memory at 0 (size=5692 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 15
       Largest non-inuse chunk           = 24352
       Total allocated space             = 140744
       Total non-inuse space             = 38384
(3)Releasing memory at 0x9000000098074000 (size=70 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 24352
       Total allocated space             = 140664
       Total non-inuse space             = 38464
(4)Releasing memory at 0x9000000098073200 (size=2746 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 24352
       Total allocated space             = 137896
       Total non-inuse space             = 41232
(5)Releasing memory at 0 (size=7 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 24352
       Total allocated space             = 137896
       Total non-inuse space             = 41232
(6)Releasing memory at 0x9000000098071000 (size=601 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 14
       Largest non-inuse chunk           = 24352
       Total allocated space             = 137272
       Total non-inuse space             = 41856
(7)Releasing memory at 0x9000000098073000 (size=28 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 13
       Largest non-inuse chunk           = 24352
       Total allocated space             = 137224
       Total non-inuse space             = 41904
(8)Releasing memory at 0x9000000098074400 (size=1536 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 135672
       Total non-inuse space             = 43456
(9)Releasing memory at 0x9000000098059480 (size=962 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 134696
       Total non-inuse space             = 44432
(10)Releasing memory at 0 (size=69179 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 134696
       Total non-inuse space             = 44432
(11)Releasing memory at 0x9000000098075000 (size=901 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 133784
       Total non-inuse space             = 45344
(12)Releasing memory at 0x9000000098075390 (size=6750 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 127016
       Total non-inuse space             = 52112
(13)Releasing memory at 0 (size=1646 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 127016
       Total non-inuse space             = 52112
(14)Releasing memory at 0 (size=1024 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 127016
       Total non-inuse space             = 52112
(15)Releasing memory at 0x900000009805a280 (size=3 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 12
       Largest non-inuse chunk           = 24352
       Total allocated space             = 126984
       Total non-inuse space             = 52144
(16)Releasing memory at 0x9000000098070000 (size=194 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 11
       Largest non-inuse chunk           = 24352
       Total allocated space             = 126776
       Total non-inuse space             = 52352
(17)Releasing memory at 0x900000009805a000 (size=480 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 10
       Largest non-inuse chunk           = 24352
       Total allocated space             = 126280
       Total non-inuse space             = 52848
(18)Releasing memory at 0 (size=2011 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 10
       Largest non-inuse chunk           = 24352
       Total allocated space             = 126280
       Total non-inuse space             = 52848
(19)Releasing memory at 0x9000000098070100 (size=2590 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 24352
       Total allocated space             = 123672
       Total non-inuse space             = 55456
(20)Releasing memory at 0x900000009805a2a0 (size=222 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 24352
       Total allocated space             = 123432
       Total non-inuse space             = 55696
(21)Releasing memory at 0x9000000098059880 (size=969 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 24352
       Total allocated space             = 122440
       Total non-inuse space             = 56688
(22)Releasing memory at 0 (size=68 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 24352
       Total allocated space             = 122440
       Total non-inuse space             = 56688
(23)Releasing memory at 0x9000000098072800 (size=852 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 24352
       Total allocated space             = 121576
       Total non-inuse space             = 57552
(24)Releasing memory at 0 (size=10254 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 24352
       Total allocated space             = 121576
       Total non-inuse space             = 57552
(25)Releasing memory at 0x9000000098073080 (size=12 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 5
       Largest non-inuse chunk           = 24352
       Total allocated space             = 121544
       Total non-inuse space             = 57584
(26)Releasing memory at 0x9000000098072500 (size=646 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 5
       Largest non-inuse chunk           = 24352
       Total allocated space             = 120888
       Total non-inuse space             = 58240
(27)Releasing memory at 0x9000000098076e00 (size=9932 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 46112
       Total allocated space             = 110936
       Total non-inuse space             = 68192
(28)Releasing memory at 0x9000000098071270 (size=4732 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 46112
       Total allocated space             = 106184
       Total non-inuse space             = 72944
(29)Releasing memory at 0x9000000098073cd0 (size=776 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 62592
       Total allocated space             = 105400
       Total non-inuse space             = 73728
(30)Releasing memory at 0x900000009806ff00 (size=111 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 62720
       Total allocated space             = 105272
       Total non-inuse space             = 73856
(31)Releasing memory at 0x900000009805c000 (size=81647 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155520
       Total allocated space             = 23608
       Total non-inuse space             = 155520
(0)Allocating 3 bytes aligned to 0x00000001
(0)Memory allocated at 0x9000000098059480
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155488
       Total allocated space             = 23640
       Total non-inuse space             = 155488
(1)Allocating 20 bytes aligned to 0x00000002
(1)Memory allocated at 0x90000000980594a0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155456
       Total allocated space             = 23672
       Total non-inuse space             = 155456
(2)Allocating 13 bytes aligned to 0x00000004
(2)Memory allocated at 0x90000000980594c0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155424
       Total allocated space             = 23704
       Total non-inuse space             = 155424
(3)Allocating 24 bytes aligned to 0x00000008
(3)Memory allocated at 0x90000000980594e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155392
       Total allocated space             = 23736
       Total non-inuse space             = 155392
(4)Allocating 31 bytes aligned to 0x00000010
(4)Memory allocated at 0x9000000098059500
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155344
       Total allocated space             = 23784
       Total non-inuse space             = 155344
(5)Allocating 12 bytes aligned to 0x00000020
(5)Memory allocated at 0x9000000098059560
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 155264
       Total allocated space             = 23816
       Total non-inuse space             = 155312
(6)Allocating 28 bytes aligned to 0x00000040
(6)Memory allocated at 0x9000000098059580
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 155216
       Total allocated space             = 23864
       Total non-inuse space             = 155264
(7)Allocating 5 bytes aligned to 0x00000080
(7)Memory allocated at 0x9000000098059600
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 155104
       Total allocated space             = 23896
       Total non-inuse space             = 155232
(8)Allocating 21 bytes aligned to 0x00000001
(8)Memory allocated at 0x9000000098059530
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 155104
       Total allocated space             = 23944
       Total non-inuse space             = 155184
(9)Allocating 8 bytes aligned to 0x00000002
(9)Memory allocated at 0x90000000980595b0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 155104
       Total allocated space             = 23976
       Total non-inuse space             = 155152
(10)Allocating 1 bytes aligned to 0x00000004
(10)Memory allocated at 0x90000000980595d0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155104
       Total allocated space             = 24024
       Total non-inuse space             = 155104
(11)Allocating 17 bytes aligned to 0x00000008
(11)Memory allocated at 0x9000000098059620
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155072
       Total allocated space             = 24056
       Total non-inuse space             = 155072
(12)Allocating 29 bytes aligned to 0x00000010
(12)Memory allocated at 0x9000000098059640
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155024
       Total allocated space             = 24104
       Total non-inuse space             = 155024
(13)Allocating 16 bytes aligned to 0x00000020
(13)Memory allocated at 0x90000000980596a0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 154944
       Total allocated space             = 24136
       Total non-inuse space             = 154992
(14)Allocating 6 bytes aligned to 0x00000040
(14)Memory allocated at 0x90000000980596c0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 154912
       Total allocated space             = 24168
       Total non-inuse space             = 154960
(15)Allocating 25 bytes aligned to 0x00000080
(15)Memory allocated at 0x9000000098059700
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 154832
       Total allocated space             = 24216
       Total non-inuse space             = 154912
(0)Allocating 11 bytes aligned to 0x00000001
(0)Memory allocated at 0x90000000980596e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 154832
       Total allocated space             = 24248
       Total non-inuse space             = 154880
(1)Allocating 18 bytes aligned to 0x00000002
(1)Memory allocated at 0x9000000098059670
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154832
       Total allocated space             = 24296
       Total non-inuse space             = 154832
(2)Allocating 26 bytes aligned to 0x00000004
(2)Memory allocated at 0x9000000098059730
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154784
       Total allocated space             = 24344
       Total non-inuse space             = 154784
(3)Allocating 32 bytes aligned to 0x00000008
(3)Memory allocated at 0x9000000098059760
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154736
       Total allocated space             = 24392
       Total non-inuse space             = 154736
(4)Allocating 9 bytes aligned to 0x00000010
(4)Memory allocated at 0x9000000098059790
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154704
       Total allocated space             = 24424
       Total non-inuse space             = 154704
(5)Allocating 30 bytes aligned to 0x00000020
(5)Memory allocated at 0x90000000980597e0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 154608
       Total allocated space             = 24472
       Total non-inuse space             = 154656
(6)Allocating 4 bytes aligned to 0x00000040
(6)Memory allocated at 0x9000000098059840
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 154528
       Total allocated space             = 24504
       Total non-inuse space             = 154624
(7)Allocating 27 bytes aligned to 0x00000080
(7)Memory allocated at 0x9000000098059880
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 154448
       Total allocated space             = 24552
       Total non-inuse space             = 154576
(8)Allocating 10 bytes aligned to 0x00000001
(8)Memory allocated at 0x9000000098059860
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 154448
       Total allocated space             = 24584
       Total non-inuse space             = 154544
(9)Allocating 19 bytes aligned to 0x00000002
(9)Memory allocated at 0x9000000098059810
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 154448
       Total allocated space             = 24632
       Total non-inuse space             = 154496
(10)Allocating 23 bytes aligned to 0x00000004
(10)Memory allocated at 0x90000000980597b0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154448
       Total allocated space             = 24680
       Total non-inuse space             = 154448
(11)Allocating 14 bytes aligned to 0x00000008
(11)Memory allocated at 0x90000000980598b0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154416
       Total allocated space             = 24712
       Total non-inuse space             = 154416
(12)Allocating 2 bytes aligned to 0x00000010
(12)Memory allocated at 0x90000000980598d0
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 154384
       Total allocated space             = 24744
       Total non-inuse space             = 154384
(13)Allocating 22 bytes aligned to 0x00000020
(13)Memory allocated at 0x9000000098059920
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 154304
       Total allocated space             = 24776
       Total non-inuse space             = 154352
(14)Allocating 15 bytes aligned to 0x00000040
(14)Memory allocated at 0x9000000098059940
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 154272
       Total allocated space             = 24808
       Total non-inuse space             = 154320
(15)Allocating 7 bytes aligned to 0x00000080
(15)Memory allocated at 0x9000000098059980
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24840
       Total non-inuse space             = 154288
(0)Releasing memory at 0x9000000098059530 (size=21 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24792
       Total non-inuse space             = 154336
(1)Releasing memory at 0x9000000098059560 (size=12 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24760
       Total non-inuse space             = 154368
(2)Releasing memory at 0x9000000098059840 (size=4 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 5
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24728
       Total non-inuse space             = 154400
(3)Releasing memory at 0x9000000098059760 (size=32 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24680
       Total non-inuse space             = 154448
(4)Releasing memory at 0x9000000098059860 (size=10 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24648
       Total non-inuse space             = 154480
(5)Releasing memory at 0x90000000980597e0 (size=30 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24600
       Total non-inuse space             = 154528
(6)Releasing memory at 0x90000000980595b0 (size=8 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24568
       Total non-inuse space             = 154560
(7)Releasing memory at 0x9000000098059670 (size=18 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24520
       Total non-inuse space             = 154608
(8)Releasing memory at 0x9000000098059920 (size=22 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24488
       Total non-inuse space             = 154640
(9)Releasing memory at 0x9000000098059480 (size=3 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 10
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24456
       Total non-inuse space             = 154672
(10)Releasing memory at 0x9000000098059880 (size=27 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 10
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24408
       Total non-inuse space             = 154720
(11)Releasing memory at 0x9000000098059810 (size=19 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24360
       Total non-inuse space             = 154768
(12)Releasing memory at 0x9000000098059940 (size=15 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24328
       Total non-inuse space             = 154800
(13)Releasing memory at 0x9000000098059730 (size=26 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24280
       Total non-inuse space             = 154848
(14)Releasing memory at 0x90000000980595d0 (size=1 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24232
       Total non-inuse space             = 154896
(15)Releasing memory at 0x90000000980596e0 (size=11 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 9
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24200
       Total non-inuse space             = 154928
(16)Releasing memory at 0x9000000098059580 (size=28 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24152
       Total non-inuse space             = 154976
(17)Releasing memory at 0x90000000980594a0 (size=20 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24120
       Total non-inuse space             = 155008
(18)Releasing memory at 0x90000000980597b0 (size=23 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24072
       Total non-inuse space             = 155056
(19)Releasing memory at 0x9000000098059640 (size=29 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 8
       Largest non-inuse chunk           = 154208
       Total allocated space             = 24024
       Total non-inuse space             = 155104
(20)Releasing memory at 0x9000000098059790 (size=9 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 154208
       Total allocated space             = 23992
       Total non-inuse space             = 155136
(21)Releasing memory at 0x9000000098059500 (size=31 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 154208
       Total allocated space             = 23944
       Total non-inuse space             = 155184
(22)Releasing memory at 0x90000000980594c0 (size=13 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 154208
       Total allocated space             = 23912
       Total non-inuse space             = 155216
(23)Releasing memory at 0x90000000980596a0 (size=16 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 154208
       Total allocated space             = 23880
       Total non-inuse space             = 155248
(24)Releasing memory at 0x9000000098059600 (size=5 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 154208
       Total allocated space             = 23848
       Total non-inuse space             = 155280
(25)Releasing memory at 0x90000000980598d0 (size=2 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 7
       Largest non-inuse chunk           = 154208
       Total allocated space             = 23816
       Total non-inuse space             = 155312
(26)Releasing memory at 0x9000000098059700 (size=25 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 6
       Largest non-inuse chunk           = 154208
       Total allocated space             = 23768
       Total non-inuse space             = 155360
(27)Releasing memory at 0x9000000098059980 (size=7 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 5
       Largest non-inuse chunk           = 154416
       Total allocated space             = 23736
       Total non-inuse space             = 155392
(28)Releasing memory at 0x9000000098059620 (size=17 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 4
       Largest non-inuse chunk           = 154416
       Total allocated space             = 23704
       Total non-inuse space             = 155424
(29)Releasing memory at 0x90000000980598b0 (size=14 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 3
       Largest non-inuse chunk           = 154912
       Total allocated space             = 23672
       Total non-inuse space             = 155456
(30)Releasing memory at 0x90000000980596c0 (size=6 bytes)
     mallinfo:
       Total space allocated from system = 179128
       Number of non-inuse chunks        = 2
       Largest non-inuse chunk           = 155392
       Total allocated space             = 23640
       Total non-inuse space             = 155488
(31)Releasing memory at 0x90000000980594e0 (size=24 bytes)
     mallinfo:
       Tonxtask_exit: mm pid=4,TCB=0x90000000980584e0
tal space allocated from system = 179128
       Number of non-inuse chunks        = 1
       Largest non-inuse chunk           = 155520
       Total allocated space             = 23608
       Total non-inuse space             = 155520
TEST COMPLETE

```

#### 1\.1\.7 Kernel\-scanftest扫描测试

##### 成功

指令：scanftest

日志：

```YAML
nsh> scanftest
task_spawn: name=scanftest entry=0x90000000980302b4 file_actions=0x900000009805e9c8 attr=0x900000009805e9d0 argv=0x900000009805eb68
nxtask_activate: scanftest pid=4,TCB=0x90000000980618c0

Testing sscanf()'s return-value,
conversions, and assignments...
Test #1 PASSED.
Test #2 PASSED.
Test #3 PASSED.
Test #4 PASSED.
Test #5 PASSED.
Test #6 PASSED.
Test #7 PASSED.
Test #8 PASSED.
Test #9 PASSED.
Test #10 PASSED.
Test #11 PASSED.
Test #12 PASSED.
Test #13 PASSED.
Test #14 PASSED.
Test #15 PASSED.
Test #16 PASSED.
Test #17 PASSED.
Test #18 PASSED.
Test #19 PASSED.
Test #20 PASSED.
Test #21 PASSED.
Test #22 PASSED.
Test #23 PASSED.
Test #24 PASSED.
Test #25 PASSED.
Test #26 PASSED.
Test #27 PASSED.
Test #28 PASSED.
Test #29 PASSED.
Test #30 PASSED.
Test #31 PASSED.
Test #32 PASSED.
Test #33 PASSED.
Test #34 PASSED.
Test #35 PASSED.
Test #36 PASSED.
Test #37 PASSED.
Test #38 PASSED.
Test #39 PASSED.
Test #40 PASSED.
Test #41 PASSED.
Test #42 PASSED.
Test #43 PASSED.
Test #44 PASSED.
Test #45 PASSED.
Test #46 PASSED.
Test #47 PASSED.
Test #48 PASSED.
Test #49 PASSED.
Test #50 PASSED.
Test #51 PASSED.
Test #52 PASSED.
Test #53 PASSED.
Test #54 PASSED.
Test #55 PASSED.
Test #56 PASSED.
Test #57 PASSED.
Test #58 PASSED.
Test #59 PASSED.
Test #60 PASSED.
Test #61 PASSED.
Test #62 PASSED.
Test #63 PASSED.
Test #64 PASSED.
Test #65 PASSED.
Test #66 PASSED.
Test #67 PASSED.
Test #68 PASSED.
Test #69 PASSED.

Back to Back Test...
Error opening /tmp/scanftest.txt for write.

Testing fscanf()'s return-value,
conversions, and assignments...
Error opening /tmp/scanftest.txt for write.

Testing scanf()'s type-modifiers...
Test #1 PASSED.
Test #2 PASSED.
Test #3 PASSED.
Test #4 PASSED.
Test #5 PASSED.
Test #6 PASSED.
Test #7 PASSED.
Test #8 PASSED.
Test #9 PASSED.
Test #10 PASSED.
Test #11 PASSED.
Test #12 PASSED.
Test #13 PASSED.
nxtask_exit: scanftest pid=4,TCB=0x90000000980618c0
Test #14 PASSED.
Test #15 PASSED.
Test #16 PASSED.
Test #17 PASSED.
Test #18 PASSED.
Test #19 PASSED.
Test #20 PASSED.
Test #21 PASSED.
Test #22 PASSED.
Test #23 PASSED.
Test #24 PASSED.
Test #25 PASSED.
Scanf tests done... OK: 94, FAILED: 2

```

##### scanftest 启用配置：

在nuttx/boards/loongarch/ls2k0300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_LIBC\_SCANSET=y

CONFIG\_TESTING\_SCANFTEST=y

CONFIG\_LIBC\_FLOATINGPOINT=y



#### 1\.1\.8  Kernel\-C测试

##### 成功

指令：hello

日志：

```Plain Text
nsh> hello
task_spawn: name=hello entry=0x900000009802f9bc file_actions=0x90000000980546c8 attr=0x90000000980546d0 argv=0x9000000098054868
nxtask_activate: hello pid=4,TCB=0x90000000980575c0
nxtask_exit: hello pid=4,TCB=0x90000000980575c0
Hello, World!!

```

#### 1\.1\.9 Kernel\-Cxx测试

##### 成功

指令：helloxx

日志：

```YAML
nsh> helloxx
task_spawn: name=helloxx entry=0x900000009802fa24 file_actions=0x90000000980546c8 attr=0x90000000980546d0 argv=0x9000000098054868
nxtask_activate: helloxx pid=5,TCB=0x90000000980575c0
CHelloWorld: Constructor: mSecret=42
HelloWorld: HelloWorld: mSecret=42
CHelloWorld: Constructor: mSecret=42
HelloWorld: HelloWorld: mSecret=42
~CHelloWorld: Destructor
~CHelloWorld: Destructor
nxtask_exit: helloxx pid=5,TCB=0x90000000980575c0
helloxx_main: Saying hello from the dynamically constructed instance
CHelloWorld::HelloWorld: Hello, World!!
helloxx_main: Saying hello from the instance constructed on the stack
CHelloWorld::HelloWorld: Hello, World!!

```

#### 1\.1\.10 Kernel\-popen测试

##### 成功

指令：popen

日志：

```YAML
nsh> popen
task_spawn: name=popen entry=0x9000000098036774 file_actions=0x9000000098058df8 attr=0x9000000098058e00 argv=0x9000000098058fc8
nxtask_activate: popen pid=4,TCB=0x900000009805bd20
task_spawn: name=popen entry=0x90000000980369e8 file_actions=0x900000009805ca50 attr=0x900000009805ca80 argv=0x900000009805ca68
nxspawn_dup2: Dup'ing 3->1
spawn_execattrs: Setting policy=1 priority=100 for pid=5
nxtask_activate: popen pid=5,TCB=0x900000009805d470
nxtask_exit: popen pid=5,TCB=0x900000009805d470
Calling popen("help")
help usage:  help [-v] [<cmd>]

    .           cmp         expr        mkfifo      set         uptime
    [           dirname     false       mkrd        sleep       usleep
    ?           date        fdinfo      mount       source      watch
    alias       dd          free        mv          test        xd
    unalias     df          help        pidof       time        wait
    basename    dmesg       hexdump     printf      true
    break       echo        kill        ps          truncate
    cat         env         pkill       pwd         uname
    cd          exec        ls          rm          umount
    cp          exit        mkdir       rmdinxtask_exit: popen pid=4,TCB=0x900000009805bd20
r       unset

Builtin Apps:
    reboot            nsh               ls_driver_test
    poweroff          sh                popen
End of data
Calling pclose()
The shell has already exited (and exit status is not available)

```

##### popen 启用配置：

在nuttx/boards/loongarch/ls2k0300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_PIPES=y

CONFIG\_SYSTEM\_POPEN=y

CONFIG\_EXAMPLES\_POPEN=y



#### 1\.1\.11 Kernel\-pipe测试

##### 成功

指令：pipe rm /var/testfifo\-1 rm /var/testfifo\-1

日志：

```YAML
nsh> pipe rm /var/testfifo-1 rm /var/testfifo-1
task_spawn: name=pipe entry=0x90000000980367ec file_actions=0x900000009805ae38 attr=0x900000009805ae40 argv=0x900000009805b008
nxtask_activate: pipe pid=4,TCB=0x900000009805dd60
nxtask_activate: pipe pid=5,TCB=0x900000009805f260
nx_pthread_exit: exit_value=0
pthread_completejoin: pid=5 exit_value=0
nxtask_exit: pipe pid=5,TCB=0x900000009805f260
pthread_destroyjoin: pjoin=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
nxtask_activate: pipe pid=6,TCB=0x900000009805f260

pipe_main: Performing FIFO test
open_write_onxtask_activate: pipe pid=7,TCB=0x900000009805fc50
nly: Opening FIFO for write access
open_write_only: Waiting for open_write_only thread
pipe_main: open_write_only returned 0
transfer_testnx_pthread_exit: exit_value=0
pthread_completejoin: pid=7 exit_value=0
nxtask_exit: pipe pid=7,TCB=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
: fdin=4 fdout=3
transfer_test: Stnx_pthread_exit: exit_value=0
pthread_completejoin: pid=6 exit_value=0
nxtask_exit: pipe pid=6,TCB=0x900000009805f260
arting transfer_reader thread
transfer_test: Starting transfer_writer thread
transfer_readerpthread_destroyjoin: pjoin=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
: started
transfer_test: Waiting for transfer_writer thread
transfer_writer: started
transfer_writer: 18200 bytes written
transfer_reader: 18200 bytes read
transfer_test: transfer_writer returned 0
transfer_nxtask_activate: pipe pid=8,TCB=0x900000009805f260
test: Waiting for transfer_reader thread
transfer_test: transfer_reader rnxtask_activate: pipe pid=9,TCB=0x900000009805fc50
eturned 0
transfer_test: returning 0
transfer_test: fdin=4 fdout=3
transfer_test: Boost priority of transfer_readerthread tnx_pthread_exit: exit_value=0
pthread_completejoin: pid=8 exit_value=0
nxtask_exit: pipe pid=8,TCB=0x900000009805f260
o 101
transfer_test: Stnx_pthread_exit: exit_value=0
pthread_completejoin: pid=9 exit_value=0
nxtask_exit: pipe pid=9,TCB=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
arting transfer_reader thread
transfer_reader: started
transfer_test: Starting transfer_writpthread_destroyjoin: pjoin=0x90000000980605e0
pthread_join: Returning 0, exit_value 0
er thread
transfer_test: Waiting for transfer_writer thread
transfer_writer: started
transfer_reader: 18200 bytes read
transfer_writer: 18200 bytenxtask_activate: pipe pid=10,TCB=0x900000009805f260
s written
transfer_test: transfer_writer returned 0
transfer_test: Waiting for transfer_reader thread
transfer_test: transfer_reader rnxtask_activate: pipe pid=11,TCB=0x900000009805fc50
eturned 0
transfer_test: returning 0
transfer_test: fdin=4 fdout=3
transfer_test: Starting transfer_reader threanx_pthread_exit: exit_value=0
pthread_completejoin: pid=11 exit_value=0
nxtask_exit: pipe pid=11,TCB=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
d
transfer_test: Boost priority ofnx_pthread_exit: exit_value=0
pthread_completejoin: pid=10 exit_value=0
nxtask_exit: pipe pid=10,TCB=0x900000009805f260
 transfer_writerthread to 101
transfer_reader: started
transfer_test: Starting transfer_writpthread_destroyjoin: pjoin=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
er thread
transfer_writer: started
transfer_test: Waiting for transfer_writer thread
transfer_writer: 18200 bytes written
transfer_reader: 18200 bytes read
transfer_test: transfer_writer returned 0
transfer_nxtask_activate: pipe pid=12,TCB=0x900000009805f260
test: Waiting for transfer_reader thread
transfer_test: transfer_reader returned 0
transfer_test: returning 0
transfer_test: fdin=4 fdnxtask_activate: pipe pid=13,TCB=0x900000009805fc50
out=3
transfer_test: Boost priority of transfer_readerthread to 101
transfer_test: Starting transfer_reader threanx_pthread_exit: exit_value=0
pthread_completejoin: pid=13 exit_value=0
nxtask_exit: pipe pid=13,TCB=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
d
transfer_reader: started
transfnx_pthread_exit: exit_value=0
pthread_completejoin: pid=12 exit_value=0
nxtask_exit: pipe pid=12,TCB=0x900000009805f260
er_test: Boost priority of transfer_writerthread to 101
transfer_test: Starting transfer_writpthread_destroyjoin: pjoin=0x900000009805fc50
pthread_join: Returning 0, exit_value 0
er thread
transfer_writer: started
transfer_test: Waiting for transfer_writer thread
transfer_writer: 18200 bytes written
transfer_reader: 18200 bytes read
nxtask_activate: pipe pid=14,TCB=0x900000009805f260
transfer_test: transfer_writer returned 0
transfer_test: Waiting for transfer_reader thread
transfer_test: transfer_reader returned 0
transfer_test: returning 0

pipe_main: Performing pipe interlock test
interlock_test: Starting null_writer thread
interlock_test: Opening FIFO for read access
null_writer: started -- sleeping
null_writer: Opening FIFO for write access
null_writer: Opened /var/testfifo-2 for writing -- sleeping
interlock_test: Reading from /var/testfifo-2
null_writer: Closing /var/testfifo-2
interlock_test: read returned
interlock_test: Closing /var/testfifo-2
interlock_test: Waiting for null_writer thread
nunx_pthread_exit: exit_value=0
pthread_completejoin: pid=14 exit_value=0
nxtask_exit: pipe pid=14,TCB=0x900000009805f260
pthread_join: Returning 0, exit_value 0
nxtask_activate: pipe pid=15,TCB=0x900000009805f260
ll_writer: Returning success
interlock_test: writer returned 0
interlock_test: Starting null_reader thread
interlock_test: Opening FIFO for write access
null_reader: started -- sleeping
null_reader: Opening FIFO for read access
null_reader: Opened /var/testfifo-2 for reading -- sleeping
interlock_test: Writing to /var/testfifo-2
interlock_test: Wrote 16 bytes of data
interlock_test: write returned
interlock_test: Closing /var/testfifo-2
interlock_test: Waiting for null_reader thread
null_reader: Closing /var/testfifo-2
nunx_pthread_exit: exit_value=0
pthread_completejoin: pid=15 exit_value=0
nxtask_exit: pipe pid=15,TCB=0x900000009805f260
pthread_join: Returning 0, exit_value 0
ll_reader: Returning nxtask_activate: pipe pid=21,TCB=0x900000009805f300
success
interlock_test: reader returned 0
intenxtask_activate: pipe pid=22,TCB=0x900000009805fc90
rlock_test: Returning 0
pipe_main: FIFO interlock test PASSED
pipe_main: FIFO test PASSED

pipe_main: Performing pipe test
transfer_testnx_pthread_exit: exit_value=0
pthread_completejoin: pid=22 exit_value=0
nxtask_exit: pipe pid=22,TCB=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
: fdin=4 fdout=3
transfer_test: Stnx_pthread_exit: exit_value=0
pthread_completejoin: pid=21 exit_value=0
nxtask_exit: pipe pid=21,TCB=0x900000009805f300
arting transfer_reader thread
transfer_test: Starting transfer_writer thread
transfer_readerpthread_destroyjoin: pjoin=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
: started
transfer_test: Waiting for transfer_writer thread
transfer_writer: started
transfer_writer: 18200 bytes written
transfer_reader: 18200 bytes read
transfer_test: transfer_writer returned 0
transfer_nxtask_activate: pipe pid=23,TCB=0x900000009805f300
test: Waiting for transfer_reader thread
transfer_test: transfer_reader rnxtask_activate: pipe pid=24,TCB=0x900000009805fc90
eturned 0
transfer_test: returning 0
transfer_test: fdin=4 fdout=3
transfer_test: Boost priority of transfer_readerthread tnx_pthread_exit: exit_value=0
pthread_completejoin: pid=23 exit_value=0
nxtask_exit: pipe pid=23,TCB=0x900000009805f300
o 101
transfer_test: Stnx_pthread_exit: exit_value=0
pthread_completejoin: pid=24 exit_value=0
nxtask_exit: pipe pid=24,TCB=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
arting transfer_reader thread
transfer_reader: started
transfer_test: Starting transfer_writpthread_destroyjoin: pjoin=0x9000000098060620
pthread_join: Returning 0, exit_value 0
er thread
transfer_test: Waiting for transfer_writer thread
transfer_writer: started
transfer_reader: 18200 bytes read
transfer_writer: 18200 bytenxtask_activate: pipe pid=25,TCB=0x900000009805f300
s written
transfer_test: transfer_writer returned 0
transfer_test: Waiting for transfer_reader thread
transfer_test: transfer_reader rnxtask_activate: pipe pid=26,TCB=0x900000009805fc90
eturned 0
transfer_test: returning 0
transfer_test: fdin=4 fdout=3
transfer_test: Starting transfer_reader threanx_pthread_exit: exit_value=0
pthread_completejoin: pid=26 exit_value=0
nxtask_exit: pipe pid=26,TCB=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
d
transfer_test: Boost priority ofnx_pthread_exit: exit_value=0
pthread_completejoin: pid=25 exit_value=0
nxtask_exit: pipe pid=25,TCB=0x900000009805f300
 transfer_writerthread to 101
transfer_reader: started
transfer_test: Starting transfer_writpthread_destroyjoin: pjoin=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
er thread
transfer_writer: started
transfer_test: Waiting for transfer_writer thread
transfer_writer: 18200 bytes written
transfer_reader: 18200 bytes read
transfer_test: transfer_writer returned 0
transfer_nxtask_activate: pipe pid=27,TCB=0x900000009805f300
test: Waiting for transfer_reader thread
transfer_test: transfer_reader returned 0
transfer_test: returning 0
transfer_test: fdin=4 fdnxtask_activate: pipe pid=28,TCB=0x900000009805fc90
out=3
transfer_test: Boost priority of transfer_readerthread to 101
transfer_test: Starting transfer_reader threanx_pthread_exit: exit_value=0
pthread_completejoin: pid=28 exit_value=0
nxtask_exit: pipe pid=28,TCB=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
d
transfer_reader: started
transfnx_pthread_exit: exit_value=0
pthread_completejoin: pid=27 exit_value=0
nxtask_exit: pipe pid=27,TCB=0x900000009805f300
er_test: Boost priority of transfer_writerthread to 101
transfer_test: Starting transfer_writpthread_destroyjoin: pjoin=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
er thread
transfer_writer: started
transfer_test: Waiting for transfer_writer thread
transfer_writer: 18200 bytes written
transfer_reader: 18200 bytes read
transfer_tenxtask_activate: pipe pid=29,TCB=0x900000009805f300
st: transfer_writer returned 0
transfer_test: Waiting for nxtask_activate: pipe pid=30,TCB=0x900000009805fc90
transfer_reader thread
transfer_test: transfer_reader returned 0
transfer_test: returning 0

pipe_main: Performing redirection test
redirection_test: Starting redirect_writer task with fd=3
redirection_test: Starting redirect_reader task with fd=4
redirect_writer: started with fdout=3
redirection_test: Waiting for null_reader thread
redirect_reader: started with fdin=4

Four score and seven years ago our fathers broughtforth on this continent a new nation,
conceived in Liberty, and dedicated to the propositionthat all men are created equal.

Now we are engaged in a great civil war, testingwhether that nation, or any nation, so
conceived and so dedicated, can long enx_pthread_exit: exit_value=0
pthread_completejoin: pid=29 exit_value=0
nxtask_exit: pipe pid=29,TCB=0x900000009805f300
ndure. We are meton a great battle-field of that war.
We have come to dedicate a portion of that field, as afinal resting place for those who hredirect_writer: 1456 bytes written
ere
gave their lives that that nationredirect_writer: Returning success
 might live. It isaltogether fitting and proper that we
should do this.

But, in a larger sense, we can not dedicate - we cannot consecrate - we can not hallow - this ground.
The brave men, living and dead, who struggled here, haveconsecrated it, far above our poor power
to add or detract. The world will little note, nor longremember what we say here, but it can
never forget what they did here. It is for us theliving, rather, to be dedicated here to the
unfinished work which they who fought here have thus farso nobly advanced. It is rather for us to
be here dedicated to the great task remaining before us- that from these honored dead we take
increased devotion to that cause for which they gave thelast full measure of devotion - that we
here highly resolve that these dead shall not hanx_pthread_exit: exit_value=0
pthread_completejoin: pid=30 exit_value=0
nxtask_exit: pipe pid=30,TCB=0x900000009805fc90
pthread_join: Returning 0, exit_value 0
ve diedin vain - that this nation, under God,
shall have a new birth of freedom - and that governmentof the people, by the people,nxtask_exit: pipe pid=4,TCB=0x900000009805dd60
 for the
people, shall not perish from the earth.

redirect_reader: 1456 bytes read
redirect_reader: Returning success
redirection_test: Waiting...
redirection_test: returning 0
pipe_main: PIPE redirection test PASSED
pipe_main: PIPE test PASSED
```

#### 1\.1\.12 Kernel\-md5值测试

##### 失败：无法启用示例，没有md5\_test指令，也没有/etc/1\.txt，按下面启动后也只能用cmocka\_hash进行md5测试，但是失败

指令：md5\_test \-f /etc/1\.txt \-c 100

日志：

```Plain Text
nsh> cmocka_hash
nxtask_activate: cmocka_hash pid=6,TCB=0x90000000980709e0
[==========] hash_tests: Running 4 test(s).
[ RUN      ] test_hash_md5
[  ERROR   ] --- 1 != 0
[   LINE   ] --- ../../apps/testing/drivers/crypto/hash.c:377: error: Failure!
[  FAILED  ] test_hash_md5
[ RUN      ] test_hash_sha1

```

##### md5 启用配置：

在nuttx/boards/loongarch/ls2k0300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_TESTS\_TESTCASES=y

CONFIG\_FS\_TEST=y

CONFIG\_FS\_TEST\_EDONLY=y

CONFIG\_NETUTILS\_CODECS=y

CONFIG\_CODECS\_HASH\_MD5=y

CONFIG\_ALLOW\_MIT\_COMPONENTS=y

CONFIG\_LIBC\_EXECFUNCS=y

CONFIG\_LIBC\_REGEX=y

CONFIG\_TESTING\_CMOCKA=y

CONFIG\_TESTING\_CRYPTO=y

CONFIG\_TESTING\_CRYPTO\_HASH=y



#### 1\.1\.13 Kernel\-C\+\+功能测试

##### 成功

指令：cxxtest

日志：

```YAML
nsh> cxxtest
task_spawn: name=cxxtest entry=0x900000009803baf4 file_actions=0x9000000098075748 attr=0x9000000098075750 argv=0x90000000980758e8
nxtask_activate: cxxtest pid=4,TCB=0x9000000098078b00
pthread_mutex_timedlock: mutex=0x900000009806c4b8
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x900000009806c4b8
pthread_mutex_unlock: Returning 0
pthread_mutex_timedlock: mutex=0x900000009806c4b8
pthread_mutex_timedlock: Returning 0
pthread_mutex_unlock: mutex=0x900000009806c4b8
pthread_mutex_unlock: Returning 0
Test std::vector =============================
v1=1 2 3
s1=Hello, World!
nxtask_exit: cxxtest pid=4,TCB=0x9000000098078b00
Hello World Good Luck
Test std::map ===============================
Test C++17 features ==========================
File /proc/meminfo exists!
File /invalid does not exist!
File /proc/version exists!
Test RTTI =============================
extend

```

##### cxxtest 启用配置：

在nuttx/boards/loongarch/ls2k0300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_HAVE\_CXX=y

CONFIG\_LIBCXX=y

CONFIG\_TLS\_NELEM=4

CONFIG\_TLS\_TASK\_NELEM=4

CONFIG\_CXX\_STANDARD="gnu\+\+17"

CONFIG\_TESTING\_CXXTEST=y

CONFIG\_CXX\_RTTI=y

CONFIG\_HAVE\_CXX=y

CONFIG\_EXAMPLES\_HELLOXX=y

CONFIG\_TESTING\_CXXTEST=y



## 1\.2  系统应用

#### 1\.2\.1 Reboot启动异常测试

##### 成功

指令：reboot

日志：

```YAML
nsh> reboot
task_spawn: name=reboot entry=0x900000009802f8c0 file_actions=0x9000000098054288 attr=0x9000000098054290 argv=0x9000000098054428
nxtask_activate: reboot pid=4,TCB=0x9000000098057180
[2036-02-06 06:28:17] CMD: reboot, UID: 0, RESULT: STARTING
LoongArch Initializing ...

RAM(Cache AS RAM) Initializing ...

Lock Scache Done.

Copy spl code to locked scache...

Jump to board_init_f...

 _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \
 |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ |
 |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ /

============ddr4 init and training done!========
Trying to boot from BootSpace

U-boot start ...

Jump to board_init_f...


```

#### 1\.2\.2 Cold boot启动异常测试

##### 成功

指令：按下reset按钮

日志：

```Plain Text
nsh>
LoongArch Initializing ...

RAM(Cache AS RAM) Initializing ...

Lock Scache Done.

Copy spl code to locked scache...

Jump to board_init_f...

 _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \
 |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ |
 |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ /

============ddr4 init and training done!========
Trying to boot from BootSpace

U-boot start ...

Jump to board_init_f...


```

#### 1\.2\.3 系统RAM资源占用统计

##### 成功

指令：free

日志：

```Plain Text
NuttShell (NSH)
nsh> free
      total       used       free    maxused    maxfree  nused  nfree name
     184088      21240     162848      21920     162848    151      1 Umem

```

#### 1\.2\.4 系统Flash资源占用统计

##### 成功

指令：df \-h

日志：

```Plain Text
nsh> df -h
  Filesystem      Size      Used  Available Mounted on
  procfs            0B        0B         0B /proc
  littlefs          1M        8K      1016K /spiflash
```



## 1\.3 驱动BSP

#### 1\.3\.1 烧写测试

##### 成功

指令：无



#### 1\.3\.2 RAM读写测试

##### 成功

指令：fstest \-n 10 \-m /tmp

日志：

```YAML
nsh> fstest -n 10 -m /tmp
task_spawn: name=fstest entry=0x9000000098034770 file_actions=0x900000009805c668 attr=0x900000009805c670 argv=0x900000009805c808
nxtask_activate: fstest pid=4,TCB=0x900000009805f5d0

=== FILLING 1 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/0D0n02abqCAsIHyQ
  File size: 759
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 1 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 2 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/blMlLLxp6Ct
  File size: 1344
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 2 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 3 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/JhXIeEOXnOeCztYtKn
  File size: 7121
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 3 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 4 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/5B2D30Wy4C
  File size: 2376
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 4 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 5 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/G5ZeLOykX67LP
  File size: 3640
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 5 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 6 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/sfMduTDfHeAQ0LVJIrvAvfn
  File size: 270
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 6 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 7 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/Y11xRSDwbW
  File size: 2994
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 7 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 8 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/FdyXj1zAk52tFSgykIE6bS1m
  File size: 7767
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 8 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 9 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/h2cHoKa
  File size: 5129
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 9 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

=== FILLING 10 =============================
ERROR: Failed to open file for writing: 2
  File name: /tmp/R6AxTloITXF9KhP9ShqhKx
  File size: 7275
Filled file system
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0

=== DELETING 10 ============================
Deleted some files
  Number of files: 0
  Number deleted:  0
Directory:
Total file size: 0
File System:
  Block Size:      0
  No. Blocks:      0
  Free Blocks:     0
  Avail. Blocks:   0
  No. File Nodes:  0
  Free File Nodes: 0

End of loop memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ======== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0

Final memory usage:
VARIABLE  BEFORE   AFTER    DELTA
======== ===nxtask_exit: fstest pid=4,TCB=0x900000009805f5d0
===== ======== ========
arena       24b38    24b38        0
ordblks         1        1        0
mxordblk    18df0    18df0        0
uordblks     bd48     bd48        0
fordblks    18df0    18df0        0
File system tests done... OK: 20, FAILED: 0

```

##### fstest 启用配置：

在nuttx/boards/loongarch/ls2k300/hummingbird\-ls2k300/configs/nsh/defconfig中添加：

CONFIG\_FS\_TMPFS=y

CONFIG\_TESTING\_FSTEST=y

CONFIG\_TESTING\_FSTEST\_MOUNTPT="/tmp"

然后在根目录创建/tmp目录：mkdir /tmp

再运行fstest测试



#### 1\.3\.3 RAM读写性能测试

##### 成功

指令：在nsh中输入 free，获取系统当前最大空闲内存块\(largest\)的size 2、在nsh中输入 ramtest \-w \-s \<内存块大小\>，等待执行结果

日志：

```YAML
nsh> ramtest -w -s 123000
task_spawn: name=ramtest entry=0x9000000098030c9c file_actions=0x90000000980572a8 attr=0x90000000980572b0 argv=0x9000000098057448
nxtask_activate: ramtest pid=9,TCB=0x900000009805a2f0
RAMTest: Marching ones: 9000000098061250 123000
RAMTest: Marching zeroes: 9000000098061250 123000
RAMTest: Pnxtask_exit: ramtest pid=9,TCB=0x900000009805a2f0
attern test: 9000000098061250 123000 55555555 aaaaaaaa
RAMTest: Pattern test: 9000000098061250 123000 66666666 99999999
RAMTest: Pattern test: 9000000098061250 123000 33333333 cccccccc
RAMTest: Address-in-address test: 9000000098061250 123000

```

#### 1\.3\.4 RAM随机读写测试

##### 失败：mkrd 需要内核权限，一直失败

失败日志：

```Plain Text
nsh> mkrd -m 1 1024
nsh: mkrd: boardctl(BOARDIOC_MKRD) failed: Operation not permitted

```

指令：

```Plain Text
mkrd 1024
  mkfatfs /dev/ram0
  mount -t vfat /dev/ram0 /tmp
  fstest
```

##### mkrd 启用配置：

在nuttx/boards/loongarch/ls2k0300/hummingbird\-ls2k0300/configs/nsh/defconfig中添加：

CONFIG\_TESTING\_CMOCKA=y

CONFIG\_TESTING\_DRIVER\_TEST=y

CONFIG\_TESTING\_DRIVER\_TEST\_STACKSIZE=8192

CONFIG\_BCH=y

CONFIG\_FS\_FAT=y

CONFIG\_FS\_TMPFS=y

CONFIG\_TESTING\_FSTEST=y

CONFIG\_TESTING\_FSTEST\_MOUNTPT="/tmp"



#### 1\.3\.5 Flash功能测试

##### 成功

指令：

日志：向flash写入文件

```Shell
nsh> echo "123" >> /spiflash/test.txt
nsh> cat /spiflash/test.txt
hello
123
```

#### 1\.3\.6 GPIO功能测试

##### 成功

指令：ls\_driver\_test led

日志：同时伴随板子上的led闪烁

```Java
nsh> ls_driver_test led
task_spawn: name=ls_driver_test entry=0x900000009803c238 file_actions=0x9000000098071f08 attr=0x9000000098071f10 argv=0x90000000980720a8
nxtask_activate: ls_driver_test pid=5,TCB=0x90000000980752c0
=== LS2K300 Driver Test ===

[LED] Testing 2 LEDs (active-low)...
[LED] Setting up GPIO72...
[LED] Pinctrl: GPIO72 set to GPIO function
[LED] Setting up GPIO73...
[LED] Pinctrl: GPIO73 set to GPIO function
[LED] Blinking all 2 LEDs 3 times (low=ON, high=OFF)...
[LED] LED ON (GPIO72=LOW)
[LED] LED ON (GPIO73=LOW)
[LED] LED OFF (GPIO72=HIGH)
[LED] LED OFF (GPIO73=HIGH)
[LED] LED ON (GPIO72=LOW)
[LED] LED ON (GPIO73=LOW)
[LED] LED OFF (GPIO72=HIGH)
[LED] LED OFF (GPIO73=HIGH)
[LED] LED ON (GPIO72=LOW)
[LED] LED ON (GPIO73=LOW)
[LED] LED OFF (GPIO72=HIGH)
[LED] LED OFF (GPIO73=HIGH)
[Lnxtask_exit: ls_driver_test pid=5,TCB=0x90000000980752c0
ED] LED left OFF (GPIO72=HIGH)
[LED] LED left OFF (GPIO73=HIGH)
[LED] Done.

=== LS2K300 Driver Test Complete ===

```

#### 1\.3\.7 i2c功能测试

##### 成功

指令：ls\_driver\_test oled

日志：oled会显示，该oled为硬件i2c

```YAML
nsh> ls_driver_test oled
task_spawn: name=ls_driver_test entry=0x900000009803c238 file_actions=0x9000000098071f08 attr=0x9000000098071f10 argv=0x90000000980720a8
nxtask_activate: ls_driver_test pid=6,TCB=0x90000000980752c0
=== LS2K300 Driver Test ===

[OLED] === SSD1306 OLED Test Start ===
[OLED] Target: I2C1 addr=0x3c SCL=GPIO50 SDA=GPIO51
[OLED] Step 1: Configure pinctrl...
[OLED] Opening /dev/pinctrl0...
[OLED] pinctrl0 opened, fd=3
[OLED] Setting GPIO50 to function 3...
[OLED] GPIO50 set OK
[OLED] Setting GPIO51 to function 3...
[OLED] GPIO51 set OK
[OLED] Pinctrl: GPIO50/GPIO51 set to I2C1 MAIN function
[OLED] Step 2: Open I2C1 device...
[OLED] I2C1 opened: /dev/i2c1 fd=3
[OLED] Step 3: Scanning I2C bus...
[OLED] Scanning I2C1 bus (0x03 - 0x77)...
[OLED]   Found device at 0x23
[OLED]   Found device at 0x38
[OLED]   Found device at 0x3c
[OLED]   Found device at 0x50
[OLED]   4 device(s) found
[OLED] Step 4: Initializing OLED...
[OLED] SSD1306 initialized
[OLED] Display test text written
[Onxtask_exit: ls_driver_test pid=6,TCB=0x90000000980752c0
LED] Done.

=== LS2K300 Driver Test Complete ===

```

#### 1\.3\.8 spi功能测试

##### 成功

指令：ls\_driver\_test adc

日志：板子通过spi2读取MCP3204芯片采集到的adc值并打印，转动电位器可以观测到电压值改变

```YAML
nsh> ls_driver_test adc
task_spawn: name=ls_driver_test entry=0x900000009803c238 file_actions=0x9000000098071f08 attr=0x9000000098071f10 argv=0x90000000980720a8
nxtask_activate: ls_driver_test pid=7,TCB=0x90000000980752c0
=== LS2K300 Driver Test ===

[ADC] === MCP3204 ADC CH0 Test ===
[ADC] MCP3204 hardware SPI2 init
[ADC] SPI2 init done, Vref=3300 mV
[ADC]   1: CH0 raw=2727 voltage=2.198 V
[ADC]   2: CH0 raw=2727 voltage=2.198 V
[ADC]   3: CH0 raw=2727 voltage=2.198 V
[ADC]   4: CH0 raw=2727 voltage=2.198 V
[ADC]   5: CH0 raw=2727 voltage=2.198 V
[ADC]   6: CH0 raw=2727 voltage=2.198 V
[ADC]   7: CH0 raw=2727 voltage=2.198 V
[ADC]   8: CH0 raw=2727 voltage=2.198 V
[ADC]   9: CH0 raw=2727 voltage=2.198 V
[ADC]  10: CH0 raw=2727 voltage=2.198 V
[ADC]  11: CH0 raw=2727 voltage=2.198 V
[ADC]  12: CH0 raw=2727 voltage=2.198 V
[ADC]  13: CH0 raw=2727 voltage=2.198 V
[ADC]  14: CH0 raw=2727 voltage=2.198 V
[ADC]  15: CH0 raw=2727 voltage=2.198 V
[ADC]  16: CH0 raw=2726 voltage=2.197 V
[ADC]  17: CH0 raw=2727 voltage=2.198 V
[ADC]  18: CH0 raw=2727 voltage=2.198 V
[ADC]  19: CH0 raw=2726 voltage=2.197 V
[ADC]  20: CH0 raw=2726 voltage=2.197 V
[ADC]  21: CH0 raw=2727 voltage=2.198 V
[ADC]  22: CH0 raw=2727 voltage=2.198 V
[ADC]  23: CH0 raw=2727 voltage=2.198 V
[ADC]  24: CH0 raw=2727 voltage=2.198 V
[ADC]  25: CH0 raw=2727 voltage=2.198 V
[ADC]  26: CH0 raw=2727 voltage=2.198 V
[ADC]  27: CH0 raw=2727 voltage=2.198 V
[ADC]  28: CH0 raw=2727 voltage=2.198 V
[ADC]  29: CH0 raw=2726 voltage=2.197 V
[ADC]  30: CH0 raw=2727 voltage=2.198 V
[Anxtask_exit: ls_driver_test pid=7,TCB=0x90000000980752c0
DC] Done.
=== LS2K300 Driver Test Complete ===

```

#### 1\.3\.9 Uart串口功能测试

##### 成功

指令：ls\_driver\_test uart2

日志：用电脑串口发送123

```Bash
nsh> ls_driver_test uart2
task_spawn: name=ls_driver_test entry=0x9000000098049654 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
nxtask_activate: ls_driver_test pid=10,TCB=0x900000009808eb20
=== LS2K0300 Driver Test ===

[UART2] === UART2 Byte Send/Receive Test ===
[UART2] Device: /dev/ttyS2
[UART2] Pins: GPIO44(TX) / GPIO45(RX), function 3
[UART2] KEY2 (GPIO86) -> exit
[UART2] Config: 8N1 @ 115200 baud

[UART2] Setting GPIO44(TX)/GPIO45(RX) to function 3...
[UART2] Pinmux OK (GPIO44/GPIO45 -> func 3)
[UART2] /dev/ttyS2 opened, fd=4
[UART2] termios configured (8N1 @ 115200)
[UART2] Sending banner (104 bytes)...
[UART2] Banner sent. Entering echo loop (send bytes to UART2).
[UART2] Press KEY2 (GPIO86) to exit.

[UART2] RX: 0x31 ('1')
[UART2] RX: 0x32 ('2')
[UART2] RX: 0x33 ('3')

```

#### 1\.3\.10 RTC时钟功能测试

##### 成功

指令：ls\_driver\_test rtc

日志：运行第一次设置时间，隔段时间后再运行，读取时间正确

```YAML
nsh> ls_driver_test rtc
task_spawn: name=ls_driver_test entry=0x9000000098049654 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
nxtask_activate: ls_driver_test pid=11,TCB=0x900000009808ec70
=== LS2K0300 Driver Test ===

[RTC] Testing RTC...
[RTC] Current RTC time: 1900-01-01 00:00:00
[RTC] Formatted time: 2036-02-06 06:28:16 Wednesday
[RTC] Setting time to 2025-01-01 12:00:00...
[RTC] Time set successfully
[Rnxtask_exit: ls_driver_test pid=11,TCB=0x900000009808ec70
TC] RTC time after 2s: 2025-01-01 12:00:02
[RTC] Time verification PASSED
[RTC] Done.

=== LS2K0300 Driver Test Complete ===
nsh> ls_driver_test rtc
task_spawn: name=ls_driver_test entry=0x9000000098049654 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
nxtask_activate: ls_driver_test pid=12,TCB=0x900000009808ec70
=== LS2K0300 Driver Test ===

[RTC] Testing RTC...
[RTC] Current RTC time: 2025-01-01 12:00:29
[RTC] Formatted time: 2025-01-01 12:00:29 Wednesday
[RTC] Setting time to 2025-01-01 12:00:00...
[RTC] Time set successfully
[Rnxtask_exit: ls_driver_test pid=12,TCB=0x900000009808ec70
TC] RTC time after 2s: 2025-01-01 12:00:02
[RTC] Time verification PASSED
[RTC] Done.

```

#### 1\.3\.11 Watchdog测试

##### 成功

指令：ls\_driver\_test watchdog

日志：

```Plain Text
nsh> ls_driver_test watchdog
task_spawn: name=ls_driver_test entry=0x9000000098049654 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
nxtask_activate: ls_driver_test pid=21,TCB=0x900000009808ec70
=== LS2K0300 Driver Test ===

[Watchdog] Testing watchdog timer...
[Watchdog] Set timeout to 5000 ms
[Watchdog] Watchdog started
[Watchdog] Keeping alive for 3 seconds...
[Watchdog] Keepalive 1
[Watchdog] Keepalive 2
[Wnxtask_exit: ls_driver_test pid=21,TCB=0x900000009808ec70
atchdog] Keepalive 3
[Watchdog] Watchdog stopped
[Watchdog] Done.

```

# 2 性能测试

## 2\.1 系统应用

#### 2\.1\.1 Cold Boot启动时间测试

##### 十次数据结果：

- 总耗时：14 s

- 平均耗时：1\.4 s/次

- 最短：1 s，共 6 次

- 最长：2 s，共 4 次

- 1 s 次数：第 1、5、6、8、9、10 次

- 2 s 次数：第 2、3、4、7 次

日志：

```YAML
[2026-09-18 16:29:26]  nsh> 
[2026-09-18 16:29:32]  LoongArch Initializing ...
[2026-09-18 16:29:32]  
[2026-09-18 16:29:32]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:29:32]  
[2026-09-18 16:29:32]  Lock Scache Done.
[2026-09-18 16:29:32]  
[2026-09-18 16:29:32]  Copy spl code to locked scache...
[2026-09-18 16:29:32]  
[2026-09-18 16:29:32]  Jump to board_init_f...
[2026-09-18 16:29:32]  
[2026-09-18 16:29:32]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:29:32]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:29:32]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:29:32]  
[2026-09-18 16:29:32]  ============ddr4 init and training done!========
[2026-09-18 16:29:33]  Trying to boot from BootSpace
[2026-09-18 16:29:33]  
[2026-09-18 16:29:33]  U-boot start ...
[2026-09-18 16:29:33]  
[2026-09-18 16:29:33]  Jump to board_init_f...
[2026-09-18 16:29:33]  
[2026-09-18 16:29:33]  
[2026-09-18 16:29:33]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:29:33]  
[2026-09-18 16:29:33]  CPU:   LA264
[2026-09-18 16:29:33]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:29:33]  Model: loongson-2k300
[2026-09-18 16:29:33]  Board: LS2K300-PAI
[2026-09-18 16:29:33]  DRAM:  512 MiB
[2026-09-18 16:29:33]  512 MiB
[2026-09-18 16:29:33]  
[2026-09-18 16:29:33]  Jump to board_init_r....
[2026-09-18 16:29:33]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:29:33]  WDT:   Not starting watchdog_d
[2026-09-18 16:29:33]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:29:33]  bdinfo is in spi-flash
[2026-09-18 16:29:33]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:29:33]  Loading Environment from SPIFlash... OK
[2026-09-18 16:29:33]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:29:33]  In:    serial 
[2026-09-18 16:29:33]  Out:   serial vidconsole 
[2026-09-18 16:29:33]  Err:   serial vidconsole 
[2026-09-18 16:29:33]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:29:33]  ************************** Notice **************************
[2026-09-18 16:29:33]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:29:33]  ************************************************************
[2026-09-18 16:29:33]  Autoboot in 0 seconds
[2026-09-18 16:29:33]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 16:29:33]  ## Starting application at 0x9000000098000000 ...
C} Entry
[2026-09-18 16:29:33]  uart_register: Registering /dev/console
[2026-09-18 16:29:33]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:29:33]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:29:33]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:29:33]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:29:33]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:29:33]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:29:33]  nx_start_application: Starting init thread
[2026-09-18 16:29:33]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:29:33]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: start
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:29:33]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:29:33]  ls2k0300_bringup: bringup: done
[2026-09-18 16:29:33]  
[2026-09-18 16:29:33]  NuttShell (NSH)
[2026-09-18 16:29:33]  nsh> 
[2026-09-18 16:29:45]  LoongArch Initializing ...
[2026-09-18 16:29:45]  
[2026-09-18 16:29:45]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:29:45]  
[2026-09-18 16:29:45]  Lock Scache Done.
[2026-09-18 16:29:45]  
[2026-09-18 16:29:45]  Copy spl code to locked scache...
[2026-09-18 16:29:45]  
[2026-09-18 16:29:45]  Jump to board_init_f...
[2026-09-18 16:29:45]  
[2026-09-18 16:29:45]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:29:45]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:29:45]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:29:45]  
[2026-09-18 16:29:45]  ============ddr4 init and training done!========
[2026-09-18 16:29:46]  Trying to boot from BootSpace
[2026-09-18 16:29:46]  
[2026-09-18 16:29:46]  U-boot start ...
[2026-09-18 16:29:46]  
[2026-09-18 16:29:46]  Jump to board_init_f...
[2026-09-18 16:29:46]  
[2026-09-18 16:29:46]  
[2026-09-18 16:29:46]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:29:46]  
[2026-09-18 16:29:46]  CPU:   LA264
[2026-09-18 16:29:46]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:29:46]  Model: loongson-2k300
[2026-09-18 16:29:46]  Board: LS2K300-PAI
[2026-09-18 16:29:46]  DRAM:  512 MiB
[2026-09-18 16:29:46]  512 MiB
[2026-09-18 16:29:46]  
[2026-09-18 16:29:46]  Jump to board_init_r....
[2026-09-18 16:29:46]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:29:46]  WDT:   Not starting watchdog_d
[2026-09-18 16:29:46]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:29:46]  bdinfo is in spi-flash
[2026-09-18 16:29:46]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:29:46]  Loading Environment from SPIFlash... OK
[2026-09-18 16:29:46]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:29:46]  In:    serial 
[2026-09-18 16:29:46]  Out:   serial vidconsole 
[2026-09-18 16:29:46]  Err:   serial vidconsole 
[2026-09-18 16:29:46]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:29:46]  ************************** Notice **************************
[2026-09-18 16:29:46]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:29:46]  ************************************************************
[2026-09-18 16:29:46]  Autoboot in 0 seconds
[2026-09-18 16:29:46]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 16:29:47]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:29:47]  uart_register: Registering /dev/console
[2026-09-18 16:29:47]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:29:47]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:29:47]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:29:47]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:29:47]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:29:47]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:29:47]  nx_start_application: Starting init thread
[2026-09-18 16:29:47]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:29:47]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: start
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:29:47]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:29:47]  ls2k0300_bringup: bringup: done
[2026-09-18 16:29:47]  
[2026-09-18 16:29:47]  NuttShell (NSH)
[2026-09-18 16:29:47]  nsh> 
[2026-09-18 16:29:50]  LoongArch Initializing ...
[2026-09-18 16:29:50]  
[2026-09-18 16:29:50]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:29:50]  
[2026-09-18 16:29:50]  Lock Scache Done.
[2026-09-18 16:29:50]  
[2026-09-18 16:29:50]  Copy spl code to locked scache...
[2026-09-18 16:29:50]  
[2026-09-18 16:29:50]  Jump to board_init_f...
[2026-09-18 16:29:50]  
[2026-09-18 16:29:50]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:29:50]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:29:50]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:29:50]  
[2026-09-18 16:29:50]  ============ddr4 init and training done!========
[2026-09-18 16:29:51]  Trying to boot from BootSpace
[2026-09-18 16:29:51]  
[2026-09-18 16:29:51]  U-boot start ...
[2026-09-18 16:29:51]  
[2026-09-18 16:29:51]  Jump to board_init_f...
[2026-09-18 16:29:51]  
[2026-09-18 16:29:51]  
[2026-09-18 16:29:51]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:29:51]  
[2026-09-18 16:29:51]  CPU:   LA264
[2026-09-18 16:29:51]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:29:51]  Model: loongson-2k300
[2026-09-18 16:29:51]  Board: LS2K300-PAI
[2026-09-18 16:29:51]  DRAM:  512 MiB
[2026-09-18 16:29:51]  512 MiB
[2026-09-18 16:29:51]  
[2026-09-18 16:29:51]  Jump to board_init_r....
[2026-09-18 16:29:51]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:29:51]  WDT:   Not starting watchdog_d
[2026-09-18 16:29:51]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:29:51]  bdinfo is in spi-flash
[2026-09-18 16:29:51]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:29:51]  Loading Environment from SPIFlash... OK
[2026-09-18 16:29:51]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:29:51]  In:    serial 
[2026-09-18 16:29:51]  Out:   serial vidconsole 
[2026-09-18 16:29:51]  Err:   serial vidconsole 
[2026-09-18 16:29:51]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:29:51]  ************************** Notice **************************
[2026-09-18 16:29:51]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:29:51]  ************************************************************
[2026-09-18 16:29:51]  Autoboot in 0 seconds
[2026-09-18 16:29:51]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 16:29:52]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:29:52]  uart_register: Registering /dev/console
[2026-09-18 16:29:52]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:29:52]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:29:52]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:29:52]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:29:52]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:29:52]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:29:52]  nx_start_application: Starting init thread
[2026-09-18 16:29:52]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:29:52]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: start
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:29:52]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:29:52]  ls2k0300_bringup: bringup: done
[2026-09-18 16:29:52]  
[2026-09-18 16:29:52]  NuttShell (NSH)
[2026-09-18 16:29:52]  nsh> 
[2026-09-18 16:29:54]  LoongArch Initializing ...
[2026-09-18 16:29:54]  
[2026-09-18 16:29:54]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:29:54]  
[2026-09-18 16:29:54]  Lock Scache Done.
[2026-09-18 16:29:54]  
[2026-09-18 16:29:54]  Copy spl code to locked scache...
[2026-09-18 16:29:54]  
[2026-09-18 16:29:54]  Jump to board_init_f...
[2026-09-18 16:29:54]  
[2026-09-18 16:29:54]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:29:54]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:29:54]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:29:54]  
[2026-09-18 16:29:54]  ============ddr4 init and training done!========
[2026-09-18 16:29:55]  Trying to boot from BootSpace
[2026-09-18 16:29:55]  
[2026-09-18 16:29:55]  U-boot start ...
[2026-09-18 16:29:55]  
[2026-09-18 16:29:55]  Jump to board_init_f...
[2026-09-18 16:29:55]  
[2026-09-18 16:29:55]  
[2026-09-18 16:29:55]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:29:55]  
[2026-09-18 16:29:55]  CPU:   LA264
[2026-09-18 16:29:55]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:29:55]  Model: loongson-2k300
[2026-09-18 16:29:55]  Board: LS2K300-PAI
[2026-09-18 16:29:55]  DRAM:  512 MiB
[2026-09-18 16:29:55]  512 MiB
[2026-09-18 16:29:55]  
[2026-09-18 16:29:55]  Jump to board_init_r....
[2026-09-18 16:29:55]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:29:55]  WDT:   Not starting watchdog_d
[2026-09-18 16:29:55]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:29:55]  bdinfo is in spi-flash
[2026-09-18 16:29:55]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:29:55]  Loading Environment from SPIFlash... OK
[2026-09-18 16:29:55]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:29:55]  In:    serial 
[2026-09-18 16:29:55]  Out:   serial vidconsole 
[2026-09-18 16:29:55]  Err:   serial vidconsole 
[2026-09-18 16:29:55]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:29:55]  ************************** Notice **************************
[2026-09-18 16:29:55]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:29:55]  ************************************************************
[2026-09-18 16:29:55]  Autoboot in 0 seconds
[2026-09-18 16:29:55]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 16:29:55]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:29:55]  uart_register: Registering /dev/console
[2026-09-18 16:29:55]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:29:55]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:29:55]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:29:55]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:29:55]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:29:55]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:29:55]  nx_start_application: Starting init thread
[2026-09-18 16:29:55]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:29:55]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: start
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:29:55]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:29:56]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:29:56]  ls2k0300_bringup: bringup: done
[2026-09-18 16:29:56]  
[2026-09-18 16:29:56]  NuttShell (NSH)
[2026-09-18 16:29:56]  nsh> 
[2026-09-18 16:30:00]  LoongArch Initializing ...
[2026-09-18 16:30:00]  
[2026-09-18 16:30:00]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:30:00]  
[2026-09-18 16:30:00]  Lock Scache Done.
[2026-09-18 16:30:00]  
[2026-09-18 16:30:00]  Copy spl code to locked scache...
[2026-09-18 16:30:00]  
[2026-09-18 16:30:00]  Jump to board_init_f...
[2026-09-18 16:30:00]  
[2026-09-18 16:30:00]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:30:00]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:30:00]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:30:00]  
[2026-09-18 16:30:00]  ============ddr4 init and training done!========
[2026-09-18 16:30:00]  Trying to boot from BootSpace
[2026-09-18 16:30:00]  
[2026-09-18 16:30:01]  U-boot start ...
[2026-09-18 16:30:01]  
[2026-09-18 16:30:01]  Jump to board_init_f...
[2026-09-18 16:30:01]  
[2026-09-18 16:30:01]  
[2026-09-18 16:30:01]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:30:01]  
[2026-09-18 16:30:01]  CPU:   LA264
[2026-09-18 16:30:01]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:30:01]  Model: loongson-2k300
[2026-09-18 16:30:01]  Board: LS2K300-PAI
[2026-09-18 16:30:01]  DRAM:  512 MiB
[2026-09-18 16:30:01]  512 MiB
[2026-09-18 16:30:01]  
[2026-09-18 16:30:01]  Jump to board_init_r....
[2026-09-18 16:30:01]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:30:01]  WDT:   Not starting watchdog_d
[2026-09-18 16:30:01]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:30:01]  bdinfo is in spi-flash
[2026-09-18 16:30:01]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:30:01]  Loading Environment from SPIFlash... OK
[2026-09-18 16:30:01]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:30:01]  In:    serial 
[2026-09-18 16:30:01]  Out:   serial vidconsole 
[2026-09-18 16:30:01]  Err:   serial vidconsole 
[2026-09-18 16:30:01]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:30:01]  ************************** Notice **************************
[2026-09-18 16:30:01]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:30:01]  ************************************************************
[2026-09-18 16:30:01]  Autoboot in 0 seconds
[2026-09-18 16:30:01]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 16:30:01]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:30:01]  uart_register: Registering /dev/console
[2026-09-18 16:30:01]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:30:01]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:30:01]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:30:01]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:30:01]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:30:01]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:30:01]  nx_start_application: Starting init thread
[2026-09-18 16:30:01]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:30:01]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: start
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:30:01]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:30:01]  ls2k0300_bringup: bringup: done
[2026-09-18 16:30:01]  
[2026-09-18 16:30:01]  NuttShell (NSH)
[2026-09-18 16:30:01]  nsh> 
[2026-09-18 16:30:03]  LoongArch Initializing ...
[2026-09-18 16:30:03]  
[2026-09-18 16:30:03]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:30:03]  
[2026-09-18 16:30:03]  Lock Scache Done.
[2026-09-18 16:30:03]  
[2026-09-18 16:30:03]  Copy spl code to locked scache...
[2026-09-18 16:30:03]  
[2026-09-18 16:30:03]  Jump to board_init_f...
[2026-09-18 16:30:03]  
[2026-09-18 16:30:03]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:30:03]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:30:03]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:30:03]  
[2026-09-18 16:30:03]  ============ddr4 init and training done!========
[2026-09-18 16:30:04]  Trying to boot from BootSpace
[2026-09-18 16:30:04]  
[2026-09-18 16:30:04]  U-boot start ...
[2026-09-18 16:30:04]  
[2026-09-18 16:30:04]  Jump to board_init_f...
[2026-09-18 16:30:04]  
[2026-09-18 16:30:04]  
[2026-09-18 16:30:04]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:30:04]  
[2026-09-18 16:30:04]  CPU:   LA264
[2026-09-18 16:30:04]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:30:04]  Model: loongson-2k300
[2026-09-18 16:30:04]  Board: LS2K300-PAI
[2026-09-18 16:30:04]  DRAM:  512 MiB
[2026-09-18 16:30:04]  512 MiB
[2026-09-18 16:30:04]  
[2026-09-18 16:30:04]  Jump to board_init_r....
[2026-09-18 16:30:04]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:30:04]  WDT:   Not starting watchdog_d
[2026-09-18 16:30:04]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:30:04]  bdinfo is in spi-flash
[2026-09-18 16:30:04]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:30:04]  Loading Environment from SPIFlash... OK
[2026-09-18 16:30:04]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:30:04]  In:    serial 
[2026-09-18 16:30:04]  Out:   serial vidconsole 
[2026-09-18 16:30:04]  Err:   serial vidconsole 
[2026-09-18 16:30:04]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:30:04]  ************************** Notice **************************
[2026-09-18 16:30:04]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:30:04]  ************************************************************
[2026-09-18 16:30:04]  Autoboot in 0 seconds
[2026-09-18 16:30:04]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 16:30:04]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:30:04]  uart_register: Registering /dev/console
[2026-09-18 16:30:04]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:30:04]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:30:04]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:30:04]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:30:04]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:30:04]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:30:04]  nx_start_application: Starting init thread
[2026-09-18 16:30:04]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:30:04]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: start
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:30:04]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:30:04]  ls2k0300_bringup: bringup: done
[2026-09-18 16:30:04]  
[2026-09-18 16:30:04]  NuttShell (NSH)
[2026-09-18 16:30:04]  nsh> 
[2026-09-18 16:30:06]  LoongArch Initializing ...
[2026-09-18 16:30:06]  
[2026-09-18 16:30:06]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:30:06]  
[2026-09-18 16:30:06]  Lock Scache Done.
[2026-09-18 16:30:06]  
[2026-09-18 16:30:06]  Copy spl code to locked scache...
[2026-09-18 16:30:06]  
[2026-09-18 16:30:06]  Jump to board_init_f...
[2026-09-18 16:30:06]  
[2026-09-18 16:30:06]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:30:06]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:30:06]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:30:06]  
[2026-09-18 16:30:06]  ============ddr4 init and training done!========
[2026-09-18 16:30:07]  Trying to boot from BootSpace
[2026-09-18 16:30:07]  
[2026-09-18 16:30:07]  U-boot start ...
[2026-09-18 16:30:07]  
[2026-09-18 16:30:07]  Jump to board_init_f...
[2026-09-18 16:30:07]  
[2026-09-18 16:30:07]  
[2026-09-18 16:30:07]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:30:07]  
[2026-09-18 16:30:07]  CPU:   LA264
[2026-09-18 16:30:07]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:30:07]  Model: loongson-2k300
[2026-09-18 16:30:07]  Board: LS2K300-PAI
[2026-09-18 16:30:07]  DRAM:  512 MiB
[2026-09-18 16:30:07]  512 MiB
[2026-09-18 16:30:07]  
[2026-09-18 16:30:07]  Jump to board_init_r....
[2026-09-18 16:30:07]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:30:07]  WDT:   Not starting watchdog_d
[2026-09-18 16:30:07]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:30:07]  bdinfo is in spi-flash
[2026-09-18 16:30:07]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:30:07]  Loading Environment from SPIFlash... OK
[2026-09-18 16:30:07]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:30:07]  In:    serial 
[2026-09-18 16:30:07]  Out:   serial vidconsole 
[2026-09-18 16:30:07]  Err:   serial vidconsole 
[2026-09-18 16:30:07]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:30:07]  ************************** Notice **************************
[2026-09-18 16:30:07]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:30:07]  ************************************************************
[2026-09-18 16:30:07]  Autoboot in 0 seconds
[2026-09-18 16:30:07]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 16:30:07]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:30:07]  uart_register: Registering /dev/console
[2026-09-18 16:30:07]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:30:07]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:30:07]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:30:07]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:30:07]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:30:07]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:30:07]  nx_start_application: Starting init thread
[2026-09-18 16:30:07]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:30:07]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: start
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:30:07]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:30:07]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:30:08]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:30:08]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:30:08]  ls2k0300_bringup: bringup: done
[2026-09-18 16:30:08]  
[2026-09-18 16:30:08]  NuttShell (NSH)
[2026-09-18 16:30:08]  nsh> 
[2026-09-18 16:30:10]  LoongArch Initializing ...
[2026-09-18 16:30:10]  
[2026-09-18 16:30:10]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:30:10]  
[2026-09-18 16:30:10]  Lock Scache Done.
[2026-09-18 16:30:10]  
[2026-09-18 16:30:10]  Copy spl code to locked scache...
[2026-09-18 16:30:10]  
[2026-09-18 16:30:10]  Jump to board_init_f...
[2026-09-18 16:30:10]  
[2026-09-18 16:30:10]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:30:10]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:30:10]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:30:10]  
[2026-09-18 16:30:10]  ============ddr4 init and training done!========
[2026-09-18 16:30:11]  Trying to boot from BootSpace
[2026-09-18 16:30:11]  
[2026-09-18 16:30:11]  U-boot start ...
[2026-09-18 16:30:11]  
[2026-09-18 16:30:11]  Jump to board_init_f...
[2026-09-18 16:30:11]  
[2026-09-18 16:30:11]  
[2026-09-18 16:30:11]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:30:11]  
[2026-09-18 16:30:11]  CPU:   LA264
[2026-09-18 16:30:11]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:30:11]  Model: loongson-2k300
[2026-09-18 16:30:11]  Board: LS2K300-PAI
[2026-09-18 16:30:11]  DRAM:  512 MiB
[2026-09-18 16:30:11]  512 MiB
[2026-09-18 16:30:11]  
[2026-09-18 16:30:11]  Jump to board_init_r....
[2026-09-18 16:30:11]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:30:11]  WDT:   Not starting watchdog_d
[2026-09-18 16:30:11]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:30:11]  bdinfo is in spi-flash
[2026-09-18 16:30:11]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:30:11]  Loading Environment from SPIFlash... OK
[2026-09-18 16:30:11]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:30:11]  In:    serial 
[2026-09-18 16:30:11]  Out:   serial vidconsole 
[2026-09-18 16:30:11]  Err:   serial vidconsole 
[2026-09-18 16:30:11]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:30:11]  ************************** Notice **************************
[2026-09-18 16:30:11]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:30:11]  ************************************************************
[2026-09-18 16:30:11]  Autoboot in 0 seconds
[2026-09-18 16:30:11]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 16:30:11]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:30:11]  uart_register: Registering /dev/console
[2026-09-18 16:30:11]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:30:11]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:30:11]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:30:11]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:30:11]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:30:11]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:30:11]  nx_start_application: Starting init thread
[2026-09-18 16:30:11]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:30:11]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: start
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:30:11]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:30:11]  ls2k0300_bringup: bringup: done
[2026-09-18 16:30:11]  
[2026-09-18 16:30:11]  NuttShell (NSH)
[2026-09-18 16:30:11]  nsh> 
[2026-09-18 16:30:14]  LoongArch Initializing ...
[2026-09-18 16:30:14]  
[2026-09-18 16:30:14]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:30:14]  
[2026-09-18 16:30:14]  Lock Scache Done.
[2026-09-18 16:30:14]  
[2026-09-18 16:30:14]  Copy spl code to locked scache...
[2026-09-18 16:30:14]  
[2026-09-18 16:30:14]  Jump to board_init_f...
[2026-09-18 16:30:14]  
[2026-09-18 16:30:14]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:30:14]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:30:14]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:30:14]  
[2026-09-18 16:30:14]  ============ddr4 init and training done!========
[2026-09-18 16:30:14]  Trying to boot from BootSpace
[2026-09-18 16:30:14]  
[2026-09-18 16:30:15]  U-boot start ...
[2026-09-18 16:30:15]  
[2026-09-18 16:30:15]  Jump to board_init_f...
[2026-09-18 16:30:15]  
[2026-09-18 16:30:15]  
[2026-09-18 16:30:15]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:30:15]  
[2026-09-18 16:30:15]  CPU:   LA264
[2026-09-18 16:30:15]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:30:15]  Model: loongson-2k300
[2026-09-18 16:30:15]  Board: LS2K300-PAI
[2026-09-18 16:30:15]  DRAM:  512 MiB
[2026-09-18 16:30:15]  512 MiB
[2026-09-18 16:30:15]  
[2026-09-18 16:30:15]  Jump to board_init_r....
[2026-09-18 16:30:15]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:30:15]  WDT:   Not starting watchdog_d
[2026-09-18 16:30:15]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:30:15]  bdinfo is in spi-flash
[2026-09-18 16:30:15]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:30:15]  Loading Environment from SPIFlash... OK
[2026-09-18 16:30:15]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:30:15]  In:    serial 
[2026-09-18 16:30:15]  Out:   serial vidconsole 
[2026-09-18 16:30:15]  Err:   serial vidconsole 
[2026-09-18 16:30:15]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:30:15]  ************************** Notice **************************
[2026-09-18 16:30:15]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:30:15]  ************************************************************
[2026-09-18 16:30:15]  Autoboot in 0 seconds
[2026-09-18 16:30:15]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 16:30:15]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:30:15]  uart_register: Registering /dev/console
[2026-09-18 16:30:15]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:30:15]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:30:15]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:30:15]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:30:15]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:30:15]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:30:15]  nx_start_application: Starting init thread
[2026-09-18 16:30:15]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:30:15]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: start
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:30:15]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:30:15]  ls2k0300_bringup: bringup: done
[2026-09-18 16:30:15]  
[2026-09-18 16:30:15]  NuttShell (NSH)
[2026-09-18 16:30:15]  nsh> 
[2026-09-18 16:30:19]  LoongArch Initializing ...
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  Lock Scache Done.
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  Copy spl code to locked scache...
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  Jump to board_init_f...
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 16:30:19]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 16:30:19]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  ============ddr4 init and training done!========
[2026-09-18 16:30:19]  Trying to boot from BootSpace
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  U-boot start ...
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  Jump to board_init_f...
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  CPU:   LA264
[2026-09-18 16:30:19]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 16:30:19]  Model: loongson-2k300
[2026-09-18 16:30:19]  Board: LS2K300-PAI
[2026-09-18 16:30:19]  DRAM:  512 MiB
[2026-09-18 16:30:19]  512 MiB
[2026-09-18 16:30:19]  
[2026-09-18 16:30:19]  Jump to board_init_r....
[2026-09-18 16:30:19]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 16:30:19]  WDT:   Not starting watchdog_d
[2026-09-18 16:30:19]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 16:30:20]  bdinfo is in spi-flash
[2026-09-18 16:30:20]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 16:30:20]  Loading Environment from SPIFlash... OK
[2026-09-18 16:30:20]  frame buffer addr: 0x900000000dc00000
[2026-09-18 16:30:20]  In:    serial 
[2026-09-18 16:30:20]  Out:   serial vidconsole 
[2026-09-18 16:30:20]  Err:   serial vidconsole 
[2026-09-18 16:30:20]  Net:   eth0: ethernet@0x16020000
[2026-09-18 16:30:20]  ************************** Notice **************************
[2026-09-18 16:30:20]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 16:30:20]  ************************************************************
[2026-09-18 16:30:20]  Autoboot in 0 seconds
[2026-09-18 16:30:20]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 16:30:20]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 16:30:20]  uart_register: Registering /dev/console
[2026-09-18 16:30:20]  uart_register: Registering /dev/ttyS0
[2026-09-18 16:30:20]  uart_register: Registering /dev/ttyS2
[2026-09-18 16:30:20]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 16:30:20]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 16:30:20]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 16:30:20]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 16:30:20]  nx_start_application: Starting init thread
[2026-09-18 16:30:20]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 16:30:20]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: start
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: ADC
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: WDT
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 16:30:20]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 16:30:20]  ls2k0300_bringup: bringup: done
[2026-09-18 16:30:20]  
[2026-09-18 16:30:20]  NuttShell (NSH)
[2026-09-18 16:30:20]  nsh> 
```

#### 2\.1\.2 Reboot启动时间测试

##### 十次数据结果：

- 总次数：10 次

- 总耗时：15 s

- 平均耗时：1\.5 s/次

- 最短：1 s，共 5 次

- 最长：2 s，共 5 次

- 1 s 的次数：第 2、3、4、5、10 次

- 2 s 的次数：第 1、6、7、8、9 次

日志：

```YAML
[2026-09-18 14:47:09]  nsh> reboot
[2026-09-18 14:47:09]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:47:09]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:47:09]  [2036-02-06 06:28:28] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:47:09]  LoongArch Initializing ...
[2026-09-18 14:47:09]  
[2026-09-18 14:47:09]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:47:09]  
[2026-09-18 14:47:09]  Lock Scache Done.
[2026-09-18 14:47:09]  
[2026-09-18 14:47:09]  Copy spl code to locked scache...
[2026-09-18 14:47:09]  
[2026-09-18 14:47:10]  Jump to board_init_f...
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:47:10]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:47:10]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]  ============ddr4 init and training done!========
[2026-09-18 14:47:10]  Trying to boot from BootSpace
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]  U-boot start ...
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]  Jump to board_init_f...
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]  CPU:   LA264
[2026-09-18 14:47:10]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:47:10]  Model: loongson-2k300
[2026-09-18 14:47:10]  Board: LS2K300-PAI
[2026-09-18 14:47:10]  DRAM:  512 MiB
[2026-09-18 14:47:10]  512 MiB
[2026-09-18 14:47:10]  
[2026-09-18 14:47:10]  Jump to board_init_r....
[2026-09-18 14:47:10]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:47:10]  WDT:   Not starting watchdog_d
[2026-09-18 14:47:10]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:47:10]  bdinfo is in spi-flash
[2026-09-18 14:47:10]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:47:10]  Loading Environment from SPIFlash... OK
[2026-09-18 14:47:10]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:47:10]  In:    serial 
[2026-09-18 14:47:10]  Out:   serial vidconsole 
[2026-09-18 14:47:10]  Err:   serial vidconsole 
[2026-09-18 14:47:10]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:47:10]  ************************** Notice **************************
[2026-09-18 14:47:10]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:47:10]  ************************************************************
[2026-09-18 14:47:10]  Autoboot in 0 seconds
[2026-09-18 14:47:10]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 14:47:11]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:47:11]  uart_register: Registering /dev/console
[2026-09-18 14:47:11]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:47:11]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:47:11]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:47:11]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:47:11]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:47:11]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:47:11]  nx_start_application: Starting init thread
[2026-09-18 14:47:11]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:47:11]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: start
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:47:11]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:47:11]  ls2k0300_bringup: bringup: done
[2026-09-18 14:47:11]  
[2026-09-18 14:47:11]  NuttShell (NSH)

[2026-09-18 14:56:57]  nsh> reboot
[2026-09-18 14:56:57]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:56:57]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:56:57]  [2036-02-06 06:28:17] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:56:57]  LoongArch Initializing ...
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  Lock Scache Done.
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  Copy spl code to locked scache...
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  Jump to board_init_f...
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:56:57]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:56:57]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  ============ddr4 init and training done!========
[2026-09-18 14:56:57]  Trying to boot from BootSpace
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  U-boot start ...
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  Jump to board_init_f...
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  CPU:   LA264
[2026-09-18 14:56:57]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:56:57]  Model: loongson-2k300
[2026-09-18 14:56:57]  Board: LS2K300-PAI
[2026-09-18 14:56:57]  DRAM:  512 MiB
[2026-09-18 14:56:57]  512 MiB
[2026-09-18 14:56:57]  
[2026-09-18 14:56:57]  Jump to board_init_r....
[2026-09-18 14:56:57]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:56:58]  WDT:   Not starting watchdog_d
[2026-09-18 14:56:58]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:56:58]  bdinfo is in spi-flash
[2026-09-18 14:56:58]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:56:58]  Loading Environment from SPIFlash... OK
[2026-09-18 14:56:58]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:56:58]  In:    serial 
[2026-09-18 14:56:58]  Out:   serial vidconsole 
[2026-09-18 14:56:58]  Err:   serial vidconsole 
[2026-09-18 14:56:58]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:56:58]  ************************** Notice **************************
[2026-09-18 14:56:58]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:56:58]  ************************************************************
[2026-09-18 14:56:58]  Autoboot in 0 seconds
[2026-09-18 14:56:58]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 14:56:58]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:56:58]  uart_register: Registering /dev/console
[2026-09-18 14:56:58]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:56:58]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:56:58]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:56:58]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:56:58]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:56:58]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:56:58]  nx_start_application: Starting init thread
[2026-09-18 14:56:58]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:56:58]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: start
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:56:58]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:56:58]  ls2k0300_bringup: bringup: done
[2026-09-18 14:56:58]  
[2026-09-18 14:56:58]  NuttShell (NSH)

[2026-09-18 14:57:01]  nsh> reboot
[2026-09-18 14:57:01]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:01]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:01]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:01]  LoongArch Initializing ...
[2026-09-18 14:57:01]  
[2026-09-18 14:57:01]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:01]  
[2026-09-18 14:57:01]  Lock Scache Done.
[2026-09-18 14:57:01]  
[2026-09-18 14:57:01]  Copy spl code to locked scache...
[2026-09-18 14:57:01]  
[2026-09-18 14:57:01]  Jump to board_init_f...
[2026-09-18 14:57:01]  
[2026-09-18 14:57:01]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:01]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:01]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:01]  
[2026-09-18 14:57:01]  ============ddr4 init and training done!========
[2026-09-18 14:57:01]  Trying to boot from BootSpace
[2026-09-18 14:57:01]  
[2026-09-18 14:57:02]  U-boot start ...
[2026-09-18 14:57:02]  
[2026-09-18 14:57:02]  Jump to board_init_f...
[2026-09-18 14:57:02]  
[2026-09-18 14:57:02]  
[2026-09-18 14:57:02]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:02]  
[2026-09-18 14:57:02]  CPU:   LA264
[2026-09-18 14:57:02]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:02]  Model: loongson-2k300
[2026-09-18 14:57:02]  Board: LS2K300-PAI
[2026-09-18 14:57:02]  DRAM:  512 MiB
[2026-09-18 14:57:02]  512 MiB
[2026-09-18 14:57:02]  
[2026-09-18 14:57:02]  Jump to board_init_r....
[2026-09-18 14:57:02]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:02]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:02]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:02]  bdinfo is in spi-flash
[2026-09-18 14:57:02]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:02]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:02]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:02]  In:    serial 
[2026-09-18 14:57:02]  Out:   serial vidconsole 
[2026-09-18 14:57:02]  Err:   serial vidconsole 
[2026-09-18 14:57:02]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:02]  ************************** Notice **************************
[2026-09-18 14:57:02]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:02]  ************************************************************
[2026-09-18 14:57:02]  Autoboot in 0 seconds
[2026-09-18 14:57:02]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 14:57:02]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:57:02]  uart_register: Registering /dev/console
[2026-09-18 14:57:02]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:02]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:02]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:02]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:02]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:02]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:02]  nx_start_application: Starting init thread
[2026-09-18 14:57:02]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:02]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:02]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:02]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:02]  
[2026-09-18 14:57:02]  NuttShell (NSH)

[2026-09-18 14:57:06]  nsh> reboot
[2026-09-18 14:57:06]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:06]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:06]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:06]  LoongArch Initializing ...
[2026-09-18 14:57:06]  
[2026-09-18 14:57:06]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:06]  
[2026-09-18 14:57:06]  Lock Scache Done.
[2026-09-18 14:57:06]  
[2026-09-18 14:57:06]  Copy spl code to locked scache...
[2026-09-18 14:57:06]  
[2026-09-18 14:57:06]  Jump to board_init_f...
[2026-09-18 14:57:06]  
[2026-09-18 14:57:06]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:06]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:06]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:06]  
[2026-09-18 14:57:06]  ============ddr4 init and training done!========
[2026-09-18 14:57:07]  Trying to boot from BootSpace
[2026-09-18 14:57:07]  
[2026-09-18 14:57:07]  U-boot start ...
[2026-09-18 14:57:07]  
[2026-09-18 14:57:07]  Jump to board_init_f...
[2026-09-18 14:57:07]  
[2026-09-18 14:57:07]  
[2026-09-18 14:57:07]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:07]  
[2026-09-18 14:57:07]  CPU:   LA264
[2026-09-18 14:57:07]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:07]  Model: loongson-2k300
[2026-09-18 14:57:07]  Board: LS2K300-PAI
[2026-09-18 14:57:07]  DRAM:  512 MiB
[2026-09-18 14:57:07]  512 MiB
[2026-09-18 14:57:07]  
[2026-09-18 14:57:07]  Jump to board_init_r....
[2026-09-18 14:57:07]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:07]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:07]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:07]  bdinfo is in spi-flash
[2026-09-18 14:57:07]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:07]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:07]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:07]  In:    serial 
[2026-09-18 14:57:07]  Out:   serial vidconsole 
[2026-09-18 14:57:07]  Err:   serial vidconsole 
[2026-09-18 14:57:07]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:07]  ************************** Notice **************************
[2026-09-18 14:57:07]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:07]  ************************************************************
[2026-09-18 14:57:07]  Autoboot in 0 seconds
[2026-09-18 14:57:07]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 14:57:07]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:57:07]  uart_register: Registering /dev/console
[2026-09-18 14:57:07]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:07]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:07]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:07]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:07]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:07]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:07]  nx_start_application: Starting init thread
[2026-09-18 14:57:07]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:07]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:07]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:07]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:07]  
[2026-09-18 14:57:07]  NuttShell (NSH)

[2026-09-18 14:57:09]  nsh> reboot
[2026-09-18 14:57:09]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:09]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:09]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:09]  LoongArch Initializing ...
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  Lock Scache Done.
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  Copy spl code to locked scache...
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  Jump to board_init_f...
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:09]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:09]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  ============ddr4 init and training done!========
[2026-09-18 14:57:09]  Trying to boot from BootSpace
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  U-boot start ...
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  Jump to board_init_f...
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  CPU:   LA264
[2026-09-18 14:57:09]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:09]  Model: loongson-2k300
[2026-09-18 14:57:09]  Board: LS2K300-PAI
[2026-09-18 14:57:09]  DRAM:  512 MiB
[2026-09-18 14:57:09]  512 MiB
[2026-09-18 14:57:09]  
[2026-09-18 14:57:09]  Jump to board_init_r....
[2026-09-18 14:57:09]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:09]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:09]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:09]  bdinfo is in spi-flash
[2026-09-18 14:57:09]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:09]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:09]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:09]  In:    serial 
[2026-09-18 14:57:10]  Out:   serial vidconsole 
[2026-09-18 14:57:10]  Err:   serial vidconsole 
[2026-09-18 14:57:10]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:10]  ************************** Notice **************************
[2026-09-18 14:57:10]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:10]  ************************************************************
[2026-09-18 14:57:10]  Autoboot in 0 seconds
[2026-09-18 14:57:10]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 14:57:10]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:57:10]  uart_register: Registering /dev/console
[2026-09-18 14:57:10]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:10]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:10]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:10]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:10]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:10]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:10]  nx_start_application: Starting init thread
[2026-09-18 14:57:10]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:10]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:10]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:10]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:10]  
[2026-09-18 14:57:10]  NuttShell (NSH)

[2026-09-18 14:57:11]  nsh> reboot
[2026-09-18 14:57:11]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:11]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:11]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:11]  LoongArch Initializing ...
[2026-09-18 14:57:11]  
[2026-09-18 14:57:11]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:11]  
[2026-09-18 14:57:11]  Lock Scache Done.
[2026-09-18 14:57:11]  
[2026-09-18 14:57:11]  Copy spl code to locked scache...
[2026-09-18 14:57:11]  
[2026-09-18 14:57:11]  Jump to board_init_f...
[2026-09-18 14:57:11]  
[2026-09-18 14:57:11]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:11]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:11]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:11]  
[2026-09-18 14:57:11]  ============ddr4 init and training done!========
[2026-09-18 14:57:12]  Trying to boot from BootSpace
[2026-09-18 14:57:12]  
[2026-09-18 14:57:12]  U-boot start ...
[2026-09-18 14:57:12]  
[2026-09-18 14:57:12]  Jump to board_init_f...
[2026-09-18 14:57:12]  
[2026-09-18 14:57:12]  
[2026-09-18 14:57:12]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:12]  
[2026-09-18 14:57:12]  CPU:   LA264
[2026-09-18 14:57:12]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:12]  Model: loongson-2k300
[2026-09-18 14:57:12]  Board: LS2K300-PAI
[2026-09-18 14:57:12]  DRAM:  512 MiB
[2026-09-18 14:57:12]  512 MiB
[2026-09-18 14:57:12]  
[2026-09-18 14:57:12]  Jump to board_init_r....
[2026-09-18 14:57:12]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:12]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:12]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:12]  bdinfo is in spi-flash
[2026-09-18 14:57:12]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:12]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:12]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:12]  In:    serial 
[2026-09-18 14:57:12]  Out:   serial vidconsole 
[2026-09-18 14:57:12]  Err:   serial vidconsole 
[2026-09-18 14:57:12]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:12]  ************************** Notice **************************
[2026-09-18 14:57:12]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:12]  ************************************************************
[2026-09-18 14:57:12]  Autoboot in 0 seconds
[2026-09-18 14:57:12]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 14:57:12]  ## Starting application at 0x9000000098000000 ...
C} Entry
[2026-09-18 14:57:12]  uart_register: Registering /dev/console
[2026-09-18 14:57:12]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:12]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:12]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:12]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:12]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:12]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:12]  nx_start_application: Starting init thread
[2026-09-18 14:57:12]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:12]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:12]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:12]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:13]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:13]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:13]  
[2026-09-18 14:57:13]  NuttShell (NSH)

[2026-09-18 14:57:13]  nsh> reboot
[2026-09-18 14:57:13]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:13]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:13]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:13]  LoongArch Initializing ...
[2026-09-18 14:57:13]  
[2026-09-18 14:57:13]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:13]  
[2026-09-18 14:57:13]  Lock Scache Done.
[2026-09-18 14:57:13]  
[2026-09-18 14:57:13]  Copy spl code to locked scache...
[2026-09-18 14:57:13]  
[2026-09-18 14:57:13]  Jump to board_init_f...
[2026-09-18 14:57:13]  
[2026-09-18 14:57:13]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:13]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:13]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:13]  
[2026-09-18 14:57:13]  ============ddr4 init and training done!========
[2026-09-18 14:57:14]  Trying to boot from BootSpace
[2026-09-18 14:57:14]  
[2026-09-18 14:57:14]  U-boot start ...
[2026-09-18 14:57:14]  
[2026-09-18 14:57:14]  Jump to board_init_f...
[2026-09-18 14:57:14]  
[2026-09-18 14:57:14]  
[2026-09-18 14:57:14]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:14]  
[2026-09-18 14:57:14]  CPU:   LA264
[2026-09-18 14:57:14]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:14]  Model: loongson-2k300
[2026-09-18 14:57:14]  Board: LS2K300-PAI
[2026-09-18 14:57:14]  DRAM:  512 MiB
[2026-09-18 14:57:14]  512 MiB
[2026-09-18 14:57:14]  
[2026-09-18 14:57:14]  Jump to board_init_r....
[2026-09-18 14:57:14]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:14]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:14]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:14]  bdinfo is in spi-flash
[2026-09-18 14:57:14]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:14]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:14]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:14]  In:    serial 
[2026-09-18 14:57:14]  Out:   serial vidconsole 
[2026-09-18 14:57:14]  Err:   serial vidconsole 
[2026-09-18 14:57:14]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:14]  ************************** Notice **************************
[2026-09-18 14:57:14]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:14]  ************************************************************
[2026-09-18 14:57:14]  Autoboot in 0 seconds
[2026-09-18 14:57:14]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 14:57:14]  ## Starting application at 0x9000000098000000 ...
C} Entry
[2026-09-18 14:57:14]  uart_register: Registering /dev/console
[2026-09-18 14:57:14]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:14]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:14]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:14]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:14]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:14]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:14]  nx_start_application: Starting init thread
[2026-09-18 14:57:14]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:14]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:14]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:14]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:15]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:15]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:15]  
[2026-09-18 14:57:15]  NuttShell (NSH)

[2026-09-18 14:57:16]  nsh> reboot
[2026-09-18 14:57:16]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:16]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:16]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:16]  LoongArch Initializing ...
[2026-09-18 14:57:16]  
[2026-09-18 14:57:16]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:16]  
[2026-09-18 14:57:16]  Lock Scache Done.
[2026-09-18 14:57:16]  
[2026-09-18 14:57:16]  Copy spl code to locked scache...
[2026-09-18 14:57:16]  
[2026-09-18 14:57:16]  Jump to board_init_f...
[2026-09-18 14:57:16]  
[2026-09-18 14:57:16]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:16]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:16]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:16]  
[2026-09-18 14:57:16]  ============ddr4 init and training done!========
[2026-09-18 14:57:17]  Trying to boot from BootSpace
[2026-09-18 14:57:17]  
[2026-09-18 14:57:17]  U-boot start ...
[2026-09-18 14:57:17]  
[2026-09-18 14:57:17]  Jump to board_init_f...
[2026-09-18 14:57:17]  
[2026-09-18 14:57:17]  
[2026-09-18 14:57:17]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:17]  
[2026-09-18 14:57:17]  CPU:   LA264
[2026-09-18 14:57:17]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:17]  Model: loongson-2k300
[2026-09-18 14:57:17]  Board: LS2K300-PAI
[2026-09-18 14:57:17]  DRAM:  512 MiB
[2026-09-18 14:57:17]  512 MiB
[2026-09-18 14:57:17]  
[2026-09-18 14:57:17]  Jump to board_init_r....
[2026-09-18 14:57:17]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:17]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:17]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:17]  bdinfo is in spi-flash
[2026-09-18 14:57:17]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:17]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:17]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:17]  In:    serial 
[2026-09-18 14:57:17]  Out:   serial vidconsole 
[2026-09-18 14:57:17]  Err:   serial vidconsole 
[2026-09-18 14:57:17]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:17]  ************************** Notice **************************
[2026-09-18 14:57:17]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:17]  ************************************************************
[2026-09-18 14:57:17]  Autoboot in 0 seconds
[2026-09-18 14:57:17]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 14:57:17]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:57:17]  uart_register: Registering /dev/console
[2026-09-18 14:57:17]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:17]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:17]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:17]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:17]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:17]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:17]  nx_start_application: Starting init thread
[2026-09-18 14:57:17]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:17]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:17]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:17]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:18]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:18]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:18]  
[2026-09-18 14:57:18]  NuttShell (NSH)

[2026-09-18 14:57:19]  nsh> reboot
[2026-09-18 14:57:19]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:19]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:19]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:19]  LoongArch Initializing ...
[2026-09-18 14:57:19]  
[2026-09-18 14:57:19]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:19]  
[2026-09-18 14:57:19]  Lock Scache Done.
[2026-09-18 14:57:19]  
[2026-09-18 14:57:19]  Copy spl code to locked scache...
[2026-09-18 14:57:19]  
[2026-09-18 14:57:19]  Jump to board_init_f...
[2026-09-18 14:57:19]  
[2026-09-18 14:57:19]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:19]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:19]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:19]  
[2026-09-18 14:57:19]  ============ddr4 init and training done!========
[2026-09-18 14:57:20]  Trying to boot from BootSpace
[2026-09-18 14:57:20]  
[2026-09-18 14:57:20]  U-boot start ...
[2026-09-18 14:57:20]  
[2026-09-18 14:57:20]  Jump to board_init_f...
[2026-09-18 14:57:20]  
[2026-09-18 14:57:20]  
[2026-09-18 14:57:20]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:20]  
[2026-09-18 14:57:20]  CPU:   LA264
[2026-09-18 14:57:20]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:20]  Model: loongson-2k300
[2026-09-18 14:57:20]  Board: LS2K300-PAI
[2026-09-18 14:57:20]  DRAM:  512 MiB
[2026-09-18 14:57:20]  512 MiB
[2026-09-18 14:57:20]  
[2026-09-18 14:57:20]  Jump to board_init_r....
[2026-09-18 14:57:20]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:20]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:20]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:20]  bdinfo is in spi-flash
[2026-09-18 14:57:20]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:20]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:20]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:20]  In:    serial 
[2026-09-18 14:57:20]  Out:   serial vidconsole 
[2026-09-18 14:57:20]  Err:   serial vidconsole 
[2026-09-18 14:57:20]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:20]  ************************** Notice **************************
[2026-09-18 14:57:20]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:20]  ************************************************************
[2026-09-18 14:57:20]  Autoboot in 0 seconds
[2026-09-18 14:57:20]  456992 bytes read in 159 ms (2.7 MiB/s)
[2026-09-18 14:57:21]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:57:21]  uart_register: Registering /dev/console
[2026-09-18 14:57:21]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:21]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:21]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:21]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:21]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:21]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:21]  nx_start_application: Starting init thread
[2026-09-18 14:57:21]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:21]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:21]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:21]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:21]  
[2026-09-18 14:57:21]  NuttShell (NSH)

[2026-09-18 14:57:22]  nsh> reboot
[2026-09-18 14:57:22]  task_spawn: name=reboot entry=0x9000000098048d00 file_actions=0x900000009808aef8 attr=0x900000009808af00 argv=0x900000009808b098
[2026-09-18 14:57:22]  nxtask_activate: reboot pid=4,TCB=0x900000009808eb20
[2026-09-18 14:57:22]  [2036-02-06 06:28:16] CMD: reboot, UID: 0, RESULT: STARTING
[2026-09-18 14:57:22]  LoongArch Initializing ...
[2026-09-18 14:57:22]  
[2026-09-18 14:57:22]  RAM(Cache AS RAM) Initializing ...
[2026-09-18 14:57:22]  
[2026-09-18 14:57:22]  Lock Scache Done.
[2026-09-18 14:57:22]  
[2026-09-18 14:57:22]  Copy spl code to locked scache...
[2026-09-18 14:57:22]  
[2026-09-18 14:57:22]  Jump to board_init_f...
[2026-09-18 14:57:22]  
[2026-09-18 14:57:22]   _     __   __  _  _  ___  ___  __  _  _    /   ___  __  \ 
[2026-09-18 14:57:22]   |    |  | |  | |\ | | __ [__  |  | |\ |    |  | __ |  \ | 
[2026-09-18 14:57:22]   |___ |__| |__| | \| |__] ___] |__| | \|    \  |__] |__/ / 
[2026-09-18 14:57:22]  
[2026-09-18 14:57:22]  ============ddr4 init and training done!========
[2026-09-18 14:57:22]  Trying to boot from BootSpace
[2026-09-18 14:57:22]  
[2026-09-18 14:57:23]  U-boot start ...
[2026-09-18 14:57:23]  
[2026-09-18 14:57:23]  Jump to board_init_f...
[2026-09-18 14:57:23]  
[2026-09-18 14:57:23]  
[2026-09-18 14:57:23]  U-Boot 2022.04-v2.0.0-00572-gfaaca55a (Jan 15 2025 - 17:49:12 +0800)
[2026-09-18 14:57:23]  
[2026-09-18 14:57:23]  CPU:   LA264
[2026-09-18 14:57:23]  Speed: Cpu @ 1000 MHz/ Mem @ 800 MHz/ Bus @ 200 MHz
[2026-09-18 14:57:23]  Model: loongson-2k300
[2026-09-18 14:57:23]  Board: LS2K300-PAI
[2026-09-18 14:57:23]  DRAM:  512 MiB
[2026-09-18 14:57:23]  512 MiB
[2026-09-18 14:57:23]  
[2026-09-18 14:57:23]  Jump to board_init_r....
[2026-09-18 14:57:23]  Core:  38 devices, 20 uclasses, devicetree: board
[2026-09-18 14:57:23]  WDT:   Not starting watchdog_d
[2026-09-18 14:57:23]  SF: Detected w25q16cl with page size 256 Bytes, erase size 4 KiB, total 2 MiB
[2026-09-18 14:57:23]  bdinfo is in spi-flash
[2026-09-18 14:57:23]  MMC:   emmc@0x16140000: 0 (eMMC), mmc@0x16148000: 1 (SD)
[2026-09-18 14:57:23]  Loading Environment from SPIFlash... OK
[2026-09-18 14:57:23]  frame buffer addr: 0x900000000dc00000
[2026-09-18 14:57:23]  In:    serial 
[2026-09-18 14:57:23]  Out:   serial vidconsole 
[2026-09-18 14:57:23]  Err:   serial vidconsole 
[2026-09-18 14:57:23]  Net:   eth0: ethernet@0x16020000
[2026-09-18 14:57:23]  ************************** Notice **************************
[2026-09-18 14:57:23]  Press c to enter u-boot console, m to enter boot menu

[2026-09-18 14:57:23]  ************************************************************
[2026-09-18 14:57:23]  Autoboot in 0 seconds
[2026-09-18 14:57:23]  456992 bytes read in 160 ms (2.7 MiB/s)
[2026-09-18 14:57:23]  ## Starting application at 0x9000000098000000 ...
nx_start: Entry
[2026-09-18 14:57:23]  uart_register: Registering /dev/console
[2026-09-18 14:57:23]  uart_register: Registering /dev/ttyS0
[2026-09-18 14:57:23]  uart_register: Registering /dev/ttyS2
[2026-09-18 14:57:23]  work_start_highpri: Starting high-priority kernel worker thread(s)
[2026-09-18 14:57:23]  nxtask_activate: hpwork pid=1,TCB=0x9000000098088850
[2026-09-18 14:57:23]  work_start_lowpri: Starting low-priority kernel worker thread(s)
[2026-09-18 14:57:23]  nxtask_activate: lpwork pid=2,TCB=0x90000000980889c0
[2026-09-18 14:57:23]  nx_start_application: Starting init thread
[2026-09-18 14:57:23]  task_spawn: name=nsh_main entry=0x90000000980124a8 file_actions=0 attr=0x90000000987fff50 argv=0x90000000987fff48
[2026-09-18 14:57:23]  nxtask_activate: nsh_main pid=3,TCB=0x9000000098088b30
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: start
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: mounting procfs
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: ADC
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: I2C0
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: I2C1
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: THERMAL
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: PWM0
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: PWM2
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: SPI0
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: WDT
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: PINCTRL
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: GPIO
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: SPIIO2 SPI Flash
[2026-09-18 14:57:23]  nx_start: CPU0: Beginning Idle Loop
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: LittleFS mounted at /spiflash
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: ETHERNET
[2026-09-18 14:57:23]  ls2k0300_bringup: bringup: done
[2026-09-18 14:57:23]  
[2026-09-18 14:57:23]  NuttShell (NSH)
[2026-09-18 14:57:23]  nsh> 
```

# 3 稳定性测试

## 2\.1 系统内核

#### 2\.1\.1 12h待机稳定性测试

##### 通过

指令：showinfo \-i 60

日志：日志过大无法完全放入

```YAML
[2026-09-18 21:25:11] nsh> showinfo -i 60
[2026-09-18 21:25:11] task_spawn: name=showinfo entry=0x900000009804a630 file_actions=0x9000000098095bb8 attr=0x9000000098095bc0 argv=0x9000000098095d58
[2026-09-18 21:25:11] nxtask_activate: showinfo pid=4,TCB=0x90000000980997e0
[2026-09-18 21:25:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:25:11]     7663368      34342    7629026      35075    7629026    163      1*float*
[2026-09-18 21:25:11] 
[2026-09-18 21:26:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:26:11]     7663368      34341    7629027      35073    7629027    163      1*float*
[2026-09-18 21:26:11] 
[2026-09-18 21:27:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:27:11]     7663368      34342    7629026      35064    7629026    163      1*float*
[2026-09-18 21:27:11] 
[2026-09-18 21:28:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:28:11]     7663368      34344    7629024      35074    7629024    163      1*float*
[2026-09-18 21:28:11] 
[2026-09-18 21:29:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:29:11]     7663368      34346    7629022      35074    7629022    163      1*float*
[2026-09-18 21:29:11] 
[2026-09-18 21:30:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:30:11]     7663368      34342    7629026      35080    7629026    163      1*float*
[2026-09-18 21:30:11] 
[2026-09-18 21:31:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:31:11]     7663368      34343    7629025      35066    7629025    163      1*float*
[2026-09-18 21:31:11] 
[2026-09-18 21:32:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:32:11]     7663368      34341    7629027      35067    7629027    163      1*float*
[2026-09-18 21:32:11] 
[2026-09-18 21:33:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:33:11]     7663368      34346    7629022      35070    7629022    163      1*float*
[2026-09-18 21:33:11] 
[2026-09-18 21:34:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:34:11]     7663368      34341    7629027      35079    7629027    163      1*float*
[2026-09-18 21:34:11] 
[2026-09-18 21:35:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:35:11]     7663368      34341    7629027      35072    7629027    163      1*float*
[2026-09-18 21:35:11] 
[2026-09-18 21:36:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:36:11]     7663368      34344    7629024      35065    7629024    163      1*float*
[2026-09-18 21:36:11] 
[2026-09-18 21:37:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:37:11]     7663368      34341    7629027      35078    7629027    163      1*float*
[2026-09-18 21:37:11] 
[2026-09-18 21:38:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:38:11]     7663368      34346    7629022      35079    7629022    163      1*float*
[2026-09-18 21:38:11] 
[2026-09-18 21:39:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:39:11]     7663368      34346    7629022      35080    7629022    163      1*float*
[2026-09-18 21:39:11] 
[2026-09-18 21:40:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:40:11]     7663368      34346    7629022      35080    7629022    163      1*float*
[2026-09-18 21:40:11] 
[2026-09-18 21:41:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:41:11]     7663368      34341    7629027      35067    7629027    163      1*float*
[2026-09-18 21:41:11] 
[2026-09-18 21:42:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:42:11]     7663368      34343    7629025      35068    7629025    163      1*float*
[2026-09-18 21:42:11] 
[2026-09-18 21:43:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:43:11]     7663368      34347    7629021      35064    7629021    163      1*float*
[2026-09-18 21:43:11] 
[2026-09-18 21:44:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:44:11]     7663368      34342    7629026      35080    7629026    163      1*float*
[2026-09-18 21:44:11] 
[2026-09-18 21:45:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:45:11]     7663368      34342    7629026      35067    7629026    163      1*float*
[2026-09-18 21:45:11] 
[2026-09-18 21:46:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:46:11]     7663368      34341    7629027      35072    7629027    163      1*float*
[2026-09-18 21:46:11] 
[2026-09-18 21:47:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:47:11]     7663368      34342    7629026      35072    7629026    163      1*float*
[2026-09-18 21:47:11] 
[2026-09-18 21:48:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:48:11]     7663368      34341    7629027      35078    7629027    163      1*float*
[2026-09-18 21:48:11] 
[2026-09-18 21:49:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:49:11]     7663368      34343    7629025      35066    7629025    163      1*float*
[2026-09-18 21:49:11] 
[2026-09-18 21:50:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:50:11]     7663368      34345    7629023      35070    7629023    163      1*float*
[2026-09-18 21:50:11] 
[2026-09-18 21:51:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:51:11]     7663368      34344    7629024      35072    7629024    163      1*float*
[2026-09-18 21:51:11] 
[2026-09-18 21:52:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:52:11]     7663368      34347    7629021      35080    7629021    163      1*float*
[2026-09-18 21:52:11] 
[2026-09-18 21:53:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:53:11]     7663368      34344    7629024      35071    7629024    163      1*float*
[2026-09-18 21:53:11] 
[2026-09-18 21:54:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:54:11]     7663368      34343    7629025      35064    7629025    163      1*float*
[2026-09-18 21:54:11] 
[2026-09-18 21:55:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:55:11]     7663368      34347    7629021      35068    7629021    163      1*float*
[2026-09-18 21:55:11] 
[2026-09-18 21:56:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:56:11]     7663368      34345    7629023      35075    7629023    163      1*float*
[2026-09-18 21:56:11] 
[2026-09-18 21:57:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:57:11]     7663368      34341    7629027      35070    7629027    163      1*float*
[2026-09-18 21:57:11] 
[2026-09-18 21:58:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:58:11]     7663368      34342    7629026      35075    7629026    163      1*float*
[2026-09-18 21:58:11] 
[2026-09-18 21:59:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 21:59:11]     7663368      34346    7629022      35079    7629022    163      1*float*
[2026-09-18 21:59:11] 
[2026-09-18 22:00:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:00:11]     7663368      34341    7629027      35073    7629027    163      1*float*
[2026-09-18 22:00:11] 
[2026-09-18 22:01:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:01:11]     7663368      34346    7629022      35078    7629022    163      1*float*
[2026-09-18 22:01:11] 
[2026-09-18 22:02:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:02:11]     7663368      34342    7629026      35078    7629026    163      1*float*
[2026-09-18 22:02:11] 
[2026-09-18 22:03:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:03:11]     7663368      34341    7629027      35071    7629027    163      1*float*
[2026-09-18 22:03:11] 
[2026-09-18 22:04:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:04:11]     7663368      34344    7629024      35070    7629024    163      1*float*
[2026-09-18 22:04:11] 
[2026-09-18 22:05:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:05:11]     7663368      34347    7629021      35077    7629021    163      1*float*
[2026-09-18 22:05:11] 
[2026-09-18 22:06:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:06:11]     7663368      34347    7629021      35074    7629021    163      1*float*
[2026-09-18 22:06:11] 
[2026-09-18 22:07:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:07:11]     7663368      34343    7629025      35072    7629025    163      1*float*
[2026-09-18 22:07:11] 
[2026-09-18 22:08:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:08:11]     7663368      34347    7629021      35077    7629021    163      1*float*
[2026-09-18 22:08:11] 
[2026-09-18 22:09:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:09:11]     7663368      34342    7629026      35065    7629026    163      1*float*
[2026-09-18 22:09:11] 
[2026-09-18 22:10:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:10:11]     7663368      34345    7629023      35077    7629023    163      1*float*
[2026-09-18 22:10:11] 
[2026-09-18 22:11:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:11:11]     7663368      34345    7629023      35072    7629023    163      1*float*
[2026-09-18 22:11:11] 
[2026-09-18 22:12:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:12:11]     7663368      34344    7629024      35069    7629024    163      1*float*
[2026-09-18 22:12:11] 
[2026-09-18 22:13:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:13:11]     7663368      34345    7629023      35078    7629023    163      1*float*
[2026-09-18 22:13:11] 
[2026-09-18 22:14:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:14:11]     7663368      34346    7629022      35080    7629022    163      1*float*
[2026-09-18 22:14:11] 
[2026-09-18 22:15:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:15:11]     7663368      34342    7629026      35069    7629026    163      1*float*
[2026-09-18 22:15:11] 
[2026-09-18 22:16:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:16:11]     7663368      34347    7629021      35065    7629021    163      1*float*
[2026-09-18 22:16:11] 
[2026-09-18 22:17:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:17:11]     7663368      34344    7629024      35064    7629024    163      1*float*
[2026-09-18 22:17:11] 
[2026-09-18 22:18:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:18:11]     7663368      34345    7629023      35075    7629023    163      1*float*
[2026-09-18 22:18:11] 
[2026-09-18 22:19:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:19:11]     7663368      34346    7629022      35071    7629022    163      1*float*
[2026-09-18 22:19:11] 
[2026-09-18 22:20:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:20:11]     7663368      34341    7629027      35079    7629027    163      1*float*
[2026-09-18 22:20:11] 
[2026-09-18 22:21:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:21:11]     7663368      34342    7629026      35080    7629026    163      1*float*
[2026-09-18 22:21:11] 
[2026-09-18 22:22:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:22:11]     7663368      34347    7629021      35066    7629021    163      1*float*
[2026-09-18 22:22:11] 
[2026-09-18 22:23:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:23:11]     7663368      34343    7629025      35074    7629025    163      1*float*
[2026-09-18 22:23:11] 
[2026-09-18 22:24:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:24:11]     7663368      34344    7629024      35066    7629024    163      1*float*
[2026-09-18 22:24:11] 
[2026-09-18 22:25:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:25:11]     7663368      34341    7629027      35080    7629027    163      1*float*
[2026-09-18 22:25:11] 
[2026-09-18 22:26:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:26:11]     7663368      34346    7629022      35070    7629022    163      1*float*
[2026-09-18 22:26:11] 
[2026-09-18 22:27:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:27:11]     7663368      34343    7629025      35066    7629025    163      1*float*
[2026-09-18 22:27:11] 
[2026-09-18 22:28:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:28:11]     7663368      34343    7629025      35065    7629025    163      1*float*
[2026-09-18 22:28:11] 
[2026-09-18 22:29:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:29:11]     7663368      34344    7629024      35077    7629024    163      1*float*
[2026-09-18 22:29:11] 
[2026-09-18 22:30:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:30:11]     7663368      34347    7629021      35068    7629021    163      1*float*
[2026-09-18 22:30:11] 
[2026-09-18 22:31:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:31:11]     7663368      34344    7629024      35075    7629024    163      1*float*
[2026-09-18 22:31:11] 
[2026-09-18 22:32:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:32:11]     7663368      34346    7629022      35078    7629022    163      1*float*
[2026-09-18 22:32:11] 
[2026-09-18 22:33:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:33:11]     7663368      34347    7629021      35068    7629021    163      1*float*
[2026-09-18 22:33:11] 
[2026-09-18 22:34:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:34:11]     7663368      34345    7629023      35077    7629023    163      1*float*
[2026-09-18 22:34:11] 
[2026-09-18 22:35:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:35:11]     7663368      34343    7629025      35079    7629025    163      1*float*
[2026-09-18 22:35:11] 
[2026-09-18 22:36:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:36:11]     7663368      34346    7629022      35073    7629022    163      1*float*
[2026-09-18 22:36:11] 
[2026-09-18 22:37:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:37:11]     7663368      34345    7629023      35072    7629023    163      1*float*
[2026-09-18 22:37:11] 
[2026-09-18 22:38:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:38:11]     7663368      34342    7629026      35078    7629026    163      1*float*
[2026-09-18 22:38:11] 
[2026-09-18 22:39:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:39:11]     7663368      34347    7629021      35074    7629021    163      1*float*
[2026-09-18 22:39:11] 
[2026-09-18 22:40:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:40:11]     7663368      34346    7629022      35071    7629022    163      1*float*
[2026-09-18 22:40:11] 
[2026-09-18 22:41:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:41:11]     7663368      34343    7629025      35072    7629025    163      1*float*
[2026-09-18 22:41:11] 
[2026-09-18 22:42:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:42:11]     7663368      34343    7629025      35072    7629025    163      1*float*
[2026-09-18 22:42:11] 
[2026-09-18 22:43:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:43:11]     7663368      34341    7629027      35079    7629027    163      1*float*
[2026-09-18 22:43:11] 
[2026-09-18 22:44:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:44:11]     7663368      34341    7629027      35069    7629027    163      1*float*
[2026-09-18 22:44:11] 
[2026-09-18 22:45:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:45:11]     7663368      34342    7629026      35065    7629026    163      1*float*
[2026-09-18 22:45:11] 
[2026-09-18 22:46:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:46:11]     7663368      34347    7629021      35071    7629021    163      1*float*
[2026-09-18 22:46:11] 
[2026-09-18 22:47:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:47:11]     7663368      34342    7629026      35065    7629026    163      1*float*
[2026-09-18 22:47:11] 
[2026-09-18 22:48:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:48:11]     7663368      34341    7629027      35071    7629027    163      1*float*
[2026-09-18 22:48:11] 
[2026-09-18 22:49:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:49:11]     7663368      34344    7629024      35079    7629024    163      1*float*
[2026-09-18 22:49:11] 
[2026-09-18 22:50:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:50:11]     7663368      34345    7629023      35079    7629023    163      1*float*
[2026-09-18 22:50:11] 
[2026-09-18 22:51:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:51:11]     7663368      34345    7629023      35077    7629023    163      1*float*
[2026-09-18 22:51:11] 
[2026-09-18 22:52:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:52:11]     7663368      34341    7629027      35070    7629027    163      1*float*
[2026-09-18 22:52:11] 
[2026-09-18 22:53:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:53:11]     7663368      34343    7629025      35069    7629025    163      1*float*
[2026-09-18 22:53:11] 
[2026-09-18 22:54:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:54:11]     7663368      34344    7629024      35077    7629024    163      1*float*
[2026-09-18 22:54:11] 
[2026-09-18 22:55:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:55:11]     7663368      34346    7629022      35074    7629022    163      1*float*
[2026-09-18 22:55:11] 
[2026-09-18 22:56:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:56:11]     7663368      34342    7629026      35067    7629026    163      1*float*
[2026-09-18 22:56:11] 
[2026-09-18 22:57:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:57:11]     7663368      34342    7629026      35066    7629026    163      1*float*
[2026-09-18 22:57:11] 
[2026-09-18 22:58:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:58:11]     7663368      34344    7629024      35074    7629024    163      1*float*
[2026-09-18 22:58:11] 
[2026-09-18 22:59:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 22:59:11]     7663368      34344    7629024      35066    7629024    163      1*float*
[2026-09-18 22:59:11] 
[2026-09-18 23:00:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:00:11]     7663368      34341    7629027      35073    7629027    163      1*float*
[2026-09-18 23:00:11] 
[2026-09-18 23:01:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:01:11]     7663368      34342    7629026      35066    7629026    163      1*float*
[2026-09-18 23:01:11] 
[2026-09-18 23:02:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:02:11]     7663368      34341    7629027      35069    7629027    163      1*float*
[2026-09-18 23:02:11] 
[2026-09-18 23:03:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:03:11]     7663368      34347    7629021      35065    7629021    163      1*float*
[2026-09-18 23:03:11] 
[2026-09-18 23:04:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:04:11]     7663368      34346    7629022      35066    7629022    163      1*float*
[2026-09-18 23:04:11] 
[2026-09-18 23:05:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:05:11]     7663368      34344    7629024      35072    7629024    163      1*float*
[2026-09-18 23:05:11] 
[2026-09-18 23:06:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:06:11]     7663368      34344    7629024      35079    7629024    163      1*float*
[2026-09-18 23:06:11] 
[2026-09-18 23:07:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:07:11]     7663368      34346    7629022      35079    7629022    163      1*float*
[2026-09-18 23:07:11] 
[2026-09-18 23:08:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:08:11]     7663368      34345    7629023      35064    7629023    163      1*float*
[2026-09-18 23:08:11] 
[2026-09-18 23:09:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:09:11]     7663368      34345    7629023      35067    7629023    163      1*float*
[2026-09-18 23:09:11] 
[2026-09-18 23:10:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:10:11]     7663368      34345    7629023      35075    7629023    163      1*float*
[2026-09-18 23:10:11] 
[2026-09-18 23:11:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:11:11]     7663368      34347    7629021      35079    7629021    163      1*float*
[2026-09-18 23:11:11] 
[2026-09-18 23:12:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:12:11]     7663368      34347    7629021      35068    7629021    163      1*float*
[2026-09-18 23:12:11] 
[2026-09-18 23:13:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:13:11]     7663368      34342    7629026      35080    7629026    163      1*float*
[2026-09-18 23:13:11] 
[2026-09-18 23:14:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:14:11]     7663368      34346    7629022      35077    7629022    163      1*float*
[2026-09-18 23:14:11] 
[2026-09-18 23:15:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:15:11]     7663368      34346    7629022      35066    7629022    163      1*float*
[2026-09-18 23:15:11] 
[2026-09-18 23:16:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:16:11]     7663368      34345    7629023      35075    7629023    163      1*float*
[2026-09-18 23:16:11] 
[2026-09-18 23:17:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:17:11]     7663368      34344    7629024      35077    7629024    163      1*float*
[2026-09-18 23:17:11] 
[2026-09-18 23:18:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:18:11]     7663368      34344    7629024      35074    7629024    163      1*float*
[2026-09-18 23:18:11] 
[2026-09-18 23:19:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:19:11]     7663368      34347    7629021      35073    7629021    163      1*float*
[2026-09-18 23:19:11] 
[2026-09-18 23:20:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:20:11]     7663368      34346    7629022      35066    7629022    163      1*float*
[2026-09-18 23:20:11] 
[2026-09-18 23:21:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:21:11]     7663368      34342    7629026      35066    7629026    163      1*float*
[2026-09-18 23:21:11] 
[2026-09-18 23:22:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:22:11]     7663368      34347    7629021      35077    7629021    163      1*float*
[2026-09-18 23:22:11] 
[2026-09-18 23:23:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:23:11]     7663368      34344    7629024      35072    7629024    163      1*float*
[2026-09-18 23:23:11] 
[2026-09-18 23:24:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:24:11]     7663368      34345    7629023      35080    7629023    163      1*float*
[2026-09-18 23:24:11] 
[2026-09-18 23:25:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:25:11]     7663368      34347    7629021      35065    7629021    163      1*float*
[2026-09-18 23:25:11] 
[2026-09-18 23:26:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:26:11]     7663368      34344    7629024      35072    7629024    163      1*float*
[2026-09-18 23:26:11] 
[2026-09-18 23:27:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:27:11]     7663368      34343    7629025      35071    7629025    163      1*float*
[2026-09-18 23:27:11] 
[2026-09-18 23:28:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:28:11]     7663368      34345    7629023      35067    7629023    163      1*float*
[2026-09-18 23:28:11] 
[2026-09-18 23:29:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:29:11]     7663368      34342    7629026      35064    7629026    163      1*float*
[2026-09-18 23:29:11] 
[2026-09-18 23:30:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:30:11]     7663368      34347    7629021      35075    7629021    163      1*float*
[2026-09-18 23:30:11] 
[2026-09-18 23:31:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:31:11]     7663368      34347    7629021      35074    7629021    163      1*float*
[2026-09-18 23:31:11] 
[2026-09-18 23:32:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:32:11]     7663368      34345    7629023      35069    7629023    163      1*float*
[2026-09-18 23:32:11] 
[2026-09-18 23:33:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:33:11]     7663368      34344    7629024      35076    7629024    163      1*float*
[2026-09-18 23:33:11] 
[2026-09-18 23:34:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:34:11]     7663368      34344    7629024      35068    7629024    163      1*float*
[2026-09-18 23:34:11] 
[2026-09-18 23:35:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:35:11]     7663368      34345    7629023      35070    7629023    163      1*float*
[2026-09-18 23:35:11] 
[2026-09-18 23:36:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:36:11]     7663368      34346    7629022      35068    7629022    163      1*float*
[2026-09-18 23:36:11] 
[2026-09-18 23:37:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:37:11]     7663368      34341    7629027      35071    7629027    163      1*float*
[2026-09-18 23:37:11] 
[2026-09-18 23:38:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:38:11]     7663368      34342    7629026      35080    7629026    163      1*float*
[2026-09-18 23:38:11] 
[2026-09-18 23:39:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:39:11]     7663368      34344    7629024      35077    7629024    163      1*float*
[2026-09-18 23:39:11] 
[2026-09-18 23:40:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:40:11]     7663368      34343    7629025      35078    7629025    163      1*float*
[2026-09-18 23:40:11] 
[2026-09-18 23:41:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:41:11]     7663368      34343    7629025      35064    7629025    163      1*float*
[2026-09-18 23:41:11] 
[2026-09-18 23:42:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:42:11]     7663368      34346    7629022      35073    7629022    163      1*float*
[2026-09-18 23:42:11] 
[2026-09-18 23:43:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:43:11]     7663368      34343    7629025      35071    7629025    163      1*float*
[2026-09-18 23:43:11] 
[2026-09-18 23:44:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:44:11]     7663368      34347    7629021      35074    7629021    163      1*float*
[2026-09-18 23:44:11] 
[2026-09-18 23:45:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:45:11]     7663368      34341    7629027      35068    7629027    163      1*float*
[2026-09-18 23:45:11] 
[2026-09-18 23:46:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:46:11]     7663368      34343    7629025      35077    7629025    163      1*float*
[2026-09-18 23:46:11] 
[2026-09-18 23:47:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:47:11]     7663368      34346    7629022      35079    7629022    163      1*float*
[2026-09-18 23:47:11] 
[2026-09-18 23:48:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:48:11]     7663368      34345    7629023      35067    7629023    163      1*float*
[2026-09-18 23:48:11] 
[2026-09-18 23:49:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:49:11]     7663368      34343    7629025      35064    7629025    163      1*float*
[2026-09-18 23:49:11] 
[2026-09-18 23:50:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:50:11]     7663368      34341    7629027      35071    7629027    163      1*float*
[2026-09-18 23:50:11] 
[2026-09-18 23:51:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:51:11]     7663368      34344    7629024      35068    7629024    163      1*float*
[2026-09-18 23:51:11] 
[2026-09-18 23:52:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:52:11]     7663368      34344    7629024      35078    7629024    163      1*float*
[2026-09-18 23:52:11] 
[2026-09-18 23:53:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:53:11]     7663368      34345    7629023      35079    7629023    163      1*float*
[2026-09-18 23:53:11] 
[2026-09-18 23:54:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:54:11]     7663368      34342    7629026      35068    7629026    163      1*float*
[2026-09-18 23:54:11] 
[2026-09-18 23:55:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:55:11]     7663368      34347    7629021      35070    7629021    163      1*float*
[2026-09-18 23:55:11] 
[2026-09-18 23:56:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:56:11]     7663368      34347    7629021      35067    7629021    163      1*float*
[2026-09-18 23:56:11] 
[2026-09-18 23:57:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:57:11]     7663368      34346    7629022      35070    7629022    163      1*float*
[2026-09-18 23:57:11] 
[2026-09-18 23:58:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:58:11]     7663368      34345    7629023      35070    7629023    163      1*float*
[2026-09-18 23:58:11] 
[2026-09-18 23:59:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-18 23:59:11]     7663368      34345    7629023      35069    7629023    163      1*float*
[2026-09-18 23:59:11] 
[2026-09-19 00:00:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:00:11]     7663368      34344    7629024      35070    7629024    163      1*float*
[2026-09-19 00:00:11] 
[2026-09-19 00:01:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:01:11]     7663368      34347    7629021      35066    7629021    163      1*float*
[2026-09-19 00:01:11] 
[2026-09-19 00:02:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:02:11]     7663368      34344    7629024      35068    7629024    163      1*float*
[2026-09-19 00:02:11] 
[2026-09-19 00:03:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:03:11]     7663368      34342    7629026      35076    7629026    163      1*float*
[2026-09-19 00:03:11] 
[2026-09-19 00:04:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:04:11]     7663368      34342    7629026      35073    7629026    163      1*float*
[2026-09-19 00:04:11] 
[2026-09-19 00:05:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:05:11]     7663368      34343    7629025      35065    7629025    163      1*float*
[2026-09-19 00:05:11] 
[2026-09-19 00:06:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:06:11]     7663368      34346    7629022      35078    7629022    163      1*float*
[2026-09-19 00:06:11] 
[2026-09-19 00:07:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:07:11]     7663368      34344    7629024      35079    7629024    163      1*float*
[2026-09-19 00:07:11] 
[2026-09-19 00:08:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:08:11]     7663368      34345    7629023      35076    7629023    163      1*float*
[2026-09-19 00:08:11] 
[2026-09-19 00:09:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:09:11]     7663368      34343    7629025      35071    7629025    163      1*float*
[2026-09-19 00:09:11] 
[2026-09-19 00:10:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:10:11]     7663368      34342    7629026      35069    7629026    163      1*float*
[2026-09-19 00:10:11] 
[2026-09-19 00:11:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:11:11]     7663368      34343    7629025      35068    7629025    163      1*float*
[2026-09-19 00:11:11] 
[2026-09-19 00:12:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:12:11]     7663368      34342    7629026      35067    7629026    163      1*float*
[2026-09-19 00:12:11] 
[2026-09-19 00:13:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:13:11]     7663368      34345    7629023      35064    7629023    163      1*float*
[2026-09-19 00:13:11] 
[2026-09-19 00:14:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:14:11]     7663368      34347    7629021      35067    7629021    163      1*float*
[2026-09-19 00:14:11] 
[2026-09-19 00:15:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:15:11]     7663368      34341    7629027      35080    7629027    163      1*float*
[2026-09-19 00:15:11] 
[2026-09-19 00:16:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:16:11]     7663368      34342    7629026      35068    7629026    163      1*float*
[2026-09-19 00:16:11] 
[2026-09-19 00:17:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:17:11]     7663368      34341    7629027      35078    7629027    163      1*float*
[2026-09-19 00:17:11] 
[2026-09-19 00:18:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:18:11]     7663368      34345    7629023      35079    7629023    163      1*float*
[2026-09-19 00:18:11] 
[2026-09-19 00:19:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:19:11]     7663368      34344    7629024      35079    7629024    163      1*float*
[2026-09-19 00:19:11] 
[2026-09-19 00:20:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:20:11]     7663368      34343    7629025      35070    7629025    163      1*float*
[2026-09-19 00:20:11] 
[2026-09-19 00:21:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:21:11]     7663368      34344    7629024      35065    7629024    163      1*float*
[2026-09-19 00:21:11] 
[2026-09-19 00:22:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:22:11]     7663368      34344    7629024      35066    7629024    163      1*float*
[2026-09-19 00:22:11] 
[2026-09-19 00:23:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:23:11]     7663368      34344    7629024      35070    7629024    163      1*float*
[2026-09-19 00:23:11] 
[2026-09-19 00:24:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:24:11]     7663368      34343    7629025      35073    7629025    163      1*float*
[2026-09-19 00:24:11] 
[2026-09-19 00:25:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:25:11]     7663368      34343    7629025      35078    7629025    163      1*float*
[2026-09-19 00:25:11] 
[2026-09-19 00:26:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:26:11]     7663368      34345    7629023      35074    7629023    163      1*float*
[2026-09-19 00:26:11] 
[2026-09-19 00:27:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:27:11]     7663368      34344    7629024      35065    7629024    163      1*float*
[2026-09-19 00:27:11] 
[2026-09-19 00:28:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:28:11]     7663368      34345    7629023      35070    7629023    163      1*float*
[2026-09-19 00:28:11] 
[2026-09-19 00:29:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:29:11]     7663368      34345    7629023      35067    7629023    163      1*float*
[2026-09-19 00:29:11] 
[2026-09-19 00:30:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:30:11]     7663368      34343    7629025      35073    7629025    163      1*float*
[2026-09-19 00:30:11] 
[2026-09-19 00:31:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:31:11]     7663368      34341    7629027      35066    7629027    163      1*float*
[2026-09-19 00:31:11] 
[2026-09-19 00:32:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:32:11]     7663368      34346    7629022      35067    7629022    163      1*float*
[2026-09-19 00:32:11] 
[2026-09-19 00:33:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:33:11]     7663368      34346    7629022      35077    7629022    163      1*float*
[2026-09-19 00:33:11] 
[2026-09-19 00:34:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:34:11]     7663368      34345    7629023      35079    7629023    163      1*float*
[2026-09-19 00:34:11] 
[2026-09-19 00:35:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:35:11]     7663368      34344    7629024      35076    7629024    163      1*float*
[2026-09-19 00:35:11] 
[2026-09-19 00:36:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:36:11]     7663368      34342    7629026      35079    7629026    163      1*float*
[2026-09-19 00:36:11] 
[2026-09-19 00:37:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:37:11]     7663368      34343    7629025      35072    7629025    163      1*float*
[2026-09-19 00:37:11] 
[2026-09-19 00:38:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:38:11]     7663368      34346    7629022      35072    7629022    163      1*float*
[2026-09-19 00:38:11] 
[2026-09-19 00:39:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:39:11]     7663368      34347    7629021      35076    7629021    163      1*float*
[2026-09-19 00:39:11] 
[2026-09-19 00:40:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:40:11]     7663368      34347    7629021      35065    7629021    163      1*float*
[2026-09-19 00:40:11] 
[2026-09-19 00:41:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:41:11]     7663368      34345    7629023      35072    7629023    163      1*float*
[2026-09-19 00:41:11] 
[2026-09-19 00:42:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:42:11]     7663368      34345    7629023      35075    7629023    163      1*float*
[2026-09-19 00:42:11] 
[2026-09-19 00:43:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:43:11]     7663368      34342    7629026      35078    7629026    163      1*float*
[2026-09-19 00:43:11] 
[2026-09-19 00:44:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:44:11]     7663368      34341    7629027      35078    7629027    163      1*float*
[2026-09-19 00:44:11] 
[2026-09-19 00:45:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:45:11]     7663368      34347    7629021      35070    7629021    163      1*float*
[2026-09-19 00:45:11] 
[2026-09-19 00:46:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:46:11]     7663368      34342    7629026      35075    7629026    163      1*float*
[2026-09-19 00:46:11] 
[2026-09-19 00:47:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:47:11]     7663368      34344    7629024      35069    7629024    163      1*float*
[2026-09-19 00:47:11] 
[2026-09-19 00:48:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:48:11]     7663368      34343    7629025      35069    7629025    163      1*float*
[2026-09-19 00:48:11] 
[2026-09-19 00:49:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:49:11]     7663368      34342    7629026      35071    7629026    163      1*float*
[2026-09-19 00:49:11] 
[2026-09-19 00:50:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:50:11]     7663368      34343    7629025      35078    7629025    163      1*float*
[2026-09-19 00:50:11] 
[2026-09-19 00:51:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:51:11]     7663368      34347    7629021      35064    7629021    163      1*float*
[2026-09-19 00:51:11] 
[2026-09-19 00:52:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:52:11]     7663368      34342    7629026      35073    7629026    163      1*float*
[2026-09-19 00:52:11] 
[2026-09-19 00:53:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:53:11]     7663368      34342    7629026      35073    7629026    163      1*float*
[2026-09-19 00:53:11] 
[2026-09-19 00:54:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:54:11]     7663368      34344    7629024      35079    7629024    163      1*float*
[2026-09-19 00:54:11] 
[2026-09-19 00:55:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:55:11]     7663368      34341    7629027      35065    7629027    163      1*float*
[2026-09-19 00:55:11] 
[2026-09-19 00:56:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:56:11]     7663368      34342    7629026      35075    7629026    163      1*float*
[2026-09-19 00:56:11] 
[2026-09-19 00:57:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:57:11]     7663368      34344    7629024      35066    7629024    163      1*float*
[2026-09-19 00:57:11] 
[2026-09-19 00:58:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:58:11]     7663368      34341    7629027      35072    7629027    163      1*float*
[2026-09-19 00:58:11] 
[2026-09-19 00:59:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 00:59:11]     7663368      34347    7629021      35077    7629021    163      1*float*
[2026-09-19 00:59:11] 
[2026-09-19 01:00:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:00:11]     7663368      34341    7629027      35078    7629027    163      1*float*
[2026-09-19 01:00:11] 
[2026-09-19 01:01:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:01:11]     7663368      34341    7629027      35079    7629027    163      1*float*
[2026-09-19 01:01:11] 
[2026-09-19 01:02:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:02:11]     7663368      34345    7629023      35068    7629023    163      1*float*
[2026-09-19 01:02:11] 
[2026-09-19 01:03:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:03:11]     7663368      34342    7629026      35066    7629026    163      1*float*
[2026-09-19 01:03:11] 
[2026-09-19 01:04:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:04:11]     7663368      34345    7629023      35066    7629023    163      1*float*
[2026-09-19 01:04:11] 
[2026-09-19 01:05:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:05:11]     7663368      34344    7629024      35074    7629024    163      1*float*
[2026-09-19 01:05:11] 
[2026-09-19 01:06:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:06:11]     7663368      34347    7629021      35071    7629021    163      1*float*
[2026-09-19 01:06:11] 
[2026-09-19 01:07:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:07:11]     7663368      34345    7629023      35077    7629023    163      1*float*
[2026-09-19 01:07:11] 
[2026-09-19 01:08:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:08:11]     7663368      34345    7629023      35069    7629023    163      1*float*
[2026-09-19 01:08:11] 
[2026-09-19 01:09:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:09:11]     7663368      34346    7629022      35079    7629022    163      1*float*
[2026-09-19 01:09:11] 
[2026-09-19 01:10:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:10:11]     7663368      34346    7629022      35078    7629022    163      1*float*
[2026-09-19 01:10:11] 
[2026-09-19 01:11:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:11:11]     7663368      34346    7629022      35071    7629022    163      1*float*
[2026-09-19 01:11:11] 
[2026-09-19 01:12:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:12:11]     7663368      34342    7629026      35080    7629026    163      1*float*
[2026-09-19 01:12:11] 
[2026-09-19 01:13:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:13:11]     7663368      34346    7629022      35074    7629022    163      1*float*
[2026-09-19 01:13:11] 
[2026-09-19 01:14:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:14:11]     7663368      34342    7629026      35075    7629026    163      1*float*
[2026-09-19 01:14:11] 
[2026-09-19 01:15:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:15:11]     7663368      34344    7629024      35069    7629024    163      1*float*
[2026-09-19 01:15:11] 
[2026-09-19 01:16:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:16:11]     7663368      34347    7629021      35065    7629021    163      1*float*
[2026-09-19 01:16:11] 
[2026-09-19 01:17:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:17:11]     7663368      34344    7629024      35075    7629024    163      1*float*
[2026-09-19 01:17:11] 
[2026-09-19 01:18:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:18:11]     7663368      34343    7629025      35075    7629025    163      1*float*
[2026-09-19 01:18:11] 
[2026-09-19 01:19:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:19:11]     7663368      34342    7629026      35070    7629026    163      1*float*
[2026-09-19 01:19:11] 
[2026-09-19 01:20:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:20:11]     7663368      34341    7629027      35079    7629027    163      1*float*
[2026-09-19 01:20:11] 
[2026-09-19 01:21:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:21:11]     7663368      34341    7629027      35071    7629027    163      1*float*
[2026-09-19 01:21:11] 
[2026-09-19 01:22:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:22:11]     7663368      34341    7629027      35074    7629027    163      1*float*
[2026-09-19 01:22:11] 
[2026-09-19 01:23:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:23:11]     7663368      34345    7629023      35075    7629023    163      1*float*
[2026-09-19 01:23:11] 
[2026-09-19 01:24:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:24:11]     7663368      34345    7629023      35068    7629023    163      1*float*
[2026-09-19 01:24:11] 
[2026-09-19 01:25:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:25:11]     7663368      34346    7629022      35077    7629022    163      1*float*
[2026-09-19 01:25:11] 
[2026-09-19 01:26:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:26:11]     7663368      34345    7629023      35064    7629023    163      1*float*
[2026-09-19 01:26:11] 
[2026-09-19 01:27:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:27:11]     7663368      34341    7629027      35077    7629027    163      1*float*
[2026-09-19 01:27:11] 
[2026-09-19 01:28:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:28:11]     7663368      34346    7629022      35071    7629022    163      1*float*
[2026-09-19 01:28:11] 
[2026-09-19 01:29:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:29:11]     7663368      34346    7629022      35074    7629022    163      1*float*
[2026-09-19 01:29:11] 
[2026-09-19 01:30:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:30:11]     7663368      34343    7629025      35064    7629025    163      1*float*
[2026-09-19 01:30:11] 
[2026-09-19 01:31:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:31:11]     7663368      34346    7629022      35067    7629022    163      1*float*
[2026-09-19 01:31:11] 
[2026-09-19 01:32:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:32:11]     7663368      34341    7629027      35068    7629027    163      1*float*
[2026-09-19 01:32:11] 
[2026-09-19 01:33:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:33:11]     7663368      34345    7629023      35064    7629023    163      1*float*
[2026-09-19 01:33:11] 
[2026-09-19 01:34:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:34:11]     7663368      34343    7629025      35070    7629025    163      1*float*
[2026-09-19 01:34:11] 
[2026-09-19 01:35:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:35:11]     7663368      34347    7629021      35074    7629021    163      1*float*
[2026-09-19 01:35:11] 
[2026-09-19 01:36:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:36:11]     7663368      34342    7629026      35075    7629026    163      1*float*
[2026-09-19 01:36:11] 
[2026-09-19 01:37:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:37:11]     7663368      34346    7629022      35068    7629022    163      1*float*
[2026-09-19 01:37:11] 
[2026-09-19 01:38:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:38:11]     7663368      34345    7629023      35064    7629023    163      1*float*
[2026-09-19 01:38:11] 
[2026-09-19 01:39:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:39:11]     7663368      34342    7629026      35064    7629026    163      1*float*
[2026-09-19 01:39:11] 
[2026-09-19 01:40:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:40:11]     7663368      34342    7629026      35075    7629026    163      1*float*
[2026-09-19 01:40:11] 
[2026-09-19 01:41:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:41:11]     7663368      34346    7629022      35072    7629022    163      1*float*
[2026-09-19 01:41:11] 
[2026-09-19 01:42:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:42:11]     7663368      34343    7629025      35076    7629025    163      1*float*
[2026-09-19 01:42:11] 
[2026-09-19 01:43:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:43:11]     7663368      34341    7629027      35076    7629027    163      1*float*
[2026-09-19 01:43:11] 
[2026-09-19 01:44:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:44:11]     7663368      34344    7629024      35064    7629024    163      1*float*
[2026-09-19 01:44:11] 
[2026-09-19 01:45:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:45:11]     7663368      34347    7629021      35073    7629021    163      1*float*
[2026-09-19 01:45:11] 
[2026-09-19 01:46:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:46:11]     7663368      34343    7629025      35075    7629025    163      1*float*
[2026-09-19 01:46:11] 
[2026-09-19 01:47:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:47:11]     7663368      34346    7629022      35075    7629022    163      1*float*
[2026-09-19 01:47:11] 
[2026-09-19 01:48:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:48:11]     7663368      34344    7629024      35072    7629024    163      1*float*
[2026-09-19 01:48:11] 
[2026-09-19 01:49:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:49:11]     7663368      34346    7629022      35074    7629022    163      1*float*
[2026-09-19 01:49:11] 
[2026-09-19 01:50:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:50:11]     7663368      34345    7629023      35076    7629023    163      1*float*
[2026-09-19 01:50:11] 
[2026-09-19 01:51:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:51:11]     7663368      34345    7629023      35079    7629023    163      1*float*
[2026-09-19 01:51:11] 
[2026-09-19 01:52:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:52:11]     7663368      34344    7629024      35068    7629024    163      1*float*
[2026-09-19 01:52:11] 
[2026-09-19 01:53:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:53:11]     7663368      34344    7629024      35068    7629024    163      1*float*
[2026-09-19 01:53:11] 
[2026-09-19 01:54:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:54:11]     7663368      34345    7629023      35073    7629023    163      1*float*
[2026-09-19 01:54:11] 
[2026-09-19 01:55:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:55:11]     7663368      34344    7629024      35074    7629024    163      1*float*
[2026-09-19 01:55:11] 
[2026-09-19 01:56:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:56:11]     7663368      34341    7629027      35067    7629027    163      1*float*
[2026-09-19 01:56:11] 
[2026-09-19 01:57:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:57:11]     7663368      34342    7629026      35069    7629026    163      1*float*
[2026-09-19 01:57:11] 
[2026-09-19 01:58:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:58:11]     7663368      34341    7629027      35075    7629027    163      1*float*
[2026-09-19 01:58:11] 
[2026-09-19 01:59:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 01:59:11]     7663368      34342    7629026      35064    7629026    163      1*float*
[2026-09-19 01:59:11] 
[2026-09-19 02:00:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:00:11]     7663368      34345    7629023      35074    7629023    163      1*float*
[2026-09-19 02:00:11] 
[2026-09-19 02:01:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:01:11]     7663368      34345    7629023      35067    7629023    163      1*float*
[2026-09-19 02:01:11] 
[2026-09-19 02:02:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:02:11]     7663368      34341    7629027      35075    7629027    163      1*float*
[2026-09-19 02:02:11] 
[2026-09-19 02:03:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:03:11]     7663368      34344    7629024      35075    7629024    163      1*float*
[2026-09-19 02:03:11] 
[2026-09-19 02:04:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:04:11]     7663368      34346    7629022      35069    7629022    163      1*float*
[2026-09-19 02:04:11] 
[2026-09-19 02:05:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:05:11]     7663368      34347    7629021      35075    7629021    163      1*float*
[2026-09-19 02:05:11] 
[2026-09-19 02:06:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:06:11]     7663368      34343    7629025      35065    7629025    163      1*float*
[2026-09-19 02:06:11] 
[2026-09-19 02:07:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:07:11]     7663368      34341    7629027      35075    7629027    163      1*float*
[2026-09-19 02:07:11] 
[2026-09-19 02:08:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:08:11]     7663368      34347    7629021      35065    7629021    163      1*float*
[2026-09-19 02:08:11] 
[2026-09-19 02:09:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:09:11]     7663368      34341    7629027      35073    7629027    163      1*float*
[2026-09-19 02:09:11] 
[2026-09-19 02:10:11]       total       used       free    maxused    largest  nused  nfree    cpu
[2026-09-19 02:10:11]     7663368      34344    7629024      35068    7629024    163      1*float*
[2026-09-19 02:10:11] 
```

启用showinfo配置：

在 `menuconfig` 中，进入 `System Configuration` \-\> `Resource Monitor`，选中 `SYSTEM_RESMONITOR`

