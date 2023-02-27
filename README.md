# FPU



## `fonecycle`接口

| I/O  | 位宽                   | 接口名            | 描述                                                         |
| ---- | ---------------------- | ----------------- | ------------------------------------------------------------ |
| `I`  | `EXPWIDTH + SIGWIDTH`  | `frs1`            | 浮点数运算第一个操作数                                       |
| `I`  | `EXPWIDTH + SIGWIDTH`  | `frs2`            | 浮点数运算第二个操作数                                       |
| `I`  | `EXPWIDTH. + SIGWIDTH` | `frs3`            | 浮点数运算第三个操作数                                       |
| `I`  | 32                     | `rs`              | 浮点数运算需要用到的32位整数，例如整数转浮点数               |
| `I`  | 64                     | `rs`              | 浮点数运算需要用到的64位整数                                 |
| `I`  | 5                      | `ftype`           | 决定使用哪种浮点数运算，对应关系见下表                       |
| `I`  | 1                      | `fcontrol`        | 1为detect tininess after rounding，0为before rounding.       |
| `I`  | 3                      | `roundingMode`    | 代表舍入模式，具体哪种舍入模式见下表                         |
| `O`  | `EXPWIDTH + SIGWIDTH`  | `farthematic_res` | 浮点数运算的结果                                             |
| `O`  | 32                     | `w_convert_res`   | 浮点数转换后得到的32位整数                                   |
| `O`  | 64                     | `l_convert_res`   | 浮点数转换后得到的64位整数                                   |
| `O`  | 1                      | `fcompare_res`    | 浮点数比较的结果                                             |
| `O`  | `XLEN`                 | `fclass_res`      | `fclass`指令的结果                                           |
| `O`  | 5                      | `exception_flags` | 浮点数运算过程中出现的异常，异常的编码为`{invalid, infinite, overflow, underflow, inexact}` |

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



## `fdivsqrt`验证



### `fdiv.s`



### `fsqrt.s`



## 几点注意

* `roundingMode`中，hardfloat在roundingMode为110的时候，还能够进行舍入，但是在RISC-V中，110没有用，111需要动态按照指令选择舍入，注意。
