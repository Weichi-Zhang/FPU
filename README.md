# FPU



## `fonecycle`接口

| I/O  | 位宽                  | 接口名            | 描述                                                         |
| ---- | --------------------- | ----------------- | ------------------------------------------------------------ |
| `I`  | `EXPWIDTH + SIGWIDTH` | `frs1`            | 浮点数运算第一个操作数                                       |
| `I`  | `EXPWIDTH + SIGWIDTH` | `frs2`            | 浮点数运算第二个操作数                                       |
| `I`  | `EXPWIDTH + SIGWIDTH` | `frs3`            | 浮点数运算第三个操作数                                       |
| `I`  | 32                    | `rs`              | 浮点数运算需要用到的32位整数，例如整数转浮点数               |
| `I`  | 64                    | `rs`              | 浮点数运算需要用到的64位整数                                 |
| `I`  | 5                     | `ftype`           | 决定使用哪种浮点数运算，对应关系见下表                       |
| `I`  | 1                     | `fcontrol`        | 1为detect tininess after rounding，0为before rounding.       |
| `I`  | 3                     | `roundingMode`    | 代表舍入模式，具体哪种舍入模式见下表                         |
| `O`  | `EXPWIDTH + SIGWIDTH` | `farthematic_res` | 浮点数运算的结果                                             |
| `O`  | 32                    | `w_convert_res`   | 浮点数转换后得到的32位整数                                   |
| `O`  | 64                    | `l_convert_res`   | 浮点数转换后得到的64位整数                                   |
| `O`  | 1                     | `fcompare_res`    | 浮点数比较的结果                                             |
| `O`  | `XLEN`                | `fclass_res`      | `fclass`指令的结果                                           |
| `O`  | 5                     | `exception_flags` | 浮点数运算过程中出现的异常，异常的编码为`{invalid, infinite, overflow, underflow, inexact}` |

其中，`ftype`和浮点数运算的对应关系如下：

| `ftype` | 指令                             |
| ------- | -------------------------------- |
| 0       | `fadd.s frd, frs1, frs2`         |
| 1       | `fsub.s frd, frs1, frs2`         |
| 2       | `fmul.s frd, frs1, frs2`         |
| 3       | `fmin.s frd, frs1, frs2`         |
| 4       | `fmax.s frd, frs1, frs2`         |
| 5       | `fmadd.s frd, frs1, frs2, frs3`  |
| 6       | `fnmadd.s frd, frs1, frs2, frs3` |
| 7       | `fmsub.s frd, frs1, frs2, frs3`  |
| 8       | `fnmsub.s frd, frs1, frs2, frs3` |
| 9       | `fcvt.w.s rd, frs1`              |
| 10      | `fcvt.wu.s rd, frs1`             |
| 11      | `fcvt.l.s rd, frs1`              |
| 12      | `fcvt.lu.s rd, frs1`             |
| 13      |  `fcvt.s.w frd, rs1`             |
| 14      |  `fcvt.s.wu frd, rs1`             |
| 15      | `fcvt.s.l frd, rs1`              |
| 16      | `fcvt.s.lu frd, rs1`             |
| 17      | `fsgnj.s frd, frs1, frs2`        |
| 18      | `fsgnjn.s frd, frs1, frs2`       |
| 19      | `fsgnjx.s frd, frs1, frs2`       |
| 20      | `feq.s rd, frs1, frs2`           |
| 21      | `flt.s rd, frs1, frs2`           |
| 22      | `fle.s rd, frs1, frs2`           |
| 23      | `fclass frs`                     |
| 24 | `fmv.w.x frd, rs` |
| 25 | `fmv.x.w rd, frs` |



其中，`roundingMode`的对应关系如下：

| `roundingMode` | 舍入模式                                |
| -------------- | --------------------------------------- |
| 000            | Round to nearest, ties to even          |
| 001            | Round towards zero                      |
| 010            | Round Down                              |
| 011            | Round Up                                |
| 100            | Round to Nearest, ties to Max Magnitude |



## `fonecycle` 验证


