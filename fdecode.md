# Fdecoder

假设传入的指令是`instruction`，位宽是32

## 需要实现的指令



### `fadd.s frd, frs1, frs2`

该指令是S型指令

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00000                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |





### `fsub.s frd, frs1, frs2`
| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00001                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



### `fmul.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00010                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



### `fmin.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00101                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode，值是000                                      |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



### `fmax.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00101                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode，值是001                                      |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



### `fmadd.s frd, frs1, frs2, frs3`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1000011    |



### `fnmadd.s frd, frs1, frs2, frs3`
| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1001111    |


### `fmsub.s frd, frs1, frs2, frs3`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1000111    |

### `fnmsub.s frd, frs1, frs2, frs3`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1001011    |



### `fcvt.w.s rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00000   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fcvt.wu.s rd, frs1`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00001   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fcvt.l.s rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00010   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fcvt.lu.s rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00011   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fcvt.s.w frd, rs1`



| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fcvt.s.wu frd, rs1`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00001   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


### `fcvt.s.l frd, rs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00010   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

### `fcvt.s.lu frd, rs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00011   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fsgnj.s frd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是00100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fsgnjn.s frd, frs1, frs2`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是00100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是001     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


### `fsgnjx.s frd, frs1, frs2`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是00100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是010     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


### `feq.s rd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是10100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是010     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `flt.s rd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是10100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是001     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

### `fle.s rd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是10100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

### `fclass rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是001     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



### `fmv.w.x frd, rs1`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11110   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


### `fmv.x.w rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

### `fdiv.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00011                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |

### `fsqrt.s frd, frs1`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `funct5`  | `instruction[31:27]` | 值是01011      |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 值是00000      |
| `frs1`    | `instruction[19:15]` | 第一个运算数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1010011    |



### `flw frd, offset(rs)`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `offset`  | `instruction[31:20]` |             |
| `rs1`     | `instruction[19:15]` |             |
| `width`   | `instruction[14:12]` | 值是010     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是0000111 |



### `fsw frs2, offset(rs1)`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `offset[11:5]` | `instruction[31:25]` |             |
|`frs2`|`instruction[24:20]`||
| `rs1`     | `instruction[19:15]` |             |
| `width`   | `instruction[14:12]` | 值是010     |
| `offset[4:0]` | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是0100111 |



### F extension的`opcode`

| 指令        | `opcode` |
| ----------- | -------- |
| `fadd.s`    | 1010011  |
| `fsub.s`    | 1010011  |
| `fmul.s`    | 1010011  |
| `fmin.s`    | 1010011  |
| `fmax.s`    | 1010011  |
| `fmadd.s`   | 1000011  |
| `fnmadd.s`  | 1001111  |
| `fmsub.s`   | 1000111  |
| `fnmsub.s`  | 1001011  |
| `fcvt.w.s`  | 1010011  |
| `fcvt.wu.s` | 1010011  |
| `fcvt.l.s`  | 1010011  |
| `fcvt.lu.s` | 1010011  |
| `fcvt.s.w`  | 1010011  |
| `fcvt.s.wu` | 1010011  |
| `fcvt.s.l`  | 1010011  |
| `fcvt.s.lu` | 1010011  |
| `fsgnj.s`   | 1010011  |
| `fsgnjn.s`  | 1010011  |
| `fsgnjx.s`  | 1010011  |
| `feq.s`     | 1010011  |
| `flt.s`     | 1010011  |
| `fle.s`     | 1010011  |
| `fclass`    | 1010011  |
| `fmv.w.x`   | 1010011  |
| `fmv.x.w`   | 1010011  |
| `fdiv.s`    | 1010011  |
| `fsqrt.s`   | 1010011  |
| `flw`       | 0000111  |
| `fsw`       | 0100111  |





## 需要支持的压缩指令



### `c.flw`：01100

指令的格式是：`c.flw frd' offset(rs')`

指令的编码如下：

| Attribute     | Value                | Description |
| ------------- | -------------------- | ----------- |
| `funct3`      | `instruction[15:13]` | 值是011     |
| `offset[5:3]` | `instruction[12:10]` |             |
| `rs'`         | `instruction[9:7]`   |             |
| `offset[2|6]` | `instruction[6:5]`   |             |
| `frd'`        | `instruction[4:2]`   |             |
| `op`          | `instruction[1:0]`   | 值是00      |

指令要被扩展成：`flw frd, offset(rs)`

扩展后的指令编码如下：