### `fadd.s`

| `frs1`值   | `frs2`值   | `frd`结果  | 描述                                                    | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ------------------------------------------------------- | --------------- | ------------ | --------------------------------- |
| 0x40200000 | 0x3F800000 | 0x40600000 | 2.5 + 1.0 = 3.5                                         | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xC49A6333 | 0x3F8CCCCD | 0xC49A4000 | -1235.1 + 1.1 = -1234.0，会触发inexact异常              | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40490FDB | 0x322BCC77 | 0x40490FDB | 3.14159265 + 0.00000001 = 3.14159265，会触发inexact异常 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |



### `fsub.s`

| `frs1`     | `frs2`     | `frd`      | 描述                                                       | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ---------------------------------------------------------- | --------------- | ------------ | --------------------------------- |
| 0x40200000 | 0x3F800000 | 0x3FC00000 | 2.5 - 1.0 = 1.5                                            | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xC49A6333 | 0xBF8CCCCD | 0xC49A4000 | -1235.1 - (-1.1) = -1234                                   | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40490FDB | 0x322BCC77 | 0x40490FDB | 3.14159265 - 0.00000001 = 3.14159265                       | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x7F800000 | 0x7F800000 | 0x7fC00000 | Inf-Inf = qNaN，两个正无穷相减，操作无效，但是不会抛出异常 | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |




### `fmul.s`

| `frs1`     | `frs2`     | `frd`      | 描述                                    | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | --------------------------------------- | --------------- | ------------ | --------------------------------- |
| 0x40200000 | 0x3F800000 | 0x40200000 | 2.5 x 1.0 = 2.5                         | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xC49A6333 | 0xBF8CCCCD | 0x44A9D385 | -1235.1 x -1.1 = 1358.61                | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40490FDB | 0x322BCC77 | 0x3306EE2D | 3.14159265 x 0.00000001 = 3.14159265e-8 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |



### `fmin.s`

| `frs1`     | `frs2`     | `frd`      | 描述                                     | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ---------------------------------------- | --------------- | ------------ | --------------------------------- |
| 0x40200000 | 0x3F800000 | 0x3F800000 | Min(2.5, 1.0) = 1.0                      | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xC49A6333 | 0x3F8CCCCD | 0xC49A6333 | Min(-1235.1, 1.1) = -1235.1              | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x3F8CCCCD | 0xC49A6333 | 0xC49A6333 | Min(1.1, -1235.1) = -1235.1              | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | 0xC49A6333 | 0xC49A6333 | Min(NaN, -1235.1) = -1235.1              | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x40490FDB | 0x322BCC77 | 0x322BCC77 | Min(3.14159265, 0.00000001) = 0.00000001 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0xC0000000 | 0xC0000000 | Min(-1.0, -2.0) = -2.0                   | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x80000000 | 0x00000000 | 0x80000000 | Min(-0.0, 0.0) = -0.0                    | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x00000000 | 0x80000000 | 0x80000000 | Min(0.0, -0.0) = -0.0                    | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |



### `fmax.s`
| `frs1`     | `frs2`     | `frd`      | 描述                                     | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ---------------------------------------- | --------------- | ------------ | --------------------------------- |
| 0x40200000 | 0x3F800000 | 0x40200000 | Max(2.5, 1.0) = 2.5                      | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xC49A6333 | 0x3F8CCCCD | 0x3F8CCCCD | Max(-1235.1, 1.1) = 1.1                  | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x3F8CCCCD | 0xC49A6333 | 0x3F8CCCCD | Max(1.1, -1235.1) = 1.1                  | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | 0xC49A6333 | 0xC49A6333 | Max(NaN, -1235.1) = -1235.1              | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x40490FDB | 0x322BCC77 | 0x40490FDB | Max(3.14159265, 0.00000001) = 3.14159265 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0xC0000000 | 0xBF800000 | Max(-1.0, -2.0) = -1.0                   | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x7F800001 | 0x3F800000 | 0x3F800000 | Max(sNaNf, 1.0) = 1.0                    | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | NaN        | 0x7FC00000 | Max(NaN, NaN) = qNaNf                    | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x80000000 | 0x00000000 | 0x00000000 | Max(-0.0, 0.0) = 0.0                     | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x00000000 | 0x80000000 | 0x00000000 | Max(0.0, -0.0) = 0.0                     | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |


### `fmadd.s`

| `frs1`     | `frs2`     | `frs3`     | `frd`      | 描述                          | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ---------- | ----------------------------- | --------------- | ------------ | --------------------------------- |
| 0x3F800000 | 0x40200000 | 0x3F800000 | 0x40600000 | 1.0 x 2.5 + 1.0 = 3.5         | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0xC49A6333 | 0x3F8CCCCD | 0x449A8666 | -1.0 x -1235.1 + 1.1 = 1236.2 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40000000 | 0xC0A00000 | 0xC0000000 | 0xC1400000 | 2.0 x -5.0 + -2.0 = -12.0     | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |



### `fnmsub.s`

| `frs1`     | `frs2`     | `frs3`     | `frd`      | 描述                            | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ---------- | ------------------------------- | --------------- | ------------ | --------------------------------- |
| 0x3F800000 | 0x40200000 | 0x3F800000 | 0xBFC00000 | -(1.0 x 2.5) + 1.0 = -1.5       | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0xC49A6333 | 0x3F8CCCCD | 0xC49A4000 | -(-1.0 x -1235.1) + 1.1 = -1234 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40000000 | 0xC0A00000 | 0xC0000000 | 0x41000000 | -(2.0 x -5.0) + -2.0 = 8.0      | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |

### `fmsub.s`

| `frs1`     | `frs2`     | `frs3`     | `frd`      | 描述                        | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ---------- | --------------------------- | --------------- | ------------ | --------------------------------- |
| 0x3F800000 | 0x40200000 | 0x3F800000 | 0x3FC00000 | 1.0 x 2.5 - 1.0 = 1.5       | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0xC49A6333 | 0x3F8CCCCD | 0x449A4000 | -1.0 x -1235.1 - 1.1 = 1234 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40000000 | 0xC0A00000 | 0xC0000000 | 0xC1000000 | 2.0 x -5.0 -( -2.0) = -8.0  | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |

### `fnmadd.s`

| `frs1`     | `frs2`     | `frs3`     | `frd`      | 描述                             | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | ---------- | -------------------------------- | --------------- | ------------ | --------------------------------- |
| 0x3F800000 | 0x40200000 | 0x3F800000 | 0xC0600000 | -(1.0 x 2.5) - 1.0 = 3.5         | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0xC49A6333 | 0x3F8CCCCD | 0xC49A8666 | -(-1.0 x -1235.1) - 1.1 = 1236.2 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40000000 | 0xC0A00000 | 0xC0000000 | 0x41400000 | -(2.0 x -5.0) -( -2.0) = -12.0   | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |

### `fcvt.w.s`

| `frs`      | `rd`      | 描述                                                   | Exception       | RoundingMode | Status                            |
| ---------- | --------- | ------------------------------------------------------ | --------------- | ------------ | --------------------------------- |
| 0xBF8CCCCD | -1        | -1.1变有符号整数是-1                                   | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0xBF800000 | -1        | -1.0变有符号整数是-1                                   | {0, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0xBF666666 | 0         | -0.9变有符号整数是0                                    | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F666666 | 0         | 0.9变有符号整数是0                                     | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F800000 | 1         | 1.0变有符号整数是1                                     | {0, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0x3F8CCCCD | 1         | 1.1变有符号整数是1                                     | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0xCF32D05E | -1 << 31  | -3e9超过了32位有符号数的下限，自动表示为最小的有符号数 | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0x4F32D05E | (1<<31)-1 | 3e9超过了32为有符号数的上限，自动表示为最大的有符号数  | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |



### `fcvt.wu.s`

| `frs`      | `rd`       | 描述                        | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | --------------------------- | --------------- | ------------ | --------------------------------- |
| 0xC0400000 | 0          | -3.0变无符号整数是0         | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0          | -1.0变无符号整数是0         | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0xBF666666 | 0          | -0.9变无符号整数是0         | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F666666 | 0          | 0.9变无符号整数是0          | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F800000 | 1          | 1.0变无符号整数是1          | {0, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0x3F8CCCCD | 1          | 1.1变无符号整数是1          | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0xCF32D05E | 0          | -3e9变无符号整数是0         | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0x4F32D05E | 3000000000 | 3e9变无符号整数是3000000000 | {0, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |



### `fcvt.l.s`

| `frs`      | `rd` | 描述                     | Exception       | RoundingMode | Status                            |
| ---------- | ---- | ------------------------ | --------------- | ------------ | --------------------------------- |
| 0xBF8CCCCD | -1   | -1.1变64位有符号整数是-1 | {0, 0, 0, 0, 1) | 001          | <font color=green>**PASS**</font> |
| 0xBF800000 | -1   | -1.0变64位有符号整数是-1 | {0, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0xBF666666 | 0    | -0.9变64位有符号整数是0  | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F666666 | 0    | 0.9变64位有符号整数是0   | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F800000 | 1    | 1.0变64位有符号整数是1   | {0, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0x3F8CCCCD | 1    | 1.1变64位有符号整数是1   | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |



### `fcvt.lu.s`

| `frs`      | `rd` | 描述                    | Exception       | RoundingMode | Status                            |
| ---------- | ---- | ----------------------- | --------------- | ------------ | --------------------------------- |
| 0xC0400000 | 0    | -3.0变64位无符号整数是0 | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0xBF800000 | 0    | -1.0变64位无符号整数是0 | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0xBF666666 | 0    | -0.9变64位无符号整数是0 | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F666666 | 0    | 0.9变64位无符号整数是0  | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0x3F800000 | 1    | 1.0变64位无符号整数是1  | {0, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |
| 0x3F8CCCCD | 1    | 1.1变64位无符号整数是1  | {0, 0, 0, 0, 1} | 001          | <font color=green>**PASS**</font> |
| 0xCF32D05E | 0    | -3e9变64位无符号整数是1 | {1, 0, 0, 0, 0} | 001          | <font color=green>**PASS**</font> |



### `fcvt.s.w`

| `rs` | `frd`      | 描述                           | Status                            |
| ---- | ---------- | ------------------------------ | --------------------------------- |
| 2    | 0x40000000 | 32位有符号整数2变浮点数是2.0   | <font color=green>**PASS**</font> |
| -2   | 0xC0000000 | 32位有符号整数-2变浮点数是-2.0 | <font color=green>**PASS**</font> |



### `fcvt.s.wu`

| `rs` | `frd`      | 描述                                  | Status                            |
| ---- | ---------- | ------------------------------------- | --------------------------------- |
| 2    | 0x40000000 | 32位无符号整数2变浮点数是2.0          | <font color=green>**PASS**</font> |
| -2   | 0x4F800000 | 32位无符号整数-2变浮点数是4.2949673e9 | <font color=green>**PASS**</font> |



### `fcvt.s.l`


| `rs` | `frd`      | 描述                           | Status                            |
| ---- | ---------- | ------------------------------ | --------------------------------- |
| 2    | 0x40000000 | 64位有符号整数2变浮点数是2.0   | <font color=green>**PASS**</font> |
| -2   | 0xC0000000 | 64位有符号整数-2变浮点数是-2.0 | <font color=green>**PASS**</font> |

### `fcvt.s.lu`

| `rs` | `frd`      | 描述                                   | Status                            |
| ---- | ---------- | -------------------------------------- | --------------------------------- |
| 2    | 0x40000000 | 64位无符号整数2变浮点数是2.0           | <font color=green>**PASS**</font> |
| -2   | 0x5F800000 | 64位无符号整数-2变浮点数是1.8446744e19 | <font color=green>**PASS**</font> |

### 



### `feq.s`

| `frs1`     | `frs2`     | `rd` | 描述           | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---- | -------------- | --------------- | ------------ | --------------------------------- |
| 0xBFAE147B | 0xBFAE147B | 1    | -1.36 == -1.36 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBFAF5C29 | 0xBFAE147B | 0    | -1.37 != -1.36 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | 0x00000000 | 0    | NaN != 0       | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | NaN        | 0    | NaN != NaN     | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x7F800001 | 0x00000000 | 0    | sNaNf != 0     | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |



### `flt.s`

| `frs1`     | `frs2`     | `rd` | 描述           | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---- | -------------- | --------------- | ------------ | --------------------------------- |
| 0xBFAE147B | 0xBFAE147B | 0    | -1.36 !< -1.36 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBFAF5C29 | 0xBFAE147B | 1    | -1.37 < -1.36  | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | 0x00000000 | 0    | NaN !< 0       | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | NaN        | 0    | NaN !< NaN     | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x7F800001 | 0x00000000 | 0    | sNaNf !< 0     | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |



### `fle.s`

| `frs1`     | `frs2`     | `rd` | 描述           | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---- | -------------- | --------------- | ------------ | --------------------------------- |
| 0xBFAE147B | 0xBFAE147B | 1    | -1.36 <= -1.36 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0xBFAF5C29 | 0xBFAE147B | 1    | -1.37 <= -1.36 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | 0x00000000 | 0    | NaN !<= 0      | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| NaN        | NaN        | 0    | NaN !<= NaN    | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |
| 0x7F800001 | 0x00000000 | 0    | sNaNf !<= 0    | {1, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |



### `fclass`

| `frs`      | `rd`       | Status                            |
| ---------- | ---------- | --------------------------------- |
| 0xFF800000 | 0x00000001 | <font color=green>**PASS**</font> |
| 0xBF800000 | 0x00000002 | <font color=green>**PASS**</font> |
| 0x807FFFFF | 0x00000004 | <font color=green>**PASS**</font> |
| 0x80000000 | 0x00000008 | <font color=green>**PASS**</font> |
| 0x00000000 | 0x00000010 | <font color=green>**PASS**</font> |
| 0x007FFFFF | 0x00000020 | <font color=green>**PASS**</font> |
| 0x3F800000 | 0x00000040 | <font color=green>**PASS**</font> |
| 0x7F800000 | 0x00000080 | <font color=green>**PASS**</font> |
| 0x7F800001 | 0x00000100 | <font color=green>**PASS**</font> |
| 0x7FC00000 | 0x00000200 | <font color=green>**PASS**</font> |



## `fdivsqrt`接口

| I/O  | 位宽                  | 接口名             | 描述                                                         |
| ---- | --------------------- | ------------------ | ------------------------------------------------------------ |
| `I`  | 1                     | `clk`              | 时钟信号                                                     |
| `I`  | 1                     | `rst`              | 复位信号                                                     |
| `I`  | `EXPWIDTH + SIGWIDTH` | `frs1`             | 浮点数运算数1                                                |
| `I`  | `EXPWIDTH + SIGWIDTH` | `frs2`             | 浮点数运算数2                                                |
| `I`  | 1                     | `ftype`            | 运算类型，0为除法，1为平方根                                 |
| `I`  | 1                     | `fcontrol`         | Detect tininess before or after rounding, 1 for after, 0 for before |
| `I`  | 3                     | `roundingMode`     | 控制舍入模式                                                 |
|`I`|1|`valid_in`|握手信号|
| `O`  | `EXPWIDTH + SIGWIDTH` | `farithematic_res` | 浮点数除法/平方根的结果                                      |
| `O`  | 4                     | `exception_flags`  | 出现的异常                                                   |
| `O`  | 1                     | `ready_out`        | 握手信号，当模块准备好计算时，`ready_out`为1                 |
| `O`  | 1                     | `finish`           | 当当前计算结束，并且计算结果全部有效时，`finish`为1          |



## `fdivsqrt`验证



### `fdiv.s`

| `frs1`     | `frs2`     | `frd`      | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | ---------- | --------------- | ------------ | --------------------------------- |
| 0x40490FDB | 0x402DF854 | 0x3F93EEE0 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0xC49A4000 | 0x449A6333 | 0xBF7FC5A2 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x40490FDB | 0x3F800000 | 0x40490FDB | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |



### `fsqrt.s`

| `frs`      | `frd`      | Exception       | RoundingMode | Status                            |
| ---------- | ---------- | --------------- | ------------ | --------------------------------- |
| 0x40490FDB | 0x3FE2DFC5 | {0, 0, 0, 0, 1} | 000          | <font color=green>**PASS**</font> |
| 0x461C4000 | 0x42C80000 | {0, 0, 0, 0, 0} | 000          | <font color=green>**PASS**</font> |



## `rv_fdecoder`接口

| I/O  | 位宽           | 接口名                 | 描述                                    |
| ---- | -------------- | ---------------------- | --------------------------------------- |
| `I`  | 32             | `instruction`          | 输入的32位指令                          |
| `O`  | 1              | `is_float_instruction` | 当前的32位指令是否是F extension中的指令 |
| `O`  | 1              | `f_uses_rs1_o`         | 当前的指令是否用到了`rs1`               |
| `O`  | 1              | `f_uses_rs2_o`         | 当前指令是否用到了`rs2`                 |
| `O`  | 1              | `f_uses_rs3_o`         | 当前指令是否用到了`rs3`                 |
| `O`  | 1              | `f_uses_rd_o`          | 当前指令是否用到了`rd`                  |
| `O`  | `VIR_REG_ADDR` | `f_rs1_address_o`      | `rs1`的地址                             |
| `O`  | `VIR_REG_ADDR` | `f_rs2_address_o`      | `rs2`的地址                             |
| `O`  | `VIR_REG_ADDR` | `f_rs3_address_o`      | `rs3`的地址                             |
| `O`  | `VIR_REG_ADDR` | `f_rd_address_o`       | `rd`的地址                              |
| `O`  | 12             | `f_immediate_o`        | 如果是`flw.s, fsw.s`，需要用到的立即数  |
| `O`  | 5              | `f_fu_function_o`      | 当前指令是哪个指令，对应关系见下表      |

其中，`f_fu_function_o`和指令的对应关系如下：

| 指令        | `f_fu_function_o` |
| ----------- | ----------------- |
| `fadd.s`    | 0                 |
| `fsub.s`    | 1                 |
| `fmul.s`    | 2                 |
| `fmin.s`    | 3                 |
| `fmax.s`    | 4                 |
| `fmadd.s`   | 5                 |
| `fnmadd.s`  | 6                 |
| `fmsub.s`   | 7                 |
| `fnmsub.s`  | 8                 |
| `fcvt.w.s`  | 9                 |
| `fcvt.wu.s` | 10                |
| `fcvt.l.s`  | 11                |
| `fcvt.lu.s` | 12                |
| `fcvt.s.w`  | 13                |
| `fcvt.s.wu` | 14                |
| `fcvt.s.l`  | 15                |
| `fcvt.s.lu` | 16                |
| `fsgnj.s`   | 17                |
| `fsgnjn.s`  | 18                |
| `fsgnjx.s`  | 19                |
| `feq.s`     | 20                |
| `flt.s`     | 21                |
| `fle.s`     | 22                |
| `fclass`    | 23                |
| `fmv.w.x`   | 24                |
| `fmv.x.w`   | 25                |
| `fdiv.s`    | 26                |
| `fsqrt.s`   | 27                |
| `flw`       | 28                |
| `fsw`       | 29                |

## `rv_fdecoder`验证

| 验证的指令                  | 指令的编码 | Status                            |
| --------------------------- | ---------- | --------------------------------- |
| `add s0, s1, s2`            | 0x01248433 | <font color=green>**PASS**</font> |
| `sub s0, s1, s2`            | 0x41248433 | <font color=green>**PASS**</font> |
| `fadd.s f3, f2, f1`         | 0x001171d3 | <font color=green>**PASS**</font> |
| `fsub.s f4, f3, f2`         | 0x0821f253 | <font color=green>**PASS**</font> |
| `fmul.s f5, f4, f3`         | 0x103272d3 | <font color=green>**PASS**</font> |
| `fmin.s f6, f5, f4`         | 0x28428353 | <font color=green>**PASS**</font> |
| `fmax.s f7, f6, f5`         | 0x285313d3 | <font color=green>**PASS**</font> |
| `fmadd.s f8, f7, f6, f5`    | 0x2863f443 | <font color=green>**PASS**</font> |
| `fnmadd.s f9, f8, f7, f6`   | 0x307474cf | <font color=green>**PASS**</font> |
| `fmsub.s f10, f9, f8, f7`   | 0x3884f547 | <font color=green>**PASS**</font> |
| `fnmsub.s f11, f10, f9, f8` | 0x409575cb | <font color=green>**PASS**</font> |
| `fcvt.w.s s0, f12 `         | 0xc0067453 | <font color=green>**PASS**</font> |
| `fcvt.wu.s s1, f13`         | 0xc016f4d3 | <font color=green>**PASS**</font> |
| `fcvt.l.s s2, f14`          | 0xc0277953 | <font color=green>**PASS**</font> |
| `fcvt.lu.s s3, f15`         | 0xc037f9d3 | <font color=green>**PASS**</font> |
| `fcvt.s.w f16, s4`          | 0xd00a7853 | <font color=green>**PASS**</font> |
| `fcvt.s.wu f17, s5`         | 0xd01af8d3 | <font color=green>**PASS**</font> |
| `fcvt.s.l f18, t0`          | 0xd022f953 | <font color=green>**PASS**</font> |
| `fcvt.s.lu f19, t1`         | 0xd03379d3 | <font color=green>**PASS**</font> |
| `feq.s t2, f20`             | 0xa00a23d3 | <font color=green>**PASS**</font> |
| `flt.s t3, f21`             | 0xa00a9e53 | <font color=green>**PASS**</font> |
| `fle.s t4, f22`             | 0xa00b0ed3 | <font color=green>**PASS**</font> |
| `fclass.s t5, f23`          | 0xe00b9f53 | <font color=green>**PASS**</font> |
| `fdiv.s f6, f24, f0`        | 0x180c7353 | <font color=green>**PASS**</font> |
| `fsqrt.s f7, f25`           | 0x580cf3d3 | <font color=green>**PASS**</font> |
| `fmv.w.x f26, a0`           | 0xf0050d53 | <font color=green>**PASS**</font> |
| `fmv.x.w a1, f27`           | 0xe00d85d3 | <font color=green>**PASS**</font> |
| `flw f28, 114514(a1)`       | 0xf525ae07 | <font color=green>**PASS**</font> |
| `fsw f29, 1919810(a2)`      | 0xb5d62127 | <font color=green>**PASS**</font> |
| `fsgnj.s f3, f2, f1`        | 0x201101d3 | <font color=green>**PASS**</font> |
| `fsgnjn.s f30, f29, f28`    | 0x21ce9f53 | <font color=green>**PASS**</font> |
| `fsgnjx.s f31, f30, f29`    | 0x21df2fd3 | <font color=green>**PASS**</font> |



## `rvc_decoder`的F扩展验证

| 指令              | 输入的压缩指令 | 扩展后的指令 | Status |
| ----------------- | -------------- | ------------ | ------ |
| `c.fsw f8, 4(x8)` | 0x0000e040     | 0x00842227   |        |
| `c.flw f8, 4(x8)` | 0x00006040     | 0x00442407   |        |
| `c.flwsp f8, 4`   | 0x00006412     | 0x00412407   |        |
| `c.fswsp f8, 4`   | 0x0000e222     | 0x00812227   |        |



## 几点注意

* `roundingMode`中，hardfloat在roundingMode为110的时候，还能够进行舍入，但是在RISC-V中，110没有用，111需要动态按照指令选择舍入，注意。