| Attribute | Value                | Description                                                  |
| --------- | -------------------- | ------------------------------------------------------------ |
| `offset`  | `instruction[31:20]` | 其中，`instruction[31:27]`为0，`instruction[26:22]`为`offset[6:2]`，`instruction[21:20]`为0. |
| `rs1`     | `instruction[19:15]` | `rs'+8`                                                      |
| `width`   | `instruction[14:12]` | 值是010                                                      |
| `rd`      | `instruction[11:7]`  | `rd'`+8                                                      |
| `opcode`  | `instruction[6:0]`   | 值是0000111                                                  |

### `c.fsw`：11100

指令的格式是：`c.fsw frs2', offset(rs1')`

指令编码如下：

| Attribute     | Value                | Description |
| ------------- | -------------------- | ----------- |
| `funct3`      | `instruction[15:13]` | 值是111     |
| `offset[5:3]` | `instruction[12:10]` |             |
| `rs1'`        | `instruction[9:7]`   |             |
| `offset[2|6]` | `instruction[6:5]`   |             |
| `frs2'`       | `instruction[4:2]`   |             |
| `op`          | `instruction[1:0]`   | 00          |

扩展后的指令是：`fsw frs2, offset(rs1)`

指令编码如下：

| Attribute      | Value                | Description                                                  |
| -------------- | -------------------- | ------------------------------------------------------------ |
| `offset[11:5]` | `instruction[31:25]` | 其中，`instruction[31:27]`为0，`instruction[26:25]`为`offset[6:5]` |
| `frs2`         | `instruction[24:20]` | `frs2'+8`                                                    |
| `rs1`          | `instruction[19:15]` | `rs1'+8`                                                     |
| `width`        | `instruction[14:12]` | 值是010                                                      |
| `offset[4:0]`  | `instruction[11:7]`  | 其中，`instruction[11:9]`为`offset[4:2]`，`instruction[8:7]`为0 |
| `opcode`       | `instruction[6:0]`   | 值是0100111                                                  |



### `c.flwsp`：01110

指令的格式是：`c.flwsp rd, offset(sp)`

指令的编码如下：

| Attribute      | Value                | Description |
| -------------- | -------------------- | ----------- |
| `funct3`       | `instruction[15:13]` | 值是011     |
| `imm[5]`       | `instruction[12]`    |             |
| `rd`           | `instruction[11:7]`  |             |
| `imm[4:2|7:6]` | `instruction[6:2]`   |             |
| `op`           | `instruction[1:0]`   | 值是10      |

要变成的指令是：`flw rd offset[7:2](sp)`，这个扩展后的指令的指令编码是：

| Attribute | Value                | Description                                                  |
| --------- | -------------------- | ------------------------------------------------------------ |
| `offset`  | `instruction[31:20]` | `instruction[31:28]`是0，`instruction[27:22]`是`offset[7:2]`，`instruction[21:20]`是0 |
| `rs`      | `instruction[19:15]` | 是`sp`指针，编号是2                                          |
| `width`   | `instruction[14:12]` | 值是010                                                      |
| `rd`      | `instruction[11:7]`  | 注意：这个是`frd`                                            |
| `opcode`  | `instruction[6:0]`   | 值是0000111                                                  |



### `c.fswsp`：11110

指令的格式是：`c.fswsp frs, offset(sp)`

指令编码如下：

| Attribute         | Value                | Description |
| ----------------- | -------------------- | ----------- |
| `funct3`          | `instruction[15:13]` | 值是111     |
| `offset[5:2|7:6]` | `instruction[12:7]`  |             |
| `frs`             | `instruction[6:2]`   |             |
| `op`              | `instruction[1:0]`   | 值是10      |

扩展后的指令是：`fsw frs, offset[7:2](sp)`

扩展后的指令编码是：

| Attribute      | Value                | Description                                                  |
| -------------- | -------------------- | ------------------------------------------------------------ |
| `offset[11:5]` | `instruction[31:25]` | 其中`instruction[31:28]`为0，`instruction[27:25]`为`offset[7:5]` |
| `frs`          | `instruction[24:20]` | 就是原来指令中的`instruction[6:2]`                           |
| `rs1`          | `instruction[19:15]` | 就是`sp`，编号是2                                            |
| `width`        | `instruction[14:12]` | 就是010                                                      |
| `offset[4:0]`  | `instruction[11:7]`  | 其中，`instruction[11:9]`为`offset[4:2]`，`instruction[8:7]`为0 |
| `opcode`       | `instruction[6:0]`   | 值是0100111                                                  |

